From: kevin.brodsky@arm.com (Kevin Brodsky)
Date: Thu, 1 Nov 2018 18:29:08 +0000
Subject: [PATCH] arm64: makefile fix build of .i file in external module
 case
In-Reply-To: <20181030233710.5529-1-kamensky@cisco.com>
References: <20181030233710.5529-1-kamensky@cisco.com>
Message-ID: <807edb71-bc2e-caf3-f415-f1ccb632ac29@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/10/2018 23:37, Victor Kamensky wrote:
> After 'a66649dab350 arm64: fix vdso-offsets.h dependency' if
> one will try to build .i file in case of external kernel module,
> build fails complaining that prepare0 target is missing. This
> issue came up with SystemTap when it tries to build variety
> of .i files for its own generated kernel modules trying to
> figure given kernel features/capabilities.
>
> The issue is that prepare0 is defined in top level Makefile
> only if KBUILD_EXTMOD is not defined. .i file rule depends
> on prepare and in case KBUILD_EXTMOD defined top level Makefile
> contains empty rule for prepare. But after mentioned commit
> arch/arm64/Makefile would introduce dependency on prepare0
> through its own prepare target.

Good catch. I knew depending on prepare0 was not a great idea, but I still can't 
think of another way to enforce the right ordering for generating vdso-offsets.h.

> Fix it to put proper ifdef KBUILD_EXTMOD around code introduced
> by mentioned commit. It matches what top level Makefile does.	

This looks reasonable. Behaving differently based on KBUILD_EXTMOD is not 
particularly nice (no other arch/ Makefile does that), but then we are not supposed 
to be using prepare0 in the first place, so I don't think we have much of a choice. 
For sure we don't care about vdso-offsets.h when building a module.

> Signed-off-by: Victor Kamensky <kamensky@cisco.com>
Acked-by: Kevin Brodsky <kevin.brodsky@arm.com>

Thanks,
Kevin

> ---
> Test to reproduce the issue:
>
> [kamensky at kamensky-w541 m]$ cat hello.c
> #include <linux/module.h>
> #include <linux/printk.h>
>
> int
> init_module (void)
> {
>      printk(KERN_DEBUG "Hello, world\n");
>      return 0;
> }
>
> void
> cleanup_module(void)
> {
>      printk(KERN_ERR "Bye, got unloaded\n");
> }
>
> MODULE_LICENSE("GPL");
> [kamensky at kamensky-w541 m]$ cat Makefile
> obj-m := hello.o
> [kamensky at kamensky-w541 m]$ make -C /home/kamensky/linux M=`pwd`
> make: Entering directory '/home/kamensky/linux'
>    CC [M]  /home/kamensky/m/hello.o
>    Building modules, stage 2.
>    MODPOST 1 modules
>    CC      /home/kamensky/m/hello.mod.o
>    LD [M]  /home/kamensky/m/hello.ko
> make: Leaving directory '/home/kamensky/linux'
> [kamensky at kamensky-w541 m]$ make -C /home/kamensky/linux M=`pwd` hello.i
> make: Entering directory '/home/kamensky/linux'
> make: *** No rule to make target 'prepare0', needed by 'vdso_prepare'.  Stop.
> make: Leaving directory '/home/kamensky/linux'
> [kamensky at kamensky-w541 m]$
>
> After the fix:
>
> [kamensky at kamensky-w541 m]$ make -C /home/kamensky/linux M=`pwd` hello.i
> make: Entering directory '/home/kamensky/linux'
>    CPP [M] /home/kamensky/m/hello.i
> make: Leaving directory '/home/kamensky/linux'
> [kamensky at kamensky-w541 m]
>
>   arch/arm64/Makefile | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index 106039d25e2f..3016ccb41468 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -147,6 +147,7 @@ archclean:
>   	$(Q)$(MAKE) $(clean)=$(boot)
>   	$(Q)$(MAKE) $(clean)=$(boot)/dts
>   
> +ifeq ($(KBUILD_EXTMOD),)
>   # We need to generate vdso-offsets.h before compiling certain files in kernel/.
>   # In order to do that, we should use the archprepare target, but we can't since
>   # asm-offsets.h is included in some files used to generate vdso-offsets.h, and
> @@ -156,6 +157,7 @@ archclean:
>   prepare: vdso_prepare
>   vdso_prepare: prepare0
>   	$(Q)$(MAKE) $(build)=arch/arm64/kernel/vdso include/generated/vdso-offsets.h
> +endif
>   
>   define archhelp
>     echo  '* Image.gz      - Compressed kernel image (arch/$(ARCH)/boot/Image.gz)'
