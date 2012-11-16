From: srinivas.kandagatla@st.com (Srinivas KANDAGATLA)
Date: Fri, 16 Nov 2012 08:39:19 +0000
Subject: [RFC PATCH 3.7.0-rc4] ARM:smp: introduce smp_notify_cpu_stop
 to fix kexec smp case
In-Reply-To: <20121115211833.GD13998@mudshark.cambridge.arm.com>
References: <1353003478-22291-1-git-send-email-srinivas.kandagatla@st.com>
 <20121115211833.GD13998@mudshark.cambridge.arm.com>
Message-ID: <50A5FBB7.9040001@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/11/12 21:18, Will Deacon wrote:
> Hello,
>
> On Thu, Nov 15, 2012 at 06:17:58PM +0000, Srinivas KANDAGATLA wrote:
>> From: Srinivas Kandagatla <srinivas.kandagatla@st.com>
>>
>> Use-case is simple kexec on smp system.
>>
>> Lets say there are two cores core-0 and core-1.
>>
>> sequence here is:
>> As part of kexec call, the secondary cores are stopped by calling
>> machine_shutdown(), which in turn issues IPIs to off-line the other CPUs
>> and then call smp_ops.cpu_kill.
>>
>> machine_shutdown invokes smp_send_stop from core-0 which then sends
>> IPI_CPU_STOP ipi message for core-1 and then smp_kill_cpus call
>> smp_ops.cpu_kill from core-0 with cpu=1.
>>
>> The expectation here is that cpu_kill will relocate secondary-core
>> to safe location from primary-core(core-0).
> Not quite. The expectation is actually that you wiggle a line to a power
> controller and the secondary core either disappears or resets.
Ok, I got this.  But In our chips we can't control power/reset to
individual cores, reset is tied up to both the cores.

>
>> This is a catch 22 situation for SOCs, which can't change PC's of other
>> cores. At the point when cpu_kill is invoked, it cant execute any
>> function calls for core-1, as it is off-line and is spinning in
>> cpu_relax.
> I thought these SoCs were fairly rare in production -- usually there is
> some way to power down secondary cores.
We have at-least 3 chips of this category, and we are looking forward to
mainline the linux-support soon.
>
>> So the only way is to put the core into safe place by executing some
>> SOC specific relocation code.
>>
>> Having a callback from ipi handler when cpu is stopped would be very
>> usefull for SOC's which want to relocate the secondary-core to safe
>> location.
> I thought about this for Versatile Express but even if you do that, your
> problems are just beginning.
Ok, atleast some SOC has similar requirement.
>  The bigger issue is co-ordinating with the
> secondaries so you know when they're safely out of the way and you can
> proceed with the kexec. Remember that you won't have working locks and you
> can't cross-call a function because it won't actually return.
Yes I agree and understand the limitation.
The callback should simple and just relocate the secondary core to a
safe place which in our case is a holding pen, which is safe and not in
the system ram.
After the callback, the secondary core will be spinning in the holding
pen which will be released once they get a matching cpu-id.
And this approach works perfectly ok on our chips and I guess should
work for other chips aswell.
> If you can solve the synchronisation problem then we can think about adding
> these hooks.
I think the call back code should not do anything complex other than few
lines of assembly or jump to a holding pen, this way it does not need
any synchronization calls or system infrastructure.
Most of the SOCs in the current tree return 1 for cpu_kill callback, Am
not sure if they fit in this category.
I think adding the callback hook would also benefit other chips which
fit in this category.
??

Thanks,
srini

>
> Will
>
