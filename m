From: philipp.tomsich@theobroma-systems.com (Dr. Philipp Tomsich)
Date: Tue, 14 Apr 2015 00:58:59 +0200
Subject: [PATCH v4 00/24] ILP32 for ARM64
In-Reply-To: <2507322.zX46IY7aRK@wuerfel>
References: <cover.1428953303.git.philipp.tomsich@theobroma-systems.com>
 <2507322.zX46IY7aRK@wuerfel>
Message-ID: <332955D5-3122-437B-93A1-E1973BE09FCA@theobroma-systems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

> 1. Adding a whole new ABI to the kernel is adding a long-term maintenance
> burden, and we don't want to do that just because someone thinks it's a cute
> hack or because it might add a few percent in performance of some low-level
> benchmark. Please describe in the cover-letter for the patch series
> specifically what applications you have in mind that would be using this, and
> what the expected timeframe is before users could move to 64-bit user space.

There?s a couple of drivers behind getting ILP32 merged on ARM64:
(a) There?s plenty of applications (i.e. having a large code-base, but not requiring 
a 64bit address space) that can?t readily be migrated to LP64 (typically networking
or data-storage applications) because they were written assuming an ILP32 data
model.  Many of these applications will never become suitable for a LP64 data
model and will remain locked into ILP32 operating environments.
(b) A number of SPEC2006 components (i.e. not low-level benchmarks, but test
cases that have been derived from large application use cases) benefit from 
having a denser data-representation?this includes the mcf, xalancbmk, astar 
and  ometpp.  This not an observation specific to ARM64 and can be observed
on other architectures as well (e.g. [1] contains data for POWER from 2010).
(c) Using AArch32 (assuming that any given ARMv8 processor supports it),
is not a real alternative, as 64bit arithmetic is not supported on AArch32 and the
AArch32 register set is significantly smaller.  Our experience shows that the 
benefit of having 64bit registers, of a larger register file and of using 64bit 
arithmetic makes ILP32 a worthwhile improvement over AArch32.

In summary, we believe that the need for ILP32 will never disappear on ARM64.
In fact, I rather expect the AArch32 compatibility to eventually disapper from
further processor designs? which will turn ILP32 into the only option for 
legacy software.

> 2. The ABI follows what x86 has their "x32" ABI. This never saw a lot of
> adoption and in retrospect the decision to have separate system calls seems
> to not have helped them. My feeling now is that if we add support for the
> ARM64 ILP32 ELF ABI, we should better stick to the existing system call ABI
> as close as possible and reuse the existing system call table. I realize
> that this is a bit controversial, but please let's talk about this now.

I see benefits and drawback to merging the system tables.  Our philosophy is
already somewhat different from x32 and from the original patch-series, as you
can see from the changes dealing with stack_t in the ?sys_rt_sigreturn' and 
?setup_rt_frame? functions.  While these could have been duplicated and 
specialized for each ABI (as on x32), the attempt was made to keep these 
changes localized.

However, this approach can not always work: if you consider cases like 
?sys_msgsnd? and ?compat_sys_msgsnd?, there?s little to no benefit in having
just a ?aarch64_sys_msgsnd?, which then calls either the LP64 or the compat
version of the underlying system call.  Having a second system call table 
helps to reduce the overheads in this case and keeps things readable.

This comes down to the fact, that a few calls will always be different due to
historical baggage in data structures shared between userspace and kernel:
'struct msgbuf? immediatly comes to mind.

I would liken the situation with ARM64 more of MIPS64 with its 64bit ABI and 
its n32 ABI than to x32? but even there it?s two separate system call tables
(although sequentially concatenated).

In other words: I fail to see the benefit from keeping the existing table.
I you elaborate on how such a solution should look, I might be better able
to follow. 

> The most important aspect here I think is time_t, and while it means starting
> out with a system call ABI that is not ready for y2038, at the same time the
> purpose of ILP32 support is to support legacy source code that is not 64-bit
> safe now, and using 32-bit time_t will make that easier in a lot of ways.
> Note that I am also leading the effort to make 32-bit Linux ready for using
> 64-bit time_t on all architectures, so ARM64 ILP32 will be fixed as well, it
> just won't be any better or worse than the others.

The decision to use the 64bit time_t actually came out of Andrew?s earliest
patch-set from late 2013? we based the kernel-side of ILP32 on that one, while
we focussed on getting all the other components into a working shape.

Breaking the C specification (by redefining time_t) always remained a 
controversial issue on our end, as we knew that the day of switching back
to a 32-bit time_t would eventually have to come.


Cheers,
Phil.

[1] https://gcc.gnu.org/wiki/summit2010?action=AttachFile&do=get&target=meissner2.pdf
