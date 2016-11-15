From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 15 Nov 2016 23:55:04 +0000
Subject: specifying order of /dev/mmcblk devices via device-tree?
In-Reply-To: <20161115221002.GA1041@n2100.armlinux.org.uk>
References: <CAJ+vNU1g8nQedd06LeaD10YWUQ_UmdRToUMFKaTNT1aNY56b0g@mail.gmail.com>
 <20161028153755.GL5806@leverpostej>
 <CAJ+vNU26tx-1bLKNpzYJ0UCeFJ-SczZOca1dYdt5mCGDxAuKTQ@mail.gmail.com>
 <20161114190839.GS1041@n2100.armlinux.org.uk>
 <CAJ+vNU38XQBHt709S_z6Quvce6wcqLzRHFuN_bVZ_0eARa3=fw@mail.gmail.com>
 <20161115213510.GY1041@n2100.armlinux.org.uk>
 <CAJ+vNU2t5f=HQ94_GW-cry7DV3FsR9Vx-ck_E-eNuDk5vd-eaw@mail.gmail.com>
 <20161115221002.GA1041@n2100.armlinux.org.uk>
Message-ID: <20161115235503.GC1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 15, 2016 at 10:10:02PM +0000, Russell King - ARM Linux wrote:
> On Tue, Nov 15, 2016 at 01:39:42PM -0800, Tim Harvey wrote:
> > On Tue, Nov 15, 2016 at 1:35 PM, Russell King - ARM Linux
> > <linux@armlinux.org.uk> wrote:
> > > On Tue, Nov 15, 2016 at 12:27:53PM -0800, Tim Harvey wrote:
> > >> On Mon, Nov 14, 2016 at 11:08 AM, Russell King - ARM Linux
> > >> <linux@armlinux.org.uk> wrote:
> > >> > So, someone merged a patch which makes mmcblk devices follow the
> > >> > host controller numbering.
> > >> >
> > >> > Now my cubox-i fails to boot correctly because the SD card in the
> > >> > _only_ SD card slot now gets called "mmcblk1" and not "mmcblk0".
> > >> >
> > >> > USDHC1 is wired to the on-microsom WiFi, and never has anything
> > >> > remotely near a SD card or eMMC present.  So, this change is
> > >> > confusing on these platforms.
> > >> >
> > >> > Moreover, this is _going_ to break SolidRun distros if people upgrade
> > >> > their kernels.
> > >> >
> > >> > It may be appropriate for eMMC, but it's not appropriate everywhere.
> > >> >
> > >> > This is a user visible _regression_ in 4.9-rc.  Whoever did this,
> > >> > please revert whatever change caused this, and next time limit it
> > >> > to only eMMC.
> > >> >
> > >> > Thanks.
> > >>
> > >> I see the same thing on newer kernels, which is why I asked the
> > >> question. I didn't expect (or even want honestly) a non mmcblk0 boot
> > >> device and was looking for a way to control that via dt. Now I'm
> > >> understanding that to avoid this kind of bootloader/kernel dependence
> > >> issue I should be using UUID's to identify the boot device.
> > >>
> > >> >From my testing it looks like the change your looking for occurred
> > >> some time ago and is somewhere between 4.5 and 4.6 and not a 4.9
> > >> regression specifically.
> > >
> > > That depends how you look at it.  Yes, there's a change in 4.5 to 4.6
> > > which ties the block device number to the host device index, but that's
> > > really only part of the story here.
> > >
> > > 4.8 definitely identifies the SD card in iMX6 usdhc2 as "mmcblk0".
> > > 4.9-rc identifies the SD card as "mmcblk1".  This makes it a 4.9 change
> > > of behaviour - there can be no argument about that.
> > >
> > > Now, digging further into this today, it appears that:
> > >
> > > v4.8: usdhc2 was probed first, and is given mmc0.
> > >       usdhc1 is probed second, and is given mmc1.
> > >
> > > v4.9-rc: usdhc1 is probed first, and is given mmc0.
> > >          usdhc2 is probed second, and is given mmc1.
> > >
> > > I haven't yet been able to figure out why there's been this change
> > > of probe order.  There's no change that I can see in the iMX6 DT
> > > files that would account for this.
> > >
> > 
> > I bisected it and the commit your looking for is
> > 9aaf3437aa72ed5370bf32c99580a3fa2c330e3d
> 
> No it's not.
> 
> Let me try and put it plainer:
> 
> * Commit 9aaf3437aa72ed5370bf32c99580a3fa2c330e3d ties the mmc block
>   device number (mmcblkN) to the mmc host interface number (mmcN).
>   This change happened between 4.5 and 4.6.
> 
> * The change I'm seeing happened between 4.8 and 4.9-rc.  I'm not
>   seeing a change of behaviour between 4.5 and 4.6.
> 
> * The change I'm seeing changes the order of the physical device
>   associated with the hosts named mmc0 and mmc1 in the kernel.
> 
> * Because physical devices associated with the mmc0 and mmc1 hosts
>   swap over, the mmcblkN number changes due to the commit you point
>   out.
> 
> * So, the change that I'm seeing between 4.8 and 4.9-rc is not caused
>   by commit 9aaf3437aa72ed5370bf32c99580a3fa2c330e3d, but by something
>   else changing the order in which the two usdhc physical hardware
>   blocks get probed.
> 
> Does this make it clearer?

It turns out to be this commit:

commit 6eb1c9496b81680f2cd2e0eda06c531317e2e28d
Author: Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon Sep 19 01:16:44 2016 +0900

    clk: probe common clock drivers earlier

    Several SoCs implement platform drivers for clocks rather than
    CLK_OF_DECLARE().  Clocks should come earlier because they are
    prerequisites for many of other drivers.  It will help to mitigate
    EPROBE_DEFER issues.

    Also, drop the comment since it does not carry much value.

    Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
    Acked-by: Michael Turquette <mturquette@baylibre.com>
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

which changes the init order.  In 4.8, we get:

calling  mmc_pwrseq_simple_driver_init+0x0/0x20 @ 1
bus: 'platform': driver_probe_device: matched device usdhc1_pwrseq with driver pwrseq_simple
bus: 'platform': really_probe: probing driver pwrseq_simple with device usdhc1_pwrseq
platform usdhc1_pwrseq: Driver pwrseq_simple requests probe deferral
platform usdhc1_pwrseq: Added to deferred list
initcall mmc_pwrseq_simple_driver_init+0x0/0x20 returned 0 after 737 usecs

which then goes on to cause:

calling  sdhci_esdhc_imx_driver_init+0x0/0x20 @ 1
bus: 'platform': driver_probe_device: matched device 2190000.usdhc with driver sdhci-esdhc-imx
bus: 'platform': really_probe: probing driver sdhci-esdhc-imx with device 2190000.usdhc
platform 2190000.usdhc: Driver sdhci-esdhc-imx requests probe deferral
platform 2190000.usdhc: Added to deferred list

followed by:

bus: 'platform': driver_probe_device: matched device 2194000.usdhc with driver sdhci-esdhc-imx
bus: 'platform': really_probe: probing driver sdhci-esdhc-imx with device 2194000.usdhc
sdhci-esdhc-imx 2194000.usdhc: Got CD GPIO
driver: 'sdhci-esdhc-imx': driver_bound: bound to device '2194000.usdhc'
bus: 'platform': really_probe: bound device 2194000.usdhc to driver sdhci-esdhc-imx
initcall sdhci_esdhc_imx_driver_init+0x0/0x20 returned 0 after 58205 usecs

and eventually:

mmc0: host does not support reading read-only switch, assuming write-enable
mmc0: new ultra high speed SDR104 SDHC card at address 0001
mmcblk0: mmc0:0001 00000 14.9 GiB
 mmcblk0: p1 p2

In 4.9-rc5, we instead get:

calling  gpio_clk_driver_init+0x0/0x20 @ 1
bus: 'platform': driver_probe_device: matched device sdio-clock with driver gpio-clk
bus: 'platform': really_probe: probing driver gpio-clk with device sdio-clock
driver: 'gpio-clk': driver_bound: bound to device 'sdio-clock'
bus: 'platform': really_probe: bound device sdio-clock to driver gpio-clk
...
calling  mmc_pwrseq_simple_driver_init+0x0/0x20 @ 1
bus: 'platform': driver_probe_device: matched device usdhc1_pwrseq with driver pwrseq_simple
bus: 'platform': really_probe: probing driver pwrseq_simple with device usdhc1_pwrseq
driver: 'pwrseq_simple': driver_bound: bound to device 'usdhc1_pwrseq'
bus: 'platform': really_probe: bound device usdhc1_pwrseq to driver pwrseq_simple
initcall mmc_pwrseq_simple_driver_init+0x0/0x20 returned 0 after 876 usecs
...
calling  sdhci_esdhc_imx_driver_init+0x0/0x20 @ 1
bus: 'platform': driver_probe_device: matched device 2190000.usdhc with driver sdhci-esdhc-imx
bus: 'platform': really_probe: probing driver sdhci-esdhc-imx with device 2190000.usdhc
sdhci-esdhc-imx 2190000.usdhc: allocated mmc-pwrseq
driver: 'sdhci-esdhc-imx': driver_bound: bound to device '2190000.usdhc'
bus: 'platform': really_probe: bound device 2190000.usdhc to driver sdhci-esdhc-imx
bus: 'platform': driver_probe_device: matched device 2194000.usdhc with driver sdhci-esdhc-imx
bus: 'platform': really_probe: probing driver sdhci-esdhc-imx with device 2194000.usdhc
driver: 'sdhci-esdhc-imx': driver_bound: bound to device '2194000.usdhc'
bus: 'platform': really_probe: bound device 2194000.usdhc to driver sdhci-esdhc-imx
initcall sdhci_esdhc_imx_driver_init+0x0/0x20 returned 0 after 384864 usecs
...
mmc1: host does not support reading read-only switch, assuming write-enable
mmc1: new ultra high speed SDR104 SDHC card at address 0001
mmcblk1: mmc1:0001 00000 14.9 GiB
 mmcblk1: p1 p2


-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
