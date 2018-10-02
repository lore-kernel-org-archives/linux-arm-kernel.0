From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 2 Oct 2018 11:00:57 +0100
Subject: RESEND and REBASE arm+arm64+aarch32 vdso rewrite
In-Reply-To: <8c09a380-7bc8-a353-aeb7-6591e6c57f68@android.com>
References: <20181001175845.168430-1-salyzyn@android.com>
 <CALAqxLWCbw0bmYeB9Vfi5wXJcnLRnE0TYxy1h5WkHLehHv8KFg@mail.gmail.com>
 <8c09a380-7bc8-a353-aeb7-6591e6c57f68@android.com>
Message-ID: <20181002100056.GA225812@arrakis.emea.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 01, 2018 at 01:44:52PM -0700, Mark Salyzyn wrote:
> On 10/01/2018 11:49 AM, John Stultz wrote:
> > On Mon, Oct 1, 2018 at 10:58 AM, Mark Salyzyn <salyzyn@android.com> wrote:
> > > Last sent 23 Nov 2016.
> > > 
> > > The following 23 patches are rebased and resent, and represent a
> > > rewrite of the arm and arm64 vDSO into C, adding support for arch32
> > > (32-bit user space hosted 64-bit kernels) and into a common library
> > > that other (arm, or non-arm) architectures may utilize.
> > So I feel like this has gone around a few times w/o much comment from
> > the arm/arm64 maintainers. I'm not sure if there's a reason?
> 
> I am "forming an opinion"(tm) that ARM is not interested in any work on 32
> bit arm architectures. They have no manpower that they are willing to devote
> to this.

Actually, we are interested in this work but, TBH, I find it a bit hard
to read your series and have postponed looking into it in detail. Just
look at the patch numbering/versioning for example:

> [PATCH v5 01/12] arm: vdso: rename vdso_datapage variables
> [PATCH v5 02/12] arm: vdso: add include file defining __get_datapage()
> [PATCH v5 03/12] arm: vdso: inline assembler operations to compiler.h
> [PATCH v5 04/12] arm: vdso: do calculations outside reader loops
> [PATCH v6 05/12] arm: vdso: Add support for CLOCK_MONOTONIC_RAW
> [PATCH v5 06/12] arm: vdso: add support for clock_getres
> [PATCH v5 07/12] arm: vdso: disable profiling
> [PATCH v5 08/12] arm: vdso: Add ARCH_CLOCK_FIXED_MASK
> [PATCH v5 09/12] arm: vdso: move vgettimeofday.c to lib/vdso/
> [PATCH v5 10/12] arm64: vdso: replace gettimeofday.S with global vgettimeofday.C
> [PATCH v6 11/12] lib: vdso: Add support for CLOCK_BOOTTIME
> [PATCH v5 12/12] lib: vdso: do not expose gettimeofday, if no arch supported timer
> [PATCH] lib: vdso: add support for time
> [PATCH v2 1/3] arm64: compat: Split the sigreturn trampolines and kuser helpers (C sources)
> [PATCH v2 2/3] arm64: compat: Split the sigreturn trampolines and kuser helpers (assembler sources)
> [PATCH v2 3/3] arm64: compat: Add CONFIG_KUSER_HELPERS
> [PATCH] arm64: compat: Expose offset to registers in sigframes
> [PATCH 1/6] arm64: compat: Use vDSO sigreturn trampolines if available
> [PATCH 2/6] arm64: elf: Set AT_SYSINFO_EHDR in compat processes
> [PATCH 3/6] arm64: Refactor vDSO init/setup
> [PATCH v2 4/6] arm64: compat: Add a 32-bit vDSO
> [PATCH 5/6] arm64: compat: 32-bit vDSO setup
> [PATCH 6/6] arm64: Wire up and expose the new compat vDSO

The above may look obvious to you as you've worked on it but not to
maintainers who have to read lots of other patchsets.

> Despite the gain of 0.4% for screen-on battery life, where Android has a mix
> of 64 and 32 bit applications, thus still relevant _today_ on 64 bit
> architectures (providing vDSO32 for 32-bit applications).

As Russell said, if that's the only gain, you may need other selling
points.

The main advantage I see is to avoid code duplication, hence a vdso
library that could be shared by arm/arm64/arm64-compat _and_ future or
existing architectures that need vdso support.

> ARM has complained that they want them all at one time because individually
> they represent more work. So the whole set is here ready to go.

Having five separate series without a clear dependency between them was
worse than the current numbering scheme ;).

Anyway, since I still think this series is important, some weeks ago I
assigned Vincenzo Frascino in my team the task of de-cluttering this
patchset and posting it to the list. So we may see a new series later
this month (and any feedback welcome).

-- 
Catalin
