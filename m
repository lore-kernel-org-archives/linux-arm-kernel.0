From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 29 Oct 2015 21:26:44 +0900
Subject: [PATCH 0/3] Revert arm64 cache geometry
In-Reply-To: <20151029112008.GA28221@leverpostej>
References: <1446068637-11509-1-git-send-email-avanbrunt@nvidia.com>
 <CAKv+Gu-CgXU4O8SymcjmCYZqyAa0PZbJXwNqXfuCamxYY9C8GA@mail.gmail.com>
 <20151029112008.GA28221@leverpostej>
Message-ID: <CAKv+Gu-gBKdQneC_3yX3sQtQsL8244S1qGkXYZ5PhrPov1aRhA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29 October 2015 at 20:20, Mark Rutland <mark.rutland@arm.com> wrote:
> On Thu, Oct 29, 2015 at 12:22:51PM +0900, Ard Biesheuvel wrote:
>> On 29 October 2015 at 06:43, Alex Van Brunt <avanbrunt@nvidia.com> wrote:
>> > This patchset reverts three patches that attempt to query the CPU for cache
>> > geometry and then make use of that information. Those patches rely on the
>> > NumSets and LineSize fields of CCSIDR to determine the cache geometry. However,
>> > the architectural documentation for these registers forbids such use:
>> >
>> >         The parameters NumSets, Associativity, and LineSize in these registers
>> >         define the architecturally visible parameters that are required for the
>> >         cache maintenance by Set/Way instructions. They are not guaranteed to
>> >         represent the actual microarchitectural features of a design. You cannot
>> >         make any inference about the actual sizes of caches based on these
>> >         parameters.
>> >
>> > It is not just theoretical. For example, the Denver CPU will report one set and
>> > one way in CCSIDR even though the actual microarchitectural implementation has
>> > many sets and many ways.
>> >
>>
>> Fair enough. It is a bit disappointing that we cannot trust these
>> values, but if the architecture does not mandate their accuracy, we
>> obviously should not be using them in the way that we are.
>
> Indeed.
>
>> > The only place that the cache geometry is used is to determine if there can be
>> > aliasing for a VIPT (virtually-indexed, physically-tagged) instruction cache.
>> > The code assumes that there is no need to flush the entire instruction cache
>> > if the size of a cache set is less than or equal to a page size. However, the
>> > architectural definition of VIPT says "The only architecturally-guaranteed way
>> > to invalidate all aliases of a physical address from a VIPT instruction cache
>> > is to invalidate the entire instruction cache." Not only are the parameters not
>> > guaranteed to be correct, it is explicitly not legal to ignore aliasing even if
>> > the parameters were correct.
>> >
>>
>> I understand that this is subject to interpretation, but I would argue
>> that this does not apply to the case where you can prove that no
>> aliases could ever exist (which is the point of comparing the way size
>> to the page size)
>
> Given NumSets and LineSize aren't guaranteed to match the physical
> values, I don't see that way have sufficient information to derive the
> physical way size in order to do so.
>

I know, but the argument being made is that if we did have this
information, we would still violate the spec if we used it to decide
whether a VIPT I-cache could alias or not.

>> > Alex Van Brunt (3):
>> >   Revert "arm64: kernel: add support for cpu cache information"
>> >   Revert "arm64: don't flag non-aliasing VIPT I-caches as aliasing"
>> >   Revert "arm64: add helper functions to read I-cache attributes"
>> >
>>
>> None of the clarifications you offer here are in the commit logs of
>> the patches. Since the cover letter does not make it into the
>> repository, someone looking at the commit log will not have a clue why
>> these patches were reverted all of a sudden. Could you please update
>> that? At the same time, could you get rid of the Change-Ids as well?
>> They are meaningless in the kernel tree.
>
> It would be good to include the quote from the cover letter in each
> patch; it makes the situation abundantly clear and avoids having to
> trawl through the ARM ARM again in future.
>

Indeed.
