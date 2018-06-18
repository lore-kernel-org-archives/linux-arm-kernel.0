From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 18 Jun 2018 11:34:59 +0200
Subject: Charge counter on droid 4
In-Reply-To: <20180618082858.GO112168@atomide.com>
References: <20180615080014.GA29192@amd> <20180615083156.GA32102@amd>
 <20180618065827.GN112168@atomide.com> <20180618074023.GA16955@amd>
 <20180618082858.GO112168@atomide.com>
Message-ID: <20180618093459.GA21391@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 2018-06-18 01:28:58, Tony Lindgren wrote:
> * Pavel Machek <pavel@ucw.cz> [180618 07:43]:
> > 
> > So... there are mA, mAh values. Those come from hardware, and I
> > believe we should keep them.
> > 
> > But there are also mW, mWh values, which are synthetic. Userland can
> > compute them from mV, mA values... and it is confusing that kernel
> > provides them. (My tendency was to start computing these synthetic
> > values in userland, to compare them with "real hardware" values from
> > kernel. But then I looked at kernel implementation, and realized they
> > are synthetic, tooo...)
> 
> Hmm mWh value is based on the hardware sampled shunt
> values and number of samples gathered between the
> two readings. I'd rather call the calculated values
> based on userland reading mV and mA values "synthetic" :)

As far as I know, shunt resistors provide you with current (mA) not
power (mW) measurement... and cpcap-battery computes power_now as
voltage * current. I'd rather have kernel tell me "hardware can't
measure power" and do "voltage*current" computation in userspace.

So I'm proposing to apply patch below.

Best regards,
								Pavel


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

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180618/be105e1c/attachment.sig>
