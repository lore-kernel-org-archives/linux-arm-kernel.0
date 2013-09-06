From: anup@brainfault.org (Anup Patel)
Date: Fri, 6 Sep 2013 15:35:45 +0530
Subject: [RFC PATCH 0/3] Target CPU=Host implementation for KVM ARM/ARM64
In-Reply-To: <BB11B00E-5EBD-45F5-89C7-7973919F7184@suse.de>
References: <1378392362-6773-1-git-send-email-anup.patel@linaro.org>
 <CAFEAcA8z+_N3UQ-RQW9u65BpGRs+aKzhr2O34yOX0DhKZCAqRg@mail.gmail.com>
 <CAAhSdy1Qyum=v3_80SvGB3rKUP_Nxqg7858Uzf4QKdQd4YvzBA@mail.gmail.com>
 <BB11B00E-5EBD-45F5-89C7-7973919F7184@suse.de>
Message-ID: <CAAhSdy1923zuSako480TTEoysZ6r_j9Z615=psQcQ8O=XyVeJQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 6, 2013 at 2:24 PM, Alexander Graf <agraf@suse.de> wrote:
>
> On 06.09.2013, at 09:44, Anup Patel wrote:
>
>> On Thu, Sep 5, 2013 at 8:21 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
>>> On 5 September 2013 15:45, Anup Patel <anup.patel@linaro.org> wrote:
>>>> It will be very useful for user space if it has a method for specifying
>>>> KVM ARM/ARM64 to give a VCPU with target type suitable to underlying host
>>>> but with particular set of features.
>>>>
>>>> In other words, user space might not be interested in having a particular
>>>> target type for VCPU but it will certainely want particular set of features
>>>> in the VCPU.
>>>>
>>>> The patch tries to implement above described method of specifying VCPU
>>>> target CPU=Host from user space by extending the KVM_ARM_VCPU_INIT ioctl
>>>> and having a dummy target KVM_ARM_TARGET_HOST which means Target CPU
>>>> same as (or suitable to) underlying host.
>>>
>>> I thought the consensus on the call last week was
>>> to have an ioctl for "get best CPU for this host"
>>> and then for userspace to pass that value to
>>> VCPU_INIT ?
>>
>> I had considered having a separate ioctl for "get best CPU for this host"
>> (as per KVM call minutes) but the same thing is possible with existing
>> KVM_ARM_VCPU_INIT so why not extend this ioctl. Also, I was finding
>
> Because it means that everything as of the INIT call is reproducible by user space. There is no way the kernel can do magic behind our back to create a vcpu that user space couldn't create the same way on a different host when you want to live migrate.

Yes, whatever we do in INIT call is still reproducible.

Also, the final VCPU target type and VCPU features are returned back to
the user space.

>
>> it hard to come up with a use case where having a separate ioctl for
>> "get best CPU for this host" would be better for user space.
>
> It can store it and migrate it as part of its migration protocol (probably hard for QEMU's current work flow, but that's QEMU's issue).

Please look at the patch carefully.

The patch makes KVM_ARM_VCPU_INIT ioctl bi-directional this means
we return the target of VCPU and features of VCPU back to user space.

>
>> Further, the approach proposed by this patch also makes the
>> KVM_ARM_VCPU_INIT ioctl inline with what we do for KVM x86 that is
>> provide only a set of features user space wish and KVM x86 will try to
>> provide most of those features with a virtual CPU suitable to host.
>
> I don't think you fully grasped how the x86 feature negotiation thing works :).

The feature negotiation implemented by this patch is as follows:
1. user space proposes a VCPU target type (or VCPU same as host) and
   VCPU features
2. KVM does the checking and determines appropriate VCPU target type
   and VCPU features
3. KVM returns VCPU target type and VCPU features back to user space

Now I am not x86 expert but the above scheme of feature negotiation is
generic enough.

>
>> Another advantage I saw in extending KVM_ARM_VCPU_INIT ioctl is
>> backward compatibility with current semantics. In other words, this patch
>> does not break current KVMTOOL/QEMU and they can implement
>> "-cpu host" whenever they wish without using any additional ioctl.
>
> It's the opposite actually. By making the ioctl parameter in/out direction you change the ioctl number, breaking the ABI, no?

Originally the ioctl was only "in" and so we are preserving the "in"
semantics. Thats why it is semantically backward compatible.

I have tested this patch with unmodified QEMU and KVMTOOL.

>
>
> Alex
>

--Anup
