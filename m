From: khilman@ti.com (Kevin Hilman)
Date: Tue, 03 May 2011 09:27:36 -0700
Subject: [PATCH 02/15] OMAP: GPIO: remove MPUIO handling from
	_clear_gpio_irqbank()
In-Reply-To: <BANLkTinmf5EWwbWrYJHz=Z19v1EkG-MPvg@mail.gmail.com> (Charulatha
	Varadarajan's message of "Mon, 25 Apr 2011 19:18:49 +0530")
References: <1303513327-14532-1-git-send-email-khilman@ti.com>
	<1303513327-14532-3-git-send-email-khilman@ti.com>
	<BANLkTinmf5EWwbWrYJHz=Z19v1EkG-MPvg@mail.gmail.com>
Message-ID: <87hb9bg35z.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Varadarajan, Charulatha" <charu@ti.com> writes:

> Kevin,
>
> On Sat, Apr 23, 2011 at 04:31, Kevin Hilman <khilman@ti.com> wrote:
>> Remove the OMAP1 #ifdef and MPUIO special case for _clear_gpio_irqbank()
>>
>> The MPUIOs do not need a register access to ack/clear the IRQ status,
>> since reading the IRQ status clears it. ?In addition, the MPUIO
>> irq_chip has an empty ack method, so _clear_gpio_irqbank() is never
>> used for MPUIOs.
>>
>> Signed-off-by: Kevin Hilman <khilman@ti.com>
>> ---
>> ?arch/arm/plat-omap/gpio.c | ? ?6 ------
>> ?1 files changed, 0 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
>> index fe6971a..8b5ca6e 100644
>> --- a/arch/arm/plat-omap/gpio.c
>> +++ b/arch/arm/plat-omap/gpio.c
>> @@ -770,12 +770,6 @@ static void _clear_gpio_irqbank(struct gpio_bank *bank, int gpio_mask)
>> ? ? ? ?void __iomem *reg = bank->base;
>>
>> ? ? ? ?switch (bank->method) {
>> -#ifdef CONFIG_ARCH_OMAP1
>> - ? ? ? case METHOD_MPUIO:
>> - ? ? ? ? ? ? ? /* MPUIO irqstatus is reset by reading the status register,
>> - ? ? ? ? ? ? ? ?* so do nothing here */
>> - ? ? ? ? ? ? ? return;
>> -#endif
>
> The default case has a "WARN_ON(1)". I guess WARN_ON()
> is not required for METHOD_MPUIO.

As stated in the changelog, this function is never called for MPUIO
banks, so the warning should not be hit.

Kevin
