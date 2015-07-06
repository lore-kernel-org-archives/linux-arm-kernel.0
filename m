From: Nathan_Lynch@mentor.com (Nathan Lynch)
Date: Mon, 6 Jul 2015 08:41:04 -0500
Subject: VDSO build failure: collect2: fatal error: cannot find 'ld'
In-Reply-To: <20150706065408.GI3139@tarshish>
References: <20150706065408.GI3139@tarshish>
Message-ID: <559A8570.6080602@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/06/2015 01:54 AM, Baruch Siach wrote:
> In commit log d2b30cd4b722 (ARM: 8384/1: VDSO: force use of BFD linker, 
> 2015-06-03) you said:
> 
>     Note: one limitation of this is that if the toolchain is configured
>     to use gold by default, and the bfd linker is not in $PATH, the VDSO
>     build will fail:
>     
>       VDSO    arch/arm/vdso/vdso.so.raw
>     collect2: fatal error: cannot find 'ld'
>     
>     This will happen if CROSS_COMPILE begins with a path such as
>     /opt/bin/arm-linux-gnu- but /opt/bin is not in $PATH.  This is
>     considered an acceptable corner-case limitation and is easily worked
>     around.
> 
> I see this build failure here with Sourcery CodeBench Lite 2014.05 even 
> though:
> 
> 	1. This toolchain doesn't include the gold linker at all
> 
> 	2. I have the arm-2014.05/bin/ directory in my $PATH
> 
> 	3. My CROSS_COMPILE is set to 'arm-none-linux-gnueabi-'
> 
> Reverting d2b30cd4b722 on v4.2-rc1 fixes the build failure.


Thanks for the detailed report; I have been able to recreate this.

This seems to be happening because the compiler supports -fuse-ld=bfd,
but the toolchain does not contain a "arm-none-linux-gnueabi-ld.bfd"
executable: creating a symlink arm-none-linux-gnueabi-ld.bfd =>
arm-none-linux-gnueabi-ld in arm-2014.05/bin/ allows the build to succeed.

I'm not sure whether this is a toolchain bug or incorrect expectations
on my part, but I'm not eager to break a toolchain that used to work.  I
think the least bad resolution is to use cc-ldoption for detecting
whether -fuse-ld=bfd will work.  The tradeoff is that if the vdso link
is attempted with gold we'll get a marginally less user-friendly error
message.

Baruch, can you confirm the patch below fixes it for you?

diff --git a/arch/arm/vdso/Makefile b/arch/arm/vdso/Makefile
index 9d259d94e429..1160434eece0 100644
--- a/arch/arm/vdso/Makefile
+++ b/arch/arm/vdso/Makefile
@@ -14,7 +14,7 @@ VDSO_LDFLAGS += -Wl,-z,max-page-size=4096
-Wl,-z,common-page-size=4096
 VDSO_LDFLAGS += -nostdlib -shared
 VDSO_LDFLAGS += $(call cc-ldoption, -Wl$(comma)--hash-style=sysv)
 VDSO_LDFLAGS += $(call cc-ldoption, -Wl$(comma)--build-id)
-VDSO_LDFLAGS += $(call cc-option, -fuse-ld=bfd)
+VDSO_LDFLAGS += $(call cc-ldoption, -fuse-ld=bfd)

 obj-$(CONFIG_VDSO) += vdso.o
 extra-$(CONFIG_VDSO) += vdso.lds
