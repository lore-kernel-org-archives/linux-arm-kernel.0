From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 16 Nov 2011 20:19:02 +0100
Subject: [PATCH 1/3] drivers: base: add support for stmp-style devices
In-Reply-To: <201111161744.19733.arnd@arndb.de>
References: <1321440459-4527-1-git-send-email-w.sang@pengutronix.de>
 <1321440459-4527-2-git-send-email-w.sang@pengutronix.de>
 <201111161744.19733.arnd@arndb.de>
Message-ID: <20111116191902.GA8843@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 16, 2011 at 05:44:19PM +0000, Arnd Bergmann wrote:
> On Wednesday 16 November 2011, Wolfram Sang wrote:
> > Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> 
> Introducing new core code definitely requires a long patch description.
> How about copying the description from the introductory mail here?

What I mainly forgot was s/PATCH/RFC/, and I'm sorry about that. I know this
series is not suitable to be applied directly, I was mainly looking for
comments from the arm people who are affected by this change.

> > +static int stmp_clear_poll_bit(void __iomem *addr, u32 mask)
> > +{
> > +	int timeout = 0x400;
> > +
> > +	writel(mask, addr + STMP_CLR_ADDR);
> > +	udelay(1);
> > +	while ((readl(addr) & mask) && --timeout)
> > +		/* nothing */;
> > +
> > +	return !timeout;
> > +}
> 
> For portable code, you should use cpu_relax() inside of the loop.
> 
> Is the udelay() actually necessary here?

I am just copying the code from the current mxs-implementation. I think fixups
(yes, needed!) should go in with seperate patches. Should have said so
explicitly.

> > +	ret = stmp_clear_poll_bit(reset_addr, STMP_MODULE_SFTRST);
> > +	if (unlikely(ret))
> > +		goto error;
> 
> Please don't use likely()/unlikely() in code that is not very
> performance sensitive. It will usually just increase the code size
> but not actually have a measurable benefit.

Ditto.

> > +	if (unlikely(!timeout))
> > +		goto error;
> 
> Since the run-time of a readl() may vary greatly, counting to 400
> for a timeout seems completely arbitrary and unhelpful.

Ditto, I know. I talked about such things in Prague this year :)

> 	long timeout = jiffies + HZ / 10; /* wait for at most 100ms */
> 
> 	do {
> 		...
> 	} while (time_before(jiffies, timeout));

Better, but not perfect ;) But I'll skip the discussion here...

> > +EXPORT_SYMBOL(stmp_reset_block);
> 
> EXPORT_SYMBOL_GPL?

Fine with me.

> > +#define STMP_SET_ADDR		0x4
> > +#define STMP_CLR_ADDR		0x8
> > +#define STMP_TOG_ADDR		0xc
> 
> The register numbers should probably go into the implementation file,
> they are not an interface.

As said, those are offsets. Especially useful for:

	offset = enabled ? STMP_SET_ADDR : STMP_CLR_ADDR;
	writel(bits1, reg1 + offset);
	writel(bits2, reg2 + offset);
	...

That will either set or clear bits, depending on 'enabled'.

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111116/64590afd/attachment.sig>
