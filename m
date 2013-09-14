From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat, 14 Sep 2013 13:13:59 +0100
Subject: [PATCH] arm64: KVM: Increase max VCPUs per-Guest to 8
In-Reply-To: <20130914115847.GB2596@hawk.usersys.redhat.com>
References: <1378904552-29347-1-git-send-email-anup.patel@linaro.org>
 <52330943.4090309@arm.com> <20130914115847.GB2596@hawk.usersys.redhat.com>
Message-ID: <0a4061dc01decc669fcdfaffeb2b2ed1@www.loen.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013-09-14 12:58, Andrew Jones wrote:
> On Fri, Sep 13, 2013 at 01:46:59PM +0100, Marc Zyngier wrote:
>> On 11/09/13 14:02, Anup Patel wrote:
>> > Current max VCPUs per-Guest is set to 4 which is preventing
>> > us from creating a Guest (or VM) with 8 VCPUs on Host (e.g.
>> > X-Gene Storm SOC) with 8 Host CPUs.
>> >
>> > The correct value of max VCPUs per-Guest should be same as
>> > the max CPUs supported by GICv2 which is 8 hence this patch
>> > increases KVM_MAX_VCPUS to 8.
>>
>> If anything, please make it configurable just like we have on 32bit. 
>> No
>> reason to impose the extra overhead on everyone.
>
> What type of overhead are we talking about? Memory, right? as

Memory indeed.

> kvm_for_each_vcpu is almost always used when iterating. But Anup says 
> in
> his v2 of this patch "can make things slower". If it's memory, then 
> is so
> much consumed by each vcpu that we shouldn't always set KVM_MAX_VCPUS

Not only. See how the GIC emulation also has per-VCPU data, and this 
results in potentially huge data structures. I have plans to address 
this in the future though.

> to at least the highest number that current hardware supports? 
> Particularly
> for aarch64 I think we should always be considering multi-platform 
> with the
> kernel configs.

What do you mean by multiplatform? This constant has nothing to do with 
being multiplatform, and the initial commit message was quite misleading 
in this respect. You can perfectly have 8 VCPUs on a single CPU host, 
and nothing so far impacts multiplatform.

The limit of 8 VCPUs has to do with a GICv2 limitation, which we 
emulate for the guest. Once we'll have GICv3 support in the kernel, this 
limit will be lifted.

         M.
-- 
Fast, cheap, reliable. Pick two.
