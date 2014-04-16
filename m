From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Wed, 16 Apr 2014 19:23:49 +0900
Subject: [PATCHv2 8/8] ARM: dts: Add device tree sources for Exynos3250
In-Reply-To: <534E4089.9070804@arm.com>
References: <1397527192-21988-1-git-send-email-cw00.choi@samsung.com>
 <1397527192-21988-9-git-send-email-cw00.choi@samsung.com>
 <534CEAB7.6020600@arm.com> <534CED76.9010302@samsung.com>
 <534CF847.5040008@arm.com> <534CF9B4.306@samsung.com>
 <534CFAD7.4030508@arm.com> <534E3DC0.40502@samsung.com>
 <534E4089.9070804@arm.com>
Message-ID: <534E5A35.7050708@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On 04/16/2014 05:34 PM, Marc Zyngier wrote:
> On 16/04/14 09:22, Chanwoo Choi wrote:
>> Hi Marc,
>>
>> On 04/15/2014 06:24 PM, Marc Zyngier wrote:
>>> On 15/04/14 10:19, Chanwoo Choi wrote:
>>>> On 04/15/2014 06:13 PM, Marc Zyngier wrote:
>>>>> On 15/04/14 09:27, Chanwoo Choi wrote:
>>>>>> Hi,
>>>>>>
>>>>>> On 04/15/2014 05:15 PM, Marc Zyngier wrote:
>>>>>>> On 15/04/14 02:59, Chanwoo Choi wrote:
>>>>>>>> From: Tomasz Figa <t.figa@samsung.com>
>>>>>>>>
>>>>>>>> This patch add new exynos3250.dtsi to support Exynos3250 SoC based on Cortex-A7
>>>>>>>> dual core and includes following dt nodes:
>>>>>>>>
>>>>>>>> - GIC interrupt controller
>>>>>>>> - Pinctrl to control GPIOs
>>>>>>>> - Clock controller
>>>>>>>> - CPU information (Cortex-A7 dual core)
>>>>>>>> - UART to support serial port
>>>>>>>> - MCT (Multi Core Timer)
>>>>>>>> - ADC (Analog Digital Converter)
>>>>>>>> - I2C/SPI bus
>>>>>>>> - Power domain
>>>>>>>> - PMU (Performance Monitoring Unit)
>>>>>>>> - MSHC (Mobile Storage Host Controller)
>>>>>>>> - PWM (Pluse Width Modulation)
>>>>>>>> - AMBA bus
>>>>>>>
>>>>>>> [...]
>>>>>>>
>>>>>>> Where is the arch timer node?
>>>>>>
>>>>>> Exynos3250 uses MCT (Multi Core Timer) instead of ARM_ARCH_TIMER.
>>>>>> - in drivers/clocksource/exynos_mct.c
>>>>>
>>>>> Don't you have a Cortex-A7? If so, you have the arch timer.
>>>>
>>>> Do you means that 'arch timer" is ARM_ARCH_TIMER?
>>>
>>> Yes.
>>>
>>>> As I knew, ARM_ARCH_TIMER is clocksource driver for system timer.
>>>> But, Exynos SoC used MCT clocksource for system timer.
>>>>
>>>> Exynos dts file didn't include arch timer node but only include mct node.
>>>
>>> Well, it is a bug, and a recurrent one. A Cortex-A7 has the arch timers
>>> implemented. Always.
>>>
>>> http://infocenter.arm.com/help/topic/com.arm.doc.ddi0464f/BABFEBJJ.html
>>>
>>> All Cortex-A7 have it, and so do A12, A15, A17, A53, A57.
>>
>> I tested 'arch_timer'(drivers/clocksource/arm_arch_timer.c) on Exynos3250 based on Cortex-A7.
>>
>> To test arch timer, I used the clocksource of arch_timer for timekeeping instead of clocksource
>> of Exynos MCT. But, I faced with issue. The following function return only same value(zero)
>> as following kernel log:
>> - arch_counter_get_cntvct() in arch/arm/include/asm/arch_timer.h
>>
>> Uncompressing Linux... done, booting the kernel.
>> [    0.000000] Booting Linux on physical CPU 0x0
>> [    0.000000] Initializing cgroup subsys cpuset
>> [    0.000000] Initializing cgroup subsys cpu
>> [    0.000000] Initializing cgroup subsys cpuacct
>> [    0.000000] Linux version 3.15.0-rc1-00020-gf452826-dirty ...
>> [    0.000000] CPU: ARMv7 Processor ...
>> ...
>> [    0.000000] Architected cp15 timer(s) running at 24.00MHz (virt).
>> [    0.000000] sched_clock: 56 bits at 24MHz, resolution 41ns, wraps every 2863311519744ns
>> ...
>>
>> Could you give me a solution to resolve this issue or a expected cause?
> 
> My guess is that you need to enable some clock for the timer to tick.
> Ask your HW guys how they have wired this clock.
> 
> Also, I cannot help but notice that you are entering your kernel at SVC
> instead of HYP. I suggest you fix your bootloader/firmware to allow all
> CPUs to enter the kernel in HYP.

I think again that I would like to add arch_timer dt node to exynos3250.dtsi
as separated patchset after finishing the test arch_timer clocksource for timekeeping.

Thanks for your review.

Best Regards,
Chanwoo Choi
