From: lost.distance@yahoo.com (Paul Parsons)
Date: Fri, 3 Feb 2012 19:35:27 +0000 (GMT)
Subject: [PATCH v4 1/2] pxa/hx4700: Add PCMCIA/CF support
In-Reply-To: <20120203090559.GH889@n2100.arm.linux.org.uk>
Message-ID: <1328297727.57229.YahooMailClassic@web29009.mail.ird.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

--- On Fri, 3/2/12, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> irq_set_irq_type(gpio_to_irq(GPIOD4_CF_nCD),
> IRQ_TYPE_EDGE_BOTH);
> 
> You shouldn't need to set the IRQ type for this.

If I don't set the IRQ type then it doesn't get set before the interrupt
is unmasked in request_irq(). On the hx4700 the default IRQ type is level
triggered low level detect, which is exactly the signal present on the
(active low) CF card detect GPIO at boot. Consequently the interrupt
handler is called repeatedly, resulting in some breakage.

I can fix this by setting the IRQ type elsewhere in the hx4700 platform
beforehand. But wouldn't it be better for soc_pcmcia_hw_init() (or
whatever) to set the IRQ type before it calls request_irq() ?

> > +??? state->detect =
> (gpio_get_value(GPIOD4_CF_nCD) == 0);
> > +??? state->ready =
> (gpio_get_value(GPIO60_HX4700_CF_RNB) != 0);
> 
> soc_common reads these for you before calling your
> socket_state
> function.

OK.

> > +??? state->bvd1 = 1;
> > +??? state->bvd2 = 1;
> 
> If you don't have the BVD signals, soc_common now defaults
> these to '1'.

OK.

> > +??? state->wrprot = 0;
> 
> You don't need to set this - soc_common sets this to zero.

OK.

> > +??? pdev =
> platform_device_alloc("pxa2xx-pcmcia", -1);
> > +??? if (!pdev)
> > +??? ??? return -ENOMEM;
> > +
> > +??? ret =
> platform_device_add_data(pdev,
> > +??? ???
> &hx4700_pcmcia_ops, sizeof(hx4700_pcmcia_ops));
> > +??? if (ret)
> > +??? ??? goto out;
> > +
> > +??? ret = platform_device_add(pdev);
> > +??? if (ret)
> > +??? ??? goto out;
> 
> ??? pdev =
> platform_device_register_data(NULL, "pxa2xx-pcmcia", -1,
> ??? ???
> &hx4700_pcmcia_ops, sizeof(hx4700_pcmcia_ops));
> ??? if (IS_ERR(pdev))
> ??? ??? return PTR_ERR(pdev);

Yes, that looks simpler.
