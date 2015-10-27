From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 27 Oct 2015 21:31:06 +0900
Subject: [PATCH] arm64/efi: register UEFI runtime mmio regions as iomem
 resources
In-Reply-To: <CACRpkdact=Jh5WpghnyPU1Oaiu8pgvb=kwva-nEkJUX9NKL6xw@mail.gmail.com>
References: <CAD0U-h+cr0xpAAcCD1P8k2hUcJJL2Ga+-Grrb8WaZrgm08G2nA@mail.gmail.com>
 <1445848860-9547-1-git-send-email-ard.biesheuvel@linaro.org>
 <CACRpkdact=Jh5WpghnyPU1Oaiu8pgvb=kwva-nEkJUX9NKL6xw@mail.gmail.com>
Message-ID: <CAKv+Gu-12azUSe_V9Cx58fd5YyO8RMO4qSOs1afQ8iAc71cC9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 October 2015 at 21:08, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, Oct 26, 2015 at 9:41 AM, Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
>
>> In order to prevent kernel drivers from attaching to MMIO regions
>> that are owned by the firmware, register them as iomem resources.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>
> Is this related to the flash memory discussion so that NOR flash
> will be part of what is considered "I/O memory"

Yes

> and flash
> protection achieved this way?
>

... and no, not entirely. Note that this is not about 'protecting' the
flash in a security sense. It is simply to reserve the resources that
should be considered occupied by the UEFI firmware drivers. This may
be NOR flash, but it may just as well be the RTC or potentially a
syscon register block to do reset and/or poweroff.

My QEMU mach-virt /proc/iomem looks like this with the patch applied:

04000000-07ffffff : UEFI Runtime MMIO
09000000-09000fff : /pl011 at 9000000
  09000000-09000fff : /pl011 at 9000000
09010000-0901ffff : UEFI Runtime MMIO
40000000-7fffffff : System RAM
  40080000-408a27d3 : Kernel code
  40970000-40adffff : Kernel data

where the first UEFI mmio region is the second bank of NOR flash (the
first one holds the firmware image itself, so that is not claimed
since the variable store driver never accesses it) and the second UEFI
mmio region is the PL031 RTC.

-- 
Ard.
