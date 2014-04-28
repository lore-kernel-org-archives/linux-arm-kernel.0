From: tony@atomide.com (Tony Lindgren)
Date: Mon, 28 Apr 2014 08:36:20 -0700
Subject: [PATCH 2/4] mfd: twl4030-power: Add support for board specific
 configuration
In-Reply-To: <20140428114726.GW21279@lee--X1>
References: <1398300030-7386-1-git-send-email-tony@atomide.com>
 <1398300030-7386-3-git-send-email-tony@atomide.com>
 <20140428114726.GW21279@lee--X1>
Message-ID: <20140428153620.GJ20807@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Lee Jones <lee.jones@linaro.org> [140428 04:47]:
> > With the recommended twl4030 configuration added, we can now add
> > board specific changes as modifications to the recommended
> > configuration.
> > 
> > Cc: Peter De Schrijver <pdeschrijver@nvidia.com>
> > Cc: Samuel Ortiz <sameo@linux.intel.com>
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > ---
> >  drivers/mfd/twl4030-power.c | 21 +++++++++++++++++++++
> >  include/linux/i2c/twl.h     |  1 +
> >  2 files changed, 22 insertions(+)
> > 
> > diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
> > index 89a8528..89c6b1a 100644
> > --- a/drivers/mfd/twl4030-power.c
> > +++ b/drivers/mfd/twl4030-power.c
> > @@ -511,13 +511,34 @@ twl4030_power_configure_scripts(const struct twl4030_power_data *pdata)
> >  	return 0;
> >  }
> >  
> > +static void twl4030_patch_rconfig(struct twl4030_resconfig *common,
> > +				  struct twl4030_resconfig *board)
> > +{
> > +	while (common->resource) {
> > +		struct twl4030_resconfig *b = board;
> > +
> > +		while (b->resource) {
> > +			if (b->resource == common->resource) {
> > +				*common = *b;
> > +				break;
> > +			}
> > +			b++;
> > +		}
> > +		common++;
> > +	}
> > +}
> 
> Forgive my ignorance, as I don't know how 'common' is setup, but we
> appear to move to the next 'common' reference them immediately
> dereference it without checking to see if it actually exists. Same
> with 'b'. What happens if we reach the end of the array? NULL
> dereference or does the final element always have a NULLed resource
> attribute?

Yes there's always a NULL entry at the end of the list always in
this case, and the configured lists are always static in the driver.

Regards,

Tony
