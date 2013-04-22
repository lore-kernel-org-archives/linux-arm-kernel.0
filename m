From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 22 Apr 2013 11:18:58 -0400 (EDT)
Subject: [RFC PATCH] drivers: bus: add ARM CCI support
In-Reply-To: <20130422142457.GM14496@n2100.arm.linux.org.uk>
References: <1365691679-28674-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1365691679-28674-2-git-send-email-lorenzo.pieralisi@arm.com>
 <51702B70.9000908@codeaurora.org>
 <alpine.LFD.2.03.1304181341020.17375@syhkavp.arg>
 <20130422142457.GM14496@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.03.1304221118100.17375@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 22 Apr 2013, Russell King - ARM Linux wrote:

> On Thu, Apr 18, 2013 at 01:54:04PM -0400, Nicolas Pitre wrote:
> > On Thu, 18 Apr 2013, Stephen Boyd wrote:
> > 
> > > On 04/11/13 07:47, Lorenzo Pieralisi wrote:
> > > > diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
> > > > new file mode 100644
> > > > index 0000000..81953de
> > > > --- /dev/null
> > > > +++ b/drivers/bus/arm-cci.c
> > > [...]
> > > > +static void notrace cci_port_control(unsigned int port, bool enable)
> > > > +{
> > > > +	void __iomem *base = ports[port].base;
> > > > +
> > > > +	if (!base)
> > > > +		return;
> > > > +
> > > > +	writel_relaxed(enable, base + CCI_PORT_CTRL);
> > > > +	while (readl_relaxed(cci_ctrl_base + CCI_CTRL_STATUS) & 0x1)
> > > > +			;
> > > 
> > > cpu_relax()?
> > 
> > In some cases there is no more cache coherence when this is called and 
> > the hardware might not be in a good state to cope with whatever action 
> > people might be tempted to insert into cpu_relax().  After the CCI is 
> > disabled it is important to keep a low profile and not touch anything 
> > global. With some early hardware revision, even a DMB here was harmful.
> 
> It would be useful if there was a comment in the code explaining this.
> As it stands, you _will_ get a stream of patches from kernel janitors
> itching to add cpu_relax() there.

Absolutely right.


Nicolas
