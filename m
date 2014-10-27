From: gnurou@gmail.com (Alexandre Courbot)
Date: Mon, 27 Oct 2014 14:27:16 +0900
Subject: [PATCH 06/17] gpio: mvebu: add suspend/resume support
In-Reply-To: <20141024204532.GA6436@lunn.ch>
References: <1414151970-6626-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1414151970-6626-7-git-send-email-thomas.petazzoni@free-electrons.com>
 <20141024163051.GG4529@psi-dev26.jf.intel.com> <20141024204532.GA6436@lunn.ch>
Message-ID: <CAAVeFu+_UZkQHa38wvaBSmRZCWof6-J13eVYgrG6KS7yargsYA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 25, 2014 at 5:45 AM, Andrew Lunn <andrew@lunn.ch> wrote:
>> > +   switch (mvchip->soc_variant) {
>> > +   case MVEBU_GPIO_SOC_VARIANT_ORION:
>> > +           mvchip->edge_mask_regs[0] =
>> > +                   readl(mvchip->membase + GPIO_EDGE_MASK_OFF);
>> > +           mvchip->level_mask_regs[0] =
>> > +                   readl(mvchip->membase + GPIO_LEVEL_MASK_OFF);
>> > +           break;
>> > +   case MVEBU_GPIO_SOC_VARIANT_MV78200:
>> > +           for (i = 0; i < 2; i++) {
>> > +                   mvchip->edge_mask_regs[i] =
>> > +                           readl(mvchip->membase +
>> > +                                 GPIO_EDGE_MASK_MV78200_OFF(i));
>> > +                   mvchip->level_mask_regs[i] =
>> > +                           readl(mvchip->membase +
>> > +                                 GPIO_LEVEL_MASK_MV78200_OFF(i));
>> > +           }
>> > +           break;
>> > +   case MVEBU_GPIO_SOC_VARIANT_ARMADAXP:
>> > +           for (i = 0; i < 4; i++) {
>> > +                   mvchip->edge_mask_regs[i] =
>> > +                           readl(mvchip->membase +
>> > +                                 GPIO_EDGE_MASK_ARMADAXP_OFF(i));
>> > +                   mvchip->level_mask_regs[i] =
>> > +                           readl(mvchip->membase +
>> > +                                 GPIO_LEVEL_MASK_ARMADAXP_OFF(i));
>> > +           }
>> > +           break;
>> > +   default:
>> > +           BUG();
>>
>> Isn't it too severe? Is the platform going too unstable if driver
>> reaches this case?
>> I'd consider a WARN() instead.
>
> This is a common pattern in this driver. So i guess Thomas just
> cut/pasted the switch statement from _probe(), which also has the
> BUG().
>
> Given that _probe() should of thrown a BUG() in this situation, if it
> happens here, it means mvchip->soc_variant has been corrupted, and so
> bad things are happening. So a BUG() is maybe called for?

I agree that BUG() is adequate here. probe() should recognize the
exact same set of chips - if we reach this point this means that
either the data has been corrupted or we added support for a new chip
in probe() and forgot suspend/resume. In both cases the driver should
express its discontent.

Acked-by: Alexandre Courbot <acourbot@nvidia.com>
