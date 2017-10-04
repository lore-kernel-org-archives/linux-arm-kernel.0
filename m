From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 4 Oct 2017 14:24:36 +0100
Subject: [PATCH] arm64: Enable MRS emulation early
In-Reply-To: <20171004124819.GU3611@e103592.cambridge.arm.com>
References: <20171004094805.24009-1-suzuki.poulose@arm.com>
 <20171004101425.GB23092@leverpostej>
 <20171004111040.vumbc3bk7sj2enc6@armageddon.cambridge.arm.com>
 <20171004113207.GT3611@e103592.cambridge.arm.com>
 <20171004113628.t4gv7srwpvbwwbsl@armageddon.cambridge.arm.com>
 <20171004124819.GU3611@e103592.cambridge.arm.com>
Message-ID: <20171004132435.yt54irsc7vwht5dy@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 04, 2017 at 01:48:19PM +0100, Dave P Martin wrote:
> On Wed, Oct 04, 2017 at 12:36:29PM +0100, Catalin Marinas wrote:
> > On Wed, Oct 04, 2017 at 12:32:07PM +0100, Dave P Martin wrote:
> 
> [...]
> 
> > > I don't think the hwcaps shouldn't change after entry to userspace,
> > > so it really doesn't matter whether HWCAP_CPUID is set before or
> > > after registration: for userspace it should all already have happened.
> > 
> > Good point, I forgot about this.
> > 
> > > It looks to me like all initcalls are called in the same kernel thread
> > > that execs the initramfs init process, before the exec.
> > > 
> > > So I still don't see how a built-in late initcall can not have been
> > > called before entry to userspace.
> > > 
> > > The patch seems to demonstrate that I'm wrong though.
> > > What am I missing?
> > 
> > I also wondered about this. I think is the kernel invoking modprobe
> > before the actual init/linuxrc in an initrd.
> 
> Ah, right.  Could that be a bug, do you think?
> 
> I wonder whether it's even well-defined how early that can happen.
> i.e., which initcall level is guaranteed early enough to prevent this?

I don't think it's a bug, probably just an undocumented convention. I
don't know which module triggered this specific issue but, for example,
I see the possibility of request_module in the ipv4 code only after
fs_initcall(). Let's hope nothing executes user space prior to
arch_initcall().

usermodehlper_enable() is called in do_basic_setup() prior to
do_initcalls(), so there is always a chance of someone calling user
space early. If we want some guarantee, maybe something like below:

diff --git a/init/main.c b/init/main.c
index 0ee9c6866ada..67040e570533 100644
--- a/init/main.c
+++ b/init/main.c
@@ -914,10 +914,16 @@ static void __init do_basic_setup(void)
 	driver_init();
 	init_irq_proc();
 	do_ctors();
-	usermodehelper_enable();
 	do_initcalls();
 }
 
+static int usermodehelper_init(void)
+{
+	usermodehelper_enable();
+	return 0;
+}
+arch_initcall_sync(usermodehelper_init);
+
 static void __init do_pre_smp_initcalls(void)
 {
 	initcall_t *fn;
