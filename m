From: brian@murphy.dk (Brian Murphy)
Date: Wed, 3 Nov 2010 09:27:38 +0100
Subject: boot decompressor code error
In-Reply-To: <AANLkTimk14Z8f1D=YuxxLK6cYHcm=ot6mWhYB4_Emav1@mail.gmail.com>
References: <AANLkTimttsvuVYFpCNFU4iJHCjHZ1Xq5E3Gni-wOrTba@mail.gmail.com>
	<20101029105643.GB21103@n2100.arm.linux.org.uk>
	<AANLkTimk14Z8f1D=YuxxLK6cYHcm=ot6mWhYB4_Emav1@mail.gmail.com>
Message-ID: <AANLkTimyBb-66FoMgEzyNfJp0vr+tbB0ER+owFkkJZnw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 3, 2010 at 9:16 AM, Brian Murphy <brian@murphy.dk> wrote:
> On Fri, Oct 29, 2010 at 12:56 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> On Fri, Oct 29, 2010 at 12:22:47PM +0200, Brian Murphy wrote:
>>> Hi,
>>> There is a problem with the boot decompression code when the inflate
>>> method is used on arm.
>>> In fact two. The second of which is also a problem on all architectures.
>>> The first, and more serious, is that static local variables seem not
>>> to be supported,
>>
>> static local variables are no different from static global variables
>> except their scope. ?static local variables can only be referenced
>> from within the block which they are defined and any child blocks,
>> whereas static global variables can be referenced by any code in the
>> same compilation unit.
>>
>> Their storage and initialization in both cases is identical.
>>
>>> this means that
>>> some tables initialized as static locals point to a place in ram where
>>> the tables are not.
>>> The function
>>>
>>> static void zlib_fixedtables(struct inflate_state *state)
>>>
>>> includes inffixed.h which contains two static tables and
>>
>> Both these tables are 'const' which means they end up in the read-only
>> section, and ultimately the text section of the image, not the data
>> section.
>>
>>> int zlib_inflate(z_streamp strm, int flush)
>>>
>>> contains a static local "order". The second seems not to have much
>>> influence on decompression
>>> but the first causes images (at least of a certain size) to fail
>>> decompression.
>>
>> Again, this is "static const unsigned short order[19] = ..." which
>> because of the const, ends up in the read-only section and therefore
>> the text section of the image.
>>
>> This is what I see from arm-linux-nm -n arch/arm/boot/compressed/vmlinux:
>> ...
>> 000835f0 t order.0
>> 00083618 t lenfix.1
>> 00083e18 t distfix.2
>> ...
>> which clearly shows these tables in the text section. ?Also
>> arm-linux-objdump -t arch/arm/boot/compressed/decompress.o shows:
>> ...
>> 000000fc l ? ? O .rodata ? ? ? ?00000026 order.0
>> 00000124 l ? ? O .rodata ? ? ? ?00000800 lenfix.1
>> 00000924 l ? ? O .rodata ? ? ? ?00000080 distfix.2
>> ...
>> which shows that these were placed into the .rodata section initially,
>> as I explained above.
>>
>> Can you show your output from the above commands please? ?Also show
>> the output of:
>>
>> arm-linux-nm -n arch/arm/boot/compressed/vmlinux|grep '\<__bss_start\>\|\<_end\>'
>>
>> arm-linux-objdump --section=.got -s arch/arm/boot/compressed/vmlinux
>>
>> Also, are you using ZBOOT_ROM=y or =n ?
>>
>
> It looks like you were right, to some degree :). The table data is in
> the image transferred to
> the board but it looks like static locals are treated by the compiler
> as locals and allocated on
> the stack! This, of course, means that at some point they get
> (partially) overwritten by newer
> locals and thus corrupted.
>
> I can't get the output you show above, the names of the local
> variables get lost and they get
> translated to a C followed by some numbers: thus C.41.2187.
>
> Can I ask you which version of gcc and binutils you use?
>
> I have tested with a gcc 4.3.4/binutils 2.19.1 compiled with buildroot and a
> gcc 4.4.3/binutils ?2.20.1.20100303 compiled with crosstool ng.
> Both behave the same with respect to this problem.
>
> /Brian
>

I gave no evidence in my earlier mail.
Here is some. The zlib_fixedtables function allocates what looks like much
stack space before making two memcpys. lenfix and distfix are static const.

extract of misc.c from -save-temps:

        .global zlib_fixedtables
        .type   zlib_fixedtables, %function
zlib_fixedtables:
        @ args = 0, pretend = 0, frame = 2176
        @ frame_needed = 1, uses_anonymous_args = 0
        mov     ip, sp
        stmfd   sp!, {r4, r5, r6, r7, r8, fp, ip, lr, pc}
        sub     sp, sp, #2176
        sub     fp, ip, #4
        sub     sp, sp, #4
        ldr     r4, .L228
        ldr     r8, .L228+4
.LPIC10:
        add     r4, pc, r4
        sub     r7, fp, #2208
        sub     r7, r7, #4
        add     r8, r4, r8
        mov     r5, r0
        sub     r6, fp, #164
        mov     r1, r8
        mov     r2, #2048
        mov     r0, r7
        bl      memcpy(PLT)
        add     r1, r8, #2048
        mov     r2, #128
        mov     r0, r6
        bl      memcpy(PLT)
        mov     r3, #9
        ldr     r0, .L228+8
        str     r3, [r5, #80]
        mov     r3, #5
        str     r3, [r5, #84]
        add     r0, r4, r0
        mov     r1, r7
        mov     r2, r6

/Brian
