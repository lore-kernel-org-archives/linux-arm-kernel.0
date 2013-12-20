From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 20 Dec 2013 16:09:40 +0000 (UTC)
Subject: [PATCHv11 06/49] clk: add support for low level register ops
In-Reply-To: <52B42747.8090408@ti.com>
References: <1387452260-23276-1-git-send-email-t-kristo@ti.com>
 <1387452260-23276-7-git-send-email-t-kristo@ti.com>
 <alpine.DEB.2.02.1312201056560.20802@utopia.booyaka.com>
 <52B42747.8090408@ti.com>
Message-ID: <alpine.DEB.2.02.1312201603340.16798@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 20 Dec 2013, Tero Kristo wrote:

> On 12/20/2013 01:00 PM, Paul Walmsley wrote:
> > On Thu, 19 Dec 2013, Tero Kristo wrote:
> > > +/**
> > > + * clk_readl_default - default clock register read support function
> > > + * @reg: register to read
> > > + *
> > > + * Default implementation for reading a clock register.
> > > + */
> > > +static u32 clk_readl_default(u32 __iomem *reg)
> > 
> > Why u32 __iomem rather than void *?  Not that this will affect OMAP, but
> > will this need to be changed later to support 64-bit addresses?
> > __raw_writel() and __raw_readl() are defined with "void __iomem *" as
> > their address argument, which will be 64 bits on arm64, correct?
> 
> Just copy pasting the current implementation from the clk-provider.h file.
> 
> However, pointer is pointer no? This is just used to refer to a 32bit value,
> the pointer itself can be either 32bit or 64bit. 

Yes I think you're right that the impact is simply cosmetic.  That
argument winds up as the address argument to __raw_readl/writel()
which is a void __iomem *, so the type there will be ignored.

> If the registers are changed to be 64 bit though.... but that will
> require changing most of the clock code as it is littered with 'u32
> val;' type declarations. 

Yes, we can count on readl/writel to operate on 32-bit values.

> Anyway, I can change this to be void __iomem.

OK

- Paul
