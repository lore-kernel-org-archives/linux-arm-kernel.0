From: will.deacon@arm.com (Will Deacon)
Date: Thu, 15 Nov 2012 21:18:33 +0000
Subject: [RFC PATCH 3.7.0-rc4] ARM:smp: introduce smp_notify_cpu_stop to
 fix kexec smp case
In-Reply-To: <1353003478-22291-1-git-send-email-srinivas.kandagatla@st.com>
References: <1353003478-22291-1-git-send-email-srinivas.kandagatla@st.com>
Message-ID: <20121115211833.GD13998@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, Nov 15, 2012 at 06:17:58PM +0000, Srinivas KANDAGATLA wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@st.com>
> 
> Use-case is simple kexec on smp system.
> 
> Lets say there are two cores core-0 and core-1.
> 
> sequence here is:
> As part of kexec call, the secondary cores are stopped by calling
> machine_shutdown(), which in turn issues IPIs to off-line the other CPUs
> and then call smp_ops.cpu_kill.
> 
> machine_shutdown invokes smp_send_stop from core-0 which then sends
> IPI_CPU_STOP ipi message for core-1 and then smp_kill_cpus call
> smp_ops.cpu_kill from core-0 with cpu=1.
> 
> The expectation here is that cpu_kill will relocate secondary-core
> to safe location from primary-core(core-0).

Not quite. The expectation is actually that you wiggle a line to a power
controller and the secondary core either disappears or resets.

> This is a catch 22 situation for SOCs, which can't change PC's of other
> cores. At the point when cpu_kill is invoked, it cant execute any
> function calls for core-1, as it is off-line and is spinning in
> cpu_relax.

I thought these SoCs were fairly rare in production -- usually there is
some way to power down secondary cores.

> So the only way is to put the core into safe place by executing some
> SOC specific relocation code.
> 
> Having a callback from ipi handler when cpu is stopped would be very
> usefull for SOC's which want to relocate the secondary-core to safe
> location.

I thought about this for Versatile Express but even if you do that, your
problems are just beginning. The bigger issue is co-ordinating with the
secondaries so you know when they're safely out of the way and you can
proceed with the kexec. Remember that you won't have working locks and you
can't cross-call a function because it won't actually return.

If you can solve the synchronisation problem then we can think about adding
these hooks.

Will
