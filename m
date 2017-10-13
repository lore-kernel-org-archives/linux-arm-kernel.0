From: dianders@chromium.org (Doug Anderson)
Date: Fri, 13 Oct 2017 08:32:12 -0700
Subject: [RESEND PATCH 1/2] spi: rockchip: Convert to late and early
 system PM callbacks
In-Reply-To: <20171013104138.3216-2-jeffy.chen@rock-chips.com>
References: <20171013104138.3216-1-jeffy.chen@rock-chips.com>
 <20171013104138.3216-2-jeffy.chen@rock-chips.com>
Message-ID: <CAD=FV=X6pkaY3t=ceh3QEUws+_gqRGMN9zveW0fXR1noF1T6ew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Oct 13, 2017 at 3:41 AM, Jeffy Chen <jeffy.chen@rock-chips.com> wrote:
> Currently we are suspending the spi master in it's ->suspend callback,
> which is racy as some other drivers may still want to transmit messages
> on the bus(e.g. spi based pwm backlight).
>
> Convert to late and early system PM callbacks to avoid the race.
>
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
>
>  drivers/spi/spi-rockchip.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

It shouldn't hurt to do this, but I'm curious if you did any digging
about why this happens?  As I understood it suspend order is supposed
to be opposite of probe order.  Thus anything that was able to get a
reference to the cros-ec PWM at its probe time should get suspended
before cros-ec suspends.


-Doug
