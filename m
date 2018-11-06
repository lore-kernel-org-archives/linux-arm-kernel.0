From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 6 Nov 2018 16:18:46 +0100
Subject: [PATCH 3/4] ARM: merge -fdata-sections BSS data to .bss section
In-Reply-To: <20181106144554.GF30658@n2100.armlinux.org.uk>
References: <20181106133935.GB30658@n2100.armlinux.org.uk>
 <E1gK1ae-0000or-7R@rmk-PC.armlinux.org.uk>
 <CAKv+Gu9-t0QYCfXHtRJ=Oc-Gsa2f=RdRHTP_suB2oT5pKKy7ZQ@mail.gmail.com>
 <20181106141033.GC30658@n2100.armlinux.org.uk>
 <CAKv+Gu8nGYRYPsFZW3zcOVPMBZfA6R3PhqQ2XQBPVGLPTw9t-g@mail.gmail.com>
 <20181106142953.GE30658@n2100.armlinux.org.uk>
 <CAKv+Gu9LmzbB=LbmdRS+GfAJOzQRTj20TcbJ=XY2jypZLSTbwQ@mail.gmail.com>
 <20181106144554.GF30658@n2100.armlinux.org.uk>
Message-ID: <CAKv+Gu8h461LN0oUGB45LHmQEDG+WccMgS4TQ2G5OVaJCpw1kA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 November 2018 at 15:45, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Tue, Nov 06, 2018 at 03:39:58PM +0100, Ard Biesheuvel wrote:
>> On 6 November 2018 at 15:29, Russell King - ARM Linux
>> <linux@armlinux.org.uk> wrote:
>> > On Tue, Nov 06, 2018 at 03:13:07PM +0100, Ard Biesheuvel wrote:
>> >> On 6 November 2018 at 15:10, Russell King - ARM Linux
>> >> <linux@armlinux.org.uk> wrote:
>> >> > On Tue, Nov 06, 2018 at 03:08:06PM +0100, Ard Biesheuvel wrote:
>> >> >> On 6 November 2018 at 14:40, Russell King <rmk+kernel@armlinux.org.uk> wrote:
>> >> >> > When building with -fdata-sections, the BSS data is placed into separate
>> >> >> > sections, so we need to ask the linker to group these together into the
>> >> >> > .bss output section, so that they're correctly placed.
>> >> >> >
>> >> >> > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
>> >> >> > ---
>> >> >> >  arch/arm/boot/compressed/vmlinux.lds.S | 2 +-
>> >> >> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >> >> >
>> >> >> > diff --git a/arch/arm/boot/compressed/vmlinux.lds.S b/arch/arm/boot/compressed/vmlinux.lds.S
>> >> >> > index 2b963d8e76dd..3b91bc3c606f 100644
>> >> >> > --- a/arch/arm/boot/compressed/vmlinux.lds.S
>> >> >> > +++ b/arch/arm/boot/compressed/vmlinux.lds.S
>> >> >> > @@ -118,7 +118,7 @@ SECTIONS
>> >> >> >
>> >> >> >    . = BSS_START;
>> >> >> >    __bss_start = .;
>> >> >> > -  .bss                 : { *(.bss) }
>> >> >> > +  .bss                 : { *(.bss) *(.bss.*) }
>> >> >>
>> >> >> Would it make sense to sort these by alignment? Otherwise, I suspect
>> >> >> you may get a lot of padding holes due to the number of different
>> >> >> input sections, each with its own alignment.
>> >> >
>> >> > We don't bother elsewhere in the kernel linker script - do you have
>> >> > a case where we get lots of padding?
>> >> >
>> >>
>> >> With -fdata-sections? How else are we ensuring that each .bss item in
>> >> its own section is not placed such that its alignment results in a
>> >> padding hole?
>> >
>> > Quite simply, we don't care (at the moment).  The alignment does not
>> > come from the size of each individual section, but the alignment
>> > requirements of data within the section.
>> >
>> > See include/asm-generic/vmlinux.lds.h and the definition of *_MAIN
>> > symbols from around line 60.
>> >
>>
>> This seems like an oversight to me: consider something like*
>>
>> unsigned char bar = 1;
>> unsigned long long foo = 4;
>>
>> build it with
>>
>> arm-linux-gnueabihf-gcc -fdata-sections -o /tmp/foo.o -c /tmp/foo.c
>>
>> and we end up with the following object file
>>
>> Section Headers:
>>   [Nr] Name              Type            Addr     Off    Size   ES Flg Lk Inf Al
>>   [ 0]                   NULL            00000000 000000 000000 00      0   0  0
>>   [ 1] .text             PROGBITS        00000000 000034 000000 00  AX  0   0  1
>>   [ 2] .data             PROGBITS        00000000 000034 000000 00  WA  0   0  1
>>   [ 3] .bss              NOBITS          00000000 000034 000000 00  WA  0   0  1
>>   [ 4] .data.bar         PROGBITS        00000000 000034 000001 00  WA  0   0  1
>>   [ 5] .data.foo         PROGBITS        00000000 000038 000008 00  WA  0   0  8
>>   ...
>>
>> Symbol table '.symtab' contains 13 entries:
>>    Num:    Value  Size Type    Bind   Vis      Ndx Name
>>     11: 00000000     8 OBJECT  GLOBAL DEFAULT    5 foo
>>     12: 00000000     1 OBJECT  GLOBAL DEFAULT    4 bar
>>
>> whereas if I remove the -fdata-sections argument, I get
>>
>> Section Headers:
>>   [Nr] Name              Type            Addr     Off    Size   ES Flg Lk Inf Al
>>   [ 0]                   NULL            00000000 000000 000000 00      0   0  0
>>   [ 1] .text             PROGBITS        00000000 000034 000000 00  AX  0   0  1
>>   [ 2] .data             PROGBITS        00000000 000038 000009 00  WA  0   0  8
>>   [ 3] .bss              NOBITS          00000000 000041 000000 00  WA  0   0  1
>>   ...
>>
>> and
>>
>> Symbol table '.symtab' contains 11 entries:
>>    Num:    Value  Size Type    Bind   Vis      Ndx Name
>>    ...
>>      9: 00000000     8 OBJECT  GLOBAL DEFAULT    2 foo
>>     10: 00000008     1 OBJECT  GLOBAL DEFAULT    2 bar
>>
>> In other words, we end up with a 7 byte padding hole by switching to
>> -fdata-sections, unless we sort the input objects by alignment.
>>
>> * for my test compiile, -fdata-sections would not produce different
>> input section so I am using .data for this example.
>
> Nevertheless, changing this is not a subject for a patch series that
> targets ARM.  What you've identified is a deficiency in the generic
> cross-arch support for this which needs a wider audience to be
> involved.
>

Fair enough.

For the record, when I build the arm64 defconfig kernel with
LD_DEAD_CODE_ELIMINATION turned on, adding --sort-section=alignment
reduces the image size from

   text    data     bss     dec     hex filename
11951684 6936332 385040 19273056 1261560 vmlinux

to

   text    data     bss     dec     hex filename
11938452 6930404 383625 19252481 125c501 vmlinux
