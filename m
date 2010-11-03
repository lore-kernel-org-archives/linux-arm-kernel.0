From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 3 Nov 2010 16:40:23 +0000
Subject: [PATCH 02/17] ARM: pxa: Access SMEMC via virtual addresses
In-Reply-To: <201011031630.03658.marek.vasut@gmail.com>
References: <1288741914-21328-1-git-send-email-marek.vasut@gmail.com>
	<1288741914-21328-2-git-send-email-marek.vasut@gmail.com>
	<AANLkTimdrc1XjnTbq8nW+0yov00YyhpJnMG9j57f4uZk@mail.gmail.com>
	<201011031630.03658.marek.vasut@gmail.com>
Message-ID: <20101103164023.GB11751@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 03, 2010 at 04:30:03PM +0100, Marek Vasut wrote:
> > >        /* Fix timings for dm9000s (CS1/CS2)*/
> > > -       MSC0 = (MSC0 & 0xffff) | (dm9000_msc << 16);
> > > -       MSC1 = (MSC1 & 0xffff0000) | dm9000_msc;
> > > +       __raw_writel((MSC0 & 0xffff) | (dm9000_msc << 16), MSC0);
> > > +       __raw_writel((MSC1 & 0xffff0000) | dm9000_msc, MSC1);
> > 
> > This isn't correct.
> 
> I don't see the difference (well, besides that this should be adjusted by 
> bootloader).

Eric is quite right - the above is not a correct conversion - it's a
functional change.

	MSC0 = (MSC0 & 0xffff) | (dm9000_msc << 16);

Reads the MSC0 register, modifies its value, and writes it back.

	__raw_writel((MSC0 & 0xffff) | (dm9000_msc << 16), MSC0);

Uses the MSC0 register address, modifies that address value, and then
writes it to the MSC0 register.

> > > @@ -205,19 +218,18 @@ pxa2xx_pcmcia_frequency_change(struct
> > > soc_pcmcia_socket *skt, static void pxa2xx_configure_sockets(struct
> > > device *dev)
> > >  {
> > >        struct pcmcia_low_level *ops = dev->platform_data;
> > > -
> > >        /*
> > >         * We have at least one socket, so set MECR:CIT
> > >         * (Card Is There)
> > >         */
> > > -       MECR |= MECR_CIT;
> > > +       uint32_t mecr = MECR_CIT;
> > > 
> > >        /* Set MECR:NOS (Number Of Sockets) */
> > >        if ((ops->first + ops->nr) > 1 ||
> > >            machine_is_viper() || machine_is_arcom_zeus())
> > > -               MECR |= MECR_NOS;
> > > -       else
> > > -               MECR &= ~MECR_NOS;
> > > +               mecr |= MECR_NOS;
> > > +
> > > +       __raw_writel(mecr, MECR);
> > 
> > This looks to be a bit inconsistent with the original code?

No comment for this - and I agree with Eric.  This again is not just a
conversion from having MECR accessing the register, to using __raw_readl
and __raw_writel.  It always forces MECR_CIT to be set - which may not
be what was there originally.

It's another functional change.
