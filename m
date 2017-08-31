From: rogershimizu@gmail.com (Roger Shimizu)
Date: Fri, 1 Sep 2017 01:05:16 +0900
Subject: [PATCH] scripts: make extract-vmlinux support armel/armhf
In-Reply-To: <20170831154941.GS20805@n2100.armlinux.org.uk>
References: <20170831153631.31026-1-rogershimizu@gmail.com>
 <20170831154941.GS20805@n2100.armlinux.org.uk>
Message-ID: <CAEQ9gEmBv-fb2MbedSzs+dWtrq-ChXwiMrisyofZ7zfu+jADYA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Russell,

Thanks for your review!

On Fri, Sep 1, 2017 at 12:49 AM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Fri, Sep 01, 2017 at 12:36:31AM +0900, Roger Shimizu wrote:
>> vmlinux/zImage on armel/armhf seems not an ELF, so update the script
>> scripts/extract-vmlinux to support such case.
>>
>> This fix is tested on Debian amd64, armel, and armhf platform, with
>> Debian kernels.
>>
>> Fixes: 09d481270d44 ("scripts: add extract-vmlinux")
>> Cc: Corentin Chary <corentincj@iksaif.net>
>> Cc: Michal Marek <mmarek@suse.com>
>> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
>> Cc: Russell King <linux@arm.linux.org.uk>
>> Cc: linux-arm-kernel at lists.infradead.org
>> Cc: linux-kbuild at vger.kernel.org
>> Signed-off-by: Roger Shimizu <rogershimizu@gmail.com>
>> ---
>>
>> Dear Michal, Masahiro-san, and Russell,
>>
>> I posted this patch before [0] but didn't get positive response.
>> Recently when I trace a Debian kernel issue, I still find this patch
>> useful to locate the root cause [1].
>>
>> Besides, it's a well known bug confuses other developers [2][3].
>> So I decide to submit the patch again.
>>
>> [0]: https://patchwork.kernel.org/patch/8120831/
>> [1]: https://bugs.debian.org/870185#50
>> [2]: https://bugs.launchpad.net/linaro-ubuntu/+bug/1050453
>> [3]: https://bugs.linaro.org/show_bug.cgi?id=461
>>
>> Please kindly help to review. Thank you!
>
> I don't think this makes sense.  This script claims to extract a "vmlinux"
> from a compressed kernel image.  "vmlinux" is normally the term of the
> ELF object, and indeed as the script currently stands, it always guarantees
> to output an ELF file.

If you think creating a new "scripts/extract-zImage" file is more
proper way, we can do it.

> However, ARM zImage does not store a compressed ELF object, it stores a
> compressed binary image of the executable in memory, so what you get out
> of this script is not an ELF file, but the binary image (iow, what
> arch/arm/boot/Image is.)
>
> What's the use case - what are you using the output of this script with?

I already provided a use case, to trace a Debian kernel issue caused
by kernel size.
- https://bugs.debian.org/870185#50

I also see other people complaining this issue:
 - https://bugs.launchpad.net/linaro-ubuntu/+bug/1050453
 - https://bugs.linaro.org/show_bug.cgi?id=461

By a random web search, I find another blog post on how to dissamble the kernel.
 - https://blog.packagecloud.io/eng/2016/03/08/how-to-extract-and-disassmble-a-linux-kernel-image-vmlinuz/


>
>> diff --git a/scripts/extract-vmlinux b/scripts/extract-vmlinux
>> index 5061abcc2540..0c72ecd24969 100755
>> --- a/scripts/extract-vmlinux
>> +++ b/scripts/extract-vmlinux
>> @@ -6,6 +6,7 @@
>>  # (c) 2009,2010 Dick Streefland <dick@streefland.net>
>>  #
>>  # (c) 2011      Corentin Chary <corentin.chary@gmail.com>
>> +# (c) 2016      Roger Shimizu <rogershimizu@gmail.com>
>>  #
>>  # Licensed under the GNU General Public License, version 2 (GPLv2).
>>  # ----------------------------------------------------------------------
>> @@ -15,7 +16,14 @@ check_vmlinux()
>>       # Use readelf to check if it's a valid ELF
>>       # TODO: find a better to way to check that it's really vmlinux
>>       #       and not just an elf
>> -     readelf -h $1 > /dev/null 2>&1 || return 1
>> +     case "$2" in
>> +     0|"")
>> +             readelf -h $1 > /dev/null 2>&1 || return 1
>> +             ;;
>> +     1)
>> +     # For ARCH like armel/armhf, vmlinux is not ELF, so we skip the check
>> +             ;;
>> +     esac
>
> Right, so passing the second argument as 1 bypasses the "is it ELF" check.
>
>> @@ -31,7 +39,7 @@ try_decompress()
>>       do
>>               pos=${pos%%:*}
>>               tail -c+$pos "$img" | $3 > $tmp 2> /dev/null
>> -             check_vmlinux $tmp
>> +             test $? -eq 0 && check_vmlinux $tmp 1
>
> and here you always pass '1', thereby bypassing the ELF check for every

There's another call without parameter "1", which handles the ELF's case.

> architecture.  What if some architecture stores another compressed
> object in the same compressed image?  I suspect the check is there to
> ensure that it works on architectures where the compressed kernel image
> contains other compressed objects.

The output of this script is output the first compressed object.
If there's need to process the 2nd, it should be handled separately.
I don't think it's a blocker to this patch.

Cheers,
-- 
Roger Shimizu, GMT +9 Tokyo
PGP/GPG: 4096R/6C6ACD6417B3ACB1
