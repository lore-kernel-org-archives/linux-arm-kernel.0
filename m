From: eduardo.valentin@ti.com (Eduardo Valentin)
Date: Sat, 19 May 2012 12:52:37 +0300
Subject: [PATCH V2] ARM: OMAP3+: PM: VP: ensure VP is idle before disable
In-Reply-To: <1337365122-702-1-git-send-email-nm@ti.com>
References: <1337365122-702-1-git-send-email-nm@ti.com>
Message-ID: <20120519095237.GA26761@besouro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Minor suggestion.

On Fri, May 18, 2012 at 01:18:41PM -0500, ext Nishanth Menon wrote:
> From: Wenbiao Wang <wwang@ti.com>
> 
> Voltage Processor state machine transition to disable need to
> occur from IDLE state. When we transition OPP in a functioning
> system, the call sequence for an OPP transition is as follows:
> omap_sr_disable
>       -> sr class 3 disable
>            -> vp disable
>            -> sr disable
> forceupdate to voltage/frequency scale depending on which OPP
> we are transitioning to.
> 
> If we hit a critical timing window where SR had commanded VP
> for a voltage transition and VP is in the middle of operating
> on that command, it needs to go through a few states before
> going to update state(where it actually sends the command to
> VC). Initial view of h/w owners is that the state disable of VP
> is expected to be sampled for the next transition.
> 
> Instead, to be on a safer side, we ensure that the valid states
> of the VP state machine is diligently followed by software. This
> can be done by waiting for VP to be in idle  prior to disabling
> VP. Existing prints have been updated to ensure context is
> available on error messages.
> 
> As part of this change, increase timeout for VP idle check to
> improbable 500uSec to be certain that system is indeed unable
> to continue before crashing out with error(worst case expectancy
> remains the same 3-100uSec depending on when we caught VP).
> 


<cut>

>  
>  /* XXX document */
> -#define VP_IDLE_TIMEOUT		200
> +#define VP_IDLE_TIMEOUT		500

I guess it is time to properly document this increasing busy loop delay..
As it is getting closer to ms scale..

>  #define VP_TRANXDONE_TIMEOUT	300
>  
>  /**
> -- 
> 1.7.9.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
