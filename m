From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sat, 19 Nov 2011 15:11:54 +0000
Subject: ARM SWP/SWPB emulation support
In-Reply-To: <4EC6E87A.4070501@codeaurora.org>
References: <4EC6E87A.4070501@codeaurora.org>
Message-ID: <CAHkRjk6Ynfh9+UbTuAtyiXCOF-yDbTNxi0ikF5ttwHViisZRZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 November 2011 23:21, Stepan Moskovchenko <stepanm@codeaurora.org> wrote:
> I have two questions regarding the following patch:
>
> commit 64d2dc384e41e2b7acead6804593ddaaf8aad8e1
> Author: Leif Lindholm<leif.lindholm@arm.com>
> Date: ? Thu Sep 16 18:00:47 2010 +0100
> ARM: 6396/1: Add SWP/SWPB emulation for ARMv7 processors
>
> First, the Kconfig text for the patch says the following:
>
> ?"In some older versions of glibc [<=2.8] SWP is used during futex
> ?trylock() operations with the assumption that the code will not
> ?be preempted. This invalid assumption may be more likely to fail
> ?with SWP emulation enabled, leading to deadlock of the user
> ?application."
>
> I see that the SWP emulation is done using LDREX / STREX instructions, so it
> looks like the SWP emulation should happen in an atomic manner with respect
> to
> loading the previous value at the address being swapped with, and storing
> the
> new value. Does this text simply imply that the old glibc implementation of
> futex trylock() is incorrect in the specific way it uses SWP instructions,
> or
> does it mean that there is a specific atomicity problem within the SWP
> emulation
> code itself?

The old glibc code assumes that a code sequence that includes SWP is
atomic, not that the SWP instruction itself is atomic. It works as
long as there is no interrupt during that sequence. With the SWP
emulation, the SWP instruction traps into the kernel and the atomicity
is automatically broken (Linux may reschedule a different task). The
SWP emulation in the kernel provides an atomic implementation of SWP
using LDREX/STREX (though only in relation to other CPUs in the inner
shareable domain, it doesn't do bus locking to be used with devices).

> Second, I noticed that the SWP emulation code does not look at the condition
> code for the SWP instruction being emulated.

Leif is just looking at this and should post a patch probably next
week (it was already spotted by someone else).

-- 
Catalin
