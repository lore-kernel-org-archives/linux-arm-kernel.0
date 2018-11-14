From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 14 Nov 2018 13:32:36 +0100
Subject: [PATCH 1/4] pwm: Add new helper to initialize a pwm_state
 variable with defaults
In-Reply-To: <20181026184157.16371-1-u.kleine-koenig@pengutronix.de>
References: <20181026184157.16371-1-u.kleine-koenig@pengutronix.de>
Message-ID: <20181114123236.GG2620@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 26, 2018 at 08:41:55PM +0200, Uwe Kleine-K?nig wrote:
> This helps to convert drivers from the legacy API to pwm_apply_state without
> having to make the aware of the configured polarity (and in some cases even
> period).
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>  include/linux/pwm.h | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)

So if I understand your intention correctly here you want consumers to
be able to get at the default state, which would be the state as it was
"configured" in DT or the PWM lookup table so that you can modify that
state (well, really just setting the duty-cycle) before you actually
send the state to the hardware.

So the difference to pwm_apply_args() is that you don't want the driver
to specifically program a duty cycle of 0 before setting the actual duty
cycle that you want to set.

Is that about right?

Isn't that exactly what pwm_init_state() already does? pwm-backlight
uses it for exactly the same purpose that you seem to be using it in
RX1950 backlight control.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181114/493f7c6e/attachment-0001.sig>
