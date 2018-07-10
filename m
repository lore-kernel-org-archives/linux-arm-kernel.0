From: Jisheng.Zhang@synaptics.com (Jisheng Zhang)
Date: Tue, 10 Jul 2018 10:07:04 +0800
Subject: [PATCH v3 3/3] serial: 8250_dw: add fractional divisor support
In-Reply-To: <20180709163241.4d4ee343@xhacker.debian>
References: <20180709160942.11a74f7a@xhacker.debian>
 <20180709162315.7f53eb9a@xhacker.debian>
 <20180709163241.4d4ee343@xhacker.debian>
Message-ID: <20180710100704.236d256c@xhacker.debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy,

On Mon, 9 Jul 2018 16:32:41 +0800 Jisheng Zhang wrote:

> Hi Andy,
> 
> On Mon, 9 Jul 2018 16:23:15 +0800 Jisheng Zhang wrote:
> 
> > For Synopsys DesignWare 8250 uart which version >= 4.00a, there's a
> > valid divisor latch fraction register. The fractional divisor width is
> > 4bits ~ 6bits.
> > 
> > Now the preparation is done, it's easy to add the feature support.
> > This patch firstly tries to get the fractional divisor width during
> > probe, then setups dw specific get_divisor() and set_divisor() hook.
> > 
> > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> > ---
> >  drivers/tty/serial/8250/8250_dw.c | 45 +++++++++++++++++++++++++++++++
> >  1 file changed, 45 insertions(+)
> > 
> > diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
> > index fa8a00e8c9c6..e90c3d229f00 100644
> > --- a/drivers/tty/serial/8250/8250_dw.c
> > +++ b/drivers/tty/serial/8250/8250_dw.c
> > @@ -31,6 +31,7 @@
> >  
> >  /* Offsets for the DesignWare specific registers */
> >  #define DW_UART_USR	0x1f /* UART Status Register */
> > +#define DW_UART_DLF	0xc0 /* Divisor Latch Fraction Register */
> >  #define DW_UART_CPR	0xf4 /* Component Parameter Register */
> >  #define DW_UART_UCV	0xf8 /* UART Component Version */
> >  
> > @@ -55,6 +56,7 @@
> >  
> >  struct dw8250_data {
> >  	u8			usr_reg;
> > +	u8			dlf_size;
> >  	int			line;
> >  	int			msr_mask_on;
> >  	int			msr_mask_off;
> > @@ -366,6 +368,37 @@ static bool dw8250_idma_filter(struct dma_chan *chan, void *param)
> >  	return param == chan->device->dev->parent;
> >  }
> >  
> > +/*
> > + * divisor = clk / (16 * baud) = div(I) + div(F)
> > + * "I" means integer, "F" means fractional
> > + *
> > + * 2^dlf_size * clk / (16 * baud) = 2^dlf_size * (div(I) + div(F))
> > + * so, (clk << (dlf_siz - 4)) / baud = (div(I) + div(F)) << dlf_size
> > + *
> > + * let quot = DIV_ROUND_CLOSEST(clk << (dlf_size - 4), baud), we get
> > + * div(I) = quot >> dlf_size
> > + * div(F) = quot & dlf_mask, where dlf_mask = GENMASK(dlf_size - 1, 0)
> > + */
> > +static unsigned int dw8250_get_divisor(struct uart_port *p,
> > +				       unsigned int baud,
> > +				       unsigned int *frac)
> > +{
> > +	unsigned int quot;
> > +	struct dw8250_data *d = p->private_data;
> > +
> > +	quot = DIV_ROUND_CLOSEST(p->uartclk << (d->dlf_size - 4), baud);
> > +	*frac = quot & GENMASK(d->dlf_size - 1, 0);
> > +
> > +	return quot >> d->dlf_size;  
> 
> After more consideration, I sent out this version for the following two
> points:
> 
> 1. the max frac divisor width is 6bits now, but we dunno whether future IP
> extends it or not. This patch version can still support > 6bits width except
> the overflow concern. But fixing overflow(if there is) is as simple as using\
> the DIV_ROUND_CLOSEST_ULL macro.
> 
> 2. this version makes use of well implemented GENMASK to get the dlf_mask,
> the micro is well understood, I think. so the code is simplified as well.
> 
> 3. the magic "4" is explained in the comments, I hope it could help the
> code.

I agree with your "making the code simple" concern. So I have a consideration
again. I think I made the code complex unnecessarily, the simplest get_divisor code
could be:

get_divisor()
{
	unsigned int quot, rem;

	quot = clk / (16 * baud);
	rem = clk % (16 *baud);
	*frac = DIV_ROUND_CLOSEST(rem << dlf_size, 16*baud);

	return quot;
}

Compared with previous version, this one adds one more div instruction,
but remove several "shift, and" instructions, the performance isn't that bad.
>From another side, even this version gets a trivial performance regression,
the get_divisor() doesn't sit on the hot code path. Making the code simpler is
more important.

I will send a new version.

Thanks
