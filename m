From: dianders@chromium.org (Doug Anderson)
Date: Tue, 28 Oct 2014 21:45:15 -0700
Subject: [PATCH v2] ARM: dts: rockchip: use internal pull-up resistors on
 I2C busses
In-Reply-To: <1414492597-13566-1-git-send-email-julien.chauveau@neo-technologies.fr>
References: <1414492597-13566-1-git-send-email-julien.chauveau@neo-technologies.fr>
Message-ID: <CAD=FV=Vs9NT3hMS_Z0dOuwyBdxCsMddqohWFYOGYbM2ePm9PrQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Julien,

On Tue, Oct 28, 2014 at 3:36 AM, Julien CHAUVEAU
<julien.chauveau@neo-technologies.fr> wrote:
> According to the I2C bus specification, it is required to use pull-up resistors
> on the clock and data lines. Probing the I2C busses with i2cdetect results in
> bad results when no devices are connected and no external resistors are used.
>
> This patch configures the I2C busses to use the internal pull-up resistors
> on the RK3066, RK3188 and RK3288 Rockchip processors. It should also be noted
> that these default pull settings match the original configuration on these SoCs.
>
> Below is the results of using i2cdetect on a I2C bus with no devices connected
> before (1) and after (2) applying this patch.
>
> (1) root at localhost:~# i2cdetect -y 3
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00:          03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f
> 10: 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f
> 20: 20 21 22 23 24 25 26 27 28 29 2a 2b 2c 2d 2e 2f
> 30: -- -- -- -- -- rk3x-i2c 2005a000.i2c: timeout, ipd: 0x81, state: 2
> -- rk3x-i2c 2005a000.i2c: timeout, ipd: 0x80, state: 2
> -- rk3x-i2c 2005a000.i2c: timeout, ipd: 0x80, state: 2
> -- rk3x-i2c 2005a000.i2c: timeout, ipd: 0x80, state: 3
> -- rk3x-i2c 2005a000.i2c: timeout, ipd: 0x80, state: 3
> -- rk3x-i2c 2005a000.i2c: timeout, ipd: 0x80, state: 3
> ...
>
> (2) root at localhost:~# i2cdetect -y 3
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00:          -- -- -- -- -- -- -- -- -- -- -- -- --
> 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 70: -- -- -- -- -- -- -- --
>
> Signed-off-by: Julien CHAUVEAU <julien.chauveau@neo-technologies.fr>
> ---
> Changes since v1:
> - fix the rk3066a pull settings (only available is pull_none/pull_default)
> - remove the warnings in the results of i2cdetect
>
>  arch/arm/boot/dts/rk3066a.dtsi | 20 ++++++++++----------
>  arch/arm/boot/dts/rk3188.dtsi  | 20 ++++++++++----------
>  arch/arm/boot/dts/rk3288.dtsi  | 24 ++++++++++++------------
>  3 files changed, 32 insertions(+), 32 deletions(-)

I won't NAK this change myself, but I have to say I'm not a huge fan.
On exynos boards the i2c has pulls by default, so there is precedent
for what you're proposing at least.

...but I'll also say that most sane boards have external pulls on i2c
and don't rely on the internal pulls.  If you've got a board where the
internal pull works well enough (lucky you!) then I think you should
override the pinctrl for just that board.

You are arguing that the internal pull "can't hurt".  I have past
experience that shows that not to be the case.  Here's an old change
for the Samsung ARM Chromebook:

https://chromium-review.googlesource.com/#/c/26607/

You probably can't dig into the bug link due to permissions, but I can
paste some of that in:

---

On Daisy / Snow we've got a NXP HDMI level converter on i2c2.  That
part has its own internal pullups.

Ideally it shouldn't hurt for us to also have the exynos's (weak) 400K
pullups on for the line too.  But according to our EE, we're just
barely within spec and so turning off the exynos pullups makes sense.

Specifically, the problem is the data line when the external HDMI
device is driving low.  The NXP chip doesn't manage to drive the data
line all the way low.  Measured on one board:
* If exynos has pullup: "low" is 560mV
* If exynos has no pull: "low" is 518mV
* If exynos has pulldown: "low" is 490mV

Low should really be 0, but exynos allows .3*VDD (or 540mV).


We should disable pullups in both the kernel and in U-Boot.  There's
even a chance that we'd want to enable pulldowns.


Note that to read EDID at all you need to also remove the strong
external pullups.

---

I did put your patch in my rk3288 board and it booted up OK, but I'm
not setup to test HDMI right now.

In v1 I think Addy said he was having trouble with HDMI and the
internal pulls on some board, so maybe he had a similar experience to
mine on snow.

-Doug
