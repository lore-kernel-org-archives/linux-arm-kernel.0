From: dianders@chromium.org (Doug Anderson)
Date: Thu, 19 Jun 2014 15:43:48 -0700
Subject: [PATCH] i2c: exynos5: Properly use the "noirq" variants of
 suspend/resume
In-Reply-To: <7h8uosyc3k.fsf@paris.lan>
References: <1403155273-1057-1-git-send-email-dianders@chromium.org>
 <7h8uosyc3k.fsf@paris.lan>
Message-ID: <CAD=FV=XxNVmF+N5HF4SnZoJRJvkSUkpEx6ct4v2gtmAQ9n28-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kevin,

On Thu, Jun 19, 2014 at 11:43 AM, Kevin Hilman <khilman@linaro.org> wrote:
> Doug Anderson <dianders@chromium.org> writes:
>
>> The original code for the exynos i2c controller registered for the
>> "noirq" variants.  However during review feedback it was moved to
>> SIMPLE_DEV_PM_OPS without anyone noticing that it meant we were no
>> longer actually "noirq" (despite functions named
>> exynos5_i2c_suspend_noirq and exynos5_i2c_resume_noirq).
>>
>> i2c controllers that might have wakeup sources on them seem to need to
>> resume at noirq time so that the individual drivers can actually read
>> the i2c bus to handle their wakeup.
>
> I suspect usage of the noirq variants pre-dates the existence of the
> late/early callbacks in the PM core, but based on the description above,
> I suspect what you actually want is the late/early callbacks.

I think it actually really needs noirq.  ;)

Specifically as soon as IRQs are enabled one of our children might get
an interrupt.  To respond to that interrupt it might want to do an i2c
transfer.

Here's a snippet from me moving it to "resume early".  You can see
that max77686 failed pretty much right away (the dummy is just the
max77686 RTC for various reasons).  Note that the max77686 isn't doing
anything tricky.  It uses regmap_irq (as per Javier's patches) and
calls enable_irq_wake() at suspend time.  It uses a simple threaded
IRQ:

[  117.968055] PM: noirq resume of devices complete after 1.391 msecs
[  117.968200] max77686 0-0009: Failed to read IRQ status: -5
[  117.968697] dummy 0-0006: Failed to read IRQ status: -5
[  117.968793] calling  12c60000.i2c+ @ 5891, parent: none
[  117.968805] s3c-i2c 12c60000.i2c: slave address 0x00
[  117.968814] s3c-i2c 12c60000.i2c: bus frequency set to 378 KHz
[  117.968824] call 12c60000.i2c+ returned 0 after 23 usecs
[  117.968831] calling  12c70000.i2c+ @ 5891, parent: none
[  117.968841] s3c-i2c 12c70000.i2c: slave address 0x00
[  117.968849] s3c-i2c 12c70000.i2c: bus frequency set to 378 KHz
[  117.968858] call 12c70000.i2c+ returned 0 after 20 usecs
[  117.968864] calling  12c80000.i2c+ @ 5891, parent: none
[  117.968874] s3c-i2c 12c80000.i2c: slave address 0x00
[  117.968882] s3c-i2c 12c80000.i2c: bus frequency set to 65 KHz
[  117.968891] call 12c80000.i2c+ returned 0 after 20 usecs
[  117.968897] calling  12c90000.i2c+ @ 5891, parent: none
[  117.968907] s3c-i2c 12c90000.i2c: slave address 0x00
[  117.968915] s3c-i2c 12c90000.i2c: bus frequency set to 65 KHz
[  117.968923] call 12c90000.i2c+ returned 0 after 19 usecs
[  117.968930] calling  12ca0000.i2c+ @ 5891, parent: none
[  117.968940] s3c-i2c 12ca0000.i2c: slave address 0x00
[  117.968948] s3c-i2c 12ca0000.i2c: bus frequency set to 65 KHz
[  117.968957] call 12ca0000.i2c+ returned 0 after 20 usecs
[  117.968964] calling  12cb0000.i2c+ @ 5891, parent: none
[  117.968974] s3c-i2c 12cb0000.i2c: slave address 0x00
[  117.968982] s3c-i2c 12cb0000.i2c: bus frequency set to 65 KHz
[  117.968990] call 12cb0000.i2c+ returned 0 after 20 usecs
[  117.968997] calling  12cd0000.i2c+ @ 5891, parent: none
[  117.969006] s3c-i2c 12cd0000.i2c: slave address 0x00
[  117.969014] s3c-i2c 12cd0000.i2c: bus frequency set to 65 KHz
[  117.969022] call 12cd0000.i2c+ returned 0 after 19 usecs
[  117.969029] calling  12ce0000.i2c+ @ 5891, parent: none
[  117.969039] s3c-i2c 12ce0000.i2c: slave address 0x00
[  117.969048] s3c-i2c 12ce0000.i2c: bus frequency set to 378 KHz
[  117.969056] call 12ce0000.i2c+ returned 0 after 20 usecs
[  117.969625] PM: early resume of devices complete after 1.469 msecs
