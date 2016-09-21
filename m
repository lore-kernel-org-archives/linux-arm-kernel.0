From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 21 Sep 2016 11:37:24 -0700
Subject: [PATCH v2] drivers: psci: PSCI checker module
In-Reply-To: <20160921143905.36197-1-kevin.brodsky@arm.com> (Kevin Brodsky's
 message of "Wed, 21 Sep 2016 15:39:05 +0100")
References: <20160921143905.36197-1-kevin.brodsky@arm.com>
Message-ID: <7hfuothzff.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kevin Brodsky <kevin.brodsky@arm.com> writes:

> On arm and arm64, PSCI is one of the possible firmware interfaces
> used for power management. This includes both turning CPUs on and off,
> and suspending them (entering idle states).
>
> This patch adds a PSCI checker module that enables basic testing of
> PSCI operations during startup. There are two main tests: CPU
> hotplugging and suspending.
>
> In the hotplug tests, the hotplug API is used to turn off and on again
> all CPUs in the system, and then all CPUs in each cluster, checking
> the consistency of the return codes.
>
> In the suspend tests, a high-priority thread is created on each core
> and uses low-level cpuidle functionalities to enter suspend, in all
> the possible states and multiple times. This should allow a maximum
> number of CPUs to enter the same sleep state at the same or slightly
> different time.

Since you're doing it multiple times, it might be useful to track the
actual time it takes to suspend and wakeup, and possibly even warn
if the time is longer than the target_residency.  This could catch
poorly configured idle states.

Kevin
