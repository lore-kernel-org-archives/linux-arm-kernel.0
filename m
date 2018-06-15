From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 15 Jun 2018 10:31:56 +0200
Subject: Charge counter on droid 4
In-Reply-To: <20180615080014.GA29192@amd>
References: <20180615080014.GA29192@amd>
Message-ID: <20180615083156.GA32102@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 2018-06-15 10:00:14, Pavel Machek wrote:
> Hi!
> 
> Droid 4 has non-removable battery, yet the charge counter is reset to
> near zero on each boot of linux.
> 
> Unfortunately, that makes charge counter pretty much useless on d4, as
> the "battery full" and "battery empty" limits will be different during
> each boot.

Hmm, and could we refrain from providing "power" values?

I was thinking great, we have hardware that does proper power
measuerement for us. No.... it is driver providing synthetic
values. As userland has enough information to do that itself, I
believe we should not do this in kernel.

diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cpcap-battery.c
index 839e365..1610026 100644
--- a/drivers/power/supply/cpcap-battery.c
+++ b/drivers/power/supply/cpcap-battery.c
@@ -490,24 +490,6 @@ static int cpcap_battery_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_CHARGE_COUNTER:
 		val->intval = latest->counter_uah;
 		break;
-	case POWER_SUPPLY_PROP_POWER_NOW:
-		tmp = (latest->voltage / 10000) * latest->current_ua;
-		val->intval = div64_s64(tmp, 100);
-		break;
-	case POWER_SUPPLY_PROP_POWER_AVG:
-		if (cached) {
-			tmp = cpcap_battery_cc_get_avg_current(ddata);
-			tmp *= (latest->voltage / 10000);
-			val->intval = div64_s64(tmp, 100);
-			break;
-		}
-		sample = latest->cc.sample - previous->cc.sample;
-		accumulator = latest->cc.accumulator - previous->cc.accumulator;
-		tmp = cpcap_battery_cc_to_ua(ddata, sample, accumulator,
-					     latest->cc.offset);
-		tmp *= ((latest->voltage + previous->voltage) / 20000);
-		val->intval = div64_s64(tmp, 100);
-		break;
 	case POWER_SUPPLY_PROP_CAPACITY_LEVEL:
 		if (cpcap_battery_full(ddata))
 			val->intval = POWER_SUPPLY_CAPACITY_LEVEL_FULL;

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180615/2ce5a36e/attachment.sig>
