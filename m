From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 12 Nov 2014 09:52:00 +0000
Subject: [RFC 1/2] mfd: qcom-rpm: Expose sleep state resources to clients
In-Reply-To: <20141111183319.GD16980@sonymobile.com>
References: <1415659966-16200-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1415659966-16200-2-git-send-email-bjorn.andersson@sonymobile.com>
 <20141111120457.GZ24004@x1> <20141111183319.GD16980@sonymobile.com>
Message-ID: <20141112095200.GD24004@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 11 Nov 2014, Bjorn Andersson wrote:

> On Tue 11 Nov 04:04 PST 2014, Lee Jones wrote:
> 
> > On Mon, 10 Nov 2014, Bjorn Andersson wrote:
> > 
> > > Resources exposed from the RPM have an "active state" that is used during
> > > normal operations and a "sleep state" that is used for HW assisted sleep
> > > modes. Expose this in the api to let client drivers set the "sleep
> > > state" as well.
> > 
> > I assume you have users lined up which will request a sleeping state?
> > 
> 
> All users of this interface (regulators, clocks and bus scaling) will have to
> be able to specify this.
> 
> [..]
> > > @@ -359,8 +361,7 @@ int qcom_rpm_write(struct qcom_rpm *rpm, int resource, u32 *buf, size_t count)
> > >  			       RPM_CTRL_REG(rpm, RPM_REQ_SELECT + i));
> > >  	}
> > >  
> > > -	writel_relaxed(RPM_ACTIVE_STATE,
> > > -		       RPM_CTRL_REG(rpm, RPM_REQUEST_CONTEXT));
> > > +	writel_relaxed(BIT(state), RPM_CTRL_REG(rpm, RPM_REQUEST_CONTEXT));
> > 
> > How are the state bits organised?
> > 
> 
> BIT(0) is active mode, BIT(1) is sleep mode, as specified below. I could add
> some sanity checking here if you would like to.

I'm just double checking that you know what that means.

BIT(0) == b01
BIT(1) == b10

It seems strange to represent a single boolean state over 2 bits.

Also, what happens if b11 or b00 occurs?

> [..]
> > > diff --git a/include/linux/mfd/qcom_rpm.h b/include/linux/mfd/qcom_rpm.h
> > > index a60798d..f0e70b2 100644
> > > --- a/include/linux/mfd/qcom_rpm.h
> > > +++ b/include/linux/mfd/qcom_rpm.h
> > > +#define RPM_ACTIVE_STATE	0
> > > +#define RPM_SLEEP_STATE		1
> 
> Regards,
> Bjorn

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
