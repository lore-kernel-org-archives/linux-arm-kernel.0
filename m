From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 3 Oct 2014 09:21:50 +0200
Subject: [PATCH] [RFC] ARM: shmobile: Add early debugging support using
 SCIF(A)
In-Reply-To: <542DE80D.2000600@renesas.com>
References: <1412276563-21473-1-git-send-email-geert+renesas@glider.be>
 <542DE80D.2000600@renesas.com>
Message-ID: <CAMuHMdWvYWrZBhFz7aZgV3b7S0r8OsQdPN4DBCB2+crY+Bqq=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Khiem-san,

On Fri, Oct 3, 2014 at 2:04 AM, Khiem Nguyen
<khiem.nguyen.xt@renesas.com> wrote:
> On 10/3/2014 4:02 AM, Geert Uytterhoeven wrote:
>> Add serial port debug macros for the SCIF(A) serial ports.
>> This includes all shmobile SoCs, except for EMEV2.
>>
>> On SoCs using the legacy machine_desc.map_io(), an identity mapping of
>> the SCIF(A) registers must be set up in .map_io(). On all but r8a7779
>> this was already done.
>>
>> On other SoCs, debug_ll_io_init() maps the SCIF(A) registers to a fixed
>> virtual address. 0xfdxxxxxx was chosen, as it should lie below
>> VMALLOC_END = 0xff000000, and must not conflict with the 2 MiB reserved
>> region at PCI_IO_VIRT_BASE = 0xfee00000.
>>
>> This was derived from the r8a7790 version by Laurent Pinchart.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>> Tested on r8a7791/koelsch and r8a7740/armadillo.
>> Testing on other platforms would be highly appreciated.
>
> Uhm..., I have tried to test your patch with devel branch/renesas repo.
> 1. CONFIG_DEBUG_SCIF is enabled in shmobile_defconfig.
> 2. *Need to configure* CONFIG_DEBUG_UART_PHYS for lager/koelsch
> since 0xe6c50000 (for ARCH_R8A7740) will be selected by default.

DEBUG_LL is meant for low-level debugging, and may not work well
if multiple platforms/SoCs are enabled.
If your kernel only has support for r8a7790/r8a7791, the default value
of CONFIG_DEBUG_UART_PHYS should be OK.
Else, ... well, you already noticed you can still change the address
when configuring.

> Diff of config changed:
> -# CONFIG_DEBUG_LL is not set
> -CONFIG_DEBUG_LL_INCLUDE="mach/debug-macro.S"
> +CONFIG_DEBUG_LL=y
> +CONFIG_DEBUG_SCIF=y
> +# CONFIG_DEBUG_ICEDCC is not set
> +# CONFIG_DEBUG_SEMIHOSTING is not set
> +# CONFIG_DEBUG_LL_UART_8250 is not set
> +# CONFIG_DEBUG_LL_UART_PL01X is not set
> +CONFIG_DEBUG_LL_INCLUDE="debug/scif.S"
>  # CONFIG_DEBUG_UART_PL01X is not set
>  # CONFIG_DEBUG_UART_8250 is not set
> +CONFIG_DEBUG_UART_PHYS=0xe6e60000
> +CONFIG_DEBUG_UNCOMPRESS=y
>  CONFIG_UNCOMPRESS_INCLUDE="debug/uncompress.h"
> +# CONFIG_EARLY_PRINTK is not set
>  # CONFIG_PID_IN_CONTEXTIDR is not set
>
> 3. Boot up in lager/koelsch, kernel log output
> to "booting the kernel" then ... nothing else.
>
> Starting kernel ...
>
> Uncompressing Linux... done, booting the kernel.
>
> Could you let me know your test procedure ?

Does enable CONFIG_EARLY_PRINTK help?

Thanks for testing!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
