From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 14 Aug 2012 09:42:54 +0000
Subject: [PATCH 5/8] mfd: Provide the PRCMU with its own IRQ domain
In-Reply-To: <CACRpkdZ7bMBytyDppV2sB1d1sUbDpPRqAQVOq8k4UOYdmg+Mkw@mail.gmail.com>
References: <1344527635-6163-1-git-send-email-lee.jones@linaro.org>
 <1344527635-6163-6-git-send-email-lee.jones@linaro.org>
 <CACRpkdZ7bMBytyDppV2sB1d1sUbDpPRqAQVOq8k4UOYdmg+Mkw@mail.gmail.com>
Message-ID: <201208140942.54773.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 14 August 2012, Linus Walleij wrote:
> 
> On Thu, Aug 9, 2012 at 5:53 PM, Lee Jones <lee.jones@linaro.org> wrote:
> 
> > +static struct irq_domain *db8500_irq_domain;
> 
> So this is a good idea.
> 
> > +int db8500_irq_get_virq(int irq);
> 
> And I'm sceptic about this business. Why isn't this physical-to virtual
> mapping business confined to the core MFD driver? But enlighten me.
> 

I believe MFD does not (yet) know about IRQ domains. The wm8994
and 88pm80x drivers do this slightly different by exporting
a foo_request_irq() function that performs the mapping.

Traditionally, an MFD would add an offset to the local IRQ number
to put the VIRQ into the IRQ resource, but this doesn't work when
you have domains other than legacy.

	Arnd
