From: anup@brainfault.org (Anup Patel)
Date: Fri, 6 Sep 2013 15:39:09 +0530
Subject: [RFC PATCH 0/3] Target CPU=Host implementation for KVM ARM/ARM64
In-Reply-To: <20130906090623.GA30450@mudshark.cambridge.arm.com>
References: <1378392362-6773-1-git-send-email-anup.patel@linaro.org>
 <CAFEAcA8z+_N3UQ-RQW9u65BpGRs+aKzhr2O34yOX0DhKZCAqRg@mail.gmail.com>
 <CAAhSdy1Qyum=v3_80SvGB3rKUP_Nxqg7858Uzf4QKdQd4YvzBA@mail.gmail.com>
 <BB11B00E-5EBD-45F5-89C7-7973919F7184@suse.de>
 <20130906090623.GA30450@mudshark.cambridge.arm.com>
Message-ID: <CAAhSdy1ERuXR36m4eOfYkq_oe_tNobmAe=Y4zQTxQjW5GOTh7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 6, 2013 at 2:36 PM, Will Deacon <will.deacon@arm.com> wrote:
> On Fri, Sep 06, 2013 at 09:54:23AM +0100, Alexander Graf wrote:
>>
>> On 06.09.2013, at 09:44, Anup Patel wrote:
>>
>> > On Thu, Sep 5, 2013 at 8:21 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
>> >> On 5 September 2013 15:45, Anup Patel <anup.patel@linaro.org> wrote:
>> >>> It will be very useful for user space if it has a method for specifying
>> >>> KVM ARM/ARM64 to give a VCPU with target type suitable to underlying host
>> >>> but with particular set of features.
>> >>>
>> >>> In other words, user space might not be interested in having a particular
>> >>> target type for VCPU but it will certainely want particular set of features
>> >>> in the VCPU.
>> >>>
>> >>> The patch tries to implement above described method of specifying VCPU
>> >>> target CPU=Host from user space by extending the KVM_ARM_VCPU_INIT ioctl
>> >>> and having a dummy target KVM_ARM_TARGET_HOST which means Target CPU
>> >>> same as (or suitable to) underlying host.
>> >>
>> >> I thought the consensus on the call last week was
>> >> to have an ioctl for "get best CPU for this host"
>> >> and then for userspace to pass that value to
>> >> VCPU_INIT ?
>> >
>> > I had considered having a separate ioctl for "get best CPU for this host"
>> > (as per KVM call minutes) but the same thing is possible with existing
>> > KVM_ARM_VCPU_INIT so why not extend this ioctl. Also, I was finding
>>
>> Because it means that everything as of the INIT call is reproducible by user space. There is no way the kernel can do magic behind our back to create a vcpu that user space couldn't create the same way on a different host when you want to live migrate.
>>
>> > it hard to come up with a use case where having a separate ioctl for
>> > "get best CPU for this host" would be better for user space.
>>
>> It can store it and migrate it as part of its migration protocol (probably hard for QEMU's current work flow, but that's QEMU's issue).
>
> It's also better from the point of view of devicetree generation. For
> example, kvmtool needs to generate the correct architected timer interrupt
> numbers for the target CPU, so munging this into KVM_ARM_VCPU_INIT means we
> have to go off and figure out the host CPU separately anyway.

Please look at the patch carefully we are returning VCPU
target type back to user space so, you can generate correct
architected timer interrupt numbers for the target CPU.

In fact, you will be able to generate complete DTB for the
Guest based on the VCPU target type returned by KVM.

For your reference also look at the KVMTOOL patch that I
have attached in my previous reply.

>
> Will

--Anup
