From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 23 Apr 2013 17:28:07 +0100
Subject: [RFC PATCH] drivers: bus: add ARM CCI support
In-Reply-To: <1366725128.8473.21.camel@computer5.home>
References: <1365691679-28674-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1365691679-28674-2-git-send-email-lorenzo.pieralisi@arm.com>
 <1366725128.8473.21.camel@computer5.home>
Message-ID: <20130423162807.GA2461@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 23, 2013 at 02:52:08PM +0100, Jon Medhurst (Tixy) wrote:
> On Thu, 2013-04-11 at 15:47 +0100, Lorenzo Pieralisi wrote:
> [...]

[...]

> > diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
> > +/*
> > + * cci_port_control()
> > + *	@port = index of the port to setup
> > + *	@enable = if true enables the port, if false disables it
> > + */
> > +static void notrace cci_port_control(unsigned int port, bool enable)
> > +{
> > +	void __iomem *base = ports[port].base;
> > +
> > +	if (!base)
> > +		return;
> > +
> > +	writel_relaxed(enable, base + CCI_PORT_CTRL);
> 
> If enable is bool (0 or 1) then this is going to set snoops as specified
> but is always going to clear DVM broadcast as that is controlled by bit1
> of the register. So, does the API need specifying different to allow the
> caller to choose DVM state as well, or does this function need to assume
> DVM and snoops state should be equal? I.e.
> 
> 	writel_relaxed(enable ? 0x3 : 0x0, base + CCI_PORT_CTRL);

Some #defines for that magic "3" would be a good idea too.  Ultimately we
may want independent control over snoops and DVM, but I think that could
be done later as an extension to the code, if needed.  We don't expect
there to be a large number of callers for this code...

Cheers
---Dave
