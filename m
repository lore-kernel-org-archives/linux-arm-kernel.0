From: Jisheng.Zhang@synaptics.com (Jisheng Zhang)
Date: Thu, 5 Jul 2018 14:39:21 +0800
Subject: [PATCH v2 3/3] serial: 8250_dw: add fractional divisor support
In-Reply-To: <f2733332a58e7f2d92948e2ff252581f93e5073a.camel@linux.intel.com>
References: <20180704165908.4bb8b090@xhacker.debian>
 <20180704170310.56772d77@xhacker.debian>
 <f2733332a58e7f2d92948e2ff252581f93e5073a.camel@linux.intel.com>
Message-ID: <20180705143921.6a8aeb50@xhacker.debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy,

On Wed, 04 Jul 2018 19:08:22 +0300 Andy Shevchenko wrote:

> On Wed, 2018-07-04 at 17:03 +0800, Jisheng Zhang wrote:
> 
> Thanks for an update, my comments below.
> 
> > For Synopsys DesignWare 8250 uart which version >= 4.00a, there's a
> > valid divisor latch fraction register. The fractional divisor width is
> > 4bits ~ 6bits.  
> 
> I have read 4.00a spec a bit and didn't find this limitation.
> The fractional divider can fit up to 32 bits.

the limitation isn't put in the register description, but in the description
about fractional divisor width configure parameters. Searching DLF_SIZE will
find it.

>From another side, 32bits fractional div is a waste, for example, let's
assume the fract divisor = 0.9, 
if fractional width is 4 bits, DLF reg will be set to UP(0.9*2^4) = 15, the
real frac divisor =  15/2^4 = 0.93;
if fractional width is 32 bits, DLF reg will be set to UP(0.9*2^32) = 3865470567
the real frac divisor = 3865470567/2^32 = 0.90;

> 
> > Now the preparation is done, it's easy to add the feature support.
> > This patch firstly checks the component version during probe, if
> > version >= 4.00a, then calculates the fractional divisor width, then
> > setups dw specific get_divisor() and set_divisor() hook.  
>  
> > +#define DW_FRAC_MIN_VERS		0x3430302A  
> 
> Do we really need this? 
> 
> My intuition (I, unfortunately, didn't find any evidence in Synopsys
> specs for UART) tells me that when it's unimplemented we would read back
> 0's, which is fine.

yeah, I agree with you. I will remove this version check in the new version

> 
> I would test this a bit later.
> 
> >   
> 
> > +	unsigned int		dlf_size:3;  
> 
> These bit fields (besides the fact you need 5) more or less for software
> quirk flags. In your case I would rather keep a u32 value of DFL mask as
> done for msr slightly above in this structure.

OK. When setting the frac div, we use DLF size rather than mask, so could
I only calculate the DLF size once then use an u8 value to hold the
calculated DLF size rather than calculating every time?

> 
> >  };
> >  
> > +/*
> > + * For version >= 4.00a, the dw uarts have a valid divisor latch
> > fraction
> > + * register. Calculate divisor with extra 4bits ~ 6bits fractional
> > portion.
> > + */  
> 
> This comment kinda noise. Better to put actual formula from datasheet
> how this fractional divider is involved into calculus.

yeah. Will do.

> 
> > +static unsigned int dw8250_get_divisor(struct uart_port *p,
> > +				       unsigned int baud,
> > +				       unsigned int *frac)
> > +{
> > +	unsigned int quot;
> > +	struct dw8250_data *d = p->private_data;
> > +  
> 
> > +	quot = DIV_ROUND_CLOSEST(p->uartclk << (d->dlf_size - 4),
> > baud);  
> 
> If we have clock rate like 100MHz and 10 bits of fractional divider it
> would give an integer overflow.

This depends on the fraction divider width. If it's only 4~6 bits,
then we are fine.

> 
> 4 here is a magic. Needs to be commented / described better.

Yes. divisor = clk/(16*baud) = BRD(I) + BRD(F)
"I" means integer, "F" means fractional

2^dlf_size*clk/(16*baud) = 2^dlf_size*(BRD(I) + BRD(F))

clk*2^(dlf_size - 4)/baud = 2^dlf_size*((BRD(I) + BRD(F))

the left part is "DIV_ROUND_CLOSEST(p->uartclk << (d->dlf_size - 4), baud)",
let's assume it equals quot.

then, BRD(I) = quot / 2^dlf_size = quot >> dlf_size, this is where
"quot >> d->dlf_size" below from.

BRD(F) = quot & dlf_mask = quot & (~0U >> (32 - dlf_size))

> 
> > +	*frac = quot & (~0U >> (32 - d->dlf_size));
> > +  
> 
> Operating on dfl_mask is simple as
> 
> u64 quot = p->uartclk * (p->dfl_mask + 1);

Since the dlf_mask is always 2^n - 1, 
clk * (p->dlf_mask + 1) = clk << p->dlf_size, but the later
is simpler

> 
> *frac = div64_u64(quot, baud * 16 * (p->dfl_mask + 1);
> return quot;

quot = DIV_ROUND_CLOSEST(p->uartclk << (d->dlf_size - 4), baud)
*frac = quot & (~0U >> (32 - d->dlf_size))
return quot >> d->dlf_size;

vs.

quot = p->uartclk * (p->dfl_mask + 1);
*frac = div64_u64(quot, baud * 16 * (p->dfl_mask + 1);
return quot;

shift vs mul.

If the dlf width is only 4~6 bits, the first calculation can avoid
64bit div. I prefer the first calculation.

> 
> (Perhaps some magic with types is needed, but you get the idea)
> 
> > +	return quot >> d->dlf_size;
> > +}
> > +
> > +static void dw8250_set_divisor(struct uart_port *p, unsigned int
> > baud,
> > +			       unsigned int quot, unsigned int
> > quot_frac)
> > +{
> > +	struct uart_8250_port *up = up_to_u8250p(p);
> > +
> > +	serial_port_out(p, DW_UART_DLF >> p->regshift, quot_frac);  
> 
> It should use the helper, not playing tricks with serial_port_out().

I assume the helper here means the one you mentioned below, i.e in

if (p->iotype == UPIO_MEM32BE) {
	...
} else {
	...
}

> 
> > +	serial_port_out(p, UART_LCR, up->lcr | UART_LCR_DLAB);
> > +	serial_dl_write(up, quot);  
> 
> At some point it would be a helper, I think. We can call
> serial8250_do_set_divisor() here. So, perhaps we might export it.

serial8250_do_set_divisor will drop the frac, that's not we want ;)

> 
> > +}
> > +
> >  static void dw8250_quirks(struct uart_port *p, struct dw8250_data
> > *data)
> >  {
> >  	if (p->dev->of_node) {
> > @@ -414,6 +445,28 @@ static void dw8250_setup_port(struct uart_port
> > *p)
> >  	dev_dbg(p->dev, "Designware UART version %c.%c%c\n",
> >  		(reg >> 24) & 0xff, (reg >> 16) & 0xff, (reg >> 8) &
> > 0xff);
> >  
> > +	/*
> > +	 * For version >= 4.00a, the dw uarts have a valid divisor
> > latch
> > +	 * fraction register. Calculate the fractional divisor width.
> > +	 */
> > +	if (reg >= DW_FRAC_MIN_VERS) {
> > +		struct dw8250_data *d = p->private_data;
> > +  
> 
> > +		if (p->iotype == UPIO_MEM32BE) {
> > +			iowrite32be(~0U, p->membase + DW_UART_DLF);
> > +			reg = ioread32be(p->membase + DW_UART_DLF);
> > +		} else {
> > +			writel(~0U, p->membase + DW_UART_DLF);
> > +			reg = readl(p->membase + DW_UART_DLF);
> > +		}  
> 
> This should use some helpers. I'll prepare a patch soon and send it
> here, you may include it in your series.

Nice. Thanks.

> 
> I think you need to clean up back them. So the flow like
> 
> 1. Write all 1:s
> 2. Read back the value
> 3. Write all 0:s

oh, yeah! will do

> 
> > +		d->dlf_size = fls(reg);  
> 
> Just save value itself as dfl_mask.

we use the dlf size during calculation, so it's better to hold the dlf_size
instead.

Thanks for the kind review,
Jisheng
