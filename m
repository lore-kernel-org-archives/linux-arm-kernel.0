From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Thu, 02 Oct 2014 18:16:43 +0200
Subject: [PATCH] ASoC: samsung: fix CDCLK handling
In-Reply-To: <1412095211-4012-1-git-send-email-drake@endlessm.com>
References: <1412095211-4012-1-git-send-email-drake@endlessm.com>
Message-ID: <542D7A6B.7010000@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[dropping unrelated addresses from Cc]

On 30/09/14 18:40, Daniel Drake wrote:
> ODROID is the only platform that uses CDCLK, and right now,
> CDCLK handling is buggy. If you start pulseaudio on ODROID,
> audio is broken until reboot (even after killing pulse).
> 
> This happens because CDCLK gets disabled by i2s.c and never enabled again.
> 
> pulseaudio does:
> 1. i2s_startup for playback channel
> 2. i2s_startup for capture channel
> 3. i2s_shutdown for capture channel
> 4. i2s_shutdown for playback channel
> 
> In step 3 we disable CDCLK even though playback should still be active.
> 
> In step 4 we do this:
> 	u32 mod = readl(i2s->addr + I2SMOD);
> 	i2s->cdclk_out = !(mod & MOD_CDCLKCON);
> 
> and now cdclk_out is always going to be 0, so we'll never turn it back
> on again.

Sorry for getting back late to this. Indeed we have a mess here.
I mostly tested interaction between two CPU DAIs - the main and the
overlay one (which is not supported in mainline yet).

> Both this bug and the one that b97c60abf9a tries to fix happened
> because of the way that CDCLK handling is painfully split between
> platform and i2s drivers.
> 
> Simplify the situation and solve the bug with the following approach:
>  - as before, samsung_i2s_dai_probe() gates CDCLK by default
>    (no need for smartq_wm8987 to do this as well)
>  - platform drivers can gate/ungate CDCLK as necessary
>    (currently only odroidx2 needs to do this)
>  - i2s code has no other interaction with CDCLK

I'm not an ASoC expert, but I'd say it would be better to modify
the I2S module so there is no additional callbacks needed in
the machine driver. This way all machine drivers using the CDCLK
output could be simplified, not mentioning using simple-card.
I'm not sure how to do it yet, I'm going to take a look at this
over the weekend.

--
Regards,
Sylwester
