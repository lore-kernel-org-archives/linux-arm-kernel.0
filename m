From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 27 Sep 2013 21:43:09 +0100
Subject: device tree binding documentation outdated
In-Reply-To: <CAHCPf3t=rG-sV-kNe5mQjSvs8k0rddv9=tgh+ub=Tt1xObYxVw@mail.gmail.com>
References: <20130926195158.GS12758@n2100.arm.linux.org.uk>
 <CAOMZO5ANsZGcpvmtBE7d0q0E6+f0bE_U8CBF7G2v3xtqoLbqcA@mail.gmail.com>
 <20130926205906.GT12758@n2100.arm.linux.org.uk>
 <CAHCPf3u9KyoJiAPv6oc_ZdVBqgix41__RAGRXh8z+d5bXO8fQw@mail.gmail.com>
 <20130926232907.GV12758@n2100.arm.linux.org.uk>
 <20130927131554.GB31178@titan.lakedaemon.net>
 <20130927170552.GC12758@n2100.arm.linux.org.uk>
 <20130927183101.GE12758@n2100.arm.linux.org.uk>
 <CAOMZO5Csr-vgsKHahnTcMKu1DfgSToYnoVncAfhYFJid-bwviQ@mail.gmail.com>
 <CAHCPf3t=rG-sV-kNe5mQjSvs8k0rddv9=tgh+ub=Tt1xObYxVw@mail.gmail.com>
Message-ID: <20130927204309.GJ12758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 27, 2013 at 03:16:48PM -0500, Matt Sealey wrote:
> On Fri, Sep 27, 2013 at 1:52 PM, Fabio Estevam <festevam@gmail.com> wrote:
> > On Fri, Sep 27, 2013 at 3:31 PM, Russell King - ARM Linux
> > <linux@arm.linux.org.uk> wrote:
> >> On Fri, Sep 27, 2013 at 06:05:52PM +0100, Russell King - ARM Linux wrote:
> >
> >> An interesting data point.  Connect it to a 100mbit switch and it works.
> >> gigabit and it behaves as above.
> >>
> >> So, the question is: does anyone have gigabit networking working on imx6
> >> with recent DT based kernels?
> >
> > Yes, we have Gigabit ethernet working on mx6sabrelite, wandboard,
> > sabresd boards.
> >
> > Does the 3.0.35 kernel work with gigabit on cubox-i? Could this issue
> > be related to the ar8035 phy fixup code?
> 
> The AR8035 has a PHY ID of 0x004dd072 and the code in the i.MX6
> platform stuff specifies 0x004dd074 - so if it's really an 8035 then
> it's not being run..

I've had this in my kernel since earlier today, after a previous comment
about where to add this fixup.  You may notice that I said earlier
in this thread - around 1pm UK time - that I'd already confirmed that
*this* fixup function *is* being run, and I even quoted this code in
that email... :)

As for "if it's really" I really have read the numbers off the top of
the chip and it "really" is an AR8035.  I wouldn't have the data sheet
and been probing its pads directly.

The phy is mounted between the MX6 (the big chip) and the HDMI connector.
It's crystal is immediately beside it.

At this point I'm going to say: please do not make the mistake of
thinking I'm just a software engineer.  I'm not.  I'm a hardware
engineer who still designs stuff from time to time.

diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index 85a1b51..4da6c68 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -164,6 +164,46 @@ static int ar8031_phy_fixup(struct phy_device *dev)
 
 #define PHY_ID_AR8031	0x004dd074
 
+static int ar8035_phy_fixup(struct phy_device *dev)
+{
+	u16 val;
+
+	/* Ar803x phy SmartEEE feature cause link status generates glitch,
+	 * which cause ethernet link down/up issue, so disable SmartEEE
+	 */
+	phy_write(dev, 0xd, 0x3);
+	phy_write(dev, 0xe, 0x805d);
+	phy_write(dev, 0xd, 0x4003);
+
+	val = phy_read(dev, 0xe);
+	phy_write(dev, 0xe, val & ~(1 << 8));
+
+	/* To enable AR8031 output a 125MHz clk from CLK_25M */
+	phy_write(dev, 0xd, 0x7);
+	phy_write(dev, 0xe, 0x8016);
+	phy_write(dev, 0xd, 0x4007);
+
+	val = phy_read(dev, 0xe);
+	val &= 0xffe3;
+	val |= 0x18;
+	phy_write(dev, 0xe, val);
+
+	/* introduce tx clock delay */
+	phy_write(dev, 0x1d, 0x5);
+	val = phy_read(dev, 0x1e);
+	val |= 0x0100;
+	phy_write(dev, 0x1e, val);
+
+	/*check phy power*/
+	val = phy_read(dev, 0x0);
+	if (val & BMCR_PDOWN)
+		phy_write(dev, 0x0, val & ~BMCR_PDOWN);
+
+	return 0;
+}
+
+#define PHY_ID_AR8035 0x004dd072
+
 static void __init imx6q_enet_phy_init(void)
 {
 	if (IS_BUILTIN(CONFIG_PHYLIB)) {
@@ -173,6 +213,8 @@ static void __init imx6q_enet_phy_init(void)
 				ksz9031rn_phy_fixup);
 		phy_register_fixup_for_uid(PHY_ID_AR8031, 0xffffffff,
 				ar8031_phy_fixup);
+		phy_register_fixup_for_uid(PHY_ID_AR8035, 0xffffffef,
+				ar8035_phy_fixup);
 	}
 }
 
