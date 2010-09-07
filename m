From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 7 Sep 2010 11:54:06 +0800
Subject: [PATCH] pio: add arch specific gpio_is_valid() function
In-Reply-To: <4C85A71F.3010402@bluewatersys.com>
References: <280328.53116.qm@web180311.mail.gq1.yahoo.com>
	<4C85A71F.3010402@bluewatersys.com>
Message-ID: <AANLkTi=B7O9jDB_pzHS6feWTxHQTfDZ-QLx7jOKaA2vN@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 7, 2010 at 10:44 AM, Ryan Mallon <ryan@bluewatersys.com> wrote:
> On 09/07/2010 02:23 PM, David Brownell wrote:
>> Still not liking or accepting this proposed
>> change to the GPIO framework.
>>
>> For the AT91 case (where integers 0..N are
>> IRQs, but N..max are GPIOs)
>>
>> A simpler solution is just to use a bit in
>> the integer to indicate IRQ vs GPIO. ?Like
>> maybe the sign bit.. which is never set on
>> valid GPIO numbers, but platforms could let
>> be set on IRQs.
>>
> How about this approach instead?
>

This doesn't solve the problem with more complicated settings, e.g.
some GPIOs within are not valid, not just the begining ones.

So the real question here is the semantics of gpio_is_valid(). I'd
personally incline it reads as if a GPIO _number_ is valid generally,
(e.g. like -1 is not a valid GPIO number), instead of that specific
GPIO is valid on that specific platform. The latter can be judged
with gpio_request().

> ----
> On some architectures gpio numbering does not start from zero. Allow for
> correct behaviour of gpio_is_valid on values below the first gpio by
> adding the architecture overrideable ARCH_FIRST_GPIO.
>
> Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
> ----
>
> diff --git a/include/asm-generic/gpio.h b/include/asm-generic/gpio.h
> index c7376bf..01aab1f 100644
> --- a/include/asm-generic/gpio.h
> +++ b/include/asm-generic/gpio.h
> @@ -22,10 +22,15 @@
> ?#define ARCH_NR_GPIOS ? ? ? ? ?256
> ?#endif
>
> +#ifndef ARCH_FIRST_GPIO
> +#define ARCH_FIRST_GPIO ? ? ? ? ? ? ? ?0
> +#endif
> +
> ?static inline int gpio_is_valid(int number)
> ?{
> ? ? ? ?/* only some non-negative numbers are valid */
> - ? ? ? return ((unsigned)number) < ARCH_NR_GPIOS;
> + ? ? ? return (number >= ARCH_FIRST_GPIO &&
> + ? ? ? ? ? ? ? (unsigned)number < ARCH_NR_GPIOS;
> ?}
>
> ?struct device;
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
