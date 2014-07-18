From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 18 Jul 2014 10:27:44 +0100
Subject: [PATCHv4 5/5] arm64: cpuinfo: print info for all CPUs
In-Reply-To: <20140717172858.GD4844@arm.com>
References: <1405524767-30220-6-git-send-email-mark.rutland@arm.com>
 <20140716155747.GR29414@arm.com>
 <CAFEAcA-_GawEimGS4q8=C7BK6gLzSA+xVSUtLFkUS5=Mf8syBw@mail.gmail.com>
 <53C7A980.8050601@arm.com> <20140717105415.GI21153@arm.com>
 <CAFEAcA8wZ9z8+0Q-2D_B3tkuQnksdWFeWEAadkHyB72oS6ae=A@mail.gmail.com>
 <20140717123533.GJ21153@arm.com>
 <CAFEAcA_ZXDDRycNVXmw1FSgRFiPgtB_2qqe-ioj91jMeBJR7PQ@mail.gmail.com>
 <20140717171058.GM18203@arm.com> <20140717172858.GD4844@arm.com>
Message-ID: <20140718092744.GA19850@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 17, 2014 at 06:28:58PM +0100, Will Deacon wrote:
> On Thu, Jul 17, 2014 at 06:10:58PM +0100, Catalin Marinas wrote:
> > On Thu, Jul 17, 2014 at 02:55:37PM +0100, Peter Maydell wrote:
> > > On 17 July 2014 13:35, Will Deacon <will.deacon@arm.com> wrote:
> > > > We're not denying the possibility of heterogeneity, we're trying to expose a
> > > > consistent view of the system to userspace. Differences between cores should
> > > > be dealt with by the kernel (e.g. IKS, HMP scheduling), not blindly
> > > > passed off to userspace.
> > > 
> > > On that basis, why report anything at all about invididual cores?
> > > Just have /proc/cpuinfo report "number of processors: 4" and
> > > no per-CPU information at all...
> > 
> > We lost a lot of time on this already (given the internal threads). So
> > my proposal is to go ahead with Mark's patch with per-CPU features. They
> > currently just include the same elf_hwcap multiple times. If we ever
> > need to present different features, the conditions would be:
> > 
> > 1. Never report more than elf_hwcap
> > 2. elf_hwcap can only include non-symmetric features *if* Linux gets a
> >    way to transparently handle migration or emulation
> 
> ... making the point of a per-cpu field entirely pointless ;)

Well, if we can support such features in a transparent way,
/proc/cpuinfo becomes more informative (e.g. user wondering why a
process runs only on certain CPUs).

But to be clear (and I think we are aligned), I don't trust user space
to parse all processors in /proc/cpuinfo and make an informed selection
of CPU affinity to avoid SIGILL.

Yet another option would be to have a single features/hwcap line and
present the extra features in a human (and only human) readable form
(e.g. some haiku that changes with every kernel release ;)).

-- 
Catalin
