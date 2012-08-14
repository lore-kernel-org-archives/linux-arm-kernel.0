From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 14 Aug 2012 04:37:58 +0200
Subject: [PATCH 05/14] ARM: at91: add pinctrl support
In-Reply-To: <CACQ1gAjPGcnOGh9iMxKUH1FA6rHBcuOzgR_A+wkbFWYkazQPxw@mail.gmail.com>
References: <20120810124820.GA20557@game.jcrosoft.org>
 <1344603731-32667-1-git-send-email-plagnioj@jcrosoft.com>
 <1344603731-32667-5-git-send-email-plagnioj@jcrosoft.com>
 <CACQ1gAjPGcnOGh9iMxKUH1FA6rHBcuOzgR_A+wkbFWYkazQPxw@mail.gmail.com>
Message-ID: <20120814023758.GC8836@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > +
> > +dbgu: serial at fffff200 {
> > +       compatible = "atmel,at91sam9260-usart";
> > +       reg = <0xfffff200 0x200>;
> > +       interrupts = <1 4 7>;
> > +       pinctrl-names = "default";
> > +       pinctrl-0 = <&pinctrl_dbgu>;
> > +       status = "disabled";
> > +};
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index e91c7cd..178a619 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -352,6 +352,7 @@ config ARCH_AT91
> >         select CLKDEV_LOOKUP
> >         select IRQ_DOMAIN
> >         select NEED_MACH_IO_H if PCCARD
> > +       select PINCTRL
> >         help
> >           This enables support for systems based on Atmel
> >           AT91RM9200 and AT91SAM9* processors.
> There's a problem with this: if CONFIG_PINCRTL is forced on ARCH_AT91
> and PINCTRL_AT91 is not selected,
> all calls to devm_pinctrl_get_select_default() will fail. => no
> serial, no nand etc..
> IMHO, CONFIG_PINCTRL should not be forced, otherwise it will break
> configs that don't want pinctrl
> Or, if pinctrl is the new and only way, PINCTRL_AT91 should also be
> forced on ARCH_AT91
no pinctrl MUST be forced as we provide pinctrl dummies
which will provide dummy config so not break

and if you want the gpio you need to enable the pinctrl on at91 otherwise you
not have it we can force PINCRTL_AT91 on DT but now the pinctrl need to always
be enabled
> > --
> > 1.7.10.4
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> 
> I tested it with a at91sam9g35-ek board, and it hangs before the dbgu
> line is configured.
> ( with at91_dt_defconfig and at91sam9g35ek.dts )
did you update you dtb before booting?

Best Regards,
J.
