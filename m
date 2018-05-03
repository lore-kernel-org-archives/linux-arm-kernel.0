From: robh@kernel.org (Rob Herring)
Date: Thu, 3 May 2018 17:06:33 -0500
Subject: [PATCH] spi: bcm2835aux: ensure interrupts are enabled for shared
 handler
In-Reply-To: <87efiso2yz.fsf@anholt.net>
References: <20180503180945.3502-1-robh@kernel.org> <87efiso2yz.fsf@anholt.net>
Message-ID: <CAL_Jsq+pf0y7+mV8o3t=Uvgo9ZbmVNB9PyS2E3BktR8BZ_ecQQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 3, 2018 at 4:15 PM, Eric Anholt <eric@anholt.net> wrote:
> Rob Herring <robh@kernel.org> writes:
>
>> The BCM2835 AUX SPI has a shared interrupt line (with AUX UART).
>> Downstream fixes this with an AUX irqchip to demux the IRQ sources and a
>> DT change which breaks compatibility with older kernels. The AUX irqchip
>> was already rejected for upstream[1] and the DT change would break
>> working systems if the DTB is updated to a newer one. The latter issue
>> was brought to my attention by Alex Graf.
>>
>> The root cause however is a bug in the shared handler. Shared handlers
>> must check that interrupts are actually enabled before servicing the
>> interrupt. Add a check that the TXEMPTY or IDLE interrupts are enabled.
>
> It looks to me like we'd only return IRQ_HANDLED if we did work that
> needed doing.  Is this check effectively doing some interlock to make
> sure that we've already started bcm2835aux_spi_transfer_one_irq() and
> aren't just racing against transaction setup?

What if you are in polled mode for the SPI and the 8250 irq (or other
SPI instance) causes the SPI irq handler to run?

The way I look at it is, this change in the irq handler was also said
to fix the problem[1]:

    u32 irq_flags = readl(bcm2835_aux_irq_reg);

    if(!(irq_flags & (1<<master->bus_num)))
    {
        return IRQ_NONE;
    }

Is checking whether the interrupt is pending in the aux reg any
different than checking for interrupt being enabled in the device? I
could have checked the status bits too, but as you say that is handled
farther down.

Rob

[1] https://github.com/raspberrypi/linux/issues/1573
