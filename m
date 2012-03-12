From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 12 Mar 2012 14:56:06 -0400
Subject: [PATCH 1/2] ARM: kirkwood: Basic support for DNS-320 and DNS-325
In-Reply-To: <op.wa2j90zu4cuzmg@gonzo.lentin.co.uk>
References: <1331476406-9844-1-git-send-email-jm@lentin.co.uk>
 <1331476406-9844-2-git-send-email-jm@lentin.co.uk>
 <20120312030232.GX5050@titan.lakedaemon.net>
 <op.wa2j90zu4cuzmg@gonzo.lentin.co.uk>
Message-ID: <20120312185606.GC5050@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 12, 2012 at 05:59:50PM -0000, Jamie Lentin wrote:
> On Mon, 12 Mar 2012 03:02:32 -0000, Jason Cooper
> <jason@lakedaemon.net> wrote:
> 
> >On Sun, Mar 11, 2012 at 02:33:25PM +0000, Jamie Lentin wrote:
> >>Add support for the DNS-320 and DNS-325. Describe as much as
> >>currently possible
> >>in the devicetree files, leave everything else in board-dt.c to
> >>be patched
> >>later.
> >>
> >>Signed-off-by: Jamie Lentin <jm@lentin.co.uk>
> >
> >Great work!  comments, below.
> >>---
> >> arch/arm/boot/dts/kirkwood-dns320.dts |   54 ++++++
> >> arch/arm/boot/dts/kirkwood-dns325.dts |   40 +++++
> >> arch/arm/mach-kirkwood/Kconfig        |   18 ++
> >> arch/arm/mach-kirkwood/Makefile.boot  |    2 +
> >> arch/arm/mach-kirkwood/board-dt.c     |  294
> >>+++++++++++++++++++++++++++++++++
> >> 5 files changed, 408 insertions(+), 0 deletions(-)
> >> create mode 100644 arch/arm/boot/dts/kirkwood-dns320.dts
> >> create mode 100644 arch/arm/boot/dts/kirkwood-dns325.dts
> >>
> >>diff --git a/arch/arm/boot/dts/kirkwood-dns320.dts
> >>b/arch/arm/boot/dts/kirkwood-dns320.dts
> >>new file mode 100644
> >>index 0000000..c039041
> >>--- /dev/null
> >>+++ b/arch/arm/boot/dts/kirkwood-dns320.dts
> >>@@ -0,0 +1,54 @@
> >>+/dts-v1/;
> >>+
> >>+/include/ "kirkwood.dtsi"
> >>+
> >>+/ {
> >>+	model = "D-Link DNS-320 NAS (Rev A1)";
> >>+	compatible = "dlink,dns-320-a1", "dlink,dns-320",
> >>"dlink,dns-kirkwood", "marvell,kirkwood-88f6281",
> >>"marvell,kirkwood";
> >
> >s/marvell/mrvl/g for compatible properties.
> >
> 
> Okay.
> 
> >>+	memory {
> >>+		device_type = "memory";
> >>+		reg = <0x00000000 0x8000000>;
> >>+	};
> >>+
> >>+	chosen {
> >>+		bootargs = "console=ttyS0,115200n8 earlyprintk";
> >>+	};
> >>+
> >>+	wdt at fed20300 {
> >>+		compatible = "mrvl,orion-wdt";
> >>+		reg = <0xfed20300 0x28>;
> >>+		clock-frequency = <166666667>;
> >>+	};
> >
> >This hasn't made it into my stable branch yet, waiting on common clock
> >to land (may be 3.5).  Please use kirkwood_wdt_init() in the mean time.
> >
> 
> So just to be clear kirkwood_dt_stable on git.infradead.org, as
> opposed to any branches on arm-soc?

For now.  I'm still learning the git integration/upstream piece.  Give
me a few more hours and I should have a new version up for review.  It's
a reshuffle and edit of the whole series.

It also redoes serial@ based on Arnd's comments to your patches.

> >>+	serial at f1012000 {
> >>+		compatible = "ns16550a";
> >>+		reg = <0xf1012000 0xff>;
> >>+		reg-shift = <2>;
> >>+		interrupts = <33>;
> >>+		clock-frequency = <166666667>;
> >>+	};
> >>+
> >>+	serial at f1012100 {
> >>+		compatible = "ns16550a";
> >>+		reg = <0xf1012100 0xff>;
> >>+		reg-shift = <2>;
> >>+		interrupts = <34>;
> >>+		clock-frequency = <166666667>;
> >>+	};
> >>+
> >>+	sata at f1080000 {
> >>+		compatible = "mrvl,orion-sata";
> >>+		reg = <0xf1080000 0x5000>;
> >>+		interrupts = <21>;
> >>+		nr-ports = <2>;
> >>+	};
> >>+
> >>+	ehci at f1050000 {
> >>+		compatible = "mrvl,orion-ehci";
> >>+		reg = <0xf1050000 0x1000>;
> >>+		interrupts = <19>;
> >>+		dma-mask = <0xffffffff>;
> >>+		phy-version = "";
> >>+	};
> >
> >sata and ehci both require working dma and interrupt controller.  I
> >should have the interrupt controller done soon.  mv_cesa will then work.
> >dma will be after that.
> 
> I found this out the hard way, but saw that dma-mask was supported
> in staging/kirkwood/dt on arm-soc and managed to get working USB
> using it. I'll switch back for now.

Yes, that "support" was a mistake on my part.  It does not appear to be
the correct answer.

> >Basically, anything in mach-kirkwood/common.c that passes kirkwood_tclk
> >is on hold for devicetree.
> 
> Including serial ports?

serial is different because it's not a kirkwood/orion-specific driver.
It's clock-frequency is not (as my understanding goes) tied to the
system clock, it just happens to be so in this case.

The other drivers want tclk because they want to know the system clock.

...
> >>diff --git a/arch/arm/mach-kirkwood/board-dt.c
> >>b/arch/arm/mach-kirkwood/board-dt.c
> >>index 12dec38..0885713 100644
> >>--- a/arch/arm/mach-kirkwood/board-dt.c
> >>+++ b/arch/arm/mach-kirkwood/board-dt.c
> >>@@ -15,6 +15,7 @@
> >> #include <linux/platform_device.h>
> >> #include <linux/irqdomain.h>
> >> #include <linux/mtd/partitions.h>
> >>+#include <linux/i2c.h>
> >> #include <linux/ata_platform.h>
> >> #include <linux/mv643xx_eth.h>
> >> #include <linux/of.h>
> >>@@ -23,6 +24,9 @@
> >> #include <linux/of_irq.h>
> >> #include <linux/of_platform.h>
> >> #include <linux/gpio.h>
> >>+#include <linux/input.h>
> >>+#include <linux/gpio_keys.h>
> >>+#include <linux/gpio-fan.h>
> >> #include <linux/leds.h>
> >> #include <linux/mtd/physmap.h>
> >> #include <linux/spi/flash.h>
> >>@@ -150,6 +154,291 @@ static void __init dreamplug_init(void)
> >> 	platform_device_register(&dreamplug_leds);
> >> }
> >>
> >>+/*****************************************************************************
> >>+ * DNS-320 & DNS-325 specifics
> >>+ ****************************************************************************/
> >>+
> >>+static struct mtd_partition dnskw_nand_parts[] = {
> >>+	{
> >>+		.name		= "u-boot",
> >>+		.offset		= 0,
> >>+		.size		= SZ_1M,
> >>+		.mask_flags	= MTD_WRITEABLE
> >>+	}, {
> >>+		.name		= "uImage",
> >>+		.offset		= MTDPART_OFS_NXTBLK,
> >>+		.size		= 5 * SZ_1M
> >>+	}, {
> >>+		.name		= "ramdisk",
> >>+		.offset		= MTDPART_OFS_NXTBLK,
> >>+		.size		= 5 * SZ_1M
> >>+	}, {
> >>+		.name		= "image",
> >>+		.offset		= MTDPART_OFS_NXTBLK,
> >>+		.size		= 102 * SZ_1M
> >>+	}, {
> >>+		.name		= "mini firmware",
> >>+		.offset		= MTDPART_OFS_NXTBLK,
> >>+		.size		= 10 * SZ_1M
> >>+	}, {
> >>+		.name		= "config",
> >>+		.offset		= MTDPART_OFS_NXTBLK,
> >>+		.size		= 5 * SZ_1M
> >>+	},
> >>+};
> >
> >You should probably squeeze in a partition for the dtb.  ;-)
> >
> >Is the config partition the u-boot environment?  That usually is much
> >smaller than what you have alotted.  So, you might be able to split that
> >to make room for the dtb.
> >
> 
> The partition scheme is the same as D-Link's kernel. The config area
> is a jffs2 filesystem that contains their config files. It seemed to
> me that copying the partition table was the right thing to do to
> allow the NAND to be read, even though in practice it's not that
> useful---I'm not sure even D-Link pay much attention to it, there's
> all sorts of odd offsets in their code.
> 
> The other option would be to ignore the nonsense and replace it with
> something useful. This would be more convenient for me because it'd
> mean I don't have to replace it with my partition scheme :). Any
> opinions?

No, reverse-compatible is a good thing if we can swing it.  How about
giving uImage 4MB and then 1MB for the dtb?  Most of my dtbs haven't
even reached 2k...

Although, that'll change device numbering, eg ramdisk = /dev/mtdblock3
where it was /dev/mtdblock2 before.

Is there any unallocated space at the end of the flash?

...
> >>+
> >>+	/* Register power off routine */
> >>+	kirkwood_pcie_id(&dev, &rev);
> >>+	if (dev == MV88F6281_DEV_ID) {
> >>+		pr_info("PCI-E Device ID: MV88F6281, configuring power-off");
> >>+		if (gpio_request(36, "dnskw:power:off") == 0 &&
> >>+		    gpio_direction_output(36, 0) == 0)
> >>+			pm_power_off = dnskw_power_off;
> >>+		else
> >>+			pr_err("dnskw: failed to configure power-off GPIO\n");
> >>+	} else {
> >>+		/*
> >>+		 * Dlink code also defines 0x6192, and sets LOW_BASE +
> >>+		 * 0x01000000 high. Either cargo-culted code or another model.
> >>+		 */
> >
> >I'm just curious, what is cargo-culted?
> >
> 
> http://en.wikipedia.org/wiki/Cargo_cult_programming

It's okay, feel free to link me to lmgtfy.  ;-)

> In this case, I originally thought that the line was relevant to
> supporting the DNS-320 (I assumed it had a MV88F6192 based on it's
> lower TCLK), but it seems it uses the MV88F6281 too. So either
> D-link have been blindly including this logic or there is a model
> somewhere that uses the different SoC.
> 
> On reflection, it's probably best to remove this entirely. Testing
> the pcie_id isn't achieving anything and is likely to confuse when
> it comes to porting the power-off to devicetree.
> 
> >>+		pr_err("Unknown PCI-E Device ID %x, no power-off", dev);
> >>+	}
> >>+
> >>+	/*
> >>+	 * Supply power to HDDs. Bootloader should have turned on
> >>sata0 already
> >>+	 */
> >
> >Don't assume the bootloader does or doesn't do anything.  Put the
> >peripheral into a known state and work from there.
> >
> 
> It doesn't, it turns both HDDs on. I'll clarify the comment though.
              ^^ bootloader or kernel?

Users (especially me) may roll their own u-boot, or swapout for redboot,
whatever.

> >>+	dnskw_gpio_register(39, "dnskw:power:sata0", 1);
> >>+	dnskw_gpio_register(40, "dnskw:power:sata1", 1);
> >>+
> >>+	/* Set NAS to turn back on after a power failure */
> >>+	dnskw_gpio_register(37, "dnskw:power:recover", 1);
> >>+}
> >>+
> >
> >I doubt this board is the only one that wants to be added while the
> >conversion to devicetree is progressing.  It makes more sense to me to
> >break the above out to a separate file, eg board-dnskw.c.  I'll follow
> >and break out the dreamplug code to board-dreamplug.c.  Otherwise, I see
> >board-dt.c becoming a long mess.
> >
> >Arnd, sound okay to you?
> >
> >> static void __init kirkwood_dt_init(void)
> >> {
> >> 	struct device_node *node;
> >>@@ -186,11 +475,16 @@ static void __init kirkwood_dt_init(void)
> >> 	if (of_machine_is_compatible("globalscale,dreamplug"))
> >> 		dreamplug_init();
> >>
> >>+	if (of_machine_is_compatible("dlink,dns-kirkwood"))
> >>+		dnskw_init();
> >>+
> >> 	of_platform_populate(NULL, kirkwood_dt_match_table, NULL, NULL);
> >> }
> >>
> >> static const char *kirkwood_dt_board_compat[] = {
> >> 	"globalscale,dreamplug",
> >>+	"dlink,dns-320",
> >>+	"dlink,dns-325",
> >> 	NULL
> >> };
> >>
> >>--
> >>1.7.9.1
> >>
> 
> 
> -- 
> Jamie Lentin
