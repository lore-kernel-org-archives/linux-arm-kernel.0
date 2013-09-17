From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Wed, 18 Sep 2013 00:25:02 +0200
Subject: [PATCH] clockevents: Sanitize ticks to nsec conversion
In-Reply-To: <alpine.DEB.2.02.1309172228400.4089@ionos.tec.linutronix.de>
References: <1379077365-18458-1-git-send-email-mkl@pengutronix.de>
 <20130917095600.GJ26819@ludovic.desroches@atmel.com>
 <20130917100417.GQ12758@n2100.arm.linux.org.uk>
 <alpine.DEB.2.02.1309171210450.4089@ionos.tec.linutronix.de>
 <20130917130153.GL26819@ludovic.desroches@atmel.com>
 <alpine.DEB.2.02.1309172228400.4089@ionos.tec.linutronix.de>
Message-ID: <5238D6BE.6040603@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/17/2013 11:15 PM, Thomas Gleixner wrote:
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
> Now instead of fixing the underlying core code problem, Marcs patch
> tried to work around the core code issue by increasing the minimal
> tick delta at clockevents registration time so the resulting limit in
> the core code backwards conversion did not violate the hardware
> limits. More SIGH!

It was not easy getting your attention with this problem :)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130918/6569f9f6/attachment.sig>
