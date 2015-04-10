From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 10 Apr 2015 10:36:40 +0100
Subject: [RFC PATCH] arm64: KVM: remove fpsimd save/restore from the world
 switch
In-Reply-To: <20150410091215.GC6186@cbox>
References: <1428598439-5217-1-git-send-email-marc.zyngier@arm.com>
 <20150410091215.GC6186@cbox>
Message-ID: <552799A8.1020307@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/04/15 10:12, Christoffer Dall wrote:
> On Thu, Apr 09, 2015 at 05:53:59PM +0100, Marc Zyngier wrote:
>> The world switch spends quite some time dealing with the FP/SIMD
>> registers, as the state is quite sizeable (32 128bit registers,
>> plus some crumbs on the side). We save/restore them on each
>> entry/exit, so that both the host and the guest always see
>> the state they expect.
>>
>> But let's face it: the host kernel doesn't care. It is the host
>> userspace that actually cares about FP. An obvious improvement is
>> to remove the save/restore from the world switch, and only perform
>> it when we're about to enter/exit the guest (by plugging it into
>> vcpu_load/vcpu_put). The effect is pretty spectacular when running
>> hackbench (which is the only benchmark worth looking at):
>>
> so the kernel never uses fp/simd registers for stuff like memcopies
> etc.?

It can, but wraps it with kernel_neon_begin/kernel_neon_end, which does
its own save-restore. And when we perform our own save/restore, we do it
with interrupts disabled so that the kernel cannot change the state
during that time.

> Can we also make a similar change for ARM on the 32-bit side?

We could, but it is worth evaluating how much better this is compared to
what we have already.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
