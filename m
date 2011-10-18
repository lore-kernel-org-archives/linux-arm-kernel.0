From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 18 Oct 2011 09:39:54 +0200
Subject: [PATCH] ARM: mxs: Add initial support for Bluegiga APX4
	Development Kit
In-Reply-To: <4E9D2A48.9060605@bluegiga.com>
References: <1318838916-8529-1-git-send-email-lauri.hintsala@bluegiga.com>
	<20111017094434.GA21504@pengutronix.de>
	<4E9D2A48.9060605@bluegiga.com>
Message-ID: <20111018073954.GD21504@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 18, 2011 at 10:27:04AM +0300, Lauri Hintsala wrote:
> Hi Uwe,
> 
> On 10/17/2011 12:44 PM, Uwe Kleine-K?nig wrote:
> >Hello,
> >
> >On Mon, Oct 17, 2011 at 11:08:36AM +0300, Lauri Hintsala wrote:
> >>Added initial support for Bluegiga APX4 module and Development Kit.
> >>Patches are based on Linux v3.1-rc9.
> >Specifying the base isn't helpful in the commit log. You can better
> >write things like these after the tripple dash below.
> 
> I'll drop the version information from commit log.
> 
> 
> >>+config MODULE_APX4
> >>+	bool
> >>+	select SOC_IMX28
> >>+	select LEDS_GPIO_REGISTER
> >>+	select MXS_HAVE_AMBA_DUART
> >>+	select MXS_HAVE_PLATFORM_AUART
> >>+	select MXS_HAVE_PLATFORM_FEC
> >>+    select MXS_HAVE_PLATFORM_MXS_I2C
> >broken indention
> 
> Thanks for catching it.
> 
> 
> >>+	select MXS_HAVE_PLATFORM_MXS_MMC
> >>+	select MXS_OCOTP
> >>+
> >MODULE_APX4 is unused, do you plan to use it later?
> 
> It is already used. MODULE_APX4 is selected by MACH_APX4DEVKIT.
Yeah, so you have two symbols that are =y for your board. One of them
doesn't do anything apart from being there and having a value. Just
removing config MODULE_APX4, putting all the selects into
MACH_APX4DEVKIT and remove the select MODULE_APX4 from it doesn't break
anything.

MODULE_TX28 at least has a separate file that is compiled for it and
that might be useful for maschines that don't necessarily use
mach-tx28.c .

> >>  config MACH_TX28
> >>  	bool "Ka-Ro TX28 module"
> >>  	select MODULE_TX28
> >>
> >>+config MACH_APX4DEVKIT
> >>+	bool "Support Bluegiga APX4 Development Kit"
> >>+	select MODULE_APX4
> >>+
> >>  endif
> >>+static int __init apx4devkit_fec_get_mac(char *macstr)
> >>+{
> >>+	int i, h, l;
> >>+
> >>+	macstr++;
> >>+
> >>+	for (i = 0; i<  6; i++) {
> >>+		if (i != 5&&  *(macstr + 2) != ':')
> >>+			goto error;
> >>+
> >>+		h = hex_to_bin(*macstr++);
> >>+		if (h == -1)
> >>+			goto error;
> >>+
> >>+		l = hex_to_bin(*macstr++);
> >>+		if (l == -1)
> >>+			goto error;
> >>+
> >>+		macstr++;
> >>+		mx28_fec_pdata.mac[i] = (h<<  4) + l;
> >>+	}
> >>+	return 0;
> >I wonder if there isn't a more generic way to parse a mac address.
> 
> Maybe it is better to use sscanf for parsing mac address, is it. I
> didn't found any generic function for this purpose. Is there any?
sscanf("%pM", ...) would be straight forward, but I'd be surprised if
that worked. I'd ask on netdev at vger.kernel.org.

> Other boards seems to use similar methods for parsing mac address:
> arch/arm/mach-orion5x/dns323-setup.c: dns323_read_mac_addr
> arch/arm/mach-orion5x/tsx09-common.c: qnap_tsx09_check_mac_addr
> arch/mips/rb532/devices.c: parse_mac_addr
> 
> I dont't mean it is right/best way to do parsing but it seems to be
> generic problem.
Yeah, so a generic solution would be great!
 
> >Other machines put the mac into the otp.
> 
> We do not want to use otps for mac.
> 
> 
> >>+error:
> >>+	pr_err("%s: invalid mac address\n", __func__);
> >>+	return -EINVAL;
> >>+}
> >>+
> >>+__setup("ethaddr", apx4devkit_fec_get_mac);
> >the name is IMHO too generic for a board specific parameter. Think about
> >a kernel that runs on all mxs based machines. ethaddr=... only affects
> >your machine type. And it's not possible to add the same parameter to a
> >different board.
> 
> I could rename the parameter name.
fec.macaddr should work already today.

> >>+static void __init apx4devkit_timer_init(void)
> >>+{
> >>+	mx28_clocks_init();
> >>+}
> >>+
> >>+static struct sys_timer apx4devkit_timer = {
> >>+	.init	= apx4devkit_timer_init,
> >>+};
> >>+
> >>+MACHINE_START(APX4DEVKIT, "Bluegiga APX4 Development Kit")
> >>+	.map_io		= mx28_map_io,
> >>+	.init_irq	= mx28_init_irq,
> >>+	.init_machine	= apx4devkit_init,
> >>+	.timer		=&apx4devkit_timer,
> >>+MACHINE_END
> >please read http://article.gmane.org/gmane.linux.ports.arm.omap/50721
> 
> Do you mean init_machine and timer are in wrong order?
yes.

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
