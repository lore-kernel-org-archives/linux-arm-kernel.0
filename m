From: jacobtiju@gmail.com (Tiju Jacob)
Date: Thu, 24 Nov 2011 09:47:47 +0530
Subject: Onenand flash request_mem_region() fails with ERROR -16
Message-ID: <CADAg6uztghgxU-e6sCDe-Dv551JgmbcVrV81vDH6f9oRi1L=vA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

I'm working with a custom made board with OMAP 2430. On upgrading the
kernel from linux-3.0.8 to linux-3.1.1, the One Nand seems to be
failing with Error -16.

onenand-flash: probe of onenand-flash failed with error -16

This happens because the request_mem_region() fails in
drivers/mtd/onenand/generic.c

if (!request_mem_region(res->start, size, dev_name(&pdev->dev))) {
		err = -EBUSY;
		goto out_free_info;
}

Our one-nand is mapped to 0x00000000 location and we request for a
length of 128K which works fine in all previous kernels.

When cat/proc/iomem is executed, the following is displayed.

00000000-0001ffff : onenand-flash
  00000000-00000000 : omap-mcbsp.5
    00000000-00000000 : omap-mcbsp.4
      00000000-00000000 : omap-mcbsp.3
        00000000-00000000 : omap-mcbsp.2
          00000000-00000000 : omap-mcbsp.1
          00000000-00000000 : omap_dma_system.0
          00000000-00000000 : omap2_mcspi.3
          00000000-00000000 : omap2_mcspi.2
          00000000-00000000 : omap2_mcspi.1
          00000000-00000000 : musb-omap2430
          00000000-00000000 : omap_uart.2
          00000000-00000000 : omap_uart.1
          00000000-00000000 : omap_uart.0
          00000000-00000000 : omap_hsmmc.0
          00000000-00000000 : omap_gpio.4
          00000000-00000000 : omap_gpio.3
          00000000-00000000 : omap_gpio.2
          00000000-00000000 : omap_gpio.1
          00000000-00000000 : omap_gpio.0
08000300-0800030f : smc91x
  08000300-0800030f : smc91x
48056000-48056fff : omap_dma_system.0
4806a000-4806bfff : omap_uart.0
  4806a000-4806bfff : omap_uart
4806c000-4806c3ff : omap_uart.1
  4806c000-4806c3ff : omap_uart
4806e000-4806e3ff : omap_uart.2
  4806e000-4806e3ff : omap_uart
48074000-480740ff : mpu
48076000-480760ff : mpu
4808c000-4808c0ff : mpu
4808e000-4808e0ff : mpu
48096000-480960ff : mpu
48098000-480980ff : omap2_mcspi.1
  48098000-480980ff : omap2_mcspi.1
4809a000-4809a0ff : omap2_mcspi.2
  4809a000-4809a0ff : omap2_mcspi.2
4809c000-4809c1ff : omap_hsmmc.0
  4809c000-4809c1ff : omap_hsmmc
480a0000-480a004f : omap_rng
  480a0000-480a004f : omap_rng
480ac000-480acfff : musb-omap2430
480b6000-480b61ff : omap_gpio.4
480b8000-480b80ff : omap2_mcspi.3
  480b8000-480b80ff : omap2_mcspi.3
4900c000-4900c1ff : omap_gpio.0
4900e000-4900e1ff : omap_gpio.1
49010000-490101ff : omap_gpio.2
49012000-490121ff : omap_gpio.3
80000000-87ffffff : System RAM
  80008000-8038556f : Kernel text
  803b0000-80412313 : Kernel data


How do many devices get the address 00000000-00000000 where actually
Onenand's address is 00000000-0001ffff? All the devices having the
address 00000000-00000000 already has a valid address space.

To see the behaviour, I try remapping the One-nand to CS6. Then
OneNand registration is successful and gets the address but the
devices at 00000000 address remains the same.

00000000-00000000 : omap-mcbsp.5
  00000000-00000000 : omap-mcbsp.4
    00000000-00000000 : omap-mcbsp.3
      00000000-00000000 : omap-mcbsp.2
        00000000-00000000 : omap-mcbsp.1
          00000000-00000000 : omap_dma_system.0
          00000000-00000000 : omap2_mcspi.3
          00000000-00000000 : omap2_mcspi.2
          00000000-00000000 : omap2_mcspi.1
          00000000-00000000 : musb-omap2430
          00000000-00000000 : omap_uart.2
          00000000-00000000 : omap_uart.1
          00000000-00000000 : omap_uart.0
          00000000-00000000 : omap_hsmmc.0
          00000000-00000000 : omap_gpio.4
          00000000-00000000 : omap_gpio.3
          00000000-00000000 : omap_gpio.2
          00000000-00000000 : omap_gpio.1
          00000000-00000000 : omap_gpio.0
08000300-0800030f : smc91x
  08000300-0800030f : smc91x
20000000-2001ffff : onenand-flash

If someone's come across this issue, do let know how to fix it.

Thanks in Advance.
Regards,
--TJ
