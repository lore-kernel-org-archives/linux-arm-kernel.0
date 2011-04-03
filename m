From: will.deacon@arm.com (Will Deacon)
Date: Sun, 03 Apr 2011 13:13:53 +0100
Subject: [PATCH 2/6] ARM: tegra: update GPIO chained IRQ handler to use
	entry/exit functions
In-Reply-To: <BANLkTikVHUUGtThJkbyXrmxg8Whmaji7DA@mail.gmail.com>
References: <1301669441-13744-1-git-send-email-will.deacon@arm.com>
	<1301669441-13744-3-git-send-email-will.deacon@arm.com>
	<BANLkTikVHUUGtThJkbyXrmxg8Whmaji7DA@mail.gmail.com>
Message-ID: <1301832833.5022.1.camel@jazzbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Colin,

On Fri, 2011-04-01 at 21:29 +0100, Colin Cross wrote:
> > diff --git a/arch/arm/mach-tegra/gpio.c b/arch/arm/mach-tegra/gpio.c
> > index 76a3f65..08c43dd 100644
> > --- a/arch/arm/mach-tegra/gpio.c
> > +++ b/arch/arm/mach-tegra/gpio.c
> > @@ -221,8 +221,9 @@ static void tegra_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
> >        int port;
> >        int pin;
> >        int unmasked = 0;
> > +       struct irq_chip chip = get_irq_desc_chip(desc);
> Should be a pointer, and 35e857c changed get_irq_desc_chip to irq_desc_get_chip
> 

Thanks for pointing that out, I'll check the rest of the series too. I
thought the rebase onto -rc1 went a little too smoothly...

> > -       desc->irq_data.chip->irq_ack(&desc->irq_data);
> > +       chained_irq_enter(chip, desc);
> asm/mach/irq.h needs to be included to use this function
> 

Yup, assumed that was already included. Will add the #include line.

Thanks for looking at this,

Will
