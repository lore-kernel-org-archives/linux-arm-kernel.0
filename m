From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 29 Oct 2014 11:17:59 +0000
Subject: [PATCH 1/3] genirq: Allow the irqchip state of an IRQ to be
 save/restored
In-Reply-To: <CACRpkdZjUPV1eWcJjT587kxJm2zyC+OEYD0Deid4wYPh8A-Z4w@mail.gmail.com>
References: <1414232097-4328-1-git-send-email-marc.zyngier@arm.com>
 <1414232097-4328-2-git-send-email-marc.zyngier@arm.com>
 <CACRpkdZjUPV1eWcJjT587kxJm2zyC+OEYD0Deid4wYPh8A-Z4w@mail.gmail.com>
Message-ID: <5450CCE7.7010803@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/10/14 10:12, Linus Walleij wrote:
> On Sat, Oct 25, 2014 at 12:14 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> 
>> There is a number of cases where a kernel subsystem may want to
>> introspect the state of an interrupt at the irqchip level:
>>
>> - When a peripheral is shared between virtual machines, its interrupt
>>   state becomes part of the guest's state, and must be switched accordingly.
>>   KVM on arm/arm64 requires this for its guest-visible timer
>> - Some GPIO controllers seem to require peeking into the interrupt controller
>>   they are connected to to report their internal state
> 
> I'd like to know exactly what this means, for GPIO. As mentioned in
> conversation with Arnd, there is since before the case where a GPIO
> irqchip gets its irqs "stolen" by some other hardware that is in the
> always-on domain, and I call these "latent irqs".

It looks like a slightly different issue:
http://patchwork.ozlabs.org/patch/397657/

Basically, the GPIO chip cannot report its own state, and has to
introspect the parent irqchip to find out.

> There is a third usecase here since ages (pre-git) in
> arch/arm/mach-integrator/integrator_cp.c:
> 
> /*
>  * It seems that the card insertion interrupt remains active after
>  * we've acknowledged it.  We therefore ignore the interrupt, and
>  * rely on reading it from the SIC.  This also means that we must
>  * clear the latched interrupt.
>  */
> static unsigned int mmc_status(struct device *dev)
> {
>         unsigned int status = readl(__io_address(0xca000000 + 4));
>         writel(8, intcp_con_base + 8);
> 
>         return status & 8;
> }
> 
> static struct mmci_platform_data mmc_data = {
>         .ocr_mask       = MMC_VDD_32_33|MMC_VDD_33_34,
>         .status         = mmc_status,
>         .gpio_wp        = -1,
>         .gpio_cd        = -1,
> };
> 
> This just goes in and peeks around in the Integrator SIC, this
> patch would solve also this I think. Or are the added calls good
> for clearing the latched IRQ too?

Pretty funky. You could also use this to clear the pending bit (assuming
there is one on the CP). I'm amazed at the number of similar hacks that
are coming out of the wood now...

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
