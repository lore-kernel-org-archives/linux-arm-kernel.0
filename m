From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 29 Sep 2013 21:44:14 +0300
Subject: [PATCH 2/5] clocksource: Add Allwinner SoCs HS timers driver
In-Reply-To: <5247ADC0.5080204@elopez.com.ar>
References: <1380117790-19390-1-git-send-email-maxime.ripard@free-electrons.com>
 <1380117790-19390-3-git-send-email-maxime.ripard@free-electrons.com>
 <52437062.5040705@elopez.com.ar> <20130926131329.GQ2954@lukather>
 <5247ADC0.5080204@elopez.com.ar>
Message-ID: <20130929184414.GB2939@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 29, 2013 at 01:34:08AM -0300, Emilio L?pez wrote:
> >>Also, would any special considerations be needed when adjusting the
> >>ahb clock? A future cpufreq driver will most likely need to.
> >
> >While this will be needed at some point, I don't really see how to
> >handle that properly. The clock framework doesn't seem to have any
> >callback when it comes to reconfiguring a clock that a device might
> >use.
> 
> Maybe we should consider using one of the other timers; from a quick
> look at the A20 user manual, it seems they can run at ~200MHz
> ("PLL6/6" as input)

Which timers are you talking about? I only find the usual timers we
already have support for and the timers supported in this user manual.

> >This will also creates trouble for IPs such as the I2C that have to
> >setup internal dividers, and use clk_get_rate to do so.
> 
> Not really, because they use APB1 which is not scaled. The manual
> makes it explicit when describing APB1:
> 
> "This clock is used for some special module apbclk(twi,uart,
> ps2, can, scr). Because these modules need special clock rate
> even if the apbclk changed."

Hmmm, right. But still, we can have IPs that depend on this one that
requires to readjust their internal rate whenever AHB is recalculated.
These HS timers for example :)

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130929/b1985037/attachment.sig>
