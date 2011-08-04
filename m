From: vinod.koul@intel.com (Koul, Vinod)
Date: Thu, 04 Aug 2011 12:58:46 +0530
Subject: [PATCH V2 08/20] dmaengine/amba-pl08x: support runtime PM
In-Reply-To: <4E3A3CB7.8040505@st.com>
References: <cover.1312190881.git.viresh.kumar@st.com>
	<bc59bbd3709a7af1723d37ab846bf44c6867c00e.1312190881.git.viresh.kumar@st.com>
	<20110803123953.GB23953@n2100.arm.linux.org.uk>
	<4E3A2BFC.3070907@st.com>
	<1312436185.1536.570.camel@vkoul-udesk3>  <4E3A3CB7.8040505@st.com>
Message-ID: <1312442926.1539.0.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-08-04 at 12:01 +0530, viresh kumar wrote:
> On 08/04/2011 11:06 AM, Koul, Vinod wrote:
> > On Thu, 2011-08-04 at 10:49 +0530, viresh kumar wrote:
> >> On 08/03/2011 06:09 PM, Russell King - ARM Linux wrote:
> >>> On Mon, Aug 01, 2011 at 03:07:18PM +0530, Viresh Kumar wrote:
> >> @@ -405,6 +406,7 @@ pl08x_get_phy_channel(struct pl08x_driver_data *pl08x,
> >>  		return NULL;
> >>  	}
> >>  
> >> +	pm_runtime_get_sync(&pl08x->adev->dev);
> > this should be ideally one of the first things you would do not last.
> > get_sync will ensure your .runtime_resume callback is called before it
> > returns (if its suspended)
> >>  	return ch;
> >>  }
> 
> Until this point we are not touching the registers at all. And they will
> accessed after this point only.
But from maintainability POV it should be at the start.

> 
> >> +	pm_runtime_put(&adev->dev);
> > _put is probe looks suspect, why do you need this here 
> 
> To save power.
> 
> > as you are already setting the status as active, this _put will decrement your
> > usage count and possibly call your runtime_suspend
> 
> We set status as active, as amba/bus layer has enabled it before calling
> probe and it doesn't put it.
> 
> As DMA will not be used until get_phy_channel() is called, so we can save
> some energy here too. So i put it here.
> 


-- 
~Vinod
