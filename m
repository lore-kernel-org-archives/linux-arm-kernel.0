From: kaloz@openwrt.org (Imre Kaloz)
Date: Wed, 18 Nov 2009 00:05:21 +0100
Subject: IXP4xx: unneeded #include platform-specific include files?
In-Reply-To: <m3ocn04vma.fsf@intrepid.localdomain>
References: <m3fx8fso72.fsf@intrepid.localdomain>
	<19200.18453.644399.845601@pilspetsen.it.uu.se>
	<op.u3gddjdi2s3iss@ecaz>
	<m3y6m7qylr.fsf@intrepid.localdomain> <op.u3j6cak02s3iss@richese>
	<m3ws1o4y3h.fsf@intrepid.localdomain> <op.u3j7xuh92s3iss@richese>
	<m3skcc4wrm.fsf@intrepid.localdomain> <op.u3j8zxsd2s3iss@richese>
	<m3ocn04vma.fsf@intrepid.localdomain>
Message-ID: <op.u3kae7qg2s3iss@richese>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2009.11.17. 23:47:09 Krzysztof Halasa <khc@pm.waw.pl> wrote:

> "Imre Kaloz" <kaloz@openwrt.org> writes:
>
>> Yeah, you get rid of the external .h files for dropping all that bloat
>> into the setup
>> files. Honestly, do however you please, but this hardly makes sense
>> IMHO when you have
>> the chance to get rid of all this mess.
>
> What I'm thinking about is (cut & paste):
>
> --- a/arch/arm/mach-ixp4xx/avila-pci.c
> +++ b/arch/arm/mach-ixp4xx/avila-pci.c
> @@ -27,49 +27,40 @@
>  #include <mach/hardware.h>
>  #include <asm/mach-types.h>
>-#define AVILA_PCI_MAX_DEV      4
> -#define LOFT_PCI_MAX_DEV       6
> -#define AVILA_PCI_IRQ_LINES    4
> +#define AVILA_MAX_DEV  4
> +#define LOFT_MAX_DEV   6
> +#define IRQ_LINES      4
> /* PCI controller GPIO to IRQ pin mappings */
> -#define AVILA_PCI_INTA_PIN     11
> -#define AVILA_PCI_INTB_PIN     10
> -#define AVILA_PCI_INTC_PIN     9
> -#define AVILA_PCI_INTD_PIN     8
> -
> -#define IRQ_AVILA_PCI_INTA     IRQ_IXP4XX_GPIO11
> -#define IRQ_AVILA_PCI_INTB     IRQ_IXP4XX_GPIO10
> -#define IRQ_AVILA_PCI_INTC     IRQ_IXP4XX_GPIO9
> -#define IRQ_AVILA_PCI_INTD     IRQ_IXP4XX_GPIO8
> +#define INTA           11
> +#define INTB           10
> +#define INTC           9
> +#define INTD           8
>
> You can see the duplicate definitions removed.
> BTW: I don't like it much, but using ordinary GPIOx certainly
> isn't better.
>
> (Yep, I see at least one bug which the patches should fix, will do).
>
>  void __init avila_pci_preinit(void)
>  {
> -       set_irq_type(IRQ_AVILA_PCI_INTA, IRQ_TYPE_LEVEL_LOW);
> -       set_irq_type(IRQ_AVILA_PCI_INTB, IRQ_TYPE_LEVEL_LOW);
> -       set_irq_type(IRQ_AVILA_PCI_INTC, IRQ_TYPE_LEVEL_LOW);
> -       set_irq_type(IRQ_AVILA_PCI_INTD, IRQ_TYPE_LEVEL_LOW);
> -
> +       set_irq_type(IXP4XX_GPIO_IRQ(INTA), IRQ_TYPE_LEVEL_LOW);
> +       set_irq_type(IXP4XX_GPIO_IRQ(INTB), IRQ_TYPE_LEVEL_LOW);
> +       set_irq_type(IXP4XX_GPIO_IRQ(INTC), IRQ_TYPE_LEVEL_LOW);
> +       set_irq_type(IXP4XX_GPIO_IRQ(INTD), IRQ_TYPE_LEVEL_LOW);
>         ixp4xx_pci_preinit();
>  }


This is far more tolerable, but SLOT1-3 would be better. Also, the
_MAX thingie should be dropped, for example the LOFT is nothing more
then an avila with an USB2 controller on the same IRQ as slot 3, where
the USB1.1 subdevices will show up as well. Those subdevices won't show
up on a board without the USB controller, but all this will blow up when
someone plugs a miniPCI USB controller into one of the slots, not to
mention if he/she plugs in more ;)

Now the best question: do those PCI subdevices need an IRQ? If there is only
one IRQ connected to a PCI slot (probably), does it make sense to assign
IRQs/GPIOs without any effect?


Imre
