From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 7 Jun 2012 21:37:35 +0800
Subject: [PATCH 1/2] ARM i.MX51: setup mipi
In-Reply-To: <20120607084336.GE30400@pengutronix.de>
References: <1338888630-25930-1-git-send-email-s.hauer@pengutronix.de>
 <1338888630-25930-2-git-send-email-s.hauer@pengutronix.de>
 <20120607025949.GM2667@S2101-09.ap.freescale.net>
 <20120607081300.7a554215@archvile>
 <CAAQ0ZWQX60YWvEi-cWtTouMoxg1WxWo_soHf+4gE7oXsPfC_1g@mail.gmail.com>
 <20120607084336.GE30400@pengutronix.de>
Message-ID: <20120607133734.GA3750@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 07, 2012 at 10:43:36AM +0200, Sascha Hauer wrote:
> On Thu, Jun 07, 2012 at 03:10:05PM +0800, Shawn Guo wrote:
> > But why can't we do ipu reset (the second patch) in ipu driver then?
> 
> Ok, we might have to come up with something better. I originally had the
> IPU reset in the IPU driver (copied from the FSL BSP). There are two
> problems with this:
> 
> - The IPU reset is external to the IPU which means that we have to
>   distinguish between SoCs.
> - The IPU reset takes quite a long time (about 300ms). Doing this in
>   the IPU driver means that the kernel boot delays for this time. Doing
>   this in early init means that the 300ms can be spent bringing the rest
>   of the system up.
> 
> As said, there are more clean ways to do this without having the two
> mentioned problems, I'm just not sure whether it's worth it to put
> significant amount of work into this.
> 
IMO, it's worth the effort.  Otherwise, we will end up with having
such reset functions for IPU, VPU and GPU (maybe more on later SoC)
over individual SoC initialization functions.  Well, VPU and GPU may
be less concerned by the mainline tree, but from FSL perspective, we
have to care about them.

Also, how will you support that for imx6q, considering we already have
src.c created as a little "driver" for imx6q System Reset Controller
(SRC)?  I feel like that we should extend this little "driver" to
support what you need for IPU reset here.

-- 
Regards,
Shawn
