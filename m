From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 8 Jul 2011 12:13:09 +0100
Subject: [PATCH 0/3] Add generic idle notifiers
In-Reply-To: <20110707201748.GB32199@google.com>
References: <1309229190-25006-1-git-send-email-toddpoynor@google.com>
	<87ei22dnsp.fsf@ti.com> <20110707201748.GB32199@google.com>
Message-ID: <20110708111309.GB4812@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 07, 2011 at 01:17:48PM -0700, Todd Poynor wrote:
> This is intended to coexist with the CPU PM notifiers.  The idle
> notifiers proposed here are notifying of a change in kernel scheduler
> state: the scheduler has no task to run and is entering its "idle
> loop", or now has something to run and is exiting idle state.
> Things that can use this include power management hints such as the
> existing drivers/idle/i7300_idle.c usage, the ARM LEDs idle triggers,
> and there's probably other existing potential uses in other arch'es that
> I should go track down.

Isn't drivers/idle yet another cpuidle like implementation, but done
differently?  Is there any reason why the drivers/idle stuff can't
hook in like cpuidle or vice versa?

Isn't it possible for cpuidle to gain the same information via the idle
callback which these notifiers are providing drivers/idle with?

One of the problems I see with these notifiers is that it's not really
possible to keep an eye on the number of things hooked into them - and
in this path adding latency to the idle stuff could affect responsiveness.

Also bear in mind that at the point where idle starts, the decision about
what power state to idle in hasn't been decided, so nothing actually knows
whether it will be powered down, so all in all, I'm not sure what you'd
use these notifiers for.
