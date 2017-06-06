From: xieyisheng1@huawei.com (Yisheng Xie)
Date: Tue, 6 Jun 2017 19:08:00 +0800
Subject: [BUG] boot fail with ARM_LPAE and VMSPLIT_3G_OPT
Message-ID: <e971a7f8-c05d-d6bd-a637-e8ba0b2d659e@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I find when both enable CONFIG_ARM_LPAE=y and CONFIG_VMSPLIT_3G_OPT=y,
which mean use PAGE_OFFSET=0xB0000000 with ARM_LPE, the kernel will boot fail.
it stop after uncompressed:
--------
  Starting kernel ...

  Uart base = 0x20001000
  watchdog reg = 0x20013000
  dtb addr = 0x80840308
  Uncompressing Linux... done, booting the kernel.

--------

Meanwhile, I also tried to use CONFIG_VMSPLIT_2G/CONFIG_VMSPLIT_1G with ARM_LPAE,
it can boot successfully.

Is that a limitation of ARM_LPAE, which I not do get any info about this from spec?
If it do have the limitation, then we should be:
--------
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 4c1a35f..c0fcab6 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1416,6 +1416,7 @@ choice
        config VMSPLIT_3G
                bool "3G/1G user/kernel split"
        config VMSPLIT_3G_OPT
+               depends on !ARM_LPAE
                bool "3G/1G user/kernel split (for full 1G low memory)"
        config VMSPLIT_2G
                bool "2G/2G user/kernel split"



Any comment is more than welcome!

Thanks
Yisheng Xie
