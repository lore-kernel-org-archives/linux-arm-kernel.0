From: balbi@ti.com (Felipe Balbi)
Date: Tue, 5 Aug 2014 15:17:35 -0500
Subject: [RESEND PATCH v3 2/4] usb: musb: Bugfix of_node assignment
In-Reply-To: <53E0CF15.8060307@linutronix.de>
References: <1384790078-15366-1-git-send-email-mpa@pengutronix.de>
 <1384790078-15366-3-git-send-email-mpa@pengutronix.de>
 <20131125161421.GH18046@saruman.home> <52937F76.107@linutronix.de>
 <20140804101344.GA2863@pengutronix.de>
 <53E0CF15.8060307@linutronix.de>
Message-ID: <20140805201735.GF15233@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 05, 2014 at 02:33:25PM +0200, Sebastian Andrzej Siewior wrote:
> On 08/04/2014 12:13 PM, Markus Pargmann wrote:
> 
> >> In the long term I would suggest to move the DT probe over to the musb
> >> core code and we wouldn't need the node assignment anymore?
> >>
> >> [0] http://www.spinics.net/lists/linux-usb/msg94701.html
> > 
> > Really old thread but I just noticed that this solution does not work
> > for automatically parsed properties like 'default' pinctrl. I added
> > 'default' pinctrl settings for the musb device node. They are
> > automatically setup by the driver core infrastracture as expected.
> > 
> > The problem is that the 'default' pincontrol settings will be applied
> > again for the musb-hdrc because they are extracted from the of_ndoe
> > data. This fails because they are already claimed by the 'musb-dsps'
> > driver. musb-hdrc continues probing, but there is a big error message
> > that it failed:
> > 
> > [    1.181912] pinctrl-single 44e10800.pinmux: pin 44e10a20.0 already requested by 47401c00.usb; cannot clai
> > m for musb-hdrc.1.auto
> > [    1.194053] pinctrl-single 44e10800.pinmux: pin-136 (musb-hdrc.1.auto) status -22
> > [    1.201930] pinctrl-single 44e10800.pinmux: could not request pin 136 (44e10a20.0) from group pinmux_usb1
> > _pins  on device pinctrl-single
> > [    1.214790] musb-hdrc musb-hdrc.1.auto: Error applying setting, reverse things back
> > 
> > Any ideas how to solve it for mainline?
> 
> Just what I said last time and I hope Felipe has the same opinion:
> Teach musb-hdrc DT. Which means "ti,musb-am33xx" would be listed for
> for musb-hdrc itself and we would lose that child device. The
> additional ops that we have would be passed via the data field next to
> the id.

sounds good to me.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140805/21431553/attachment-0001.sig>
