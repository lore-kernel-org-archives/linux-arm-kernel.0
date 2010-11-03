From: brian@murphy.dk (Brian Murphy)
Date: Wed, 3 Nov 2010 10:14:46 +0100
Subject: boot decompressor code error
In-Reply-To: <20101103082558.GA11176@pengutronix.de>
References: <AANLkTimttsvuVYFpCNFU4iJHCjHZ1Xq5E3Gni-wOrTba@mail.gmail.com>
	<20101029105643.GB21103@n2100.arm.linux.org.uk>
	<AANLkTimk14Z8f1D=YuxxLK6cYHcm=ot6mWhYB4_Emav1@mail.gmail.com>
	<20101103082558.GA11176@pengutronix.de>
Message-ID: <AANLkTinsKWK3fR=jZzJXeWHzmUUbbxJsRKxVdrYKtf15@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/11/3 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> Hello Brian,
>
> On Wed, Nov 03, 2010 at 09:16:12AM +0100, Brian Murphy wrote:
>> On Fri, Oct 29, 2010 at 12:56 PM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > On Fri, Oct 29, 2010 at 12:22:47PM +0200, Brian Murphy wrote:
>> >> Hi,
>> >> There is a problem with the boot decompression code when the inflate
>> >> method is used on arm.
>> >> In fact two. The second of which is also a problem on all architectures.
>> >> The first, and more serious, is that static local variables seem not
>> >> to be supported,
>> >
>> > static local variables are no different from static global variables
>> > except their scope. ?static local variables can only be referenced
>> > from within the block which they are defined and any child blocks,
>> > whereas static global variables can be referenced by any code in the
>> > same compilation unit.
>> >
>> > Their storage and initialization in both cases is identical.
>> >
>> >> this means that
>> >> some tables initialized as static locals point to a place in ram where
>> >> the tables are not.
>> >> The function
>> >>
>> >> static void zlib_fixedtables(struct inflate_state *state)
>> >>
>> >> includes inffixed.h which contains two static tables and
>> >
>> > Both these tables are 'const' which means they end up in the read-only
>> > section, and ultimately the text section of the image, not the data
>> > section.
>> >
>> >> int zlib_inflate(z_streamp strm, int flush)
>> >>
>> >> contains a static local "order". The second seems not to have much
>> >> influence on decompression
>> >> but the first causes images (at least of a certain size) to fail
>> >> decompression.
>> >
>> > Again, this is "static const unsigned short order[19] = ..." which
>> > because of the const, ends up in the read-only section and therefore
>> > the text section of the image.
>> >
>> > This is what I see from arm-linux-nm -n arch/arm/boot/compressed/vmlinux:
>> > ...
>> > 000835f0 t order.0
>> > 00083618 t lenfix.1
>> > 00083e18 t distfix.2
>> > ...
>> > which clearly shows these tables in the text section. ?Also
>> > arm-linux-objdump -t arch/arm/boot/compressed/decompress.o shows:
>> > ...
>> > 000000fc l ? ? O .rodata ? ? ? ?00000026 order.0
>> > 00000124 l ? ? O .rodata ? ? ? ?00000800 lenfix.1
>> > 00000924 l ? ? O .rodata ? ? ? ?00000080 distfix.2
>> > ...
>> > which shows that these were placed into the .rodata section initially,
>> > as I explained above.
>> >
>> > Can you show your output from the above commands please? ?Also show
>> > the output of:
>> >
>> > arm-linux-nm -n arch/arm/boot/compressed/vmlinux|grep '\<__bss_start\>\|\<_end\>'
>> >
>> > arm-linux-objdump --section=.got -s arch/arm/boot/compressed/vmlinux
>> >
>> > Also, are you using ZBOOT_ROM=y or =n ?
>> >
>>
>> It looks like you were right, to some degree :). The table data is in
>> the image transferred to
>> the board but it looks like static locals are treated by the compiler
>> as locals and allocated on
>> the stack! This, of course, means that at some point they get
>> (partially) overwritten by newer
>> locals and thus corrupted.
> Some time ago the decompressor was compiled using
>
> ? ? ? ?-Dstatic=
>
> Is this still the case for you?
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? | Uwe Kleine-K?nig ? ? ? ? ? ?|
> Industrial Linux Solutions ? ? ? ? ? ? ? ? | http://www.pengutronix.de/ ?|
>

I'll reply again to the list.
Yes, in the decompressor in the 2.6.33 misc.c is compiled with -Dstatic=
which puts all local static variables on the stack. As we all know
returning a pointer
to a local variable is not a good idea.
This causes decompression of certain files which use these tables to fail.

/Brian
