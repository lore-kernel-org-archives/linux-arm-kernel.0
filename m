From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 01 Apr 2015 16:29:38 +0100
Subject: [RFC PATCH 0/7] Pseudo-NMI for arm64 using ICC_PMR_EL1 (GICv3)
In-Reply-To: <20150401151541.GC3602@e103592.cambridge.arm.com>
References: <1426688428-3150-1-git-send-email-daniel.thompson@linaro.org>
 <20150320154544.GC4725@e103592.cambridge.arm.com>
 <55105FD9.5010909@linaro.org>
 <20150401151541.GC3602@e103592.cambridge.arm.com>
Message-ID: <551C0EE2.2040800@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/04/15 16:15, Dave P Martin wrote:
> Apologies for the slow reply... :/
> 
> Anyway,
> 
> On Mon, Mar 23, 2015 at 06:47:53PM +0000, Daniel Thompson wrote:
>> On 20/03/15 15:45, Dave Martin wrote:
>>> On Wed, Mar 18, 2015 at 02:20:21PM +0000, Daniel Thompson wrote:
>>>> This patchset provides a pseudo-NMI for arm64 kernels by reimplementing
>>>> the irqflags macros to modify the GIC PMR (the priority mask register is
>>>> accessible as a system register on GICv3 and later) rather than the
>>>> PSR. The pseudo-NMI changes are support by a prototype implementation of
>>>> arch_trigger_all_cpu_backtrace that allows the new code to be exercised.
> 
> Minor nit: the "pseudo NMI" terminology could lead to confusion if
> something more closely resembling a real NMI comes along.
> 
> I'll have to have a think, but nothing comes to mind right now...
> 
> [...]
> 
>>>>  3. Requires GICv3+ hardware together with firmware support to enable
>>>>     GICv3 features at EL3. If CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS is
>>>>     enabled the kernel will not boot on older hardware. It will be hard
>>>>     to diagnose because we will crash very early in the boot (i.e.
>>>>     before the call to start_kernel). Auto-detection might be possible
>>>>     but the performance and code size cost of adding conditional code to
>>>>     the irqflags macros probably makes it impractical. As such it may
>>>>     never be possible to remove this limitation (although it might be
>>>>     possible to find a way to survive long enough to panic and show the
>>>>     results on the console).
>>>
>>> This can (and should) be done via patching -- otherwise we risk breaking
>>> single kernel image for GICv2+v3.
>>
>> Do you mean real patching (hunting down all those inlines and
>> rewrite them) or simply implementing irqflags with an ops table? If
>> the former I didn't look at this because I didn't release we could
>> do that...
> 
> A generic patching framework was introduced by Andre Przywara in this
> patch:
> 
> e039ee4 arm64: add alternative runtime patching
> 
> I believe you should be able to use this to patch between DAIF and
> ICC_PMR accesses.
> 
> You should be able to find examples of this framework being used by
> grepping.  I've not played with it myself yet.

To follow-up on this, I have a few patches queued that use the runtime
patching code to deal with GICv3 in KVM:

http://thread.gmane.org/gmane.comp.emulators.kvm.arm.devel/616

The first few patches are already queued for v4.1, and the rest should
follow shortly after.

Cheers,

	M.
-- 
Jazz is not dead. It just smells funny...
