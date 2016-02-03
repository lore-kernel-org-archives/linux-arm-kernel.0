From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 3 Feb 2016 09:16:51 +0100
Subject: [PATCH 3/3] kallsyms: remove --page-offset command line option
In-Reply-To: <20160203000504.GY10826@n2100.arm.linux.org.uk>
References: <1454419174-21290-1-git-send-email-ard.biesheuvel@linaro.org>
 <1454419174-21290-4-git-send-email-ard.biesheuvel@linaro.org>
 <20160203000504.GY10826@n2100.arm.linux.org.uk>
Message-ID: <CAKv+Gu8vzvX-6=+SgPwm2CUy_1Qpt-GHvzv=brQTs50i2Z=v9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(+ Uwe, Maxime)

Complete thread here:
http://thread.gmane.org/gmane.linux.ports.arm.kernel/474400

On 3 February 2016 at 01:05, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Feb 02, 2016 at 02:19:34PM +0100, Ard Biesheuvel wrote:
>> The --page-offset command line option was only used for ARM, to filter
>> symbol addresses below CONFIG_PAGE_OFFSET. This is no longer needed, so
>> remove the functionality altogether.
>
> From what I remember, this option has nothing to do with MMU-ful ARM,
> but noMMU ARM, where the .text segment can be significantly different
> from the .data segment.
>
> I think you need to talk to noMMU people about this patch.
>

We have

commit f6537f2f0eba4eba3354e48dbe3047db6d8b6254
Author: Ming Lei <tom.leiming@gmail.com>
Date:   Sat Nov 2 09:11:33 2013 +1030

    scripts/kallsyms: filter symbols not in kernel address space

    This patch uses CONFIG_PAGE_OFFSET to filter symbols which
    are not in kernel address space because these symbols are
    generally for generating code purpose and can't be run at
    kernel mode, so we needn't keep them in /proc/kallsyms.

    For example, on ARM there are some symbols which may be
    linked in relocatable code section, then perf can't parse
    symbols any more from /proc/kallsyms, this patch fixes the
    problem (introduced b9b32bf70f2fb710b07c94e13afbc729afe221da)

which introduces the --page-offset option to kallsyms, in response to
your patch that moves .vectors and .stubs to VMA 0x0. Then we have

commit 7122c3e9154b5d9a7422f68f02d8acf050fad2b0
Author: Ming Lei <tom.leiming@gmail.com>
Date:   Tue Dec 10 16:46:29 2013 +1030

    scripts/link-vmlinux.sh: only filter kernel symbols for arm

    Actually CONFIG_PAGE_OFFSET isn't same with PAGE_OFFSET, so
    it isn't easy to figue out PAGE_OFFSET defined in header
    file from scripts.

    Because CONFIG_PAGE_OFFSET may not be defined in some ARCHs(
    64bit ARCH), or defined as bogus value in !MMU case, so
    this patch only applys the filter on ARM when CONFIG_PAGE_OFFSET
    is defined as the original problem is only on ARM.

which restricts the use of --page-offset to CONFIG_ARM, and

commit cc8475305203ddfd117b81e2e732194b67d8f310
Author: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Date:   Thu May 21 19:17:44 2015 +0800

    scripts: link-vmlinux: Don't pass page offset to kallsyms if XIP Kernel

    When Kernel is executed in place from ROM, the symbol addresses can be
    lower than the page offset.

which restricts the use of --page-offset to CONFIG_ARM && !CONFIG_XIP_KERNEL

So it looks like the Dec 10 patch fixes some fallout related to !MMU
that was caused by the Nov 2 patch, but the original patch has nothing
to do with !MMU. Furthermore, 3 out of 4 !MMU configs we have in the
tree (efm32, stm32 and vf610m4) are also XIP kernel, for which
--page-offset isn't even used to begin with after Maxime's patch.
Hopefully Uwe and/or Maxime can confirm, but removing the PAGE_OFFSET
lower limit should not affect those platforms at all afaict,
especially since, after patch 1/3, there are no symbols left to filter
below that limit in the first place.

Thanks,
Ard.
