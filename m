From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Thu, 7 Jun 2012 06:59:05 +0000
Subject: [PATCH 05/11] ARM: OMAP2+: hwmod code/data: fix 32K sync timer
In-Reply-To: <20120607061309.25532.13430.stgit@dusk>
References: <20120607060901.25532.68354.stgit@dusk>
 <20120607061309.25532.13430.stgit@dusk>
Message-ID: <79CD15C6BA57404B839C016229A409A83EA43E0F@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 07, 2012 at 11:43:10, Paul Walmsley wrote:
> Kevin discovered that commit c8d82ff68fb6873691536cf33021977efbf5593c
> ("ARM: OMAP2/3: hwmod data: Add 32k-sync timer data to hwmod
> database") broke CORE idle on OMAP3.  This prevents device low power
> states.
> 
> The root cause is that the 32K sync timer IP block does not support
> smart-idle mode[1], and so the hwmod code keeps the IP block in
> no-idle mode while it is active.  This in turn prevents the WKUP
> clockdomain from transitioning to idle.  There is a hardcoded sleep
> dependency that prevents the CORE_L3 and CORE_CM clockdomains from
> transitioning to idle when the WKUP clockdomain is active[2], so the
> chip cannot enter any device low power states.
> 
> It turns out that there is no need to take the 32k sync timer out of
> idle.  The IP block itself probably does not have any native idle
> handling at all, due to its simplicity.  Furthermore, the PRCM will
> never request target idle for this IP block while the kernel is
> running, due to the sleep dependency that prevents the WKUP
> clockdomain from idling while the CORE_L3 clockdomain is active.  So
> we can safely leave the 32k sync timer in target-no-idle mode, even
> while we continue to access it.
> 
> This workaround is implemented by programming the force-idle mode for
> any IP block that only supports the force-idle and no-idle modes.  If
> an IP block is ever released that doesn't support smart-idle and
> requires no-idle mode to be programmed while it's in use, we'll have
> to change this behavior.
> 

Isn't this impact AM33xx devices, where we do not support smart idle mode???
Anyway, I will also test it on both OMAP3EVM and AM33xx platform now...

Thanks,
Vaibhav
