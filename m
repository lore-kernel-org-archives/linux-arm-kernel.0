From: nschichan@freebox.fr (Nicolas Schichan)
Date: Mon, 24 Aug 2015 15:05:51 +0200
Subject: Prevent list poison values from being mapped by userspace
 processes
In-Reply-To: <20150821133043.GV7557@n2100.arm.linux.org.uk>
References: <CABXk95C=CpeL4mNmS6-jJ-0bMJf6fawwfs6DM1-p8FctTEFbpw@mail.gmail.com>
 <20150821133043.GV7557@n2100.arm.linux.org.uk>
Message-ID: <55DB16AF.7090607@freebox.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/21/2015 03:30 PM, Russell King - ARM Linux wrote:
> On Tue, Aug 18, 2015 at 02:42:44PM -0700, Jeffrey Vander Stoep wrote:
>> List poison pointer values point to memory that is mappable by
>> userspace. i.e. LIST_POISON1 = 0x00100100 and LIST_POISON2 =
>> 0x00200200. This means poison values can be valid pointers controlled
>> by userspace and can be used to exploit the kernel as demonstrated in
>> a recent blackhat talk:
>> https://www.blackhat.com/docs/us-15/materials/us-15-Xu-Ah-Universal-Android-Rooting-Is-Back-wp.pdf
>>
>> Can these poison values be moved to an area not mappable by userspace
>> on 32 bit ARM?
> 
> As was discussed privately before your message, both Catalin and myself
> agreed that this is not possible, and I proposed alternatives which were
> feasible.
> 
> I have now implemented the domain access alternative which I mentioned
> during that discussion, which is suitable for all non-LPAE setups, which
> has the effect of blocking almost all implicit kernel accesses to
> userspace, thereby substantially reducing the possibility for an attack
> similar to that given in the above paper.
> 
> It should be said that with the following patches applied, it won't stop
> the original bug being used to crash the system (that's already been
> fixed) but it will prevent userspace being able to mask the crash, and
> therefore prevent such use-after-free bugs being used to gain privileges.
> 
> This approach also covers low-vector CPUs as well, with one caveat: the
> lower 1MB of userspace will remain accessible to the kernel due to the
> need for the vectors to remain visible.  Doing otherwise crashes the
> machine on the first exception event.  So here, we offer a "best efforts"
> implementation rather than something which completely blocks userspace
> access from kernel space.
> 
> This is not a simple fix - it's quite involved, and it changes a fair
> number of places in the kernel.  It needs time to be proven before any
> thought can be given to backporting these changes to stable kernels.
> It would be good to get some testing of these changes.

Hello Russell,

I gave your patch serie a try on ARMv5/kirkwood (backported on a v4.1 kernel)
and at first I got the following panic just after the kernel transitioned
to userland (with CONFIG_CPU_SW_DOMAIN_PAN=y):

[   13.505419] Freeing unused kernel memory: 180K (c0813000 - c0840000)
[   13.535671] Unhandled fault: page domain fault (0x01b) at 0xb6ec605c
[   13.542056] pgd = df7c0000
[   13.544768] [b6ec605c] *pgd=1ec1f831, *pte=008b618f, *ppte=008b6aae
[   13.551085] Internal error: : 1b [#1] ARM
[   13.555109] Modules linked in:
[   13.558184] CPU: 0 PID: 1 Comm: init Not tainted 4.1.0-00341-gde5a42f-dirty #19
[   13.565522] Hardware name: FBXGW1R
[   13.572596] task: df442000 ti: df450000 task.ti: df450000
[   13.578026] PC is at not_thumb+0x0/0x1c
[   13.581879] LR is at __dabt_usr+0x4c/0x60
[   13.585904] pc : [<c0013f4c>]    lr : [<c000dbcc>]    psr: 40000093
[   13.585904] sp : df451fb0  ip : 00000051  fp : be860f18
[   13.597429] r10: b6f00920  r9 : b6ed83b3  r8 : 00053977
[   13.602671] r7 : 0005397f  r6 : ffffffff  r5 : 20000010  r4 : b6ec605c
[   13.609228] r3 : be860fdf  r2 : df451fb0  r1 : 00000017  r0 : b6ed83a2
[   13.615786] Flags: nZcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
[   13.623040] Control: 0005397f  Table: 1f7c0000  DAC: 00000051
[   13.628811] Process init (pid: 1, stack limit = 0xdf450190)
[   13.634402] Stack: (0xdf451fb0 to 0xdf452000)
[   13.638773] 1fa0:                                     be860fdf b6ed83a2
00000010 00000048
[   13.646991] 1fc0: be860f14 be860e50 00000000 b6ed83a2 00000003 b6ed83b3
b6f00920 be860f18
[   13.655205] 1fe0: be860ee8 be860e38 b6ea1ee4 b6ec605c 20000010 ffffffff
29211822 602a0511
[   13.663425] [<c0013f4c>] (not_thumb) from [<00000048>] (0x48)
[   13.669200] Code: 03833b02 e3130b02 03811b02 eaffd4a2 (05943000)
[   13.675317] ---[ end trace f412d29360772faf ]---
[   13.684219] Kernel panic - not syncing: Fatal exception
[   13.696487] Rebooting in 10 seconds..

I have tracked this to the attempt made by the code in
arch/arm/mm/abort-ev5t.S to read the fault instruction which in this
case is in unserspace:

	ldreq	r3, [r4]			@ read aborted ARM instruction

The following (crude) changes seemed to fix it:

diff --git a/arch/arm/mm/abort-ev5t.S b/arch/arm/mm/abort-ev5t.S
index a0908d4..fc3a219 100644
--- a/arch/arm/mm/abort-ev5t.S
+++ b/arch/arm/mm/abort-ev5t.S
@@ -15,12 +15,33 @@
  * abort here if the I-TLB and D-TLB aren't seeing the same
  * picture.  Unfortunately, this does happen.  We live with it.
  */
+
+        .macro  uaccess_disable, tmp
+#ifdef CONFIG_CPU_SW_DOMAIN_PAN
+       /*
+        * Whenever we re-enter userspace, the domains should always be
+        * set appropriately.
+        */
+       mov     \tmp, #DACR_UACCESS_DISABLE
+       mcr     p15, 0, \tmp, c3, c0, 0         @ Set domain register
+#endif
+        .endm
+
+       .macro uaccess_enable, tmp
+#ifdef CONFIG_CPU_SW_DOMAIN_PAN
+       mov     \tmp, #DACR_UACCESS_ENABLE
+       mcr     p15, 0, \tmp, c3, c0, 0         @ set domain register
+#endif
+       .endm
+
        .align  5
 ENTRY(v5t_early_abort)
        mrc     p15, 0, r1, c5, c0, 0           @ get FSR
        mrc     p15, 0, r0, c6, c0, 0           @ get FAR
        do_thumb_abort fsr=r1, pc=r4, psr=r5, tmp=r3
+       uaccess_enable ip
        ldreq   r3, [r4]                        @ read aborted ARM instruction
+       uaccess_disable ip
        bic     r1, r1, #1 << 11                @ clear bits 11 of FSR
        do_ldrd_abort tmp=ip, insn=r3
        tst     r3, #1 << 20                    @ check write

It looks like ARMv6 with CONFIG_ARM_ERRATA_326103 enabled will suffer
from the same issue as it reads the faulty ARM instruction, possibly from
userland (see arch/arm/mm/abort-ev6.S).

With the changes above, userland boots fine and attempts to
dereference LIST_POISON1 from the kernel results the expected "page
domain fault".

To test that I mapped LIST_POISON1 from user space via mmap() and
triggered the fault by reading from /proc/cpu/alignment. I modified the
code showing /proc/cpu/alignment to access LIST_POISON1. Without your
patch serie the access to LIST_POISON1 goes through without a hitch.

Also, when CONFIG_CPU_SW_DOMAIN_PAN is not set, the DACR_INIT constant is
setup with (domain_val(DOMAIN_USER, DOMAIN_NOACCESS) which will cause the
kernel to die with a "page domain fault" when running init.

The following (crude patch) works around that:

diff --git a/arch/arm/include/asm/domain.h b/arch/arm/include/asm/domain.h
index 0c37397..e878129 100644
--- a/arch/arm/include/asm/domain.h
+++ b/arch/arm/include/asm/domain.h
@@ -57,11 +57,19 @@
 #define domain_mask(dom)       ((3) << (2 * (dom)))
 #define domain_val(dom,type)   ((type) << (2 * (dom)))

+#ifdef CONFIG_CPU_SW_DOMAIN_PAN
 #define DACR_INIT \
        (domain_val(DOMAIN_USER, DOMAIN_NOACCESS) | \
         domain_val(DOMAIN_KERNEL, DOMAIN_MANAGER) | \
         domain_val(DOMAIN_IO, DOMAIN_CLIENT) | \
         domain_val(DOMAIN_VECTORS, DOMAIN_CLIENT))
+#else
+#define DACR_INIT \
+       (domain_val(DOMAIN_USER, DOMAIN_CLIENT) | \
+        domain_val(DOMAIN_KERNEL, DOMAIN_MANAGER) | \
+        domain_val(DOMAIN_IO, DOMAIN_CLIENT) | \
+        domain_val(DOMAIN_VECTORS, DOMAIN_CLIENT))
+#endif

 #define __DACR_DEFAULT \
        domain_val(DOMAIN_KERNEL, DOMAIN_CLIENT) | \


Thanks,

-- 
Nicolas Schichan
