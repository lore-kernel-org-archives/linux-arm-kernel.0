From: khilman@kernel.org (Kevin Hilman)
Date: Tue, 10 Mar 2015 09:00:19 -0700
Subject: [PATCH 2/4] soc: Mediatek: Add SCPSYS power domain driver
In-Reply-To: <20150310144053.GH24885@pengutronix.de> (Sascha Hauer's message
 of "Tue, 10 Mar 2015 15:40:53 +0100")
References: <1425888603-25800-1-git-send-email-s.hauer@pengutronix.de>
 <1425888603-25800-3-git-send-email-s.hauer@pengutronix.de>
 <7h61a94zy0.fsf@deeprootsystems.com>
 <20150310094142.GD24885@pengutronix.de>
 <20150310144053.GH24885@pengutronix.de>
Message-ID: <7hoao0yh9o.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sascha Hauer <s.hauer@pengutronix.de> writes:

> On Tue, Mar 10, 2015 at 10:41:42AM +0100, Sascha Hauer wrote:
>> > > +	if (data->bus_prot_mask) {
>> > > +		u32 mask = data->bus_prot_mask;
>> > > +		struct regmap *infracfg = scp->infracfg;
>> > > +
>> > > +		regmap_update_bits(infracfg, INFRA_TOPAXI_PROTECTEN, mask, 0);
>> > > +
>> > > +		expired = jiffies + HZ;
>> > > +
>> > > +		while (1) {
>> > > +			u32 val;
>> > > +
>> > > +			ret = regmap_read(infracfg, INFRA_TOPAXI_PROTECTSTA1, &val);
>> > > +			if (ret)
>> > > +				return ret;
>> > > +
>> > > +			if (!(val & mask))
>> > > +				break;
>> > > +
>> > > +			cpu_relax();
>> > > +			if (time_after(jiffies, expired))
>> > > +				return -EIO;
>> > > +		}
>> > > +	}
>> > 
>> > This whole "Clear bus protection bits" part seems like it should be an
>> > API in the infracfg driver.
>> 
>> Ok, can do.
>
> Since the infracfg driver (which is really a clk driver) currently is
> pending for inclusion I don't want to add more patches to it. I decided
> to drop the protection bits for now and come back to this once the
> infracfg driver is merged.

Makes sense to me.  Hopefully by then, we can have a bit more clarity
from the MTK folks also.

Kevin
