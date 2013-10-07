From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 07 Oct 2013 13:03:13 -0700
Subject: Bug: kbuild always rebuilds compressed images on ARM
In-Reply-To: <20131005131706.GY12758@n2100.arm.linux.org.uk>
References: <20131005131706.GY12758@n2100.arm.linux.org.uk>
Message-ID: <52531381.8070607@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/05/13 06:17, Russell King - ARM Linux wrote:
> Hi,
>
> I've noticed that kbuild always rebuilds the compressed piggy image
> on ARM.  Here's the output from running make with V=2:
>
>   CALL    /home/rmk/git/linux-rmk/scripts/checksyscalls.sh - due to target missing
>   CHK     include/generated/compile.h
>   Kernel: arch/arm/boot/Image is ready
>   Building modules, stage 2.
>   LZO     arch/arm/boot/compressed/piggy.lzo - due to command line change
>   MODPOST 17 modules - due to target is PHONY
>   AS      arch/arm/boot/compressed/piggy.lzo.o - due to: arch/arm/boot/compressed/piggy.lzo
>   LD      arch/arm/boot/compressed/vmlinux - due to: arch/arm/boot/compressed/piggy.lzo.o
>   OBJCOPY arch/arm/boot/zImage - due to: arch/arm/boot/compressed/vmlinux
>   Kernel: arch/arm/boot/zImage is ready
>
> and with V=1:
>
> ...
> make -f /home/rmk/git/linux-rmk/scripts/Makefile.build obj=arch/arm/boot/compressed arch/arm/boot/compressed/vmlinux
> make -f /home/rmk/git/linux-rmk/scripts/Makefile.modpost
>   find .tmp_versions -name '*.mod' | xargs -r grep -h '\.ko$' | sort -u | sed 's/\.ko$/.o/' | scripts/mod/modpost -m -a -o /home/rmk/git/build/imx6/Module.symvers    -S  -s -T -
>   (cat arch/arm/boot/compressed/../Image | lzop -9 && printf \\010\\224\\034\\002) > arch/arm/boot/compressed/piggy.lzo || (rm -f arch/arm/boot/compressed/piggy.lzo ; false)

There are double slashes here '\\'

> make -f /home/rmk/git/linux-rmk/scripts/Makefile.fwinst obj=firmware __fw_modbuild
> ...
>
> The arch/arm/boot/compressed/.piggy.lzo.cmd file contains this:
>
> cmd_arch/arm/boot/compressed/piggy.lzo := (cat arch/arm/boot/compressed/../Image | lzop -9 && printf \\\\010\\\\224\\\\034\\\\002) > arch/arm/boot/compressed/piggy.lzo || (rm -f arch/arm/boot/compressed/piggy.lzo ; false)

But then there are quadruple slashes here '\\\\'. That seems to be
causing kbuild to rebuild each time.

>
> Any ideas why it thinks that the command has changed?

This hack seems to work, but I'm not convinced it's the right solution.

diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 547e15d..bfc0b79 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -209,7 +209,7 @@ endif
 # >$< substitution to preserve $ when reloading .cmd file
 # note: when using inline perl scripts [perl -e '...$$t=1;...']
 # in $(cmd_xxx) double $$ your perl vars
-make-cmd = $(subst \\,\\\\,$(subst \#,\\\#,$(subst $$,$$$$,$(call escsq,$(cmd_$(1))))))
+make-cmd = $(subst \#,\\\#,$(subst $$,$$$$,$(call escsq,$(cmd_$(1)))))
 
 # Find any prerequisites that is newer than target or that does not exist.
 # PHONY targets skipped in both cases.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
