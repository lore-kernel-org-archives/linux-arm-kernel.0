From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 8 Nov 2018 16:44:48 +0100
Subject: [PATCH 0/7] Ensure stack is aligned for kernel entries
In-Reply-To: <20181108153916.GD3505@e103592.cambridge.arm.com>
References: <1537970184-44348-1-git-send-email-julien.thierry@arm.com>
 <CAKv+Gu-jVTWyy61Q--HE_Hw+RZVxYcTypZmF+YUhmX1p_QkLKQ@mail.gmail.com>
 <8382cafd-9fb7-7121-0de2-5091ba079d31@arm.com>
 <CAKv+Gu_K9p5FvQGtvgzKmveiQvHQp1H1PxAzxqcFnJfDQt4huw@mail.gmail.com>
 <cdae83fa-dc71-e635-acda-be363695bf0c@arm.com>
 <20181108153032.GC3505@e103592.cambridge.arm.com>
 <312bdb62-4361-2475-da62-a42b9d22e8bb@arm.com>
 <20181108153916.GD3505@e103592.cambridge.arm.com>
Message-ID: <CAKv+Gu_C=0mOcrR1_=8key1RNsvYm-TSFFTZQzir6fpTCmYS-w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 November 2018 at 16:39, Dave Martin <Dave.Martin@arm.com> wrote:
> On Thu, Nov 08, 2018 at 03:33:01PM +0000, Ramana Radhakrishnan wrote:
>> On 08/11/2018 15:30, Dave Martin wrote:
>> > On Thu, Nov 08, 2018 at 02:19:14PM +0000, Ramana Radhakrishnan wrote:
>> >> On 08/11/2018 14:10, Ard Biesheuvel wrote:
>> >>> (+ Ramana)
>> >>>
>> >>> On 8 November 2018 at 14:27, Julien Thierry <julien.thierry@arm.com> wrote:
>> >>>>
>> >>>>
>> >>>> On 08/11/18 13:04, Ard Biesheuvel wrote:
>> >>>>>
>> >>>>> On 26 September 2018 at 15:56, Julien Thierry <julien.thierry@arm.com>
>> >>>>> wrote:
>> >>>>>>
>> >>>>>> Hi,
>> >>>>>>
>> >>>>>> Having SCTLR_ELx.SA enabled requires the SP to be 16-bytes aligned before
>> >>>>>> using it to access memory. When taking an exception, it is possible that
>> >>>>>> the context during which the exception occured had SP mis-aligned.
>> >>>>>
>> >>>>>
>> >>>>> How is this possible? GCC clearly only manipulates the stack pointer
>> >>>>> in 16 byte multiples, and so if we do the same in our asm code (which
>> >>>>> I think we already do, given the lack of reports about this issue), is
>> >>>>> this handling really necessary?
>> >>>>>
>> >>>>
>> >>>> Is there anything that actually gives us that guarantee from GCC? I agree
>> >>>> that currently it looks like aarch64-<...>-gcc only manipulates SP aligned
>> >>>> to 16 bytes, but I don't know whether that is certain.
>> >>>>
>> >>>
>> >>> I think we should get that clarified then. I don't think it makes
>> >>> sense for GCC to have to reason about whether SP currently has a value
>> >>> that permits dereferencing.
>> >>
>> >> The ABI gives that guarantee.
>> >>
>> >> http://infocenter.arm.com/help/topic/com.arm.doc.ihi0055b/IHI0055B_aapcs64.pdf
>> >>
>> >> <quote>
>> >
>> > Surely This only applies at public interfaces?
>> >
>>
>> I don't think this has anything to do with public interfaces. If there
>> is a trap with a 16byte misaligned access of the SP then it doesn't
>> matter whether it's a public interface or not.
>
> We're not talking about SP alignment faults here particluarly.
>
> We're talking about any exception that may be taken from EL1h to EL1h,
> which may happen on random instructions inside a function, for random
> reasons.
>

Indeed.

But my question remains how likely it is that the compiler we use for
generating the kernel code (so we are not talking about userland JITs
or other crazy stuff here) would play with SP like that, especially
since it is no longer a general purpose register. To me, it would make
sense to attempt to reach an agreement with the GCC folks that
compiler generated code does not muck about with SP like that.

In asm, there is one notable exception, of course, where we swap x0
and sp temporarily in the entry path, but we can't get interrupted
there anyway.

In any case, if people insist, I'm ok with it. To me, it just seems
like unnecessary clutter for a theoretical issue.
