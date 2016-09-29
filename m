From: andrew@aj.id.au (Andrew Jeffery)
Date: Thu, 29 Sep 2016 17:24:59 +0930
Subject: [PATCH 5/8] pinctrl: aspeed: Enable capture of off-SCU pinmux
 state
In-Reply-To: <CACPK8Xc7y3GtcJCVYYs-JKTqBZvqVeZaz5MUk=UX151SX1xEFw@mail.gmail.com>
References: <cover.115463f791b69859c5ce9dafd61a5755ea039f4b.1474986045.git-series.andrew@aj.id.au>
 <a266046d34009e6e92c4c76699c550c2ba44bd5c.1474986045.git-series.andrew@aj.id.au>
 <CACPK8Xc7y3GtcJCVYYs-JKTqBZvqVeZaz5MUk=UX151SX1xEFw@mail.gmail.com>
Message-ID: <1475135699.24463.21.camel@aj.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2016-09-29 at 16:15 +0930, Joel Stanley wrote:
> On Wed, Sep 28, 2016 at 12:20 AM, Andrew Jeffery <andrew@aj.id.au> wrote:
> > 
> > The System Control Unit IP in the Aspeed SoCs is typically where the
> > pinmux configuration is found.
> > 
> > But not always.
> > 
> > On the AST2400 and AST2500 a number of pins depend on state in one of
> > the SIO, LPC or GFX IP blocks, so add support to at least capture what
> > that state is. The pinctrl engine for the Aspeed SoCs doesn't try to
> > inspect or modify the state of the off-SCU IP blocks. Instead, it logs
> > the state requirement with the expectation that the platform
> > designer/maintainer arranges for the appropriate configuration to be
> > applied through the associated drivers.
> This is unfortunate.
> 
> This patch kicks the can down the road, but doesn't solve the problem
> for a user who wants to configure some functionality that depends on
> the non-SCU bits. Because of this I'm not sure if we want to put it in
> the tree.

I agree that there's not much functionality from a user's perspective,
but the "kicking the can down the road" assessment might be a little
harsh. Given the lack of user functionality it becomes more difficult
to argue for the patch's inclusion given the additional complexity, but
it does mean that the g4/g5 drivers can completely specify their
dependencies and not have the aspeed pinctrl core do the wrong thing
when it encounters the non-SCU IP offsets. It gets us half-way to
having the pinctrl driver actually configure the state (knowing what it
needs to configure), which I feel is more than a kick-the-can-down-the-
road boondoggle.

> 
> However, I'm not sure what a proper solution would look like.

So if we accept that a proper solution includes specifying the off-SCU
dependencies, the remaining question is how do we tastefully apply the
desired state on register-spaces the pinctrl driver doesn't own.

>  Perhaps
> Linus can point out another SoC that has a similar problem?

Or failing that, an approach that is acceptable...

Cheers,

Andrew
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160929/31192dfd/attachment-0001.sig>
