From: balbi@ti.com (Felipe Balbi)
Date: Fri, 13 Mar 2015 10:45:39 -0500
Subject: [PATCH v3 3/5] i2c: recovery: change input parameter to
 i2c_adapter for prepare/unprepare_recovery
In-Reply-To: <5502B8DA.70504@linaro.org>
References: <1417448047-15236-1-git-send-email-grygorii.strashko@ti.com>
 <1417448047-15236-4-git-send-email-grygorii.strashko@ti.com>
 <55017943.6040603@nokia.com> <5502B8DA.70504@linaro.org>
Message-ID: <20150313154539.GF5615@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Mar 13, 2015 at 12:15:54PM +0200, Grygorii.Strashko at linaro.org wrote:
> Hi Wolfram,
> 
> On 03/12/2015 01:32 PM, Alexander Sverdlin wrote:
> > On 01/12/14 16:34, Grygorii Strashko wrote:
> >> This patch changes type of input parameter for .prepare/unprepare_recovery()
> >> callbacks from struct i2c_bus_recovery_info * to struct i2c_adapter *.
> >> This allows to simplify implementation of these callbacks and avoid
> >> type conversations from i2c_bus_recovery_info to i2c_adapter.
> >> The i2c_bus_recovery_info can be simply retrieved from struct i2c_adapter
> >> which contains pointer on it.
> >>
> >> CC: Sekhar Nori <nsekhar@ti.com>
> >> CC: Kevin Hilman <khilman@deeprootsystems.com>
> >> CC: Santosh Shilimkar <ssantosh@kernel.org>
> >> CC: Murali Karicheri <m-karicheri2@ti.com>
> >> Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> >> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> >> ---
> >>   drivers/i2c/i2c-core.c | 4 ++--
> >>   include/linux/i2c.h    | 4 ++--
> >>   2 files changed, 4 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> >> index 2f90ac6..72b6e34 100644
> >> --- a/drivers/i2c/i2c-core.c
> >> +++ b/drivers/i2c/i2c-core.c
> >> @@ -563,7 +563,7 @@ static int i2c_generic_recovery(struct i2c_adapter *adap)
> >>   	int i = 0, val = 1, ret = 0;
> >>   
> >>   	if (bri->prepare_recovery)
> >> -		bri->prepare_recovery(bri);
> >> +		bri->prepare_recovery(adap);
> >>   
> >>   	/*
> >>   	 * By this time SCL is high, as we need to give 9 falling-rising edges
> >> @@ -588,7 +588,7 @@ static int i2c_generic_recovery(struct i2c_adapter *adap)
> >>   	}
> >>   
> >>   	if (bri->unprepare_recovery)
> >> -		bri->unprepare_recovery(bri);
> >> +		bri->unprepare_recovery(adap);
> >>   
> >>   	return ret;
> >>   }
> >> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> >> index b556e0a..cf9380f 100644
> >> --- a/include/linux/i2c.h
> >> +++ b/include/linux/i2c.h
> >> @@ -404,8 +404,8 @@ struct i2c_bus_recovery_info {
> >>   	void (*set_scl)(struct i2c_adapter *, int val);
> >>   	int (*get_sda)(struct i2c_adapter *);
> >>   
> >> -	void (*prepare_recovery)(struct i2c_bus_recovery_info *bri);
> >> -	void (*unprepare_recovery)(struct i2c_bus_recovery_info *bri);
> >> +	void (*prepare_recovery)(struct i2c_adapter *);
> >> +	void (*unprepare_recovery)(struct i2c_adapter *);
> >>   
> >>   	/* gpio recovery */
> >>   	int scl_gpio;
> >>
> > 
> > Acked-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> > 
> 
> Could I ask you to consider this patch for 4.1?
> Now my I2C Davinci series is based on it and probably I2C OMAP changes
> will need to be based on it too - if Felipe would agree with this of course.

I can easily fix my i2c-omap series for this, but I need confirmation
that this is what's going to get merged.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150313/46f6dd6f/attachment.sig>
