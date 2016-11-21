From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Mon, 21 Nov 2016 08:59:06 +0000
Subject: [PATCH v2] ARM: Drop fixed 200 Hz timer requirement from Samsung
 platforms
In-Reply-To: <CA+Ln22GyRwywcxdO4Gp67d8TfpjfNzaE0z25=WW9GWibjGkDuQ@mail.gmail.com>
References: <1479453418-25314-1-git-send-email-krzk@kernel.org>
 <22757093.ejshJp9T7L@wuerfel>
 <CA+Ln22GyRwywcxdO4Gp67d8TfpjfNzaE0z25=WW9GWibjGkDuQ@mail.gmail.com>
Message-ID: <d67d8100-c8bf-d353-2225-e3b869a1c90d@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/11/16 06:01, Tomasz Figa wrote:
> 2016-11-18 17:46 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
>> Maybe add a paragraph about the specific problem:
>>
>> "On s3c24xx, the PWM counter is only 16 bit wide, and with the
>> typical 12MHz input clock that overflows every 5.5ms. This works
>> with HZ=200 or higher but not with HZ=100 which needs a 10ms
>> interval between ticks. On Later chips (S3C64xx, S5P and EXYNOS),
>> the counter is 32 bits and does not have this problem.
>> The new samsung_pwm_timer driver solves the problem by scaling
>> the input clock by a factor of 50 on s3c24xx, which makes it
>> less accurate but allows HZ=100 as well as CONFIG_NO_HZ with
>> fewer wakeups".
>
> One thing to correct here is that the typical clock is PCLK, which is
> derived from one of the PLLs and AFAIR is between 33-66 MHz on
> s3c24xx. Technically you can drive the PWM block from an external
> clock (12 MHz for some board-file based boards), but for simplicity
> this functionality was omitted in the new PWM timer driver used for DT
> boards (which worked fine with the PWM driven by PCLK).

Given it was a clock mux option, that would not have been difficult to
acheive. However these platforms are now so old people don't care, I
think all my pre-armv7 stuff is now in a box.

The use of the 12MHz input was to give something to run PWM timers from
that wasn't interrupted by cpu frequency scaling as PCLK generally is
half HCLK which is divided down from the core CPU clock.

(Later devices had multiple PLL sources so you didn't have to have the
  CPU fed from the same clock as the peripherals)

> Also I'm wondering if the divisor we use right now for 16-bit timers
> isn't too small, since it gives us a really short wraparound time,
> which means getting more timer interrupts for longer intervals, kind
> of defeating the benefit of tickless mode. However, AFAICT it doesn't
> affect the HZ problem.

The original implementation was to go for the best accuracy from the
timer at the expense of 200 irqs per second instead of the usual 100.



> Best regards.
> Tomasz
>


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
