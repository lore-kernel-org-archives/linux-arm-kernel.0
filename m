From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 2 May 2012 22:21:01 +0200
Subject: [PATCH v2 1/3] ARM: imx: Add common imx cpuidle init
 functionality.
In-Reply-To: <CAMXH7KGLHD8uimSnf8=0t15F7KcFiPuL=3bebY309MbaA75USA@mail.gmail.com>
References: <1335924760-796-1-git-send-email-rob.lee@linaro.org>
 <1335924760-796-2-git-send-email-rob.lee@linaro.org>
 <20120502072701.GR4141@pengutronix.de>
 <CAMXH7KGLHD8uimSnf8=0t15F7KcFiPuL=3bebY309MbaA75USA@mail.gmail.com>
Message-ID: <20120502202101.GA16535@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 02, 2012 at 02:16:36PM -0500, Rob Lee wrote:
> Sascha,
> 
> >> +int __init imx_cpuidle_init(struct cpuidle_driver *drv)
> >> +{
> >> + ? ? struct cpuidle_device *dev;
> >> + ? ? int cpu_id, ret;
> >> +
> >> + ? ? if (!drv || drv->state_count > CPUIDLE_STATE_MAX) {
> >
> > Please don't check for !drv here. When someone calls this function with
> > a NULL pointer he should get a nive stack trace allowing him to figure
> > out what went wrong.
> >
> 
> Ok, I will change this in v3.  Given your statement, my understanding
> is that I should avoid adding checks to make sure a valid driver
> object was given as the stack trace information is all the handling
> that is needed.  If there is any further logic needed in that rule,
> could you elaborate so that I don't make this mistake in the future,
> or so that I don't add a check on a driver object in a case that I
> should?

Here we have the case that only a Kernel developer will add a call to
this function. For a kernel developer a stack trace is more useful
than a pr_err. Of course this is different when not testing for a NULL
pointer causes subtle bugs in unrelated code.

> >
> > You should only unregister the cpuidle devices you successfully
> > registered. Unregistering not yet registered cpuidle devices probably
> > has unwanted side effects.
> >
> 
> I did not add in this handling because the cpuidle_unregister_device()
> call already has a "registered" check so extra handling seemed
> unnecessary.  But if you still think it is needed just let me know.
> 

It's ok then. I didn't check cpuidle_unregister_device.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
