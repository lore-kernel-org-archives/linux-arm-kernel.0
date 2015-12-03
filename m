From: computersforpeace@gmail.com (Brian Norris)
Date: Thu, 3 Dec 2015 12:33:57 -0800
Subject: [PATCH v3 2/5] thermal: rockchip: fix a impossible condition
 caused by the warning
In-Reply-To: <20151203201908.GA34901@dtor-ws>
References: <1449132523-18817-1-git-send-email-wxt@rock-chips.com>
 <1449132523-18817-3-git-send-email-wxt@rock-chips.com>
 <20151203201908.GA34901@dtor-ws>
Message-ID: <20151203203357.GA141945@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 03, 2015 at 12:19:08PM -0800, Dmitry Torokhov wrote:
> On Thu, Dec 03, 2015 at 04:48:40PM +0800, Caesar Wang wrote:
> > As the Dan report the smatch check the thermal driver warning:
> > drivers/thermal/rockchip_thermal.c:551 rockchip_configure_from_dt()
> > warn: impossible condition '(thermal->tshut_temp > ((~0 >> 1))) =>
> > (s32min-s32max > s32max)'
> > 
> > Let's we remove the imposssible condition Since the Temperature is
> > currently represented as int not long in the thermal driver.
> > 
> > Fixes: commit 437df2172e8d
> > ("thermal: rockchip: consistently use int for temperatures")
> > 
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> > 
> > ---
> > 
> > Changes in v3:
> > - As Brian comments on https://patchwork.kernel.org/patch/7580661/,
> >   let's remove the impossible condition.
> > 
> > Changes in v2: None
> > Changes in v1: None
> > 
> >  drivers/thermal/rockchip_thermal.c | 6 ------
> >  1 file changed, 6 deletions(-)
> > 
> > diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
> > index ae796ec..611de00 100644
> > --- a/drivers/thermal/rockchip_thermal.c
> > +++ b/drivers/thermal/rockchip_thermal.c
> > @@ -549,12 +549,6 @@ static int rockchip_configure_from_dt(struct device *dev,
> >  		thermal->tshut_temp = shut_temp;
> >  	}
> >  
> > -	if (thermal->tshut_temp > INT_MAX) {
> > -		dev_err(dev, "Invalid tshut temperature specified: %d\n",
> > -			thermal->tshut_temp);
> > -		return -ERANGE;
> > -	}
> 
> Well, that is not entirely correct. The value that we read from DT is
> u32, but we convert it down to int. I believe you want to move the check

Do we really account for the possibility of sizeof(int) < sizeof(u32)?

EDIT: A bit after writing the above line, I notice my error, but in case
anyone else is thinking the same thing... I guess you're referring to
the sign bit, since we're casting unsigned to signed.

Brian

> up so that you do:
> 
> 	} else if (tshut_temp > INT_MAX) {
> 		dev_err(dev, "Invalid tshut temperature specified: %d\n",
> 			thermal->tshut_temp);
> 		return -ERANGE;
> 	} else {
> 		thermal->tshut_temp = shut_temp;
> 	}
> 
> Thanks.
