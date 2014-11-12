From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Wed, 12 Nov 2014 11:55:21 -0800
Subject: [RFC 1/2] mfd: qcom-rpm: Expose sleep state resources to clients
In-Reply-To: <20141112095200.GD24004@x1>
References: <1415659966-16200-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1415659966-16200-2-git-send-email-bjorn.andersson@sonymobile.com>
 <20141111120457.GZ24004@x1> <20141111183319.GD16980@sonymobile.com>
 <20141112095200.GD24004@x1>
Message-ID: <20141112195520.GB19703@sonymobile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 12 Nov 01:52 PST 2014, Lee Jones wrote:

> On Tue, 11 Nov 2014, Bjorn Andersson wrote:
> 
> > On Tue 11 Nov 04:04 PST 2014, Lee Jones wrote:
> > 
> > > On Mon, 10 Nov 2014, Bjorn Andersson wrote:
> > > 
> > > > Resources exposed from the RPM have an "active state" that is used during
> > > > normal operations and a "sleep state" that is used for HW assisted sleep
> > > > modes. Expose this in the api to let client drivers set the "sleep
> > > > state" as well.
> > > 
> > > I assume you have users lined up which will request a sleeping state?
> > > 
> > 
> > All users of this interface (regulators, clocks and bus scaling) will have to
> > be able to specify this.
> > 
> > [..]
> > > > @@ -359,8 +361,7 @@ int qcom_rpm_write(struct qcom_rpm *rpm, int resource, u32 *buf, size_t count)
> > > >  			       RPM_CTRL_REG(rpm, RPM_REQ_SELECT + i));
> > > >  	}
> > > >  
> > > > -	writel_relaxed(RPM_ACTIVE_STATE,
> > > > -		       RPM_CTRL_REG(rpm, RPM_REQUEST_CONTEXT));
> > > > +	writel_relaxed(BIT(state), RPM_CTRL_REG(rpm, RPM_REQUEST_CONTEXT));
> > > 
> > > How are the state bits organised?
> > > 
> > 
> > BIT(0) is active mode, BIT(1) is sleep mode, as specified below. I could add
> > some sanity checking here if you would like to.
> 
> I'm just double checking that you know what that means.
> 
> BIT(0) == b01
> BIT(1) == b10
> 
> It seems strange to represent a single boolean state over 2 bits.
> 

I'm aware of this and find most parts of this solution to be strange.

> Also, what happens if b11 or b00 occurs?
> 

Had to pull out the firmware for the other side; it boils down to a count of
trailing zeros, with 0 giving 0, that is then turned back into and enum where
ACTIVE is 0 and SLEEP is 1. This is then sanity checked to be less than 2.

So the possible values and results would be:
 00 => ACTIVE (seems invalid but "accidentally" accepted)
 01 => ACTIVE
 10 => SLEEP
 11 => ACTIVE

In one of the later versions of the RPM (not applicable for any of these
platforms) 2 seems to be a valid choice as well; but there it's passed as an
u32 and not a bitmask.

Regards,
Bjorn
