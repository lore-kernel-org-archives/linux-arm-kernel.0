From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 18 Jul 2018 14:33:08 +0200
Subject: [PATCH] mmc: sunxi: remove output of virtual base address
In-Reply-To: <7cda9046-ec72-02d9-6474-0f4fbaa7e170@arm.com>
References: <20180717100958.12042-1-andre.przywara@arm.com>
 <20180717114348.lv2ngzrekp5zpcmk@flea.home>
 <7cda9046-ec72-02d9-6474-0f4fbaa7e170@arm.com>
Message-ID: <20180718123308.vqhr5ydg6wsoavgq@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 18, 2018 at 12:19:41PM +0100, Andre Przywara wrote:
> Hi,
> 
> On 17/07/18 12:43, Maxime Ripard wrote:
> > 1;5202;0c
> > On Tue, Jul 17, 2018 at 11:09:58AM +0100, Andre Przywara wrote:
> >> Recent Linux versions refuse to print actual virtual kernel addresses,
> >> to not give a hint about the location of the kernel in a randomized virtual
> >> address space. This affects the output of the sunxi MMC controller
> >> driver, which now produces the rather uninformative line:
> >>
> >> [    1.482660] sunxi-mmc 1c0f000.mmc: base:0x(____ptrval____) irq:8
> >>
> >> Since the virtual base address is not really interesting in the first
> >> place, let's just drop this value. We have the physical address as part
> >> of the DT node name, which is way more useful for debugging purposes.
> >>
> >> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> >> ---
> >>  drivers/mmc/host/sunxi-mmc.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> >> index 8e7f3e35ee3d..811b08d2d0f2 100644
> >> --- a/drivers/mmc/host/sunxi-mmc.c
> >> +++ b/drivers/mmc/host/sunxi-mmc.c
> >> @@ -1407,7 +1407,7 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
> >>  	if (ret)
> >>  		goto error_free_dma;
> >>  
> >> -	dev_info(&pdev->dev, "base:0x%p irq:%u\n", host->reg_base, host->irq);
> >> +	dev_info(&pdev->dev, "irq:%u\n", host->irq);
> > 
> > Can't we just remove it? It doesn't look like it brings much value anyway.
> 
> Yes, the IRQ value is the virtual Linux number, so equally
> non-informative. But this line is the only info message left from the
> mmc driver, so since we have scary "deferring probe" messages before,
> I'd rather leave this "success!" message in, to help debugging:
> # dmesg | grep mmc
> [    1.314211] sunxi-mmc 1c0f000.mmc: could not find pctldev for node
> /soc/pinctrl at 1c20800/mmc0-pins, deferring probe
> [    1.324705] sunxi-mmc 1c11000.mmc: could not find pctldev for node
> /soc/pinctrl at 1c20800/mmc2-pins, deferring probe
> [    1.737310] sunxi-mmc 1c0f000.mmc: irq:6
> [    1.771255] sunxi-mmc 1c11000.mmc: irq:7
> [    1.787003] mmc0: new high speed SDHC card at address 1234
> [    1.796029] mmcblk0: mmc0:1234 SA08G 7.21 GiB
> [    1.809093]  mmcblk0: p1 p2 p3
> ....
>
> We could just say something like: "initialized.".

Then maybe that what we should have, it's much more informative than a
interrupt number that's supposed to meant that the driver was probed
sucessfully :)

> It would be even more useful if we could print the type of MMC: SD
> card, SDIO, eMMC, but apart from eMMC vs. MMC0/1 for the A64 we
> don't have this information (not even the index number) at this
> level, I think.

My understanding is that you don't have access to that information at
probe time. Once the host is probed, the MMC device is going to be
discovered, and only then you'll be able to identify which card is
connected on the other side.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180718/01249aa1/attachment.sig>
