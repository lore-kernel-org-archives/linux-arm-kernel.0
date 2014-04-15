From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Tue, 15 Apr 2014 11:44:33 +0100
Subject: Change of TEXT_OFFSET for multi_v7_defconfig
Message-ID: <534D0D91.8020406@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Folks

I've just been rebasing some of my development branches against v3.15rc1
and observed some boot regressions due to TEXT_OFFSET changing from
0x8000 to 0x208000.

Now the boot regression turned out to be fault in the JTAG boot tools I
was using (it had internally hardcoded to TEXT_OFFSET to 0x8000 when
calculating what physical load address to use). I've fixed the JTAG
loader and my own boards now boots fine.

However this did get me looking at what had causes the offset to change.
I think that as some of the Qualcomm platforms have been converted to
multi-arch then, for the first time some older code in arch/arm/Kernel
gets enabled on the multi_v7 kernels:

--- cut here ---
textofs-y       := 0x00008000
textofs-$(CONFIG_ARCH_CLPS711X) := 0x00028000
# We don't want the htc bootloader to corrupt kernel during resume
textofs-$(CONFIG_PM_H1940)      := 0x00108000
# SA1111 DMA bug: we don't want the kernel to live in precious DMA-able
memory
ifeq ($(CONFIG_ARCH_SA1100),y)
textofs-$(CONFIG_SA1111) := 0x00208000
endif
textofs-$(CONFIG_ARCH_MSM7X30) := 0x00208000
textofs-$(CONFIG_ARCH_MSM8X60) := 0x00208000
textofs-$(CONFIG_ARCH_MSM8960) := 0x00208000
--- cut here ---

It strikes me as a bit of a "bad smell" that enabling architecture
options in the multi-arch kernel causes the text offset to jump about
(not least because more than one platform might seek to change the text
offset).

Do the ARCH_QCOM platforms (ARCH_MSM8X60 & ARCH_MSM8960) still require a
special text offset?


Daniel.
