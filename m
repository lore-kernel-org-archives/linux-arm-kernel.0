From: richard@nod.at (Richard Weinberger)
Date: Tue, 04 Sep 2018 21:45:06 +0200
Subject: =?UTF-8?B?562U5aSNOg==?= [PATCH] arm64/ptrace: add PTRACE_SYSEMU
 and PTRACE_SYSEMU_SINGLESTEP support
In-Reply-To: <AM4PR08MB29297B27FCC0E8696473523185030@AM4PR08MB2929.eurprd08.prod.outlook.com>
References: <20180903062310.GA4524@haibo-VirtualBox>
 <20180903165726.GJ6954@arm.com>
 <AM4PR08MB29297B27FCC0E8696473523185030@AM4PR08MB2929.eurprd08.prod.outlook.com>
Message-ID: <3641125.aEYyuDiOni@blindfold>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 4. September 2018, 04:11:07 CEST schrieb Haibo Xu (Arm Technology China):
> Hi Richard,
> 
> What do you mean by done it in the core? moving macro definition to include/uapi/linux/ptrace.h?
> The patch is strictly follow x86's sematic on PTRACE_SYSEMU/SINGLESTEP support.

Well, the feature itself is not really architecture specific.
Just because x86 does it in arch/x86, it does not mean that this is the best way.
I guess this is also what Will tried to say.
If we can, we should implement PTRACE_SYSEMU in the core ptrace code and not
per architecture.

> > > I wonder what Haibo Xu want to do with PTRACE_SYSEMU on arm64.
> > > Are you porting UML or gvisor to arm64?
> >
> > That's a good question. Haibo?
> 
> The story is we are working on a container runtime(Google Gvisor) support on ARM64 platform,
> and the Gvisor depend on Linux kernel PTRACE_SYSEMU/SINGLESTEP support.

Gvisor also supports a kvm backend which should be *much* faster than PTRACE_SYSEMU.
Otherwise gvisor suffers from the same performance drawbacks as UML does.
Pagefaults via SIGSEGV/mmap, syscall gate via ptrace().

Did you check, is PTRACE_SYSEMU really the way to go for gvisor?
Last time I checked the KVM backend looked promising but still WIP, though.

I also wonder whether PTRACE_SYSEMU is really the only missing bit to support
gvisor on arm64. Did you check how to work around VIPT/VIVT caching issues?
UML (and gvisor in this context) have lots of implicit x86 dependencies.

Thanks,
//richard
