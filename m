From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 24 Oct 2017 09:09:52 +0100
Subject: [PATCH] ARM: Fix zImage file size not aligned with
 CONFIG_EFI_STUB enabled
In-Reply-To: <20171023114549.GU20805@n2100.armlinux.org.uk>
References: <20171018050108.10352-1-jeffy.chen@rock-chips.com>
 <CAKv+Gu9ReBC+rLxaD-+Mp+aWRDfsYECAeOZo9CYU3big2nPw0w@mail.gmail.com>
 <20171022124757.GL20805@n2100.armlinux.org.uk>
 <CAKv+Gu9cgt0sjW_pnaXN6J8j8BXAb7z+gLhDY3oMaKwK5vcO-Q@mail.gmail.com>
 <59ED6179.5020301@rock-chips.com>
 <20171023085006.GM20805@n2100.armlinux.org.uk>
 <59EDC34C.40109@rock-chips.com> <20171023105046.GT20805@n2100.armlinux.org.uk>
 <20171023114549.GU20805@n2100.armlinux.org.uk>
Message-ID: <CAKv+Gu_R+OfHMxcZEJML4Pm54DyOji6S42LihMgi6+vxi9LOAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 October 2017 at 12:45, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Mon, Oct 23, 2017 at 11:50:46AM +0100, Russell King - ARM Linux wrote:
>> On Mon, Oct 23, 2017 at 06:24:12PM +0800, jeffy wrote:
>> > Hi Russell,
>> >
>> > Thanks for your reply.
>> >
>> > On 10/23/2017 04:50 PM, Russell King - ARM Linux wrote:
>> > >>>
>> > >>>hmm, right, didn't notice the data is already aligned...
>> > >>>so it's indeed caused by the ksym:
>> > >>>
>> > >>>   [ 9] .data             PROGBITS        006ce000 6d6000 000200 00  WA  0
>> > >>>0 4096
>> > >>>   [10] ___ksymtab+sort   PROGBITS        006ce200 6d6200 000008 00  WA  0
>> > >>>0  4
>> > >>>   [11] .bss              NOBITS          006ce208 6d6208 00001c 00  WA  0
>> > >>>0  4
>> > >It's earlier - look for __ksymtab_strings.
>> >
>> > the problem i meet is the appended dtb code found dtb invalid. i thought
>> > that is because of unaligned zImage size, but i was wrong...
>>
>> Hmm, you really ought not to be using the appended dtb code for modern
>> systems - the appended dtb system is there for old boot loaders that
>> are incapable of dealing with a dtb.  As is said in the option's help
>> text:
>>
>>   This is meant as a backward compatibility convenience for those
>>   systems with a bootloader that can't be upgraded to accommodate
>>   the documented boot protocol using a device tree.
>>
>>   Beware that there is very little in terms of protection against
>>   this option being confused by leftover garbage in memory that might
>>   look like a DTB header after a reboot if no actual DTB is appended
>>   to zImage.  Do not leave this option active in a production kernel
>>   if you don't intend to always append a DTB.  Proper passing of the
>>   location into r2 of a bootloader provided DTB is always preferable
>>   to this option.
>>
>> If you rely on it, and you have something that looks like a dtb after
>> the image, then things will go wrong, so it's better _not_ to use it
>> and to keep it disabled.
>>
>> That aside, thanks for doing a more in-depth analysis of what is going
>> on, which helps to understand /why/ Ard's fix works (whereas before
>> it was rather nebulous.)
>>
>> I wonder whether we ought to tell the linker to discard any unknown
>> sections by adding at the bottom:
>>
>>       /DISCARD/ { *(*) }
>>
>> but I do think we need to document this, specifically that _edata must
>> point to the first byte after the binary file, and that the only
>> sections after it are allowed to be the .bss and stack sections.
>
> Short of adding the discard (which I think is itself risky, we've had
> problems in the main kernel's vmlinux.lds in this area), I think we
> ought to verify the size of the zImage file, so that the build fails
> when we generate a zImage which is wrong, rather than producing a
> zImage that is incorrect.  Maybe something like this?
>
> 8<=====
> From: Russell King <rmk+kernel@armlinux.org.uk>
> Subject: [PATCH] ARM: verify size of zImage
>
> The linker can sometimes add additional sections to the zImage ELF file
> which results in the zImage binary being larger than expected.  This
> causes appended DT blobs to fail.
>
> Verify that the zImage binary is the expected size, and fail the build
> if this is not the case.
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
>  arch/arm/boot/Makefile         |  6 +++++-
>  arch/arm/boot/verify_zimage.sh | 21 +++++++++++++++++++++
>  2 files changed, 26 insertions(+), 1 deletion(-)
>  create mode 100755 arch/arm/boot/verify_zimage.sh
>
> diff --git a/arch/arm/boot/Makefile b/arch/arm/boot/Makefile
> index a3af4dc08c3e..1290875556ae 100644
> --- a/arch/arm/boot/Makefile
> +++ b/arch/arm/boot/Makefile
> @@ -53,6 +53,10 @@ $(obj)/Image $(obj)/zImage: FORCE
>
>  else
>
> +quiet_cmd_mkzimage = ZIMAGE  $@
> +cmd_mkzimage = $(cmd_objcopy) && $(CONFIG_SHELL) -c \
> +       '$(srctree)/$(src)/verify_zimage.sh $< $@ "$(NM)" || { rm -f $@; false; }'
> +
>  $(obj)/xipImage: FORCE
>         @echo 'Kernel not configured for XIP (CONFIG_XIP_KERNEL!=y)'
>         @false
> @@ -64,7 +68,7 @@ $(obj)/compressed/vmlinux: $(obj)/Image FORCE
>         $(Q)$(MAKE) $(build)=$(obj)/compressed $@
>
>  $(obj)/zImage: $(obj)/compressed/vmlinux FORCE
> -       $(call if_changed,objcopy)
> +       $(call if_changed,mkzimage)
>
>  endif
>
> diff --git a/arch/arm/boot/verify_zimage.sh b/arch/arm/boot/verify_zimage.sh
> new file mode 100755
> index 000000000000..922a93e61aa7
> --- /dev/null
> +++ b/arch/arm/boot/verify_zimage.sh
> @@ -0,0 +1,21 @@
> +#!/bin/sh
> +set -e
> +
> +vmlinuz="$1"
> +zimage="$2"
> +nm="$3"
> +
> +magic_size=$("$nm" "$vmlinuz" | perl -e 'while (<>) {
> +       $magic_start = hex($1) if /^([[:xdigit:]]+) . _magic_start$/;
> +       $magic_end = hex($1) if /^([[:xdigit:]]+) . _magic_end$/;
> +}; printf "%d\n", $magic_end - $magic_start;')
> +
> +zimage_size=$(stat -c '%s' "$zimage")
> +
> +# Verify that the resulting binary matches the size contained within
> +# the binary (iow, the linker has not added any additional sections.)
> +if [ $magic_size -ne $zimage_size ]; then
> +   echo "zImage size ($zimage_size) disagrees with linked size ($magic_size)" >&2
> +   exit 1
> +fi
> +exit 0
> --
> 2.7.4
>

The following patch appears to fix the issue as well:

diff --git a/arch/arm/boot/compressed/vmlinux.lds.S
b/arch/arm/boot/compressed/vmlinux.lds.S
index 7a4c59154361..0e0f504e256e 100644
--- a/arch/arm/boot/compressed/vmlinux.lds.S
+++ b/arch/arm/boot/compressed/vmlinux.lds.S
@@ -83,7 +83,9 @@ SECTIONS
   __pecoff_data_rawsize = . - ADDR(.data);
 #endif

-  _edata = .;
+  .edata (NOLOAD) : {
+    _edata = .;
+  }

   _magic_sig = ZIMAGE_MAGIC(0x016f2818);
   _magic_start = ZIMAGE_MAGIC(_start);

because the NOLOAD triggers the linker to emit all PROGBITS sections
before _edata, including unknown ones.

E.g., in my binary, it gives me

00798020 D __pecoff_data_end
00798200 d __ksymtab_sort
00798208 B __bss_start
00798208 D _edata
