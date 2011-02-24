From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 24 Feb 2011 02:16:57 -0700 (MST)
Subject: [PATCH 4/8] OMAP2+: hwmod: find MPU initiator hwmod during in
	_register()
In-Reply-To: <4D651BDC.8040700@ti.com>
References: <20110223070455.5874.51326.stgit@twilight.localdomain>
	<20110223071146.5874.15334.stgit@twilight.localdomain>
	<4D651BDC.8040700@ti.com>
Message-ID: <alpine.DEB.2.00.1102240208160.6198@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Beno?t,

On Wed, 23 Feb 2011, Cousson, Benoit wrote:
> On 2/23/2011 8:11 AM, Paul Walmsley wrote:
> > +	/*
> > +	 * XXX Rather than doing a strcmp(), this should test a flag
> > +	 * set in the hwmod data, inserted by the autogenerator code.
> 
> What do you mean exactly? Something like a "is_mpu" field set to true 
> for the mpu? Since we are enforcing a consistent naming for every 
> hwmods, that looks like a duplication of the name. We will always named 
> this hwmod "mpu", so the strcmp() should be enough.
> 
> But, maybe I'm missing your point.

I had in mind adding a new flag bit for struct omap_hwmod.flags for this 
purpose, mostly for these reasons:

1. Russell indicated a preference to avoid strcmp() for this type of
   situation during the clock code merge a few years ago

2. Testing a single bit is much more efficient than calling strcmp(), 
   which will hopefully make life a little easier when running on an 
   FPGA emulator

A separate field would of course work as well, but seems more heavyweight 
if there's only one special case.

> > +	 */
> > +	if (!strcmp(oh->name, MPU_INITIATOR_NAME))
> > +		mpu_oh = oh;
> > 
> > -	return ret;
> > +	return 0;
> >   }


- Paul
