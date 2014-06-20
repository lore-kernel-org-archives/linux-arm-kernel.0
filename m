From: khilman@linaro.org (Kevin Hilman)
Date: Fri, 20 Jun 2014 14:48:01 -0700
Subject: [PATCH] i2c: exynos5: Properly use the "noirq" variants of
 suspend/resume
In-Reply-To: <CAD=FV=XxNVmF+N5HF4SnZoJRJvkSUkpEx6ct4v2gtmAQ9n28-Q@mail.gmail.com>
 (Doug Anderson's message of "Thu, 19 Jun 2014 15:43:48 -0700")
References: <1403155273-1057-1-git-send-email-dianders@chromium.org>
 <7h8uosyc3k.fsf@paris.lan>
 <CAD=FV=XxNVmF+N5HF4SnZoJRJvkSUkpEx6ct4v2gtmAQ9n28-Q@mail.gmail.com>
Message-ID: <7hwqcbs166.fsf@paris.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Doug,

Doug Anderson <dianders@chromium.org> writes:

> On Thu, Jun 19, 2014 at 11:43 AM, Kevin Hilman <khilman@linaro.org> wrote:
>> Doug Anderson <dianders@chromium.org> writes:
>>
>>> The original code for the exynos i2c controller registered for the
>>> "noirq" variants.  However during review feedback it was moved to
>>> SIMPLE_DEV_PM_OPS without anyone noticing that it meant we were no
>>> longer actually "noirq" (despite functions named
>>> exynos5_i2c_suspend_noirq and exynos5_i2c_resume_noirq).
>>>
>>> i2c controllers that might have wakeup sources on them seem to need to
>>> resume at noirq time so that the individual drivers can actually read
>>> the i2c bus to handle their wakeup.
>>
>> I suspect usage of the noirq variants pre-dates the existence of the
>> late/early callbacks in the PM core, but based on the description above,
>> I suspect what you actually want is the late/early callbacks.
>
> I think it actually really needs noirq.  ;)

Yes, it appears it does.   Objection withdrawn.

I just wanted to be sure because since the introduction of late/early,
the need for noirq should be pretty rare, but there certainly are needs.

<tangent> 
In this case though, the need for it has more to do with the
lack of a way for us to describe non parent-child device dependencies
than whether or not IRQs are enabled or not.
</tangent>

Kevin
