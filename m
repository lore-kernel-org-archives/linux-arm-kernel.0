From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 5 Jul 2016 20:33:53 +0200
Subject: [PATCH 2/3] ARM: dts: imx6sx: Add UDOO Neo support
In-Reply-To: <577BBC4B.5040903@suse.de>
References: <1467691450-22975-1-git-send-email-afaerber@suse.de>
 <1467691450-22975-3-git-send-email-afaerber@suse.de>
 <CAOMZO5CQWz++TVKBKEMSQuyks3C+7Tx5=Frh6R+Qubcab=EbjA@mail.gmail.com>
 <577BBC4B.5040903@suse.de>
Message-ID: <20160705183353.GQ16643@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 05, 2016 at 03:55:23PM +0200, Andreas F?rber wrote:
> Hi Fabio,
> 
> Am 05.07.2016 um 14:04 schrieb Fabio Estevam:
> > On Tue, Jul 5, 2016 at 1:04 AM, Andreas F?rber <afaerber@suse.de> wrote:
> > 
> >> +/dts-v1/;
> >> +
> >> +#include "imx6sx-udoo-neo.dtsi"
> >> +
> >> +/ {
> >> +       model = "UDOO Neo Basic";
> > 
> > This should be something like:
> > 
> > model = "Udoo i.MX6 SoloX UDOO Neo Basic";
> 
> Why should anyone use such a weird concatenation of names? If you wanted
> "UDOO Neo Basic (based on i.MX 6SoloX)" that would be more
> understandable, but there is no UDOO Neo Basic board with another SoC:
> 
> http://www.udoo.org/udoo-neo/
> 
> imx6dl-udoo.dts uses "Udoo i.MX6 Dual-lite Board" and
> imx6q-udoo.dts  uses "Udoo i.MX6 Quad Board".

Ack, I'm OK with "UDOO Neo Basic" et al, too.

> > [ discussion about what to use for compatible ]
> However, "udoo,neo-basic", "udoo,neo", "fsl,imx6sx" should be sufficient
> since unlike the Quad/Dual situation there is no SoC variation here. Or
> "seco,udoo-neo"? "udoo,udoo-neo" looks duplicate.

I'd use

	"udoo,neo-basic", "fsl,imx6sx";

> >> +&fec1 {
> >> +       pinctrl-names = "default";
> >> +       pinctrl-0 = <&pinctrl_enet1>;
> >> +       phy-mode = "rmii";
> >> +       phy-reset-gpios = <&gpio5 4 GPIO_ACTIVE_HIGH>;
> > 
> > Shouldn't this be GPIO_ACTIVE_LOW instead?
> 
> Hm, network worked okay for me like this, how do we verify?
> 
> Schematics are here: http://www.udoo.org/other-resources/

The phy's RST# pin is connected to a signal that routes to ENET1_CRS /
C7. That corresponds to GPIO2_IO01.

Also that's what is used in "my" device tree that was created by a
colleague who probably took udoo's dts as reference.

Regarding the question how to verify that:

	barebox at Freescale i.MX6 SoloX UDOO NEO Board:/ ifup eth0
	eth0: 100Mbps full duplex link detected
	T DHCP client bound to address 192.168.24.110

	barebox at Freescale i.MX6 SoloX UDOO NEO Board:/ ping 192.168.23.4
	host 192.168.23.4 is alive

	barebox at Freescale i.MX6 SoloX UDOO NEO Board:/ gpio_direction_output 33 0

	barebox at Freescale i.MX6 SoloX UDOO NEO Board:/ ping 192.168.23.4
	eth0: transmission timeout
	T eth0: transmission timeout
	T eth0: transmission timeout
	T eth0: transmission timeout
	T eth0: transmission timeout
	T eth0: transmission timeout
	ping failed: Connection timed out

	barebox at Freescale i.MX6 SoloX UDOO NEO Board:/ gpio_direction_output 33 1

	barebox at Freescale i.MX6 SoloX UDOO NEO Board:/ ping 192.168.23.4
	host 192.168.23.4 is alive

So I'd say the right thing to do is:

	phy-reset-gpios = <&gpio2 1 GPIO_ACTIVE_LOW>;

And as the fec driver ignores the flag (for historic reasons), the only
other correct possibility is:

	phy-reset-gpios = <&gpio2 1 GPIO_ACTIVE_HIGH>;
	phy-reset-active-high;

which is wrong here though.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
