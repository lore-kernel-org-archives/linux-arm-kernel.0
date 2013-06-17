From: tony@atomide.com (Tony Lindgren)
Date: Mon, 17 Jun 2013 00:29:52 -0700
Subject: [PATCH] drivers: pinctrl: add active state to core
In-Reply-To: <51BB357F.80406@wwwdotorg.org>
References: <1370938616-5952-1-git-send-email-linus.walleij@stericsson.com>
 <51B75148.5080701@wwwdotorg.org>
 <CACRpkdYQSO0+9tQkS=df-kpL=XL+DpnY1ijp6_Zeg0MvmFujyw@mail.gmail.com>
 <20130612183345.GU8164@atomide.com>
 <51BA1E06.6020705@wwwdotorg.org>
 <20130614084644.GD20992@atomide.com> <51BB357F.80406@wwwdotorg.org>
Message-ID: <20130617072951.GC4465@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Stephen Warren <swarren@wwwdotorg.org> [130614 08:29]:
> On 06/14/2013 02:46 AM, Tony Lindgren wrote:
> > 
> > Hmm how would the pinctrl subsystem know which pins to reprogram and
> > which ones are static?
> 
> Each state should list the desired configuration of all pins used by the
> HW module. Any configuration that's identical between the old an new
> state when pinctrl_select_state() executes is static, anything else is not.

Listing all the pins in each named mode won't work too well from hardware
point of view, I think this can be solved by having a bit finer grained
named modes. I've just replied about this in the related thread
"[PATCH] pinctrl: document the pinctrl PM states".
 
> > We don't have any default state for pins for omaps at least and pinctrl
> > single does not not set them to anything when disable is called unless
> > function-off is specified.
> 
> But that's OMAP-specific. If the set of pinctrl states that the core PM
> code operates on is documented as general policy, it has to work the
> same everywhere.

Agreed. Hopefully this issue too is addressed in the other reply I
mention above.
 
> > But even if the pinctrl driver does something to the pins in disable,
> > that should work too. It's just an extra step between toggling between
> > two named pin states.
> 
> If the "default" state says e.g. "set pin X to function A", and the
> "idle" state doesn't say anything about pin X, when a switch from
> default -> idle will simply program pin X back to its default state (if
> the driver does that) and then not program it to anything else, since
> the idle state doesn't say what to program it to.
> 
> As I said, this might work fine if the pinctrl driver doesn't do
> anything in struct pinmux_ops .disable, but given that it's legal for
> the driver to do so, relying on that won't work for all drivers, so some
> alternative scheme of handling static pinmux configuration is needed.

And hopefully this issue too is addressed :)
 
> >> Also, if default uses more pins that active, when you switch to active,
> >> those pins won't be marked as owned any more, I think, so something else
> >> could in theory grab them. At least, debugfs wouldn't be entirely
> >> accurate any more.
> > 
> > I think you're misunderstanding. The default pins are held for as long
> > as the device is loaded. We're not touching the default pins at all
> > after probe. Active and idle pins are not subsets of default.
> 
> OK, then please provide an example of how this is represented.

I've listed a few examples in the other thread, so maybe take a look
and see if it addresses your concerns.

Regards,

Tony
