From: drake@endlessm.com (Daniel Drake)
Date: Wed, 24 Sep 2014 11:52:07 -0600
Subject: [PATCH] ASoC: samsung-i2s: Maintain CDCLK settings across
 i2s_{shutdown/startup}
In-Reply-To: <1405008673-15994-1-git-send-email-s.nawrocki@samsung.com>
References: <1405008673-15994-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <CAD8Lp47nEcY6nyDE3xkUGUdnYpTOv_1NUMGjuBLoLhGeZ45A6A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sylwester,

On Thu, Jul 10, 2014 at 10:11 AM, Sylwester Nawrocki
<s.nawrocki@samsung.com> wrote:
> Currently configuration of the CDCLK pad is being overwritten in
> the i2s_shutdown() callback in order to gate the SoC output clock.
> However if an ASoC machine driver doesn't restore that clock
> settings each time after opening the sound device this results
> in the CDCLK pin being permanently configured into input mode.
> I.e. the output clock will always stay disabled.
> Fix that by saving the CDCLKCON bit state in i2s_shutdown() and
> and restoring it in the i2s_startup() callback.

I'm still having trouble in this area on ODROID. Basically, if you
start pulseaudio, all audio breaks. Even after you kill pulseaudio,
audio is still broken.
This happens because CDCLK gets disabled by i2s.c and never enabled again.

pulseaudio does:
1. i2s_startup for playback channel
2. i2s_startup for capture channel
3. i2s_shutdown for capture channel
4. i2s_shutdown for playback channel

In step 3 we disable CDCLK even though playback should still be active, oops.

In step 4 we do this:
        u32 mod = readl(i2s->addr + I2SMOD);
        i2s->cdclk_out = !(mod & MOD_CDCLKCON);

and now cdclk_out is always going to be 0, so we'll never turn it back on again.

Regardless of what we do now, I think there is a bug in i2s_shutdown
in that it should not do any real shutdown stuff if the other stream
(playback/capture) is open.

However I'm wondering if we should more thoroughly clean up CDCLK
handling. Right now CDCLK is enabled during boot in
odroidx2_late_probe() (even if you never play any audio), and then
sometimes disabled by i2s.c after the sound device has been opened and
then closed, with a half-broken attempt to sometimes enable it again
next time it is opened. We're in this situation because that setup is
pretty fragile and confusing...

Is CDCLK something ODROID-specific? Perhaps we could have
startup/shutdown hooks in odroidx2_max98090.c that start and stop the
clock (with proper refcounting), and remove CDCLK interaction from
i2s.c.

Is CDCLK something more generic for Samsung i2s devices? In that case
we could enable it in i2s_startup, disable it in i2s_shutdown, and
avoid interacting with it at all from odroidx2_max98090.c. (again with
proper refcounting)

Thanks
Daniel
