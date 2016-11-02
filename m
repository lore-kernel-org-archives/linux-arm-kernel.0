From: markus.mayer@broadcom.com (Markus Mayer)
Date: Wed, 2 Nov 2016 14:41:18 -0700
Subject: [PATCH] arm64: errata: Check for --fix-cortex-a53-843419 and
 --fix-cortex-a53
In-Reply-To: <20161102212747.GL22791@arm.com>
References: <20161031194414.61287-1-code@mmayer.net>
 <20161102210331.GJ22791@arm.com>
 <CAGt4E5tKHNQw=eLzFx-+g6yLwJ=xCTQEqNZHFZu6aOVpKm7X7w@mail.gmail.com>
 <20161102212747.GL22791@arm.com>
Message-ID: <CAGt4E5sxMcyizwAjwEZd6zepOAyr05WCgtstoRDfNjkNQtnJCA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2 November 2016 at 14:27, Will Deacon <will.deacon@arm.com> wrote:
> On Wed, Nov 02, 2016 at 02:07:17PM -0700, Markus Mayer wrote:
>> On 2 November 2016 at 14:03, Will Deacon <will.deacon@arm.com> wrote:
>> > On Mon, Oct 31, 2016 at 12:44:14PM -0700, Markus Mayer wrote:
>> >> From: Markus Mayer <mmayer@broadcom.com>
>> >>
>> >> The new errata check leads to a warning with some older versions of the
>> >> linker that do know how to work around the errata, but still use the
>> >> original name of the command line option: --fix-cortex-a53. The commit
>> >> in question that changed the name of the option can be found at [1].
>> >> It looks like only "gold" is affected by this rename. Traditional "ld"
>> >> isn't. (There, the argument was always called --fix-cortex-a53-843419.)
>> >>
>> >> To allow older versions of gold to properly handle the erratum if they
>> >> can, check whether ld supports the old name of this option in addition
>> >> to checking the new one.
>> >>
>> >> [1] https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;a=commitdiff;h=7a2a1c793578a8468604e661dda025ecb8d0bd20;hp=cfbf0e3c5b637d66b2b1aeadecae9c187b825b2f
>> >>
>> >> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
>> >
>> > If newer versions of gold accept the correct option name, why do we care?
>>
>> Because Documentation/Changes states that the minimum requirement for
>> binutils is 2.12. Right now, that is not really true. And not
>> everybody can always use the newest toolchain, for various reasons.
>
> Well the kernel still builds, right? Can binutils 2.12 even work around
> 843419? For people who can't use a recent toolchain, then they don't get
> erratum workaround and we warn them about it.

Correct. Linkers as old as 2.12 are not able to work around the
erratum, and the warning is accurate. So, there's no problem there.

But there are newer versions that do know how to work around the
erratum, but use the original name of the option. Right now, you could
be using a linker that knows how to fix the erratum, but instead, the
you get a warning, and the erratum is not fixed.

This one, for instance:

$ arm-linux-ld -v
GNU ld (GNU Binutils) Linaro 2014.11-2 2.24.0.20141017

Without the proposed patch, this linker will produce a kernel without
the workaround, but not because the linker can't do it, but because it
isn't given the command line argument it understands.

>> The question I am asking is: What do we have to lose by supporting both options?
>
> We end up passing "--fix-cortex-a53" to the linker, without knowing what it
> might do in the future.

It seems highly unlikely that such a generic option would be added in
the future, both, because the precedent has been set for topic
specific options, and because they know it has been used in the past,
so they wouldn't add a previously used option to do something
completely different. (And if they really did, then that would be a
huge binutils bug.)

So, we have a trade-off between a real world problem that does
currently exist and avoiding a theoretical issue that may never
materialize.

Regards,
-Markus

> Will
