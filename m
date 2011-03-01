From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 1 Mar 2011 10:05:18 +0100
Subject: [RFC] device.h: add device_set_platdata routine
In-Reply-To: <4D6CADE5.6000206@st.com>
References: <5c561db378360ad1763da41f8350c7be816daa06.1298953633.git.viresh.kumar@st.com>
	<20110301075953.GR22310@pengutronix.de> <4D6CADE5.6000206@st.com>
Message-ID: <20110301090518.GV22310@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Viresh,

> > On Tue, Mar 01, 2011 at 10:03:20AM +0530, Viresh Kumar wrote:
> >> device.h supports device_get_platdata but doesn't support device_set_platdata.
> >> This routine is required by platforms in which device structure is declared
> >> in a machine specific file and platform data comes from board specific file.
> >>
> >> This will be used by SPEAr patches sent in separate patch series.
> >>
> >> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> >> ---
> >>  include/linux/device.h |    5 +++++
> >>  1 files changed, 5 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/include/linux/device.h b/include/linux/device.h
> >> index 1bf5cf0..6ce0f20 100644
> >> --- a/include/linux/device.h
> >> +++ b/include/linux/device.h
> >> @@ -576,6 +576,11 @@ static inline void *dev_get_platdata(const struct device *dev)
> >>  	return dev->platform_data;
> >>  }
> >>  
> >> +static inline void dev_set_platdata(struct device *dev, void *platdata)
> >> +{
> >> +	dev->platform_data = platdata;
> >> +}
> >> +
> > Note that dev->platform_data was designed to hold dynamically allocated
> > memory, at least it's kfreed in platform_device_release.  And note there
> > is platform_device_add_data that kmemdups its argument into
> > pdev->dev.platform_data.
> > 
> 
> Ok. So we should use platform_device_add_data instead and mark our platform
> data's struct as __init. So that it doesn't consume any memory after
> this routine is done??
Yeah, either __initdata or still better const + __initconst if possible.
 
Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
