From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 14 May 2013 15:09:08 +0900
Subject: [PATCH 3/3] ARM: mach-shmobile: lager: support GPIO switches
In-Reply-To: <20130514025941.GC20239@verge.net.au>
References: <1368435233-8587-1-git-send-email-horms+renesas@verge.net.au>
 <1368435233-8587-4-git-send-email-horms+renesas@verge.net.au>
 <9256981.LFpgU8cctr@avalon> <20130514025941.GC20239@verge.net.au>
Message-ID: <CANqRtoTj+FnxrtOayxQYCxkyuP4XGeCaXpNUbPsFV4kyBD_48Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon and Laurent,

On Tue, May 14, 2013 at 11:59 AM, Simon Horman <horms@verge.net.au> wrote:
> On Tue, May 14, 2013 at 12:35:20AM +0200, Laurent Pinchart wrote:
>> Hi Simon,
>>
>> Thank you for the patch.
>>
>> On Monday 13 May 2013 17:53:53 Simon Horman wrote:
>> > The lager board has pins 1 - 4 of SW2 wired up to GPIO pins.
>> > This patch allows access to those pins as KEYS 1 - 4 using
>> > gpio-keys.
>> >
>> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
>> >
>> > ---
>> >
>> > This patch has run time dependencies on
>> > 1. "gpio-rcar: Add support for IRQ_TYPE_EDGE_BOTH"
>> > 2. "ARM: shmobile: r8a7790: Configure R-Car GPIO for IRQ_TYPE_EDGE_BOTH"
>> >
>> > Without those dependencies satisfied the gpio-keys driver will
>> > fail to be initialise itself. The boot should be otherwise successful
>> > and the board otherwise functional.
>> > ---
>> >  arch/arm/mach-shmobile/board-lager.c | 22 ++++++++++++++++++++++
>> >  1 file changed, 22 insertions(+)
>> >
>> > diff --git a/arch/arm/mach-shmobile/board-lager.c
>> > b/arch/arm/mach-shmobile/board-lager.c index 6a1ba38..4d1b42b 100644
>> > --- a/arch/arm/mach-shmobile/board-lager.c
>> > +++ b/arch/arm/mach-shmobile/board-lager.c
>> > @@ -18,7 +18,10 @@
>> >   * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301
>> > USA */
>> >
>> > +#include <linux/gpio.h>
>> > +#include <linux/gpio_keys.h>
>> >  #include <linux/interrupt.h>
>> > +#include <linux/input.h>
>>
>> My dictionary lists input before interrupt :-)
>
> Thanks, I will fix that.
>
>> >  #include <linux/irqchip.h>
>> >  #include <linux/kernel.h>
>> >  #include <linux/leds.h>
>> > @@ -52,6 +55,22 @@ static struct gpio_led_platform_data lager_leds_pdata = {
>> > .num_leds   = ARRAY_SIZE(lager_leds),
>> >  };
>> >
>> > +/* GPIO KEY */
>> > +#define GPIO_KEY(c, g, d, ...) \
>> > +   { .code = c, .gpio = g, .desc = d, .active_low = 1 }
>> > +
>> > +static struct gpio_keys_button gpio_buttons[] = {
>> > +   GPIO_KEY(KEY_4,         RCAR_GP_PIN(1, 28),     "SW2-pin4"),
>> > +   GPIO_KEY(KEY_3,         RCAR_GP_PIN(1, 26),     "SW2-pin3"),
>> > +   GPIO_KEY(KEY_2,         RCAR_GP_PIN(1, 24),     "SW2-pin2"),
>> > +   GPIO_KEY(KEY_1,         RCAR_GP_PIN(1, 14),     "SW2-pin1"),
>> > +};
>> > +
>> > +static struct gpio_keys_platform_data lager_keys_pdata = {
>> > +   .buttons        = gpio_buttons,
>> > +   .nbuttons       = ARRAY_SIZE(gpio_buttons),
>> > +};
>> > +
>>
>> Could you please also update the lager dts file ?
>
> I wonder if in that case we can remove the C code above.
> And probably the C code for the GPIO leds too.
>
> Magnus, could you clarify how you would like
> C-code and DTS to look on the lager board?

I'd like C and DTS to coexist in parallel until we can ditch C fully.
I believe there is a need for us to be able to back port the C code.
For the future we want to use DTS.

To support DTS for Lager I think you should create a -reference DTS
file for Lager where you put the DT version of your GPIO LED / switch
code. At the time when we can configure the PFC via PINCTRL DT then I
believe we should be able to replace most of the platform device code
with DT versions. At that we should hopefully be able to ditch all the
C board code, or maybe we need to keep some around until we have the
common clocks going...

Thanks,

/ magnus
