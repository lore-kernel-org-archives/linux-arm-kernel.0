From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Fri, 7 Oct 2011 05:29:07 +0530
Subject: [PATCH 1/2] arm: samsung: move timer irq numbers to end of linux
	irq space
In-Reply-To: <CAJuYYwQh30k-7+uZk8XLUBhzRxHDu7xObC=-z70WtXe5WSJSrQ@mail.gmail.com>
References: <1317935503-11756-1-git-send-email-thomas.abraham@linaro.org>
	<1317935503-11756-2-git-send-email-thomas.abraham@linaro.org>
	<20111006221517.GC21464@n2100.arm.linux.org.uk>
	<CAJuYYwQh30k-7+uZk8XLUBhzRxHDu7xObC=-z70WtXe5WSJSrQ@mail.gmail.com>
Message-ID: <CAJuYYwQdkwjXMoPKgf7hM9p1U2KcxW+H46FBGxXm_yhYo17TTQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 October 2011 05:26, Thomas Abraham <thomas.abraham@linaro.org> wrote:
> Hi Russell,
>
> On 7 October 2011 03:45, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> On Fri, Oct 07, 2011 at 02:41:42AM +0530, Thomas Abraham wrote:
>>> All of Samsung's s5p platforms have timer irqs statically mapped from linux
>>> irq numbers 11 to 15. These timer irqs are moved to end of the statically
>>> mapped linux irq space and the hardware irqs, which were statically mapped
>>> starting from 32 is moved to start from 0. The NR_IRQS macro is consolidated
>>> for all the s5p platforms in this process.
>>
>> Am I reading this patch correctly - in that on platforms with the GIC,
>> you add 32 to the GIC IRQ number _just_ to avoid the possibility that
>> IRQs 11-15 are seen as valid?
>>
>> Or to put it another way, you're trying to ensure that if these timer
>> IRQs are requested, they will fail?
>>
>
> This patch is applicable for s5p64x0, s5pc100, s5pv210 and exynos4.
> Exynos4 has GIC and the rest use VIC.
>
> For all these platforms, the five hardware timer irqs are connected to
> GIC/VIC at some hardware irq number (in exynos it is GIC_ID 69 to 73
> for five timers). When any of these hardware interrupt occurs, its
> interrupt handler calls generic_handle_irq() with linux irq number
> 11/12/13/14/15 for timer 0/1/2/3/4 as the parameter. The code that
> needs to be notified about the timer interrupts would have already
> registered its handler for either of the interrupts 11 to 15. I am not
> sure why such remapping is used. I think it is not needed but did not
> intend to change it. All this is included in the file
> "arch/arm/plat-samsung/irq-vic-timer.c".
>
> Instead of using linux irq number 11 to 15 to which consumers of timer
> interrupt attach their handler, this interrupt range is moved to the
> end of linux irq space used. So there will be no interrupts statically
> mapped between 0 to 31.
>
> The GIC/VIC hardware interrupts, which were previously statically
> mapped to start from linux irq 32 are now moved to start from linux
> irq 0. In case of exynos, GIC_ID[0] (which is SGI[0]) which was
> previously at linux irq 32, will not be at linux irq 0.

Correcting the line above:
previously at linux irq 32, will _now_ be at linux irq 0.

>
> This was the intended change. This was required to use Rob Herring's
> GIC OF bindings patches for Exynos4.
>
> Thanks,
> Thomas.
>
