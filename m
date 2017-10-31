From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 31 Oct 2017 12:57:35 +0000
Subject: [PATCH] ARM: add a private asm/unaligned.h
In-Reply-To: <20171031124707.GD9463@n2100.armlinux.org.uk>
References: <20171020200231.1355569-1-arnd@arndb.de>
 <87wp3g39es.fsf@free-electrons.com>
 <20171027152743.GJ20805@n2100.armlinux.org.uk>
 <87k1zc3fxp.fsf@free-electrons.com>
 <20171030154855.GO20805@n2100.armlinux.org.uk>
 <87bmko1v6f.fsf@free-electrons.com>
 <20171030161207.GS20805@n2100.armlinux.org.uk>
 <8737601u4d.fsf@free-electrons.com>
 <20171030163816.GA27404@n2100.armlinux.org.uk>
 <20171031124707.GD9463@n2100.armlinux.org.uk>
Message-ID: <CAKv+Gu-te-Q+em36jM-dyouZuov_=xJaVY0Yr-3JCmJn6Zi4sg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31 October 2017 at 12:47, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Mon, Oct 30, 2017 at 04:38:17PM +0000, Russell King - ARM Linux wrote:
>> On Mon, Oct 30, 2017 at 05:24:34PM +0100, Gregory CLEMENT wrote:
>> > Hi Russell King,
>> >
>> > Here you will find all the objects included the vmlinux:
>> >
>> > http://free-electrons.com/~gregory/pub/compressed.tgz
>>
>> Thanks.  Unfortunately, nothing stands out, but I do see a difference
>> between the output of your linker from mine.
>>
>> Yours:
>>
>> Idx Name          Size      VMA       LMA       File off  Algn
>>   0 .text         00005ef8  00000000  00000000  00010000  2**5
>>                   CONTENTS, ALLOC, LOAD, READONLY, CODE
>>
>> Mine:
>>
>> Idx Name          Size      VMA       LMA       File off  Algn
>>   0 .text         00005f00  00000000  00000000  00010000  2**5
>>                   CONTENTS, ALLOC, LOAD, READONLY, CODE
>>
>> That has the effect of moving the addresses of the following
>> sections in your vmlinux down by 8 bytes.  However, I don't think
>> that's the cause of this - but it does hint at something being
>> different in binutils in the way sections are processed in the
>> linker.
>>
>> Please add to your linker script after the assignment of _edata:
>>
>>   .image_end (NOLOAD) : {
>>     _edata_foo = .;
>>   }
>>
>> relink the decompressor, and see what value _edata_foo ends up with
>> compared to _edata?  They should be the same, but I suspect using
>> your linker, they will be different.
>>
>> Also try adding
>>     BYTE(0);
>>
>> after the _edata_foo assignment as a separate test, and see whether
>> that makes any difference - with that you should end up with the
>> .image_end section in the output image.
>
> Gregory sent me has new url... for _both_ changes, which gives me:
>
> $ arm-linux-nm vmlinux |grep _edata
> 00491160 D _edata
> 00491160 D _edata_foo
>
> So there's no reason that ASSERT() should be failing!  However, as I
> don't have the intermediate step, I can't say whether the addition
> of the BYTE() affected it in some way - sorry, but I asked for _both_
> to be tested above because I wanted to speed up the process, and
> clearly that's backfired.
>
> Given how close we potentially are to 4.14, I don't think we're going
> to get to the bottom of this to make 4.14.  I'd want to get this
> sorted by Wednesday so linux-next (which is resuming this evening)
> can grab a copy of my tree with it in, and we have another day to
> sort out any remaining issues, but I'm basically out of time to do
> anything further with this as of now.
>
> So, 4.14 will likely be released without any of this being fixed.
>

IIUC, the current issue is limited to the ASSERT() itself, which is
there to prevent future regressions, while the other two patches deal
with severe and difficult to diagnose known issues.

So why can't we apply those two patches as fixes, and revisit the
patch that helps us prevent this from regressing in the future for
v4.15?
