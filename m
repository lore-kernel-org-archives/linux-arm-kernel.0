From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 20 Jan 2016 17:02:20 +0000
Subject: [RFC PATCH v3] irqchip: Add support for Tango interrupt controller
In-Reply-To: <569FB4AE.8000506@sigmadesigns.com>
References: <569CE0F2.1060507@sigmadesigns.com>
 <569D0B80.1010908@sigmadesigns.com>
 <569D165E.4060004@sigmadesigns.com> <569FAFF5.4090909@arm.com>
 <yw1xr3hcqlix.fsf@unicorn.mansr.com>
 <569FB4AE.8000506@sigmadesigns.com>
Message-ID: <20160120170219.GC28169@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 20, 2016 at 05:24:14PM +0100, Marc Gonzalez wrote:
> On 20/01/2016 17:10, M?ns Rullg?rd wrote:
> 
> > Marc Zyngier wrote:
> > 
> >>> +	if (of_property_read_u32(node, "reg", &ctl))
> >>> +		panic("%s: failed to get reg base", node->name);
> >>> +
> >>> +	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
> >>> +	chip->ctl = ctl;
> >>> +	chip->base = base;
> > 
> > As I said before, this assumes the outer DT node uses a ranges
> > property.  Normally reg properties work the same whether they specify an
> > offset within an outer "ranges" or have a full address directly.  It
> > would be easy enough to make this work with either, so I don't see any
> > reason not to.
> 
> IIRC, I was told very early in the review process that the ranges prop
> was mandatory. Lemme look for it... It was Arnd:
> 
> http://thread.gmane.org/gmane.linux.ports.arm.kernel/444131/focus=444207

I believe Arnd's point was that you need _a_ ranges property, rather
than specifically requiring an idmap/empty ranges property.

As Marc pointed out, you can use of_iomap on the child nodes to map the
portions described by the reg properties, which will handle any
ranges-based translation automatically.

When you put together the binding document, please point out that the
ranges property is necessary.

Thanks,
Mark.
