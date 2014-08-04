From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon, 4 Aug 2014 12:13:44 +0200
Subject: [RESEND PATCH v3 2/4] usb: musb: Bugfix of_node assignment
In-Reply-To: <52937F76.107@linutronix.de>
References: <1384790078-15366-1-git-send-email-mpa@pengutronix.de>
 <1384790078-15366-3-git-send-email-mpa@pengutronix.de>
 <20131125161421.GH18046@saruman.home> <52937F76.107@linutronix.de>
Message-ID: <20140804101344.GA2863@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sebastian,

This thread was about the of_node assignment for the child device
musb-hdrc. Mainline commit:
	4fc4b274f9b3 (usb: musb: dsps: do not bind to "musb-hdrc")

On Mon, Nov 25, 2013 at 05:48:54PM +0100, Sebastian Andrzej Siewior wrote:
> 
> Is this fixing a bug? Commit 4fc4b2 ("usb: musb: dsps: do not bind to
> "musb-hdrc") [0] should fix the problem that is described here.
> ux500 is affected by the same problem as dsps but it is only visible on
> dsps because we DEFER probe for few reasons there test the fail path.
> 
> So by just looking at it should fix the same problem as the change I
> cited _but_ it would also cover ux500. Currently I can't think of any
> side effects by assigning of_node if the musb_init_*() did not do it.
> If we take this in I would suggest to remove the check I added (because
> it does no longer serve any purpose) and the description (why we do
> this, what is the problem exactly) is could be taken from my patch
> since I think it is better described (it safe to assign a node to a
> driver, it becomes unsafe if after platform_probe _also_ the DT probe
> is executed which was not to designed to work like this).
> 
> In the long term I would suggest to move the DT probe over to the musb
> core code and we wouldn't need the node assignment anymore?
> 
> [0] http://www.spinics.net/lists/linux-usb/msg94701.html

Really old thread but I just noticed that this solution does not work
for automatically parsed properties like 'default' pinctrl. I added
'default' pinctrl settings for the musb device node. They are
automatically setup by the driver core infrastracture as expected.

The problem is that the 'default' pincontrol settings will be applied
again for the musb-hdrc because they are extracted from the of_ndoe
data. This fails because they are already claimed by the 'musb-dsps'
driver. musb-hdrc continues probing, but there is a big error message
that it failed:

[    1.181912] pinctrl-single 44e10800.pinmux: pin 44e10a20.0 already requested by 47401c00.usb; cannot clai
m for musb-hdrc.1.auto
[    1.194053] pinctrl-single 44e10800.pinmux: pin-136 (musb-hdrc.1.auto) status -22
[    1.201930] pinctrl-single 44e10800.pinmux: could not request pin 136 (44e10a20.0) from group pinmux_usb1
_pins  on device pinctrl-single
[    1.214790] musb-hdrc musb-hdrc.1.auto: Error applying setting, reverse things back

Any ideas how to solve it for mainline?

Best regards,

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140804/ed1f3e6a/attachment.sig>
