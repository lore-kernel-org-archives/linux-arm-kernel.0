From: vinod.koul@intel.com (Vinod Koul)
Date: Fri, 11 Mar 2016 13:13:28 +0530
Subject: [PATCH] dmaengine: pl330: Fix some race conditions in residue
 calculation
In-Reply-To: <1457452241.2818.128.camel@linaro.org>
References: <1456319674.2867.15.camel@linaro.org>
 <20160308041238.GL11154@localhost>
 <1457433611.2818.83.camel@linaro.org>
 <20160308141551.GP11154@localhost>
 <1457452241.2818.128.camel@linaro.org>
Message-ID: <20160311074328.GU11154@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 08, 2016 at 03:50:41PM +0000, Jon Medhurst (Tixy) wrote:

> > The reside is requested for "a descriptor". For example if you have prepared
> > two descriptors A and B and submitted them, then you can request status and
> > reside for A and you need to calculate that for A only and not take into
> > account status of B
> 
> But, in the case of the pl330 driver, A and B may each consist of
> multiple internal/hidden descriptors. So the residue calculation has to
> sum up the residue of all these internal/hidden descriptors as well.
> This is what the current pl330_tx_status() function does, but has bugs.
> 
> I've only just managed to clearly understand all the above details
> whilst writing this email, and this confusion obviously means the code
> and any commit messages need to explain things better.

Okay I relooked at the code, the driver is creating descriptor per period,
so yes while calculating that should be taken into account but only for
cyclic case and not for rest, as it will break reside values for for them.

-- 
~Vinod
