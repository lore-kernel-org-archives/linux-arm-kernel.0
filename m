From: khilman@linaro.org (Kevin Hilman)
Date: Thu, 19 Jun 2014 11:43:11 -0700
Subject: [PATCH] i2c: exynos5: Properly use the "noirq" variants of
 suspend/resume
In-Reply-To: <1403155273-1057-1-git-send-email-dianders@chromium.org> (Doug
 Anderson's message of "Wed, 18 Jun 2014 22:21:13 -0700")
References: <1403155273-1057-1-git-send-email-dianders@chromium.org>
Message-ID: <7h8uosyc3k.fsf@paris.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Doug Anderson <dianders@chromium.org> writes:

> The original code for the exynos i2c controller registered for the
> "noirq" variants.  However during review feedback it was moved to
> SIMPLE_DEV_PM_OPS without anyone noticing that it meant we were no
> longer actually "noirq" (despite functions named
> exynos5_i2c_suspend_noirq and exynos5_i2c_resume_noirq).
>
> i2c controllers that might have wakeup sources on them seem to need to
> resume at noirq time so that the individual drivers can actually read
> the i2c bus to handle their wakeup.

I suspect usage of the noirq variants pre-dates the existence of the
late/early callbacks in the PM core, but based on the description above,
I suspect what you actually want is the late/early callbacks.

Kevin
