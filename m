From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 8 Feb 2018 12:26:35 +0000
Subject: [PATCH v2 17/20] arm64: bp hardening: Allow late CPUs to enable
 work around
In-Reply-To: <b4705fa2-39aa-9fea-78c4-03ac5eb48a49@arm.com>
References: <20180131182807.32134-1-suzuki.poulose@arm.com>
 <20180131182807.32134-18-suzuki.poulose@arm.com>
 <20180207103942.GH5862@e103592.cambridge.arm.com>
 <b4705fa2-39aa-9fea-78c4-03ac5eb48a49@arm.com>
Message-ID: <bea7947f-79e1-53e5-30ec-3f28bda46e5a@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/02/18 12:19, Suzuki K Poulose wrote:
> On 07/02/18 10:39, Dave Martin wrote:
>> On Wed, Jan 31, 2018 at 06:28:04PM +0000, Suzuki K Poulose wrote:
>>> We defend against branch predictor training based exploits by
>>> taking specific actions (based on the CPU model) to invalidate
>>> the Branch predictor buffer (BPB). This is implemented by per-CPU
>>> ptr, which installs the specific actions for the CPU model.
>>>
>>> The core code can handle the following cases where:
>>>   1) some CPUs doesn't need any work around
>>>   2) a CPU can install the work around, when it is brought up,
>>>      irrespective of how late that happens.
> 
> With the recent patches from Marc to expose this information to KVM
> guests, it looks like allowing a late CPU to turn this on is not going
> to be a good idea. We unconditionally set the capability even
> when we don't need the mitigation. So I am not really sure if
> we should go ahead with this patch. I am open to suggestions
> 
> Marc,
> 
> What do you think ?

By the time we bring in that CPU that requires some level of mitigation,
we may be running a guest already, and we've told that guest that no
mitigation was required. If we bring in that CPU, we break that promise,
and the guest becomes vulnerable without knowing about it.

The same thing is valid for userspace once we expose the status of the
mitigation in /sys, just like x86 does. If we transition from not
vulnerable to vulnerable (or even mitigated), we have lied to userspace.

In either case, I don't think breaking this contract is acceptable.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
