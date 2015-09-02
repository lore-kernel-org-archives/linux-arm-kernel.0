From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 2 Sep 2015 18:11:58 +0100
Subject: [PATCHv2] ARM64: Add AT_ARM64_MIDR to the aux vector
In-Reply-To: <CA+=Sn1=27ibpBokqJj3vLZ7NsnovKRdq7mR22ReeJJya4ona-A@mail.gmail.com>
References: <1440873982-44062-1-git-send-email-apinski@cavium.com>
 <20150901163304.GC16430@leverpostej>
 <A9115CAF-0C57-4810-97F6-6245E7D0CE48@gmail.com>
 <4C8DD5E0-E1EA-40C6-B947-72189241023C@caviumnetworks.com>
 <20150901173043.GE16430@leverpostej>
 <9AA83792-C973-4642-88BA-3C59F23EB048@gmail.com>
 <20150901221254.5e08ab6e@i7>
 <8C837F8F-050A-45DD-882B-02E107EFD663@caviumnetworks.com>
 <20150902165752.782e75be@i7>
 <CA+=Sn1=27ibpBokqJj3vLZ7NsnovKRdq7mR22ReeJJya4ona-A@mail.gmail.com>
Message-ID: <20150902171157.GC25614@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 02, 2015 at 10:52:05PM +0800, Andrew Pinski wrote:
> On Wed, Sep 2, 2015 at 9:57 PM, Siarhei Siamashka <siarhei.siamashka@gmail.com> wrote:
[...]
> >> > On Wed, 2 Sep 2015 01:58:56 +0800 pinskia at gmail.com wrote:
> >> >> Yes but I guess you talk about caching the value in userspace but doing
> >> >> it via the aux vector is the same as your suggestion. Just one
> >> >> difference is you don't get the aux vector entry if there is a CPU
> >> >> that is online which is different. No difference from your suggestion
> >> >> of caching it. Without considering hot pug for a second (that is a
> >> >> huge different issue all together), if userland wants to know if all
> >> >> up CPUs have the same midr, they would either read /sys entries (lots
> >> >> of syscalls) or bind to each CPU and do the trap. That means at least
> >> >> three or two syscalls/traps for each CPU. My way is none and gets a
> >> >> value of midr if they are all the Same for free.

Whether we like it or not, big.LITTLE systems are present in the ARM
ecosystem. You are looking to add a specific AT_ to solve a particular
problem on fully symmetric systems, ignoring the rest. I want this fixed
for all systems rather than trying to invent something else for
big.LITTLE which won't help user space at all.

If you want to avoid parsing all /sys entries, I would rather have a
HWCAP_ASYMMETRIC bit for big.LITTLE systems and let user space decide
whether to read all entries or not.

> > I wonder if we still can try to make "sched_getcpu()" use vDSO
> > instead of the syscall to make it faster? Now that there exists a
> > vDSO implementation for gettimeofday(), everything should be easy if
> > we can find an unused userspace readable coprocessor register.
> > In the past, Catalin Marinas mentioned that "We have a user read-only
> > thread register unused on arm64":
> >     http://lists.infradead.org/pipermail/linux-arm-kernel/2013-December/220664.html

We have a patch under development internally, it will appear on the list
at some point.

> > And if I understand it correctly, also one of the "scratch registers"
> > should exist in 32-bit ARM, which "isn't present in ARMv8/AArch64":
> >     http://lists.infradead.org/pipermail/linux-arm-kernel/2013-December/221056.html
> > What kind of registers are these exactly?
> >
> > In principle, the aux vector can be extended to also contain a pointer
> > to an array of MIDR values for all the CPU cores if reducing the setup
> > overhead is critical.
> 
> That is not a bad idea.  Put this array in the data section of the
> VDSO too.  It should be small enough though on systems with 96 or more
> cores (dual socket ThunderX has 96 cores total), it is slightly
> getting big.
> The struct would be something like:
> struct
> {
>   int32 numcores;
>   int32 midr[];
> };

First of all, I'm against hard-coding (VDSO) data as ABI. So far we used
VDSO to override some weak glibc functions but the VDSO-specific data is
parsed by the VDSO function implementation and not directly by glibc (or
user space). I prefer helper functions that read the VDSO-internal data
structures.

Secondly, you seem to be only interested in MIDR_EL1 but we also have
REVIDR_EL1 and AIDR_EL1 which may be relevant. Once we realise that more
information is needed, it's not always clear where the boundaries are
so I would rather have this exposed via /sys and/or MRS emulation (there
are patches for both).

Anyway, you need to involve the toolchain people in such discussions,
they may have different needs (like ifunc).

-- 
Catalin
