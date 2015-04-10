From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 10 Apr 2015 10:11:43 +0100
Subject: [RFC PATCH] arm64: KVM: remove fpsimd save/restore from the world
 switch
In-Reply-To: <55278CAD.70302@redhat.com>
References: <1428598439-5217-1-git-send-email-marc.zyngier@arm.com>
 <55278CAD.70302@redhat.com>
Message-ID: <552793CF.8050904@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/04/15 09:41, Paolo Bonzini wrote:

Hi Paolo,

> On 09/04/2015 18:53, Marc Zyngier wrote:
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
>> vcpu_load/vcpu_put).
> 
> Good idea!  Does ARM have a way to do "lazy" save/restore?  On x86 we
> know if the FP/SIMD state was in use on the host, and we can force an
> exit the first time the guest uses the FP/SIMD.
> 
> On ARM, it wouldn't be a problem to handle this kind of exit straight in
> EL2 (similar to the hack Ard used when playing with memory attributes).

We already do this on the 32bit port, and it works fine.

I did some experimentations on arm64 a long while ago (see the
kvm-arm64/lazy-fp branch in my tree), and it wasn't that great,
apparently because aarch64 userspace tends to be much more FP happy than
aarch32, but I'm not completely sure about it. Also this is from a time
when I didn't have much HW to play with...

Maybe I should resurrect it and compare it to what this patch does, just
as a comparison point.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
