From: mpa@pengutronix.de (Markus Pargmann)
Date: Tue, 9 Sep 2014 07:51:57 +0200
Subject: [PATCH] mfd: mc13xxx: Configure WDI reset
In-Reply-To: <540D9BCC.2000801@gmail.com>
References: <1410159671-25873-1-git-send-email-mpa@pengutronix.de>
 <540D5DEB.6020605@gmail.com>
 <20140908092559.GB24081@pengutronix.de>
 <540D9BCC.2000801@gmail.com>
Message-ID: <20140909055157.GC24081@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Sep 08, 2014 at 02:06:36PM +0200, Philippe R?tornaz wrote:
> Le 08/09/2014 11:25, Markus Pargmann a ?crit :
> >Hi,
> >
> >On Mon, Sep 08, 2014 at 09:42:35AM +0200, Philippe R?tornaz wrote:
> >>Hello
> >>
> >>Le 08/09/2014 09:01, Markus Pargmann a ?crit :
> >>>Setup the PMIC to make a restart when a watchdog interrupt occures.
> >>>If this is not configured, the PMIC will shut down the power supply
> >>>without a restart.
> >>
> >>
> >>Well, this was used to poweroff the mx31moboard board.
> >>So we need to be able to configure the functionality.
> >
> >So on mx31moboard the watchdog interrupt always leads to a poweroff instead of
> >a reset?
> 
> Well, no, it simply doesn't work since the output pin is not enabled :)
> We enable the watchdog output only in pm_power_off().
> 
> >Perhaps it would be better to switch back to poweroff on
> >watchdog interrupt right before the shutdown watchdog interrupt is
> >triggered.
> 
> Yes, we definitely should be doing this.
> The only point is that we don't have currently access to the PMIC
> from pm_power_off().
> Is there a clean/recommended way to do it ?

An exported function in the pmic mfd driver that switches between
poweroff/reset on watchdog interrupt may be ok for this. In the board
pm_power_off routine you could then use of_find_device_by_node() or
something similar to get the device struct and pass it to the function.

Best Regards,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140909/999413b8/attachment.sig>
