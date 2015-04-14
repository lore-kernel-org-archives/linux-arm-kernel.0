From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 14 Apr 2015 15:56:44 +0100
Subject: [PATCH v4 00/24] ILP32 for ARM64
In-Reply-To: <8EFB0EC5-969B-40B1-BF72-359D9CB76B3F@caviumnetworks.com>
References: <cover.1428953303.git.philipp.tomsich@theobroma-systems.com>
 <17844053.vZiPCu4un3@wuerfel>
 <6C99D1ED-37A9-4E68-A137-BF8F78720BFE@caviumnetworks.com>
 <3234795.e0Uq9k2nUp@wuerfel>
 <8EFB0EC5-969B-40B1-BF72-359D9CB76B3F@caviumnetworks.com>
Message-ID: <20150414145643.GE14546@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 14, 2015 at 11:51:54AM +0000, Pinski, Andrew wrote:
> > On Apr 14, 2015, at 4:15 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tuesday 14 April 2015 10:45:43 Pinski, Andrew wrote:
> >>> On Apr 14, 2015, at 3:08 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> >>> There are multiple ways of doing this:
> >>> 
> >>> a) separate syscall table for arm64: as you say, this is the current approach,
> >>>  and I'd like to avoid that too
> >>> b) add syscalls for ilp32 as additional numbers in the normal lp64 version of
> >>>  asm-generic/unistd.h, and share the binary tables between ilp32 and lp64
> >>>  on aarch64
> >>> c) change asm-generic/unistd.h to generate three possible tables: instead of
> >>>  just native (lp64 or ilp32 depending on the arch), compat (support for
> >>>  existing ilp32 binaries on some architectures, there would also be a
> >>>  "modern" ilp32 variant that is a mix of the two, as your table today
> >>> d) don't use the asm-generic/unistd.h table for aarch64-ilp32 at all, but instead
> >>>  reuse the table from arch/arm64/include/asm/unistd32.h
> >>> 
> >>> I think you are referring to approach b) or c) above, but my preferred one
> >>> would actually be d).
> >> 
> >> D is the worst of all 4 options in my mind. The reason is when a new syscall is
> >> added, then you have to update that file too.
> > 
> > I don't know what the miscommunication is here, but the advantage of d is
> > specifically that it is /less/ work to maintain: With the current approach,
> > each new syscall that gets added needs to be checked to see if the normal
> > aarch64 version works or if it needs another wrapper, while with d) we
> > get the update for free, because we follow exactly what aarch32 is doing.
> 
> More than that d won't work due to ucontext being different between
> aarch32 and aarch64.

This too, I forgot to mention it (unless we restrict ILP32 to only 15
registers, reduced FP bank; in summary, it won't work).

> Also this abi is about to be used in a product so any changes need to
> happen fast and need to thought out why making changes to it make
> senses.

This is not our problem really. It's been pretty quiet on the ILP32
front for the past 6 months or more and just because a product is going
to use it is not an argument to accept a long term ABI.

> Changing to use the aarch32 syscall #'s make less sense since this is
> not a legacy syscalls. 

That I agree. I'm fine with 32-bit only data structures but I really
want to stick to the asm-generic/unistd.h syscalls for new ABIs.

-- 
Catalin
