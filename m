From: Haibo.Xu@arm.com (Haibo Xu (Arm Technology China))
Date: Tue, 16 Oct 2018 02:54:20 +0000
Subject: =?utf-8?B?562U5aSNOiDnrZTlpI06IFtQQVRDSF0gYXJtNjQvcHRyYWNlOiBhZGQgUFRS?=
 =?utf-8?B?QUNFX1NZU0VNVSBhbmQgUFRSQUNFX1NZU0VNVV9TSU5HTEVTVEVQIHN1cHBv?=
 =?utf-8?Q?rt?=
In-Reply-To: <3641125.aEYyuDiOni@blindfold>
References: <20180903062310.GA4524@haibo-VirtualBox>
 <20180903165726.GJ6954@arm.com>
 <AM4PR08MB29297B27FCC0E8696473523185030@AM4PR08MB2929.eurprd08.prod.outlook.com>
 <3641125.aEYyuDiOni@blindfold>
Message-ID: <AM4PR08MB2929E6207681A78C615C174085FE0@AM4PR08MB2929.eurprd08.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 05, 2018 at 03:45:51AM +0200, Richard Weinberger wrote:
> Am Dienstag, 4. September 2018, 04:11:07 CEST schrieb Haibo Xu (Arm Technology China):
> > Hi Richard,
> >
> > What do you mean by done it in the core? moving macro definition to include/uapi/linux/ptrace.h?
> >The patch is strictly follow x86's sematic on PTRACE_SYSEMU/SINGLESTEP support.
>
> Well, the feature itself is not really architecture specific.
> Just because x86 does it in arch/x86, it does not mean that this is the best way.
> I guess this is also what Will tried to say.
> If we can, we should implement PTRACE_SYSEMU in the core ptrace code and not per architecture.
>

After re-evaluating the workload to unify the PTRACE_SYSEMU in the core ptrace code on both ARM and x86 architecture,
We think we are not able to work on it recently(we only have 1.5 person work on the Gvisor project).

> > > > I wonder what Haibo Xu want to do with PTRACE_SYSEMU on arm64.
> > > > Are you porting UML or gvisor to arm64?
> > >
> > > That's a good question. Haibo?
> >
> > The story is we are working on a container runtime(Google Gvisor)
> > support on ARM64 platform, and the Gvisor depend on Linux kernel PTRACE_SYSEMU/SINGLESTEP support.
>
> Gvisor also supports a kvm backend which should be *much* faster than PTRACE_SYSEMU.
> Otherwise gvisor suffers from the same performance drawbacks as UML does.
> Pagefaults via SIGSEGV/mmap, syscall gate via ptrace().
>
> Did you check, is PTRACE_SYSEMU really the way to go for gvisor?
> Last time I checked the KVM backend looked promising but still WIP, though.
>

Gvisor do support two platforms, ptrace and kvm. To support ptrace platform on ARM64 is our first step.
>From the long run, KVM would be a better choice, and we will work on it after ptrace platform get worked.

Currently,  our initial patches for Gvisor ARM64 support are ready for the small "hello-world" container
(please refer to the attachment for the test logs),  and we are in the process of upstreaming the code.
Could you help merge this patch to the Linux kernel for the time being?  We can reschedule the resource
to unify the overall Ptrace codes in the kernel late.

> I also wonder whether PTRACE_SYSEMU is really the only missing bit to support gvisor on arm64. Did you check how to work around VIPT/VIVT caching issues?
> UML (and gvisor in this context) have lots of implicit x86 dependencies.

As far as we know,  PTRACE_SYSEMU is the only missing bit that needed in Linux kernel to support Gvisor ptrace platform on ARM64.

Thanks,

Haibo

-----????-----
???: Richard Weinberger <richard@nod.at>
????: 2018?9?5? 3:45
???: Haibo Xu (Arm Technology China) <Haibo.Xu@arm.com>
??: Will Deacon <Will.Deacon@arm.com>; Catalin Marinas <Catalin.Marinas@arm.com>; linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org; nd <nd@arm.com>; jdike at addtoit.com
??: Re: ??: [PATCH] arm64/ptrace: add PTRACE_SYSEMU and PTRACE_SYSEMU_SINGLESTEP support

Am Dienstag, 4. September 2018, 04:11:07 CEST schrieb Haibo Xu (Arm Technology China):
> Hi Richard,
>
> What do you mean by done it in the core? moving macro definition to include/uapi/linux/ptrace.h?
> The patch is strictly follow x86's sematic on PTRACE_SYSEMU/SINGLESTEP support.

Well, the feature itself is not really architecture specific.
Just because x86 does it in arch/x86, it does not mean that this is the best way.
I guess this is also what Will tried to say.
If we can, we should implement PTRACE_SYSEMU in the core ptrace code and not per architecture.

> > > I wonder what Haibo Xu want to do with PTRACE_SYSEMU on arm64.
> > > Are you porting UML or gvisor to arm64?
> >
> > That's a good question. Haibo?
>
> The story is we are working on a container runtime(Google Gvisor)
> support on ARM64 platform, and the Gvisor depend on Linux kernel PTRACE_SYSEMU/SINGLESTEP support.

Gvisor also supports a kvm backend which should be *much* faster than PTRACE_SYSEMU.
Otherwise gvisor suffers from the same performance drawbacks as UML does.
Pagefaults via SIGSEGV/mmap, syscall gate via ptrace().

Did you check, is PTRACE_SYSEMU really the way to go for gvisor?
Last time I checked the KVM backend looked promising but still WIP, though.

I also wonder whether PTRACE_SYSEMU is really the only missing bit to support gvisor on arm64. Did you check how to work around VIPT/VIVT caching issues?
UML (and gvisor in this context) have lots of implicit x86 dependencies.

Thanks,
//richard


IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: Gvisor logs.txt
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181016/1484729a/attachment-0001.txt>
