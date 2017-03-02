From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 2 Mar 2017 12:35:07 +0000
Subject: [PATCH] arm64: restore get_current() optimisation
In-Reply-To: <ee26a4f0-e3e9-fb44-fe7c-c40a15c33b38@nvidia.com>
References: <1483468021-8237-1-git-send-email-mark.rutland@arm.com>
 <ee26a4f0-e3e9-fb44-fe7c-c40a15c33b38@nvidia.com>
Message-ID: <20170302123507.GD19632@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 02, 2017 at 11:35:06AM +0000, Jon Hunter wrote:
> Hi Mark,

Hi Jon,

> On 03/01/17 18:27, Mark Rutland wrote:
> > Commit c02433dd6de32f04 ("arm64: split thread_info from task stack")
> > inverted the relationship between get_current() and
> > current_thread_info(), with sp_el0 now holding the current task_struct
> > rather than the current thead_info. The new implementation of
> > get_current() prevents the compiler from being able to optimize repeated
> > calls to either, resulting in a noticeable penalty in some
> > microbenchmarks.
> > 
> > This patch restores the previous optimisation by implementing
> > get_current() in the same way as our old current_thread_info(), using a
> > non-volatile asm statement.

> > +/*
> > + * We don't use read_sysreg() as we want the compiler to cache the value where
> > + * possible.
> > + */
> >  static __always_inline struct task_struct *get_current(void)
> >  {
> > -	return (struct task_struct *)read_sysreg(sp_el0);
> > +	unsigned long sp_el0;
> > +
> > +	asm ("mrs %0, sp_el0" : "=r" (sp_el0));
> > +
> > +	return (struct task_struct *)sp_el0;
> >  }
> >  
> >  #define current get_current()

> I noticed that with v4.10 I am seeing the following panic ...

Ouch. :(

For reference, which toolchain are you using? This kind of code tends to be
toolchain-sensitive.

> [  184.523390] Unable to handle kernel paging request at virtual address ffff8001bb7a2800
> [  184.531316] pgd = ffff8000b96b1000
> [  184.534711] [ffff8001bb7a2800] *pgd=0000000000000000
> [  184.539670] Internal error: Oops: 96000005 [#1] PREEMPT SMP

That ESR_EL1 value decodes as a "Data Abort taken without a change in Exception
level", the DFSC decodes as "Translation fault, level 1", and WnR is clear.

So we're blowing up on a read of a bogus address.

> [  184.566458] PC is at regcache_flat_read+0x14/0x20
> [  184.571155] LR is at regcache_read+0x50/0x78
> [  184.575417] pc : [<ffff0000085d0c6c>] lr : [<ffff0000085cefa8>] pstate: 400001c5

Judging by the PC, that read could be any of:

* the read of map->cache at the start of regcache_flat_read()

* an inlined regcache_get_index_by_order()'s read of map->reg_stride_order

* the read of cache[regcache_flat_get_index(map, reg)]

... so it seems either map or map->cache is dodgy.

If you're can addr2line that PC, that should tell us which access is
blowing up, and therefore which pointer is dodgy.

We'll want the full output considering inlined functions, i.e.

${CROSS_COMPILE}addr2line -ife vmlinux 0xffff0000085d0c6c

> [  184.582802] sp : ffff8000b964b970
> [  184.586108] x29: ffff8000b964b970 x28: ffff8000b9584800 
> [  184.591412] x27: ffff8000b964bcc8 x26: ffff8000b9461000 
> [  184.596716] x25: 0000000000000000 x24: 0000000000000000 
> [  184.602019] x23: 00000000ffff8000 x22: ffff8000b964ba1c 
> [  184.607322] x21: ffff8000b964ba1c x20: 00000000ffff8000 
> [  184.612626] x19: ffff8000bb7dc400 x18: 0000000000000000 
> [  184.617928] x17: 0000000000000001 x16: ffff0000081f79e8 
> [  184.623230] x15: 0000000000497000 x14: 0000000000000000 
> [  184.628532] x13: 0000000000000001 x12: 0000000005cc6000 
> [  184.633835] x11: 0000000000000000 x10: ffff8000bc16bf00 
> [  184.639138] x9 : 0000000000000000 x8 : 0000000000000000 
> [  184.644441] x7 : ffff8000bff68908 x6 : 0000000000000000 
> [  184.649742] x5 : ffff000008fc9f00 x4 : ffff8000bb7aa800 
> [  184.655044] x3 : 0000000000000002 x2 : ffff8000b964ba1c 
> [  184.660347] x1 : 000000003fffe000 x0 : 0000000000000000 

> [  185.178203] [<ffff0000085d0c6c>] regcache_flat_read+0x14/0x20
> [  185.183939] [<ffff0000085cce60>] _regmap_read+0x98/0xe8
> [  185.189155] [<ffff0000085cd218>] _regmap_update_bits+0xa0/0xf0
> [  185.194978] [<ffff0000085ce1d8>] regmap_update_bits_base+0x60/0x90
> [  185.201152] [<ffff000008856c44>] snd_soc_component_update_bits+0x24/0x40

AFAICT, these don't implicitly access current as part of generating the
map pointer, so the dodgy pointer must have been generated above this
level.

At this level I can't see why current would be involved at all. Beyond this
point it's rather painful to follow the backtrace due to inlining.

> [  185.207843] [<ffff00000884e7f4>] dapm_power_widgets+0x474/0x730
> [  185.213751] [<ffff00000884eb2c>] soc_dapm_mux_update_power.isra.29+0x7c/0xa0
> [  185.220787] [<ffff00000884eb9c>] snd_soc_dapm_mux_update_power+0x4c/0x88
> [  185.227479] [<ffff00000886bd04>] tegra210_xbar_put_value_enum+0x1b4/0x228
> [  185.234256] [<ffff000008830110>] snd_ctl_elem_write+0x110/0x188
> [  185.240165] [<ffff000008830610>] snd_ctl_ioctl+0xd0/0x798
> [  185.245557] [<ffff0000081f7354>] do_vfs_ioctl+0xa4/0x738
> [  185.250859] [<ffff0000081f7a74>] SyS_ioctl+0x8c/0xa0
> [  185.255818] [<ffff000008082f30>] el0_svc_naked+0x24/0x28
> [  185.261121] Code: 52800000 b941c883 f9410084 1ac32421 (b8615881) 
> [  185.267223] ---[ end trace 5f6a6332822eca30 ]---
> 
> Bisecting the panic ends up at this patch and reverting it on top of v4.10 prevents this from
> occurring. 
> 
> The occurs when I start playing audio on Tegra210 using tinymix. I do have some out-of-tree
> patches for Tegra audio that I am using when seeing this but I have been using those for
> probably a year or so, as I am gradually upstreaming bits.
> 
> I am a bit flummoxed by the above, any thoughts?

Likewise. :/

It could just be that this happens to change the alignment/size of things, and
unmasks a latent bug. Possibly, the removal of volatile has allowed some code
to be reordered, highlighting missing barriers/synchronisation.

Maybe we are generating current wrong in some case, though I can't see how, and
this is the only such report I've seen.

If the commit in question is resulting in get_current() behaving differently,
it *might* be possible to detect with the hack below. I haven't seen it blow up
on my test systems.

Otherwise, it might be worth giving KASAN a go; that might detect data
corruption. If you have a recent enough toolchain, you only need enable
CONFIG_KASAN. This will make your kernel Image a fair amount larger.

Thanks,
Mark.

---->8----
diff --git a/arch/arm64/include/asm/current.h b/arch/arm64/include/asm/current.h
index 86c4041..2093103 100644
--- a/arch/arm64/include/asm/current.h
+++ b/arch/arm64/include/asm/current.h
@@ -1,6 +1,7 @@
 #ifndef __ASM_CURRENT_H
 #define __ASM_CURRENT_H
 
+#include <linux/bug.h>
 #include <linux/compiler.h>
 
 #include <asm/sysreg.h>
@@ -13,7 +14,7 @@
  * We don't use read_sysreg() as we want the compiler to cache the value where
  * possible.
  */
-static __always_inline struct task_struct *get_current(void)
+static __always_inline struct task_struct *__get_cached_current(void)
 {
        unsigned long sp_el0;
 
@@ -22,6 +23,19 @@ static __always_inline struct task_struct *get_current(void)
        return (struct task_struct *)sp_el0;
 }
 
+static __always_inline struct task_struct *__get_uncached_current(void)
+{
+       return (struct task_struct *)read_sysreg(sp_el0);
+}
+
+static __always_inline struct task_struct *get_current(void)
+{
+       struct task_struct *cur = __get_cached_current();
+       BUG_ON(cur != __get_uncached_current());
+
+       return cur;
+}
+
 #define current get_current()
 
 #endif /* __ASSEMBLY__ */
