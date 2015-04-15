From: philipp.tomsich@theobroma-systems.com (Dr. Philipp Tomsich)
Date: Wed, 15 Apr 2015 11:18:06 +0200
Subject: [PATCH v4 00/24] ILP32 for ARM64
In-Reply-To: <2947000.5TRODaJfhK@wuerfel>
References: <cover.1428953303.git.philipp.tomsich@theobroma-systems.com>
 <2069111.6po5Xr33Dn@wuerfel>
 <20150414150034.GF14546@e104818-lin.cambridge.arm.com>
 <2947000.5TRODaJfhK@wuerfel>
Message-ID: <025BB233-8D14-457A-B3B2-C6BD6C3B32EF@theobroma-systems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On 15 Apr 2015, at 00:28, Arnd Bergmann <arnd@arndb.de> wrote:
> 
> On Tuesday 14 April 2015 16:00:34 Catalin Marinas wrote:
>> On Tue, Apr 14, 2015 at 04:07:36PM +0200, Arnd Bergmann wrote:
>>> For completeness, there is yet another option, which would be to use the
>>> exact system call table from arm64 and do all the emulation in user space
>>> rather than the kernel. This would however be the least compatible with
>>> existing source code, so you probably don't want to do that.
>> 
>> It would be great if this worked but I think we looked at it before and
>> it seems nice until you hit the futex stuff and robust lists (I don't
>> fully remember the details). Some of the structures (siginfo) would no
>> longer be POSIX compliant and some of them aren't only accessed via libc
>> to be able to create shadow copies.
> 
> Well, that may or may not be acceptable. Aarch64-ilp32 mode is a hack to
> enable a very special class of applications, it's not like anyone would
> want to run a full system for this and need POSIX compliance.

I strongly disagree on this: ILP32 is a first-class citizen of the ARMv8 
ecosystem as a  ?data-model? for AArch64. Having a corresponding Linux 
syscall ABI is necessitated because not all data structures shared across
the syscall-boundary are describted/defined in data-model agnostic types.
ILP32 thus has the same importance as the LP64 ABI in ARMv8. It is thus 
neither a hack nor likely/expected to go away anytime soon.

We?ve run full systems (built from buildroot) consisting of ILP32 binaries
only (ok? admittedly gdb was an exception, as we haven?t fixed the fact
that someone has assumed sizeof(long) == 8 in some data-structure of
the AArch64 backend there) in our verification runs. In fact, it will be very 
special classes of applications that will need a 64bit address-space.

If anything, then backward-compatibility for ARMv7 binaries should be
considered a hack (although one that is performed in hardware).

> We could definitely be pragmatic and do whatever helps get the job
> done. That said, it diverges further from what legacy 32-bit applications
> expect to see, so this approach will likely make an application port harder,
> not easier.

The key question at this point seems to be whether we want to support
?legacy 32-bit applications? (i.e. ones that make assumption that are
not covered by the underlying type definitions or specifications) or whether
we aim for ?well-formed 32-bit applications?.

To stay with the 'struct timespec?-example, the difference between the 
former and the latter would (among others) be that the former might 
assume sizeof(long) == sizeof(time_t), whereas the latter is allowed to
except that sizeof(long) == sizeof(ts.tv_nsec).

I don?t believe in keeping compatibility for the former type of applications.
Consequently, I don?t necessarily see the value in defining ILP32 for
AArch64 with a 32bit time_t (even though it would be simpler at this 
moment), as I don?t see the benefit of adding a new ABI that propagates
a well known problem (even if one could argue that there?s plenty of time
to fix this by 2038).

Phil.
