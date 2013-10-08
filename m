From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Tue, 08 Oct 2013 12:08:33 +0200
Subject: [PATCH v2] clockevents: Sanitize ticks to nsec conversion
In-Reply-To: <1380052223-24139-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <alpine.DEB.2.02.1309191629040.4089@ionos.tec.linutronix.de>
 <1380052223-24139-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <5253D9A1.1080106@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/24/2013 09:50 PM, Uwe Kleine-K?nig wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Marc Kleine-Budde pointed out, that commit 77cc982 "clocksource: use
> clockevents_config_and_register() where possible" caused a regression
> for some of the converted subarchs.
> 
> The reason is, that the clockevents core code converts the minimal
> hardware tick delta to a nanosecond value for core internal
> usage. This conversion is affected by integer math rounding loss, so
> the backwards conversion to hardware ticks will likely result in a
> value which is less than the configured hardware limitation. The
> affected subarchs used their own workaround (SIGH!) which got lost in
> the conversion.
> 
> The solution for the issue at hand is simple: adding evt->mult - 1 to
> the shifted value before the integer divison in the core conversion
> function takes care of it. But this only works for the case where for
> the scaled math mult/shift pair "mult <= 1 << shift" is true. For the
> case where "mult > 1 << shift" we can apply the rounding add only for
> the minimum delta value to make sure that the backward conversion is
> not less than the given hardware limit. For the upper bound we need to
> omit the rounding add, because the backwards conversion is always
> larger than the original latch value. That would violate the upper
> bound of the hardware device.
> 
> Though looking closer at the details of that function reveals another
> bogosity: The upper bounds check is broken as well. Checking for a
> resulting "clc" value greater than KTIME_MAX after the conversion is
> pointless. The conversion does:
> 
>       u64 clc = (latch << evt->shift) / evt->mult;
> 
> So there is no sanity check for (latch << evt->shift) exceeding the
> 64bit boundary. The latch argument is "unsigned long", so on a 64bit
> arch the handed in argument could easily lead to an unnoticed shift
> overflow. With the above rounding fix applied the calculation before
> the divison is:
> 
>        u64 clc = (latch << evt->shift) + evt->mult - 1;
> 
> So we need to make sure, that neither the shift nor the rounding add
> is overflowing the u64 boundary.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> Cc: nicolas.ferre at atmel.com
> Cc: Marc Pignat <marc.pignat@hevs.ch>
> Cc: john.stultz at linaro.org
> Cc: kernel at pengutronix.de
> Cc: Ronald Wahl <ronald.wahl@raritan.com>
> Cc: LAK <linux-arm-kernel@lists.infradead.org>
> Cc: Ludovic Desroches <ludovic.desroches@atmel.com>
> [ukl: move assignment to rnd after eventually changing mult, fix build
>  issue and correct comment with the right math]
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

What's the status of this patch?

Marc
-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 259 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131008/e2dd9038/attachment.sig>
