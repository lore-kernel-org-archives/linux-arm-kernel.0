From: stano@meduna.org (Stanislav Meduna)
Date: Thu, 08 Nov 2012 22:27:59 +0100
Subject: scheduler clock for MXS
In-Reply-To: <20121106224624.GR28327@n2100.arm.linux.org.uk>
References: <5093D8DE.70505@meduna.org>
 <20121105025753.GA26528@S2100-06.ap.freescale.net>
 <50978370.9060001@meduna.org>
 <20121105134655.GB27260@S2100-06.ap.freescale.net>
 <5097E4A9.3090008@meduna.org> <20121105222859.GI28327@n2100.arm.linux.org.uk>
 <5098CB9F.9030401@meduna.org>
 <20121106134630.GD27643@S2100-06.ap.freescale.net>
 <20121106202038.GB32398@n2100.arm.linux.org.uk> <50998F94.8000908@meduna.org>
 <20121106224624.GR28327@n2100.arm.linux.org.uk>
Message-ID: <509C23DF.1020106@meduna.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06.11.2012 23:46, Russell King - ARM Linux wrote:

>  * round_jiffies - function to round jiffies to a full second
> 
> This is probably it.  With mine, it's a 32.768kHz clock, so limiting
> it to 16-bit gives a wrap period of 2 seconds exactly.  We take 10%
> off, so the timer would be asked to fire every 1.8s, which would be
> rounded up to 2 seconds.  That's a little too close for comfort...

Confirmed.

- if I artificially change my timer code to act as a 16-bit one,
  I get wrap-arounds. Not always, but there are definitely some
  during the bootup (where maybe the tick is sometimes delayed
  a tad more)

- if I then remove the round_jiffies and only leave jiffies +
  wrap_ticks, the wrap-arounds go away

> I think in this case, we need a version of round_jiffies() which _always_
> rounds down.  Unfortunately, it doesn't exist.  Thomas?  What are the
> options here?

What is actually the reason of round_jiffies there? The
http://kernel.org/doc/htmldocs/device-drivers/API-round-jiffies.html
mentions saving power, is it the only one?

I'd probably just leave the round_jiffies out at least for
wrap_ticks < around 16*HZ. Above that the error by possibly
rounding up can be ignored.

There is also a round_jiffies_up - unless I am too tired, as long as
we tick no faster than once per second, subtracting (HZ-1) and rounding
up should be the same as rounding down.

But: is the round_jiffies* safe at all for sub-second precision
at jiffies around 0xffffffff? From quick looking it does a modulo,
0xffffffff % say 250 is 45, the next jiffy is@0...

Regards
-- 
                                       Stano
