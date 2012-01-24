From: khilman@ti.com (Kevin Hilman)
Date: Tue, 24 Jan 2012 12:08:08 -0800
Subject: [PATCH v3 0/7] Add common cpuidle code for consolidation.
In-Reply-To: <1327379854-12403-1-git-send-email-rob.lee@linaro.org> (Robert
 Lee's message of "Mon, 23 Jan 2012 22:37:27 -0600")
References: <1327379854-12403-1-git-send-email-rob.lee@linaro.org>
Message-ID: <871uqoj23b.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Robert Lee <rob.lee@linaro.org> writes:

> This patch series adds a new common cpuidle interface to consolidate code
> commonly duplicated by various platforms.  A patch was then made for each
> platform that could immediately take advantage of this code.  The platform
> specific changes are not required by the common code and are only made for
> consoldation.

I noticed that the generic code uses ktime_get() for measuring time.  On
OMAP, we use getnstimeofday() because I while back I remember having
problems with the interaction of CPUidle state measurements and system
suspend.  Any idle activity during system suspend/resume ktime_get()
will WARN() because the timekeeping system has been suspended.

Off the top of my head, I don't remember the interactions that triggered
this, but I guess all it would require the idle loop to be entered after
the syscore_ops->suspend for the timekeeping subsystem (and before the
syscore_ops ->resume.)

Depending on what syscore_ops are registered, this could be rather
platforms specific.

> Maintainers and cpuidle idle developers of these platforms, please check to make
> sure that you agree with the changes.  

In earlier version you mentioned that OMAP didn't quite fit the
pattern.  Do you have any suggestions for how to make OMAP fit.

> Besides just code consolidation, a
> default "WFI" state is now used with default parameters that different from your
> original paramenters. The assumption is that if you have a WFI only idle state,
> the parameters in the new default WFI are more realistic as a true WFI only
> hardware state incurs minimal latency(<1us) or power penalty to enter and exit.
> If your platform actually performs other platform specific functionality upon
> entering WFI and the default parameters do not accurately reflect the 
> exit_latency and target_residency given in the common default state, please
> say so.  

I'm not sure what you mean by "WFI only".  On OMAP, WFI is the entry
point for all the idle states, with varying latencies.  The latencies
are then dependent on how the states are programmed for the various
power domains.  Upon WFI, the hardware then takes over puts the
powerdomains to their programmed states.   

Kevin
