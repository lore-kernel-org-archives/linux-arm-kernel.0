From: dhdang@apm.com (Duc Dang)
Date: Fri, 9 Oct 2015 15:21:42 -0700
Subject: arm/arm64: GICv2 driver does not have irq_disable implemented
In-Reply-To: <alpine.DEB.2.11.1510092348370.6097@nanos>
References: <CADaLND=spbEHLZXmqsVRDsPAyNKXJHnc=Yy6ujY0em74dB5CbA@mail.gmail.com>
 <alpine.DEB.2.11.1510091951250.6097@nanos>
 <CADaLNDmgWnOAugY20nXWz_-2m-KPKnARMWeYMDTuPdRe8SA8sQ@mail.gmail.com>
 <alpine.DEB.2.11.1510092348370.6097@nanos>
Message-ID: <CADaLNDnoGnzUSDrXMBujVRkMybJNHXY3_j9-YXsCZHJJRZMG3w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 9, 2015 at 2:52 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Fri, 9 Oct 2015, Duc Dang wrote:
>> On Fri, Oct 9, 2015 at 10:52 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>> > On Fri, 9 Oct 2015, Duc Dang wrote:
>> >> In APM ARM64 X-Gene Enet controller driver, we use disable_irq_nosync to
>> >> disable interrupt before calling __napi_schedule to schedule packet handler
>> >> to process the Tx/Rx packets.
>> >
>> > Which is wrong to begin with. Disable the interrupt at the device
>> > level not at the interrupt line level.
>> >
>> We could not disable the interrupt at Enet controller level due to the
>> controller limitation. As you said, using  disable_irq_nosync is wrong
>> but it looks like that the only option that we have.
>
> Oh well.
>
>> Do you have any suggestion about different approach that we could try?
>
> Try the patch below and add
>
>     irq_set_status_flags(irq, IRQ_DISABLE_UNLAZY);
>
> to your driver before requesting the interrupt. Unset it when freeing
> the interrupt.

Thanks, Thomas!

We will try and let you know soon.

>
> Thanks,
>
>         tglx
>
> 8<--------------
>
> Subject: genirq: Add flag to force mask in disable_irq[_nosync]()
> From: Thomas Gleixner <tglx@linutronix.de>
> Date: Fri, 09 Oct 2015 23:28:58 +0200
>
> If an irq chip does not implement the irq_disable callback, then we
> use a lazy approach for disabling the interrupt. That means that the
> interrupt is marked disabled, but the interrupt line is not
> immediately masked in the interrupt chip. It only becomes masked if
> the interrupt is raised while it's marked disabled. We use this to avoid
> possibly expensive mask/unmask operations for common case operations.
>
> Unfortunately there are devices which do not allow the interrupt to be
> disabled easily at the device level. They are forced to use
> disable_irq_nosync(). This can result in taking each interrupt twice.
>
> Instead of enforcing the non lazy mode on all interrupts of a irq
> chip, provide a settings flag, which can be set by the driver for that
> particular interrupt line.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  include/linux/irq.h   |    4 +++-
>  kernel/irq/chip.c     |    9 +++++++++
>  kernel/irq/settings.h |    7 +++++++
>  3 files changed, 19 insertions(+), 1 deletion(-)
>
> Index: tip/include/linux/irq.h
> ===================================================================
> --- tip.orig/include/linux/irq.h
> +++ tip/include/linux/irq.h
> @@ -72,6 +72,7 @@ enum irqchip_irq_state;
>   * IRQ_IS_POLLED               - Always polled by another interrupt. Exclude
>   *                               it from the spurious interrupt detection
>   *                               mechanism and from core side polling.
> + * IRQ_DISABLE_UNLAZY          - Disable lazy irq disable
>   */
>  enum {
>         IRQ_TYPE_NONE           = 0x00000000,
> @@ -97,13 +98,14 @@ enum {
>         IRQ_NOTHREAD            = (1 << 16),
>         IRQ_PER_CPU_DEVID       = (1 << 17),
>         IRQ_IS_POLLED           = (1 << 18),
> +       IRQ_DISABLE_UNLAZY      = (1 << 19),
>  };
>
>  #define IRQF_MODIFY_MASK       \
>         (IRQ_TYPE_SENSE_MASK | IRQ_NOPROBE | IRQ_NOREQUEST | \
>          IRQ_NOAUTOEN | IRQ_MOVE_PCNTXT | IRQ_LEVEL | IRQ_NO_BALANCING | \
>          IRQ_PER_CPU | IRQ_NESTED_THREAD | IRQ_NOTHREAD | IRQ_PER_CPU_DEVID | \
> -        IRQ_IS_POLLED)
> +        IRQ_IS_POLLED | IRQ_DISABLE_UNLAZY)
>
>  #define IRQ_NO_BALANCING_MASK  (IRQ_PER_CPU | IRQ_NO_BALANCING)
>
> Index: tip/kernel/irq/chip.c
> ===================================================================
> --- tip.orig/kernel/irq/chip.c
> +++ tip/kernel/irq/chip.c
> @@ -241,6 +241,13 @@ void irq_enable(struct irq_desc *desc)
>   * disabled. If an interrupt happens, then the interrupt flow
>   * handler masks the line at the hardware level and marks it
>   * pending.
> + *
> + * If the interrupt chip does not implement the irq_disable callback,
> + * a driver can disable the lazy approach for a particular irq line by
> + * calling 'irq_set_status_flags(irq, IRQ_DISABLE_UNLAZY)'. This can be
> + * used for devices which cannot disable the interrupt at the device
> + * level under certain circumstances and have to use
> + * disable_irq[_nosync] instead.
>   */
>  void irq_disable(struct irq_desc *desc)
>  {
> @@ -248,6 +255,8 @@ void irq_disable(struct irq_desc *desc)
>         if (desc->irq_data.chip->irq_disable) {
>                 desc->irq_data.chip->irq_disable(&desc->irq_data);
>                 irq_state_set_masked(desc);
> +       } else if (irq_settings_disable_unlazy(desc)) {
> +               mask_irq(desc);
>         }
>  }
>
> Index: tip/kernel/irq/settings.h
> ===================================================================
> --- tip.orig/kernel/irq/settings.h
> +++ tip/kernel/irq/settings.h
> @@ -15,6 +15,7 @@ enum {
>         _IRQ_NESTED_THREAD      = IRQ_NESTED_THREAD,
>         _IRQ_PER_CPU_DEVID      = IRQ_PER_CPU_DEVID,
>         _IRQ_IS_POLLED          = IRQ_IS_POLLED,
> +       _IRQ_DISABLE_UNLAZY     = IRQ_DISABLE_UNLAZY,
>         _IRQF_MODIFY_MASK       = IRQF_MODIFY_MASK,
>  };
>
> @@ -28,6 +29,7 @@ enum {
>  #define IRQ_NESTED_THREAD      GOT_YOU_MORON
>  #define IRQ_PER_CPU_DEVID      GOT_YOU_MORON
>  #define IRQ_IS_POLLED          GOT_YOU_MORON
> +#define IRQ_DISABLE_UNLAZY     GOT_YOU_MORON
>  #undef IRQF_MODIFY_MASK
>  #define IRQF_MODIFY_MASK       GOT_YOU_MORON
>
> @@ -154,3 +156,8 @@ static inline bool irq_settings_is_polle
>  {
>         return desc->status_use_accessors & _IRQ_IS_POLLED;
>  }
> +
> +static inline bool irq_settings_disable_unlazy(struct irq_desc *desc)
> +{
> +       return desc->status_use_accessors & _IRQ_DISABLE_UNLAZY;
> +}

Regards,
Duc Dang.
