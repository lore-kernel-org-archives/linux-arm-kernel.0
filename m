From: will.deacon@arm.com (Will Deacon)
Date: Fri, 17 Feb 2017 17:16:34 +0000
Subject: [RFC PATCH v3 00/11] arm64: Add a compat vDSO
In-Reply-To: <20161206160353.14581-1-kevin.brodsky@arm.com>
References: <20161206160353.14581-1-kevin.brodsky@arm.com>
Message-ID: <20170217171634.GM15431@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 06, 2016 at 04:03:42PM +0000, Kevin Brodsky wrote:
> Hi,

Hi Kevin,

> This series adds support for a compat (AArch32) vDSO, providing two
> userspace functionalities to compat processes:
> 
> * "Virtual" time syscalls (gettimeofday and clock_gettime). The
>   implementation is an adaptation of the arm vDSO (vgettimeofday.c),
>   sharing the data page with the 64-bit vDSO.
> 
> * sigreturn trampolines, following the example of the 64-bit vDSO
>   (sigreturn.S), but slightly more complicated because we provide A32
>   and T32 variants for both sigreturn and rt_sigreturn, and appropriate
>   arm-specific unwinding directives.
> 
> The first point brings the performance improvement expected of a vDSO,
> by implementing time syscalls directly in userspace. The second point
> allows to provide unwinding information for sigreturn trampolines,
> achieving feature parity with the trampolines provided by glibc.
> 
> Unfortunately, this time we cannot escape using a 32-bit toolchain. To
> build the compat VDSO, CONFIG_COMPAT_VDSO must be set *and*
> CROSS_COMPILE_ARM32 must be defined to the prefix of a 32-bit compiler.
> Failure to do so will not prevent building the kernel, but a warning
> will be printed and the compat vDSO will not be built.
> 
> v3 is a major refactor of the series. The main change is that the kuser
> helpers are no longer mutually exclusive with the 32-bit vDSO, and can
> be disabled independently of the 32-bit vDSO (they are kept enabled by
> default). To this end, the "old" sigreturn trampolines have been moved
> out of the [vectors] page into an independent [sigreturn] page, similar
> to [sigpage] on arm. The [vectors] page is now [kuserhelpers], and its
> presence is controlled by CONFIG_KUSER_HELPERS. The [sigreturn] page is
> only present when the 32-bit vDSO is not included (the latter provides
> its own sigreturn trampolines with unwinding information). The following
> table summarises which pages are now added in 32-bit processes:
> 
> +----------------+----------------+----------------+
> |     CONFIG     | !VDSO32        | VDSO32         |
> +----------------+----------------+----------------+
> | !KUSER_HELPERS | [sigreturn]    | [vvar]         |
> |                |                | [vdso]         |
> +----------------+----------------+----------------+
> | KUSER_HELPERS  | [sigreturn]    | [vvar]         |
> |                | [kuserhelpers] | [vdso]         |
> |                |                | [kuserhelpers] |
> +----------------+----------------+----------------+

Why is this different to arch/arm/? The idea of the COMPAT layer is to
do the same thing as arch/arm, so we should use [sigpage] and [vectors]
instead of [sigreturn] and [kuserhelpers]. I also think that the /proc/maps
code assumes the "gate vma" is at the end, but that's more of a niggle
than anything else.

The big issue with this series is that I share Nathan's concerns that we're
needlessly forking code from arch/arm/, without a commitment to follow up
with the refactoring effort.  So, whilst I can see that technically this is
looking pretty solid, it's a big ask to merge this into mainline as-is.

Will
