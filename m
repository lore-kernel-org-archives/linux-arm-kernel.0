From: ore@pengutronix.de (Oleksij Rempel)
Date: Tue, 20 Jun 2017 17:29:59 +0200
Subject: [PATCH v5 3/6] kernel/reboot.c: export pm_power_off_prepare
In-Reply-To: <1497969426.3177.14.camel@nxp.com>
References: <20170619050245.2632-1-o.rempel@pengutronix.de>
 <20170619050245.2632-4-o.rempel@pengutronix.de>
 <1497872109.5380.10.camel@nxp.com>
 <5023d338-f845-b8a6-c4a0-d414c75f841c@pengutronix.de>
 <1497969426.3177.14.camel@nxp.com>
Message-ID: <20170620152959.n6cwarfvdtt6mhry@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 20, 2017 at 05:37:06PM +0300, Leonard Crestez wrote:
> On Tue, 2017-06-20 at 07:01 +0200, Oleksij Rempel wrote:
> > 
> > On 19.06.2017 13:35, Leonard Crestez wrote:
> > > 
> > > On Mon, 2017-06-19 at 07:02 +0200, Oleksij Rempel wrote:
> > > > 
> > > > Export pm_power_off_prepare. It is needed to implement power off on
> > > > Freescale/NXP iMX6 based boards with external power management
> > > > integrated circuit (PMIC).
> > > > 
> > > > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > > > ---
> > > > ?kernel/reboot.c | 1 +
> > > > ?1 file changed, 1 insertion(+)
> > > > 
> > > > diff --git a/kernel/reboot.c b/kernel/reboot.c
> > > > index bd30a973fe94..a6903bf772c7 100644
> > > > --- a/kernel/reboot.c
> > > > +++ b/kernel/reboot.c
> > > > @@ -49,6 +49,7 @@ int reboot_force;
> > > > ? */
> > > > 
> > > > ?void (*pm_power_off_prepare)(void);
> > > > +EXPORT_SYMBOL(pm_power_off_prepare);
> > > > 
> > > Could you register a reboot notifier in the pfuze driver instead? Right
> > > now the only user of pm_power_off_prepare is ACPI so this alternative
> > > seems less intrusive.
> > hm... in this case i will need to make sure that reboot handler is not?
> > executed on reboot. This will make code looks strange. Which is opposite?
> > of your comment in other email about strange standby code for power off :)
> > Should i really do this?
> 
> A reboot handler receives a parameter to differentiate between reboot
> and shutdown so it would be easy. Isn't it preferable to use an
> existing mechanism instead of exporting a new symbol?
> 
> But maybe somebody else will Ack this, I don't particularly insist on
> changing this.

I just need to make sure, nothing else will do some thing unexpected
with PMIC. Don't forget we use same PMIC_STBY_REQ signal for stanby,
suspend to RAM and for power off. Entering wrong state in wrong moment
will be fatal. This is why I use last possible step before pm_power_off.

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
