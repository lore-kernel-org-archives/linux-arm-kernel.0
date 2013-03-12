From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Tue, 12 Mar 2013 16:36:57 +0530
Subject: PL330 interrupt handling
In-Reply-To: <CAOcd1mrL219kP-SLcjxQ2x79A-LvwxXjesv3G9Y=R+w5=Rjtsw@mail.gmail.com>
References: <CAOcd1mrL219kP-SLcjxQ2x79A-LvwxXjesv3G9Y=R+w5=Rjtsw@mail.gmail.com>
Message-ID: <CABb+yY1EqszSFhnbWve2yEpmcgMdofM5uFJSCe1b4he0-LnGQA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 11, 2013 at 5:05 PM, Naveen Mamindlapalli
<naveen.mamindlapalli@gmail.com> wrote:
> Hi All,
>
> I am referring to drivers/dma/pl330.c. I found that the driver uses a single
> interrupt source. As per the CoreLink DMA-330 controller technical reference
> manual, the number of interrupts can be configurable & also there is an
> irq_abort interrupt output. I see that the IRQ handler (pl330_irq_handler)
> handles abort event also.
>
> My question is: What was the assumption that this driver treats the
> interrupts and abort interrupt as a single interrupt source? Is there any
> specific hardware implementation change was done which is different from
> TRM?
>
> We are using a PL330 configuration of 8 interrupts and 1 abort interrupt.
> How to handle this in the driver? I have modified the driver code as below.
> Is this correct?
>
> +       for (i = 0; i < 9; i++) {
> +               irq = adev->irq[i];
> +               ret = request_irq(irq, pl330_irq_handler, IRQF_SHARED,
> +                               dev_name(&adev->dev), pi);
> +               if (ret)
> +                       goto probe_err3;
> +               else
> +                       num_irqs++;
> +       }
>
The interrupt handler already discerns relevant IRQ/Event from the ES
register. I guess all implementations of PL330 have all IRQ lines
bound together, so the code has been working.
If your interrupt controller is fed 1 line for each of the 8 IRQs from
PL330, you'll need to change the code as above (in which case I would
like to know the envisaged benefit of such a h/w design).
