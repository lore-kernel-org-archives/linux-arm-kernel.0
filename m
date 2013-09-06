From: anup@brainfault.org (Anup Patel)
Date: Fri, 6 Sep 2013 13:14:23 +0530
Subject: [RFC PATCH 0/3] Target CPU=Host implementation for KVM ARM/ARM64
In-Reply-To: <CAFEAcA8z+_N3UQ-RQW9u65BpGRs+aKzhr2O34yOX0DhKZCAqRg@mail.gmail.com>
References: <1378392362-6773-1-git-send-email-anup.patel@linaro.org>
 <CAFEAcA8z+_N3UQ-RQW9u65BpGRs+aKzhr2O34yOX0DhKZCAqRg@mail.gmail.com>
Message-ID: <CAAhSdy1Qyum=v3_80SvGB3rKUP_Nxqg7858Uzf4QKdQd4YvzBA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 5, 2013 at 8:21 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 5 September 2013 15:45, Anup Patel <anup.patel@linaro.org> wrote:
>> It will be very useful for user space if it has a method for specifying
>> KVM ARM/ARM64 to give a VCPU with target type suitable to underlying host
>> but with particular set of features.
>>
>> In other words, user space might not be interested in having a particular
>> target type for VCPU but it will certainely want particular set of features
>> in the VCPU.
>>
>> The patch tries to implement above described method of specifying VCPU
>> target CPU=Host from user space by extending the KVM_ARM_VCPU_INIT ioctl
>> and having a dummy target KVM_ARM_TARGET_HOST which means Target CPU
>> same as (or suitable to) underlying host.
>
> I thought the consensus on the call last week was
> to have an ioctl for "get best CPU for this host"
> and then for userspace to pass that value to
> VCPU_INIT ?

I had considered having a separate ioctl for "get best CPU for this host"
(as per KVM call minutes) but the same thing is possible with existing
KVM_ARM_VCPU_INIT so why not extend this ioctl. Also, I was finding
it hard to come up with a use case where having a separate ioctl for
"get best CPU for this host" would be better for user space.

Further, the approach proposed by this patch also makes the
KVM_ARM_VCPU_INIT ioctl inline with what we do for KVM x86 that is
provide only a set of features user space wish and KVM x86 will try to
provide most of those features with a virtual CPU suitable to host.

Another advantage I saw in extending KVM_ARM_VCPU_INIT ioctl is
backward compatibility with current semantics. In other words, this patch
does not break current KVMTOOL/QEMU and they can implement
"-cpu host" whenever they wish without using any additional ioctl.

PFA, KVMTOOL patch which I used to test KVM_ARM_TARGET_HOST.

>
> -- PMM
> _______________________________________________
> kvmarm mailing list
> kvmarm at lists.cs.columbia.edu
> https://lists.cs.columbia.edu/cucslists/listinfo/kvmarm

--Anup
-------------- next part --------------
A non-text attachment was scrubbed...
Name: kvmtool_cpu_host.patch
Type: application/octet-stream
Size: 1377 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130906/da5336f0/attachment.obj>
