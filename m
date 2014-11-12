From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 12 Nov 2014 10:14:58 +0100
Subject: Samsung/S3C6410/Mini6410: how to handle NAND's "clock off"
In-Reply-To: <20141111184226.GH27002@pengutronix.de>
References: <201411111910.34231.juergen@kreuzholzen.de>
 <20141111184226.GH27002@pengutronix.de>
Message-ID: <20141112091458.GM27002@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello again,

[extending audience a bit]

On Tue, Nov 11, 2014 at 07:42:26PM +0100, Uwe Kleine-K?nig wrote:
> On Tue, Nov 11, 2014 at 07:10:33PM +0100, Juergen Borleis wrote:
> > Hi,
> > 
> > the S3C2410 NAND driver [1] can still be used for NANDs attached to an S3C6410
> > SoC. But this driver has a "nice" feature called "clock off" to save some
> > power while not in use. I tried it here on my Mini6410 platform and it freezes
> > the system.
> > 
> > The clock tree is somehow:
> > 
> > [...]
> >   hclk                      4            4   133000000          0 0
> >      hclk_mfc               0            0   133000000          0 0
> >      hclk_mem0              2            2   133000000          0 0
> >         mem0_srom           0            0   133000000          0 0
> >         mem0_nfcon          1            1   133000000          0 0
> >         mem0_onenand0       0            0   133000000          0 0
> >         mem0_onenand1       0            0   133000000          0 0
> >         mem0_cfcon          0            0   133000000          0 0
> > [...]
> > 
> > On the Mini6410 the "mem0_nfcon" clock is the only single user of the
> > "hclk_mem0". And this clock is required to keep the access to the external
> > network device enabled. When the NAND driver disables its clock "mem0_nfcon",
> > the "hclk_mem0" gets also disabled because there is no consumer anymore. The
> > next time the network driver tries to access its device, the SoC freezes.
> Sounds like the network driver should hold a reference to hclk_mem0.
After talking to J?rgen by phone, the solution that the dm9000 driver
should handle the clock sounds wrong. The clk in question is needed by
the SoC to operate the bus the dm9000 is connected to. So I think the
right approach would include

diff --git a/arch/arm/boot/dts/s3c6410-mini6410.dts b/arch/arm/boot/dts/s3c6410-mini6410.dts
index 57e00f9bce99..b5067e631216 100644
--- a/arch/arm/boot/dts/s3c6410-mini6410.dts
+++ b/arch/arm/boot/dts/s3c6410-mini6410.dts
@@ -55,9 +55,11 @@
 	srom-cs1 at 18000000 {
 		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
+		clock-names = "hclk-whatever";
+		clocks = <&no_idea_which_device MEM0_SROM>;
 		reg = <0x18000000 0x8000000>;
 		ranges;
 
 		ethernet at 18000000 {
 			compatible = "davicom,dm9000";

I don't think the simple bus has clock handling, and I'm not sure if
simple bus is intended to be too simple to handle that. Anyhow, it would
describe the hardware.
The next thing that will pop up once simple-bus (or a dedicated
whatever-bus) has clk-handling is power management. Does the bus notice
when all it's devices are suspended such that the bus driver can turn
off its clock?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
