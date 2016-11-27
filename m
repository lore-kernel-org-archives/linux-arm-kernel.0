From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sun, 27 Nov 2016 23:30:43 +0100
Subject: [PATCH] ARM: dts: mvebu: Fix armada-385-turris-omnia stdout-path
In-Reply-To: <0f51c7a1-6d52-3e3e-edfe-e7b10917ecab@suse.de>
References: <71af60f5-b657-cab4-32a8-00a604fc656e@suse.de>
 <1480275444-4220-1-git-send-email-afaerber@suse.de>
 <20161127212528.wmqbwciz5ltnfws3@pengutronix.de>
 <0f51c7a1-6d52-3e3e-edfe-e7b10917ecab@suse.de>
Message-ID: <20161127223043.2a3wpteentjosjce@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Sun, Nov 27, 2016 at 11:14:37PM +0100, Andreas F?rber wrote:
> Am 27.11.2016 um 22:25 schrieb Uwe Kleine-K?nig:
> > On Sun, Nov 27, 2016 at 08:37:24PM +0100, Andreas F?rber wrote:
> >> Specify the baudrate.
> >>
> >> Fixes: 26ca8b52d6e1 ("ARM: dts: add support for Turris Omnia")
> >> Cc: Uwe Kleine-K?nig <uwe@kleine-koenig.org>
> >> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> > 
> > You said with plain &uart0 the kernel uses a wrong baud rate? That's
> > strange. For me it works and I think it's the intended behaviour to
> > dermine the baud rate setup by the bootloader and use this.
> 
> IIRC the 8250 driver defaults to 9600n8 if unspecified.
> 
> Kernel tested: 4.9.0-rc2-next-20161028-00010-g4fb44d9-dirty
> 
> Maybe you used some console= argument overriding it?

Yes, you're right.

> > I'd prefer it this way over hard coding the baud rate.
> > 
> >>  arch/arm/boot/dts/armada-385-turris-omnia.dts | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/arch/arm/boot/dts/armada-385-turris-omnia.dts b/arch/arm/boot/dts/armada-385-turris-omnia.dts
> >> index f53cb8b73610..2eff012287d4 100644
> >> --- a/arch/arm/boot/dts/armada-385-turris-omnia.dts
> >> +++ b/arch/arm/boot/dts/armada-385-turris-omnia.dts
> >> @@ -52,7 +52,7 @@
> >>  	compatible = "cznic,turris-omnia", "marvell,armada385", "marvell,armada380";
> >>  
> >>  	chosen {
> >> -		stdout-path = &uart0;
> >> +		stdout-path = "serial0:115200n8";
> >>  	};
> >>  
> >>  	memory {
> > 
> > This has the downside to depend on the alias. Not sure this is
> > considered modern. An alternative would be:
> > 
> > 	stdout-path = "/soc/internal-regs/serial at 12000:115200n8";
> 
> Please don't unroll the path I'm trying to abstract elsewhere.

Yeah, specifying the path isn't nice.

> Like I said, the "serialX:115200n8" syntax is what all other Armada 38x
> boards use:

This isn't a reason to not think about better alternatives. An if
something like:

	stdout-path = &uart0 + ":115200n8";

would be possible, I'd definitely prefer it over "serial0:115200n8".

> git grep stdout-path -- arch/arm/boot/dts/ | grep armada-38
> arch/arm/boot/dts/armada-385-db-ap.dts:		stdout-path = "serial1:115200n8";
> arch/arm/boot/dts/armada-385-linksys.dtsi:		stdout-path =
> "serial0:115200n8";
> arch/arm/boot/dts/armada-388-clearfog.dts:		stdout-path =
> "serial0:115200n8";
> arch/arm/boot/dts/armada-388-db.dts:		stdout-path = "serial0:115200n8";
> arch/arm/boot/dts/armada-388-gp.dts:		stdout-path = "serial0:115200n8";
> arch/arm/boot/dts/armada-388-rd.dts:		stdout-path = "serial0:115200n8";
> 
> The alias is needed to reliably determine the tty device number and is
> set "globally" in armada-38x.dtsi, so why is it a problem to rely on?

AFAIK aliases are seen as (still necessary) evil by the dt people. So if
you can stop making use of them, that would be nice.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
