From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 25 Jul 2017 10:12:02 +0100
Subject: [PATCH v2] mfd: mc13xxx: Set the irq type.
In-Reply-To: <CAM=E1R4SajN07gAW8tu4TREFssH0dLTuip3Ez3XfWXT0i0Sx_w@mail.gmail.com>
References: <1483112613-18092-1-git-send-email-lilja.magnus@gmail.com>
 <20170104110959.GZ27589@dell>
 <CAM=E1R59oKhT3b8=nJ3Utg4cPi0Z6oiLkj8DU7grg6T+2CoMAw@mail.gmail.com>
 <20170105075159.GH24225@dell>
 <CAM=E1R4SajN07gAW8tu4TREFssH0dLTuip3Ez3XfWXT0i0Sx_w@mail.gmail.com>
Message-ID: <20170725091202.r4mvyxx76ir5dyqp@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 21 Jul 2017, Magnus Lilja wrote:

> Lee, Thomas,
> 
> I don't think I saw an answer from Thomas in this matter.
> 
> ( http://lists.infradead.org/pipermail/linux-arm-kernel/2017-January/476699.html
> )

No, me either.

Hopefully he will reply now.

> On 5 January 2017 at 08:51, Lee Jones <lee.jones@linaro.org> wrote:
> > Thomas,
> >
> > On Wed, 04 Jan 2017, Magnus Lilja wrote:
> >> On 4 January 2017 at 12:09, Lee Jones <lee.jones@linaro.org> wrote:
> >> > On Fri, 30 Dec 2016, Magnus Lilja wrote:
> >> >
> >> >> Commit 10f9edaeaa30 ("mfd: mc13xxx: Use regmap irq framework for
> >> >> interrupts") removed the passing of the IRQF_TRIGGER_HIGH flag when
> >> >> registering the interrupt.
> >> >> This commit fixes that problem by setting the IRQF_TRIGGER_HIGH flag in
> >> >> case no irq type is set via irqd framework (e.g. device tree). In the
> >> >> latter case the irq flag from irqd is used.
> >> >
> >> > This looks like a hack.
> >> >
> >> > Why can't you set the trigger type in Device Tree instead?
> >>
> >> The i.MX31 PDK board has not, like many (all?) i.MX31 boards, not been
> >> converted to use device tree yet. I think there is work in progress in
> >> this area. However, as the IRQF_TRIGGER problem also affects several
> >> stable kernel series (since 3.18.x) I thought it was worthwhile to fix
> >> this.
> >
> > I would like Thomas' advice on this.
> >
> >> >> Tested on i.MX31 PDK hardware.
> >> >>
> >> >> Fixes: 10f9edaeaa30 ("mfd: mc13xxx: Use regmap irq framework for interrupts")
> >> >> Cc: <stable@vger.kernel.org> # 3.18.x
> >> >> Cc: Lee Jones <lee.jones@linaro.org>
> >> >> Signed-off-by: Magnus Lilja <lilja.magnus@gmail.com>
> >> >> ---
> >> >> Changes from v1 (which was part of a patch series):
> >> >>   - Now uses irqd_-functions to check if irq type is defined
> >> >>   - Added Fixes: and Cc: to stable kernel.
> >> >>
> >> >>  drivers/mfd/mc13xxx-core.c | 8 +++++++-
> >> >>  1 file changed, 7 insertions(+), 1 deletion(-)
> >> >>
> >> >> diff --git a/drivers/mfd/mc13xxx-core.c b/drivers/mfd/mc13xxx-core.c
> >> >> index d7f54e4..e1757ea 100644
> >> >> --- a/drivers/mfd/mc13xxx-core.c
> >> >> +++ b/drivers/mfd/mc13xxx-core.c
> >> >> @@ -15,6 +15,7 @@
> >> >>  #include <linux/of_device.h>
> >> >>  #include <linux/platform_device.h>
> >> >>  #include <linux/mfd/core.h>
> >> >> +#include <linux/irq.h>
> >> >>
> >> >>  #include "mc13xxx.h"
> >> >>
> >> >> @@ -410,6 +411,7 @@ int mc13xxx_common_init(struct device *dev)
> >> >>       struct mc13xxx *mc13xxx = dev_get_drvdata(dev);
> >> >>       u32 revision;
> >> >>       int i, ret;
> >> >> +     unsigned int flags;
> >> >>
> >> >>       mc13xxx->dev = dev;
> >> >>
> >> >> @@ -440,7 +442,11 @@ int mc13xxx_common_init(struct device *dev)
> >> >>       mc13xxx->irq_chip.irqs = mc13xxx->irqs;
> >> >>       mc13xxx->irq_chip.num_irqs = ARRAY_SIZE(mc13xxx->irqs);
> >> >>
> >> >> -     ret = regmap_add_irq_chip(mc13xxx->regmap, mc13xxx->irq, IRQF_ONESHOT,
> >> >> +     flags = irqd_get_trigger_type(irq_get_irq_data(mc13xxx->irq));
> >> >> +     flags = (flags == IRQ_TYPE_NONE) ? IRQF_TRIGGER_HIGH : flags;
> >> >> +
> >> >> +     ret = regmap_add_irq_chip(mc13xxx->regmap, mc13xxx->irq,
> >> >> +                               IRQF_ONESHOT | flags,
> >> >>                                 0, &mc13xxx->irq_chip, &mc13xxx->irq_data);
> >> >>       if (ret)
> >> >>               return ret;
> >> >
> >

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
