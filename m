From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 12 Apr 2011 21:47:46 +0800
Subject: [PATCH] pxa270 rtc wakeup event fix
In-Reply-To: <201104121253.38937.marek.vasut@gmail.com>
References: <4D9F3AE4.2040101@gmail.com>
	<201104082136.52297.marek.vasut@gmail.com>
	<BANLkTi=dUVins-kj2H6t6vwQKPKG8-PzQw@mail.gmail.com>
	<201104121253.38937.marek.vasut@gmail.com>
Message-ID: <BANLkTi=ZJ2utAwpnADMdLWx5SEnLqwX18g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 12, 2011 at 6:53 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
> On Tuesday 12 April 2011 09:44:17 Eric Miao wrote:
>> Hi Nick,
>>
>> Thanks for spotting this. The problem is really IRQ_TO_GPIO() macro
>> doesn't behave as assumed. A better approach would be to return -1
>> when none-GPIO IRQs are mapped back, let me know if you are OK w/
>> the patch below:
>>
>> diff --git a/arch/arm/mach-pxa/include/mach/gpio.h
>> b/arch/arm/mach-pxa/include/mach/gpio.h
>> index b024a8b..b9f4ed1 100644
>> --- a/arch/arm/mach-pxa/include/mach/gpio.h
>> +++ b/arch/arm/mach-pxa/include/mach/gpio.h
>> @@ -103,7 +103,20 @@
>>
>> ?#define gpio_to_bank(gpio) ? ((gpio) >> 5)
>> ?#define gpio_to_irq(gpio) ? ?IRQ_GPIO(gpio)
>> -#define irq_to_gpio(irq) ? ? IRQ_TO_GPIO(irq)
>> +
>> +static inline int irq_to_gpio(unsigned int irq)
>
> Maybe drop the explicit inline?

It's in a header file, and has to be declared as inline to avoid the
copy being duplicated in every .c files where this header is included.
