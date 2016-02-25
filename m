From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 25 Feb 2016 18:31:04 +0100
Subject: [PATCH v5sub2 1/8] arm64: add support for module PLTs
In-Reply-To: <20160225165601.GG16546@arm.com>
References: <1454332178-4414-2-git-send-email-ard.biesheuvel@linaro.org>
 <20160225160714.GA16546@arm.com>
 <CAKv+Gu94LAAwj2f9Sj9imn68V0VTF+NOtUPsE3tQnVzNDhAATw@mail.gmail.com>
 <20160225162622.GC16546@arm.com>
 <CAKv+Gu8Qx21M=ymne1S4CQUFrXKHTnWFygGBLtXbxiUD9GkiWw@mail.gmail.com>
 <20160225164208.GD16546@arm.com>
 <CAKv+Gu-REUdVJF-_wGU=LRaVRZqsD9bgny9S52pMLp+Es4E-1A@mail.gmail.com>
 <20160225164630.GF16546@arm.com>
 <CAKv+Gu8GYhPeXvgpAoHxYTYfqEHLqqLHVU9U6o3nvxew8dGo6A@mail.gmail.com>
 <CAKv+Gu_dXEQ1U2XY2=xX7R8MoPB0jKM7Vh3zgZB9tBuMfQYuGg@mail.gmail.com>
 <20160225165601.GG16546@arm.com>
Message-ID: <CAKv+Gu_Bv0CsMrCR=fiowZjtmmepjdLi7RX94wv_oDdrbjr3iw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 February 2016 at 17:56, Will Deacon <will.deacon@arm.com> wrote:
> On Thu, Feb 25, 2016 at 05:50:17PM +0100, Ard Biesheuvel wrote:
>> On 25 February 2016 at 17:49, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>> > On 25 February 2016 at 17:46, Will Deacon <will.deacon@arm.com> wrote:
>> >> On Thu, Feb 25, 2016 at 05:43:35PM +0100, Ard Biesheuvel wrote:
>> >>> On 25 February 2016 at 17:42, Will Deacon <will.deacon@arm.com> wrote:
>> >>> > On Thu, Feb 25, 2016 at 05:33:25PM +0100, Ard Biesheuvel wrote:
>> >>> >> AFAIK, gcc never uses x18 (the platform register) so we may be able to
>> >>> >> use that instead. We'd need confirmation from the toolchain guys,
>> >>> >> though ...
>> >>> >
>> >>> > In fact, a better thing to do is probably for the atomic code to
>> >>> > save/restore those register explicitly and then remove them from the
>> >>> > cflags above.
>> >>> >
>> >>> > I'll try hacking something together...
>> >>> >
>> >>>
>> >>> That would be more correct, indeed. Also, the PLT can only use br
>> >>> <reg> so it will always enter the callee with the preserved value
>> >>> stacked, and so the callee needs to be modified in any case.
>> >>
>> >> Wait -- why does the callee need to be modified here? It has no idea
>> >> about whether or not it was invoked via a PLT.
>> >>
>> >
>> > No, it doesn't, and that is exactly the problem: the PLT must end in a
>> > br <reg> instruction because that is the only branch instruction with
>> > unlimited range. That means you will always enter the callee with its
>> > address in some register rather than the value that should have been
>> > preserved. I don't see a way to manage that from the callee
>> >
>>
>> *caller! dammit
>
> The caller can do:
>
> save x16, 17
> bl plt
> restore x16, x17
>

This is __LL_SC_CALL, right? So you just fold a stp/ldp in there?

> the plt will do:
>
> get_addr_of_callee_into_x16_and_clobber_x17_or_something
> br callee
>
> then the callee will be compiled with all those weird options, but *not*
> the ones specifying x16 and x17. That means it can happily use those guys
> as scratch, because the caller will take care of them.
>

Yes, that makes sense. But if you don't relax that restriction, you
only need the alternative __LL_SC_CALL for modules.
