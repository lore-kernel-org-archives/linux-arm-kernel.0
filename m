From: drjones@redhat.com (Andrew Jones)
Date: Sat, 14 Sep 2013 14:36:56 +0200
Subject: [PATCH] arm64: KVM: Increase max VCPUs per-Guest to 8
In-Reply-To: <0a4061dc01decc669fcdfaffeb2b2ed1@www.loen.fr>
References: <1378904552-29347-1-git-send-email-anup.patel@linaro.org>
 <52330943.4090309@arm.com>
 <20130914115847.GB2596@hawk.usersys.redhat.com>
 <0a4061dc01decc669fcdfaffeb2b2ed1@www.loen.fr>
Message-ID: <20130914123656.GD2596@hawk.usersys.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 14, 2013 at 01:13:59PM +0100, Marc Zyngier wrote:
> On 2013-09-14 12:58, Andrew Jones wrote:
> >On Fri, Sep 13, 2013 at 01:46:59PM +0100, Marc Zyngier wrote:
> >>On 11/09/13 14:02, Anup Patel wrote:
> >>> Current max VCPUs per-Guest is set to 4 which is preventing
> >>> us from creating a Guest (or VM) with 8 VCPUs on Host (e.g.
> >>> X-Gene Storm SOC) with 8 Host CPUs.
> >>>
> >>> The correct value of max VCPUs per-Guest should be same as
> >>> the max CPUs supported by GICv2 which is 8 hence this patch
> >>> increases KVM_MAX_VCPUS to 8.
> >>
> >>If anything, please make it configurable just like we have on
> >>32bit. No
> >>reason to impose the extra overhead on everyone.
> >
> >What type of overhead are we talking about? Memory, right? as
> 
> Memory indeed.
> 
> >kvm_for_each_vcpu is almost always used when iterating. But Anup
> >says in
> >his v2 of this patch "can make things slower". If it's memory,
> >then is so
> >much consumed by each vcpu that we shouldn't always set KVM_MAX_VCPUS
> 
> Not only. See how the GIC emulation also has per-VCPU data, and this
> results in potentially huge data structures. I have plans to address
> this in the future though.
> 
> >to at least the highest number that current hardware supports?
> >Particularly
> >for aarch64 I think we should always be considering multi-platform
> >with the
> >kernel configs.
> 
> What do you mean by multiplatform? This constant has nothing to do
> with being multiplatform, and the initial commit message was quite
> misleading in this respect. You can perfectly have 8 VCPUs on a
> single CPU host, and nothing so far impacts multiplatform.

I meant compile the kernel once, but still have it useful on multiple
hosts (some with 4 cpus, some with 8...). Of course with config option
that's still possible, just compile with CONFIG_KVM_MAX_VCPUS=8. So I
guess this is really more of a debate about what the default should be.
Considering the GIC code may be a bit of an over-consumer at the moment
and 8-cpu hosts may not be that widely deployed, then maybe 4 is the
better default right now?

drew
