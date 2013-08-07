From: dgilbert@interlog.com (Douglas Gilbert)
Date: Wed, 07 Aug 2013 11:45:41 -0400
Subject: at91sam9x5: uart (not usart) broken
In-Reply-To: <5201EA4D.8030106@overkiz.com>
References: <52019591.2010408@interlog.com> <5201EA4D.8030106@overkiz.com>
Message-ID: <52026BA5.40707@interlog.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13-08-07 02:33 AM, boris brezillon wrote:
> Hello Doug,
>
> On 07/08/2013 02:32, Douglas Gilbert wrote:
>> Between lk 3.10.0 and lk 3.11.0-rc4 the uarts (not usarts)
>> have been broken in the at91sam9x5 family. The DT files have
>> been re-factored for uarts but look correct.
>>
>> So suspicion moves to the atmel_serial driver which enjoyed
>> a lot of changes in June.
>>
>
> My patch (the last one in log history) is adding error checks on clk_get and
> clk_enable (clk_prepare_enable) calls.
> I think the issue you're having comes from these new checks, and the fact
> that uart clks DT entries are missing.
>
> The previous version was just silently ignoring these errors.
> It may work if these clks (uart clks) are already enabled by bootstrap or
> bootloader.
>
> Anyway, I think the cleaner way for resolving this issue is to apply the patch
> I joined in attachment.
>
> Could you test it (I don't have any sam9x5 boards), and if this works I'll submit
> it.

Hi Boris,
Yes, your patch works with lk 3.11.0-rc4 on a at91sam9g25
(aria G25). So please apply to the current rc series.

Also since in the lk 3.10 series this is silently broken and/or
works by accident (e.g. when a boot loader sets the uart clocks)
then perhaps this fix should be sent to Greg K-H for inclusion
in the lk 3.10.x stable series.

Doug Gilbert

>> Tested on a at91sam9g25 (Aria G25) which is a member of the
>> at91sam9x5 family with two uarts (four usarts and a debug
>> serial port). The failure looks like this in dmesg:
>>
>>  console [ttyS0] enabled
>>  f801c000.serial: ttyS1 at MMIO 0xf801c000 (irq = 23) is a ATMEL_SERIAL
>>  f8020000.serial: ttyS2 at MMIO 0xf8020000 (irq = 24) is a ATMEL_SERIAL
>>  f8024000.serial: ttyS3 at MMIO 0xf8024000 (irq = 25) is a ATMEL_SERIAL
>>  atmel_usart: probe of f8040000.serial failed with error -2
>>  f8028000.serial: ttyS4 at MMIO 0xf8028000 (irq = 32) is a ATMEL_SERIAL
>>
>> The device at 0xf8040000 is uart0 . My DT file was trying
>> to bring up uart0 but not uart1.
>>
>> Doug Gilbert
>
