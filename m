From: santosh.shilimkar@ti.com (Santosh)
Date: Tue, 06 Sep 2011 11:31:02 +0530
Subject: [PATCH v2 0/2] make reinitialization of ARM core components
	possible
In-Reply-To: <1315288107-14689-1-git-send-email-shawn.guo@linaro.org>
References: <1315288107-14689-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <4E65B71E.6060307@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 06 September 2011 11:18 AM, Shawn Guo wrote:
> When ARM core resumes from low-power mode where losing power, for my
> example: CA-9 MPCore resumes from Dormant/Shutdown, we have to
> reinitialize components like L2 Cache, GIC and SCU to bring system
> back to work.
>
I think you mean to drop GIC from above as well.

> The patch set basically removes __init annotation from a bunch of
> initialization functions, so that platform resume procedure can call
> into them again to set those components up.
>
> Changes since v1:
>   * Drop the GIC patch, as it's been handled by [1] nicely.
>   * Drop the change of adding empty l2x0_of_init(), as it's been
>     handled by [2].
>
> Shawn Guo (2):
>        ARM: cache-l2x0: remove __init annotation from initialization functions
Do you really need to do a re-init function for L2.
Look at the OMAP code, You just need to restore the configuration 
registers and that's it. And the save can be done only once because
these are configuration register which won't change in the live system.

>        ARM: smp_scu: remove __init annotation from scu_enable()
>
This init is really small one so should be ok but I still feel a
simple register restore is better.
