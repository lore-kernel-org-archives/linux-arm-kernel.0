From: b.brezillon@overkiz.com (boris brezillon)
Date: Wed, 07 Aug 2013 08:33:49 +0200
Subject: at91sam9x5: uart (not usart) broken
In-Reply-To: <52019591.2010408@interlog.com>
References: <52019591.2010408@interlog.com>
Message-ID: <5201EA4D.8030106@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Doug,

On 07/08/2013 02:32, Douglas Gilbert wrote:
> Between lk 3.10.0 and lk 3.11.0-rc4 the uarts (not usarts)
> have been broken in the at91sam9x5 family. The DT files have
> been re-factored for uarts but look correct.
>
> So suspicion moves to the atmel_serial driver which enjoyed
> a lot of changes in June.
>

My patch (the last one in log history) is adding error checks on clk_get and
clk_enable (clk_prepare_enable) calls.
I think the issue you're having comes from these new checks, and the fact
that uart clks DT entries are missing.

The previous version was just silently ignoring these errors.
It may work if these clks (uart clks) are already enabled by bootstrap or
bootloader.

Anyway, I think the cleaner way for resolving this issue is to apply the 
patch
I joined in attachment.

Could you test it (I don't have any sam9x5 boards), and if this works 
I'll submit
it.

Best Regards,

Boris
> Tested on a at91sam9g25 (Aria G25) which is a member of the
> at91sam9x5 family with two uarts (four usarts and a debug
> serial port). The failure looks like this in dmesg:
>
>  console [ttyS0] enabled
>  f801c000.serial: ttyS1 at MMIO 0xf801c000 (irq = 23) is a ATMEL_SERIAL
>  f8020000.serial: ttyS2 at MMIO 0xf8020000 (irq = 24) is a ATMEL_SERIAL
>  f8024000.serial: ttyS3 at MMIO 0xf8024000 (irq = 25) is a ATMEL_SERIAL
>  atmel_usart: probe of f8040000.serial failed with error -2
>  f8028000.serial: ttyS4 at MMIO 0xf8028000 (irq = 32) is a ATMEL_SERIAL
>
> The device at 0xf8040000 is uart0 . My DT file was trying
> to bring up uart0 but not uart1.
>
> Doug Gilbert

-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-ARM-at91-add-missing-uart-clocks-DT-entries.patch
Type: text/x-patch
Size: 1172 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130807/4f82ce04/attachment.bin>
