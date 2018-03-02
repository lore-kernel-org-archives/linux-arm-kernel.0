From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 2 Mar 2018 12:19:29 +0000
Subject: [PATCH] i2c: s3c2410: Properly handle interrupts of number 0
In-Reply-To: <20180302114909.u6kqdszt3aew2io2@mwanda>
References: <1519936484-23132-1-git-send-email-krzk@kernel.org>
 <20180302111931.GX9418@n2100.armlinux.org.uk>
 <20180302114909.u6kqdszt3aew2io2@mwanda>
Message-ID: <20180302121929.GY9418@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 02, 2018 at 02:49:09PM +0300, Dan Carpenter wrote:
> On Fri, Mar 02, 2018 at 11:19:31AM +0000, Russell King - ARM Linux wrote:
> > On Thu, Mar 01, 2018 at 09:34:44PM +0100, Krzysztof Kozlowski wrote:
> > > Interrupt number 0 (returned by platform_get_irq()) might be a valid IRQ
> > > so do not treat it as an error.  If interrupt 0 was configured, the driver
> > > would exit the probe early, before finishing initialization, but with
> > > 0-exit status.
> > 
> > The official position (as stated by Linus) is that interrupt zero is
> > not a valid interrupt for peripheral drivers (it may be valid within
> > architecture code for things like the x86 PIT, but nothing else.)
> > 
> > You need to number your platform interrupts from one rather than zero.
> > 
> > Note that there have been patches proposed to make platform_get_irq()
> > return an error rather than returning a value of zero, so changing
> > the driver in this way is not a good idea.
> > 
> 
> Those patches to make platform_get_irq() return error codes were merged
> 12 years ago in commit 305b3228f9ff ("[PATCH] driver core:
> platform_get_irq*(): return -ENXIO on error").

Rubbish.  Please look at the commit you're quoting, it doesn't have
much to do with what I'm saying, and I think you're mis-remembering
on two counts.

The discussion came up recently (last November) about making
platform_get_irq() return an error rather than zero - in other words,
it will never return zero.  This is entirely different from making
platform_get_irq() return -ENXIO when an error occurs (not finding
the resource.)  This discussion was sparked by patch sets from
Arvind Yadav.

Further information can be found by looking up the discussions
around killing "NO_IRQ", particularly messages from Linus.

Secondly, the code today does:

int platform_get_irq(struct platform_device *dev, unsigned int num)
{
...
        return r ? r->start : -ENXIO;
}

So if the IRQ resource is not found, then yes, it will return -ENXIO.
If on the other hand the resource is found, then it will return
whatever is found in r->start, which can be zero.

As stated, IRQ 0 shall not be taken by drivers to be a valid
interrupt.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
