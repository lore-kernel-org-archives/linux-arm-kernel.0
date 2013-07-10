From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 10 Jul 2013 10:12:46 +0200
Subject: [PATCH -next 2/2] kbuild: fix for updated LZ4 tool with the new
 streaming format
In-Reply-To: <20130506095124.GA22041@pd.tnic>
References: <1367829775-4434-1-git-send-email-kyungsik.lee@lge.com>
 <1367829775-4434-2-git-send-email-kyungsik.lee@lge.com>
 <20130506095124.GA22041@pd.tnic>
Message-ID: <CAMuHMdWH9w5fj6HRXi+9QcBJym4dukAFsPVGZVqSSk3yTZJUcA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 6, 2013 at 11:51 AM, Borislav Petkov <bp@alien8.de> wrote:
> On Mon, May 06, 2013 at 05:42:55PM +0900, Kyungsik Lee wrote:
>> LZ4 has been updated with LZ4 Streaming Format specification(v1.3).
>> lz4demo is replaced by lz4c. lz4c supports both the new streaming and
>> legacy format with -l option.
>>
>> This patch makes use of lz4c to support legacy format which is
>> used for LZ4 De/compression in the linux kernel.
>>
>> Link: https://code.google.com/p/lz4/source/checkout
>> Signed-off-by: Kyungsik Lee <kyungsik.lee@lge.com>
>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>> Cc: Ingo Molnar <mingo@elte.hu>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Russell King <rmk@arm.linux.org.uk>
>> Cc: Borislav Petkov <bp@alien8.de>
>> Cc: Florian Fainelli <florian@openwrt.org>
>> Cc: Yann Collet <yann.collet.73@gmail.com>
>> Cc: Chanho Min <chanho.min@lge.com>
>> ---
>>  scripts/Makefile.lib | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
>> index a0ab6d7..c9bfbb0 100644
>> --- a/scripts/Makefile.lib
>> +++ b/scripts/Makefile.lib
>> @@ -313,7 +313,7 @@ cmd_lzo = (cat $(filter-out FORCE,$^) | \
>>
>>  quiet_cmd_lz4 = LZ4     $@
>>  cmd_lz4 = (cat $(filter-out FORCE,$^) | \
>> -     lz4demo -c1 stdin stdout && $(call size_append, $(filter-out FORCE,$^))) > $@ || \
>> +     lz4c -l -c1 stdin stdout && $(call size_append, $(filter-out FORCE,$^))) > $@ || \
>
> You probably want to check for the presence of lz4c on the system and
> bail with an informative message if absent.

Yep, x86_64-randconfig
(http://kisskb.ellerman.id.au/kisskb/buildresult/9110794/):

  LZ4     arch/x86/boot/compressed/vmlinux.bin.lz4
/bin/sh: lz4c: command not found

Also, several of the blackfin builds started failing due to a
compression-related
issue, e.g. http://kisskb.ellerman.id.au/kisskb/buildresult/9101322/:

  UIMAGE  arch/blackfin/boot/uImage.lzma

Invalid Compression Type - valid names are: none, bzip2, gzip
Usage: /usr/local/bin/mkimage -l image
          -l ==> list image header information
       /usr/local/bin/mkimage [-x] -A arch -O os -T type -C comp -a
addr -e ep -n name -d data_file[:data_file...] image
          -A ==> set architecture to 'arch'
          -O ==> set operating system to 'os'
          -T ==> set image type to 'type'
          -C ==> set compression type 'comp'
          -a ==> set load address to 'addr' (hex)
          -e ==> set entry point to 'ep' (hex)
          -n ==> set image name to 'name'
          -d ==> use image data from 'datafile'
          -x ==> set XIP (execute in place)
make[2]: *** [arch/blackfin/boot/uImage.lzma] Error 1

May be unrelated, though.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
