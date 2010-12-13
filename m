From: LW@KARO-electronics.de (=?iso-8859-15?Q?Lothar_Wa=DFmann?=)
Date: Mon, 13 Dec 2010 08:54:41 +0100
Subject: [PATCH v5 07/15] ARM: mxs: Add gpio support
In-Reply-To: <20101213072743.GA23558@ubuntu.localdomain>
References: <1291968402-19393-1-git-send-email-shawn.guo@freescale.com>
	<1291968402-19393-2-git-send-email-shawn.guo@freescale.com>
	<20101210102416.GH17441@pengutronix.de>
	<20101213072743.GA23558@ubuntu.localdomain>
Message-ID: <19717.53569.772925.280495@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Shawn Guo writes:
> Hi Uwe,
> 
> On Fri, Dec 10, 2010 at 03:24:16AM -0700, Uwe Kleine-K?nig wrote:
> > Hello Shawn,
> > 
> > On Fri, Dec 10, 2010 at 04:06:40PM +0800, Shawn Guo wrote:
> [...]
> > > +int __init mxs_gpio_init(struct mxs_gpio_port *port, int cnt)
> > > +{
> > > +	int i, j;
> > > +
> > > +	/* save for local usage */
> > > +	mxs_gpio_ports = port;
> > > +	gpio_table_size = cnt;
> > > +
> > > +	pr_info("MXS GPIO hardware\n");
> > > +
> > > +	for (i = 0; i < cnt; i++) {
> > > +		/* disable the interrupt and clear the status */
> > > +		__raw_writel(0, port[i].base +
> > > +				PINCTRL_PIN2IRQ(i));
> > > +		__raw_writel(0, port[i].base +
> > > +				PINCTRL_IRQEN(i));
> > > +		__raw_writel(~0, port[i].base +
> > > +				PINCTRL_IRQSTAT(i) + MXS_CLR_ADDR);
> > Why not __raw_writel(0, port[i].base + PINCTRL_IRQSTAT(i)) ?
> > (And note that applying ~ on a signed integer isn't portable in
> > general.  For all sane archs this is the same as ~0U though and ARM is
> > sane (here), still I think it's good to be aware of such things and
> > avoid them if easily possible.)
> > 
> The i.MX28 RM section 9.4.78 tells "Software may clear any bit in this
> register by writing a 1 to the bit at the SCT clear address".
> 
> What about writing 0xffffffff into clear address?
> 
When initializing a register it's much more straightforward to write a
zero into the register than to (ab)use the bitwise clear function.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
