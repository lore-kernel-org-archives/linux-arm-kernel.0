From: balbi@ti.com (Felipe Balbi)
Date: Fri, 26 Oct 2012 09:20:36 +0300
Subject: [PATCHv2] Input: omap4-keypad: Add pinctrl support
In-Reply-To: <20121025205901.GA3827@sirena.org.uk>
References: <1350911580-20307-1-git-send-email-sourav.poddar@ti.com>
 <20121024161429.GA16350@core.coreip.homeip.net>
 <CACRpkdai3NocZQnW6YRF+k6GXUSx3P_Ge=F-tkuivrFm6tBbLg@mail.gmail.com>
 <4099134.xWUIfbbahk@dtor-d630.eng.vmware.com>
 <20121024185818.GB772@arwen.pp.htv.fi>
 <20121025205901.GA3827@sirena.org.uk>
Message-ID: <20121026062008.GA21734@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Oct 25, 2012 at 09:59:01PM +0100, Mark Brown wrote:
> On Wed, Oct 24, 2012 at 09:58:19PM +0300, Felipe Balbi wrote:
> 
> > need a way to tell drivers/base "hey, don't touch pinctrl at all because
> > I know what I'm doing" and that has to happen before probe() too,
> > otherwise it's already too late and, according to what you suggest,
> > drivers/base will already have touched pinctrl. The only way I see would
> > be to add an extra "dont_touch_my_pins" field to every driver structure
> > in the kernel. Clearly what you say is nonsense.
> 
> I suspect that's not actually a big deal and that if we went down this
> route we'd have the driver take over control from the core code during
> probe() with the core still setting up the default state.
> 
> Personally I do think we want to be factoring bolierplate out of
> drivers, if they're not doing anything constructive with pinctrl they
> should be able to avoid having code for it.  There definitely are issues
> to work through but it seems like we ought to be able to do something.

IMHO this will come back to bite you in the *ss. Specially when the same
driver is shared among multiple revisions of the same SoC or multiple
different SoCs.

Hypothetical situation: OMAP4 has keypad as the default pin mode and low
power is handled by the HW, so keypad could have pinctlr "boilerplate"
factored out. Then comes OMAP5 and low power mode has to be handled by
SW for whatever reason (maybe there are more than one low power mode).
Then we will need to patch omap4-keypad.c to remove "dont_touch_my_pins"
flag and add pinctrl support.

When you think of the possibilities of every single driver going
throught that it sounds a lot nicer to not make that decision IMHO and
keep pinctrl explicit.

This is not like module_*_driver() macro.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121026/b949fc3f/attachment.sig>
