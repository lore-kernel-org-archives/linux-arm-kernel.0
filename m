From: balbi@ti.com (Felipe Balbi)
Date: Tue, 18 Jun 2013 11:48:45 +0300
Subject: [PATCH] USB: initialize or shutdown PHY when add or remove host
 controller
In-Reply-To: <51C01E11.8050201@ti.com>
References: <1371539701-11441-1-git-send-email-chao.xie@marvell.com>
 <20130618080130.GC5461@arwen.pp.htv.fi> <51C0191F.2050104@ti.com>
 <20130618082428.GF5461@arwen.pp.htv.fi> <51C01B80.3050803@ti.com>
 <20130618083712.GJ5461@arwen.pp.htv.fi> <51C01E11.8050201@ti.com>
Message-ID: <20130618084845.GM5461@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jun 18, 2013 at 11:45:05AM +0300, Roger Quadros wrote:
> >>>>> this looks wrong for two reasons:
> >>>>>
> >>>>> a) you're not grabbing the PHY here.
> >>>>>
> >>>>> 	You can't just assume another entity grabbed your PHY for you.
> >>>>
> >>>> Isn't that done in the controller drivers e.g. ehci-fsl.c, ohci-omap, etc?
> >>>
> >>> right, and what I'm saying is that it should all be re-factored into
> >>> ehci-hcd core :-)
> >>>
> >>>> If the controllers don't want HCD core to manage the PHY they can just set it
> >>>> to some error code.
> >>>
> >>> they shouldn't have the choice, otherwise it'll be a bit of a PITA to
> >>> maintain the code. ehci core tries to grab the PHY, if it's not there,
> >>> try to continue anyway. Assume it's not needed.
> >>>
> >>
> >> OK fine, but ehci-omap is a weird case as it needs a slightly different
> >> sequence as to when PHY is initialized depending on which mode it is. (Transceiver
> >> or transceiver-less). please see this fix.
> >> http://www.spinics.net/lists/stable/msg12106.html
> >>
> >> All I'm saying as that ehci-omap needs a way to tell hcd core that it needs PHY
> >> handling for itself.
> > 
> > why don't you do that always ? Meaning, why don't you *always* take PHY
> > out of suspend ? If PHY is suspended, you can't wakeup unless you have
> > (in OMAP case) pad wakeup working, right ?
> > 
> 
> Maybe I wasn't clear before. This is nothing about wakeup and e always take PHY out of suspend. 
> The problem is when to take it out of suspend relative to when EHCI controller starts.
> Let me clarify.
> 
> In Transceiver mode we need this.
> 
> - bring phy out of reset
> - start EHCI controller
> 
> Whereas for Transceiver-less mode we need this.
> 
> - start EHCI controller
> - bring phy out of reset
> 
> If there is some way to signal this behaviour to the HCD core, it
> should be good enough.

alright, now I get it. That's quite messed up that it has to be this way
:-p

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130618/fc604c6d/attachment.sig>
