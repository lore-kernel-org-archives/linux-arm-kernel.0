From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 21 Nov 2014 15:10:44 -0800
Subject: [RFC 0/2] Qualcomm RPM sleep states
In-Reply-To: <1415659966-16200-1-git-send-email-bjorn.andersson@sonymobile.com>
References: <1415659966-16200-1-git-send-email-bjorn.andersson@sonymobile.com>
Message-ID: <546FC674.1070005@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn,

On 11/10/2014 02:52 PM, Bjorn Andersson wrote:
> During the review of the Qualcomm SMD RPM regulators [1], I got (offline)
> feedback that my implementation did not handle "sleep states". As the problem
> is shared between all families of Qualcomm platforms I use [2] (family A) to
> propose a solution (as I hope to get that merged sooner).
>
> The "sleep states" comment boils down to certain regulators (or rpm resources
> in general) are used by the currently clocked/running CPU(s) and can not be
> disabled while we're still running. 

This is the first flaw in the argument. There are certain regulators
that are used to power the clocks for CPUs that can be disabled while
we're running as long as the CPUs aren't using these clocks. I'll
explain further down below.

> Further more, these resources are shared
> with peripherals in the system; e.g. LDO12 on PM8941 is used to clock the CPU
> and WiFi/BT PLLs as well as providing power to the display in our devices. So
> the suspend functionality in the regulator framework doesn't cut it.

Furthermore, we can trigger a transition to the sleep set during idle
paths so suspend definitely won't cut it.

>
>
> The downstream solution to this is to expose 3 regulators per regulator
> resource, each specified to control the active mode, sleep mode or both modes
> respectively. Peripherals are directed to use the "both" regulator while the
> CPUs are directed to the "active only" regulator.
>
> After reviewing this solution and looking at what it's actually achieving I
> here propose flagging these regulators to have "deferred disable";
> * we consider the specific regulators as always-on _while running_
> * hence, disable and enable affect only the sleep state
> * we update both active and sleep state with all other properties
>
> This gives us a single regulator exposed for the resource, that will be kept on
> with parameters as specified by the clients if it's referenced and upon loosing
> the last reference (disabling all consumers) it will be turned off when the
> CPU(s) are sleeping.
>
>
> As far as I can see this should give the same behaviour as we have downstream,
> without the need for playing tricks with how we expose the regulators. However
> there's plenty of details hidden in that code, so I hope to get some feedback
> from the Qualcomm engineers on this.

First some background. The Krait CPUs are clocked by dedicated per-cpu
PLLs and a global PLL. The dedicated per-cpu PLLs are supplied by a
regulator (actually a handful of them, but let's just assume one for the
sake of argument). When we go to suspend or idle we will turn off these
dedicated per-cpu PLLs and switch the CPUs to source off the global PLL.
The global PLL is also used as the lowest rate that the CPUs can run at.
We'd like to not communicate with the RPM unnecessarily during
idle/suspend to turn off these resources when we go idle/suspend because
it takes more time and thus more power.

So the CPU really wants to only be voting for the HFPLL regulator
supplies in the active set. This way, if we're not using the HFPLLs
(i.e. the CPUs are all running off the global PLL), then we can disable
the regulator in the active set (RPM code only caches sleep set so we
won't be doing unnecessary flushes in the idle/suspend path). The clock
driver will make sure to turn off the HFPLLs before we go into a sleep
state that would trigger a switch from active to sleep set (commonly
referred to as RPM notification). It very well could be that there are
other consumers of the same regulator, but that doesn't matter to the
CPU clock driver because it only cares about the active set. Now you may
ask why can't the CPU clock driver disable the regulator when the HFPLL
is disabled? We don't do that in this case because a) it causes more RPM
communication overhead and b) we will be in atomic context when the
HFPLL is disabled during idle/suspend and the regulator APIs are
sleeping calls. In the non-idle/suspend path we will disable the regulator.

Also the active/sleep sets are about more than just on/off state. We may
have a situation where the active set voltage (or some other attribute
like current, mode, etc.) is different than the sleep set voltage. For
example, the CPU is supplied by a digital logic regulator that is shared
with other digital logic in the SoC (GPU, wifi, etc.). The CPU may
require some high voltage, but the GPU only needs some lower voltage.
The suspend/idle code relies on the fact that the GPU is voting on the
active+sleep regulator while the CPU is voting on the active only
regulator so that the RPM can automatically switch between high voltage
and low voltage when the CPU notifies the RPM that it's gone idle (or
the CPU wakes up).

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
