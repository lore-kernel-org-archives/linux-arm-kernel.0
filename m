From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 14 Oct 2011 20:42:36 +0100
Subject: [PATCH v4 5/8] ARM: pxa: change gpio driver to platform driver
In-Reply-To: <20111013192222.GW18574@ponder.secretlab.ca>
References: <1318478825-17187-1-git-send-email-haojian.zhuang@marvell.com>
	<1318478825-17187-6-git-send-email-haojian.zhuang@marvell.com>
	<20111013192222.GW18574@ponder.secretlab.ca>
Message-ID: <20111014194235.GU21648@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 13, 2011 at 01:22:22PM -0600, Grant Likely wrote:
> On Thu, Oct 13, 2011 at 12:07:02PM +0800, Haojian Zhuang wrote:
> > +struct resource mmp2_resources_gpio[] = {
> > +	{
> > +		.start  = 0xd4019000,
> > +		.end    = 0xd4019fff,
> > +		.name   = "gpio_phys_base",
> > +		.flags  = IORESOURCE_MEM,
> > +	}, {
> > +		.start  = APB_VIRT_BASE + 0x19000,
> > +		.end    = APB_VIRT_BASE + 0x19fff,
> > +		.name   = "gpio_virtual_base",
> > +		.flags  = IORESOURCE_MEM,
> 
> This shouldn't be needed.  The driver should ioremap its registers.
> Only the physical address should be passed in via a IORESOURCE_MEM
> resource.

Definitely - the thing to point out to people who do this kind of thing
is that resources are part of an ordered tree occupying a single space,
and nasty things happen when resources overlap other resources within
that space (sometimes they can refuse to be requested - which causes
device registration to fail.)

Therefore, abusing MEM resources to pass non-physical addresses is a
potential cause for trouble.
