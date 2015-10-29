From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 29 Oct 2015 12:22:51 +0900
Subject: [PATCH 0/3] Revert arm64 cache geometry
In-Reply-To: <1446068637-11509-1-git-send-email-avanbrunt@nvidia.com>
References: <1446068637-11509-1-git-send-email-avanbrunt@nvidia.com>
Message-ID: <CAKv+Gu-CgXU4O8SymcjmCYZqyAa0PZbJXwNqXfuCamxYY9C8GA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29 October 2015 at 06:43, Alex Van Brunt <avanbrunt@nvidia.com> wrote:
> This patchset reverts three patches that attempt to query the CPU for cache
> geometry and then make use of that information. Those patches rely on the
> NumSets and LineSize fields of CCSIDR to determine the cache geometry. However,
> the architectural documentation for these registers forbids such use:
>
>         The parameters NumSets, Associativity, and LineSize in these registers
>         define the architecturally visible parameters that are required for the
>         cache maintenance by Set/Way instructions. They are not guaranteed to
>         represent the actual microarchitectural features of a design. You cannot
>         make any inference about the actual sizes of caches based on these
>         parameters.
>
> It is not just theoretical. For example, the Denver CPU will report one set and
> one way in CCSIDR even though the actual microarchitectural implementation has
> many sets and many ways.
>

Fair enough. It is a bit disappointing that we cannot trust these
values, but if the architecture does not mandate their accuracy, we
obviously should not be using them in the way that we are.

I think we have similar code in the ARM tree, so we should probably
make some changes there as well.

> I have two suggestions for how to get the cache geometry on an ARMv8 processor:
>   1. Specify the information in the device tree. The purpose of the deivce tree
>      is to specify information that software cannot query at run-time. Becuase
>      the architecture does not have an architectural way to query the cache
>      geometry this may be a good fit.
>   2. Add a function pointer to cpu_table that gives a implementation specific
>      way to query the cache geometry. For an A57, for example, the function
>      could read the CCSIDR register because it happens to report the
>      microarchitectural geometry. The Denver CPU has implementation defined
>      registers that can be used to determine the microarchitectural geometry.
>      However, the implementation for the default "AArch64 Processor", must
>      return an error.
>
> The only place that the cache geometry is used is to determine if there can be
> aliasing for a VIPT (virtually-indexed, physically-tagged) instruction cache.
> The code assumes that there is no need to flush the entire instruction cache
> if the size of a cache set is less than or equal to a page size. However, the
> architectural definition of VIPT says "The only architecturally-guaranteed way
> to invalidate all aliases of a physical address from a VIPT instruction cache
> is to invalidate the entire instruction cache." Not only are the parameters not
> guaranteed to be correct, it is explicitly not legal to ignore aliasing even if
> the parameters were correct.
>

I understand that this is subject to interpretation, but I would argue
that this does not apply to the case where you can prove that no
aliases could ever exist (which is the point of comparing the way size
to the page size)


> Alex Van Brunt (3):
>   Revert "arm64: kernel: add support for cpu cache information"
>   Revert "arm64: don't flag non-aliasing VIPT I-caches as aliasing"
>   Revert "arm64: add helper functions to read I-cache attributes"
>

None of the clarifications you offer here are in the commit logs of
the patches. Since the cover letter does not make it into the
repository, someone looking at the commit log will not have a clue why
these patches were reverted all of a sudden. Could you please update
that? At the same time, could you get rid of the Change-Ids as well?
They are meaningless in the kernel tree.
