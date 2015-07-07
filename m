From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 7 Jul 2015 14:32:33 +0200
Subject: [PATCH v2] mfd: atmel-hlcdc: implement write synchronization
In-Reply-To: <20150707122258.GE2887@sirena.org.uk>
References: <1434623835-11205-1-git-send-email-boris.brezillon@free-electrons.com>
 <20150624141233.GM15013@x1> <20150707122258.GE2887@sirena.org.uk>
Message-ID: <20150707143233.21d73e71@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Tue, 7 Jul 2015 13:22:58 +0100
Mark Brown <broonie@kernel.org> wrote:

> On Wed, Jun 24, 2015 at 03:12:33PM +0100, Lee Jones wrote:
> > Mark,
> > 
> > Can you take a look at this please?
> > 
> > Does it subvert any of the neat regmap functionality that you'd get
> > otherwise?
> 
> Please don't ask questions like this off list unless there is a great
> reason to, doing that means that other people can't help and that people
> with the same people won't be able to search the list for the answer.
> 
> > > Some HLCDC registers cannot be written until the previous write access has
> > > been synchronized with the hardware. If they are written while a
> > > synchronization is in progress, the new value (and the associated
> > > configuration) might be silently ignored, resulting in unpredictable
> > > behavior.
> 
> > > Hide the write synchronization stuff in a regmap implementation and use
> > > this implementation instead of the generic mmio one.
> 
> The above makes it sound like we're just waiting for the write to be
> posted (usually forced by doing a read or something) but...

Does that mean I should reword the description ...

> 
> > > +static int regmap_atmel_hlcdc_reg_write(void *context, unsigned int reg,
> > > +					unsigned int val)
> > > +{
> > > +	void __iomem *regs = context;
> > > +
> > > +	if (reg <= ATMEL_HLCDC_DIS) {
> > > +		u32 status;
> > > +
> > > +		readl_poll_timeout(regs + ATMEL_HLCDC_SR, status,
> > > +				   !(status & ATMEL_HLCDC_SIP), 1, 100);
> > > +	}
> > > +
> > > +	writel(val, regs + reg);
> 
> ...this is polling for some bit to be set.  That's not very common at
> all and not something that the framework supports.

... and keep the implementation as proposed here ?
Or should I had this kind of behavior to the core infrastructure ?

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
