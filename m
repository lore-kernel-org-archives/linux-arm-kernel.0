From: david.yangshuai@gmail.com (David Yang)
Date: Wed, 28 Jul 2010 14:19:05 +0800
Subject: Questions about FPU and NEON on Cortex-A9 with armv7 instructions!
Message-ID: <AANLkTinA_ZNdNwx2R-6C9LBQ=4i8uMVpmVFCRaKkS=Xs@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,everyone

       Because I need use the NEON on Cortex-A9, so I want to add the
parameter : -mfpu=neon -mfloat-abi=softfp to the KBUILD_CFLAGS and
KBUILD_AFLAGS in the Makefile of the top dir like below:

################################################################################################
      ifdef CONFIG_NEON
              KBUILD_CFLAGS   += -march=armv7-a -mtune=cortex-a9
-mfpu=neon -ftree-vectorize -mfloat-abi=softfp -O3
              KBUILD_AFLAGS   += -march=armv7-a -mtune=cortex-a9
-mfpu=neon -ftree-vectorize -mfloat-abi=softfp -O3
      endif
#################################################################################################

But I fount it conflicts with  one parameter in the arch/arm/Makefile,
the parameter: -msoft-float, like below:

#################################################################################################
KBUILD_CFLAGS  +=$(CFLAGS_ABI) $(CFLAGS_THUMB2) $(arch-y) $(tune-y)
$(call cc-option,-mshort-load-bytes,$(call
cc-option,-malignment-traps,)) -msoft-float -Uarm

KBUILD_AFLAGS  +=$(CFLAGS_ABI) $(AFLAGS_THUMB2) $(arch-y) $(tune-y)
-include asm/unified.h -msoft-float
#################################################################################################

When I deleted the -msoft-float in the arch/arm/Makefile,the make of
the kernel could be completed.

My Questions:

1,What should I do to complete the make of the kernel without breaking
the compatible ,I mean do not modify the arch/arm/Makefile
    Or that change is inevitable?

2,I think the NEON is the extension of the VFP unit. If I use
-msoft-float , then the hardware of NEON and VFP will not be used?
   What should I do ,if I want to use both hardware NEON and VFP. Or I
just could use only one of them , with the switch between using
-mfpu=vfp and using -mfpu=neon?


Thanks!
