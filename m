From: apatel@apm.com (Anup Patel)
Date: Thu, 28 Feb 2013 19:36:27 +0530
Subject: [PATCH] arm64: add support for uart earlyprintk
In-Reply-To: <512F5304.4070006@arm.com>
References: <1362049268-26822-1-git-send-email-apatel@apm.com>
 <512F40B9.6020105@arm.com> <20130228121047.GF30747@arm.com>
 <512F5304.4070006@arm.com>
Message-ID: <CAMwBHsZyd+-T_pEDAaxxthjct27UsS_G-6FXKqGTccbok_NVVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 28, 2013 at 6:22 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 28/02/13 12:10, Catalin Marinas wrote:
>> On Thu, Feb 28, 2013 at 11:34:17AM +0000, Marc Zyngier wrote:
>>> On 28/02/13 11:01, Anup Patel wrote:
>>>> +}
>>>> +
>>>> +/*
>>>>   * PL011 single character TX.
>>>>   */
>>>>  static void pl011_printch(char ch)
>>>> @@ -47,6 +62,7 @@ struct earlycon_match {
>>>>
>>>>  static const struct earlycon_match earlycon_match[] __initconst = {
>>>>     { .name = "pl011", .printch = pl011_printch, },
>>>> +   { .name = "uart", .printch = uart_printch, },
>>>
>>> "uart" is way too generic. pl011 is an UART too, and I suspect most of
>>> the backends that are going to be added here over time will be UARTs.
>>>
>>> "uart8250" would be a possibility (and actually consistent with the rest
>>> of the kernel, see drivers/tty/serial/8250/8250_early.c.
>>
>> I think it makes more sense to use the existing 8250_early.c driver. It
>> has more features than the simple earlyprintk implementation in the
>> 64-bit kernel (like parsing more parameters, initialising the UART). The
>> only difference is that the early_param is called "earlycon".
>
> Indeed, this seems to be the best way, as it removes the need for this
> patch altogether.

The earlycon option does not seem to work on my ARM64 kernel because it uses
ioremap_nocache() whereas ARM64 earlyprintk uses early_io_map()

I do agree that earlycon is more feature rich compared to ARM64 earlyprintk but
I doubt whether 8250_early.c is generic enough to be usable on ARM64 kernel

The best part about ARM64 earlyprintk is that its very very simple and does not
expect us to re-programme UART HW which is already programmed by the
the bootloader.

IMHO, adding 8250 support in ARM64 earlyprintk would be very ARM64
specific and not
re-implementation of 8250_early.c

>
>         M.
> --
> Jazz is not dead. It just smells funny...
>

Regards,
Anup
CONFIDENTIALITY NOTICE: This e-mail message, including any attachments, 
is for the sole use of the intended recipient(s) and contains information
that is confidential and proprietary to Applied Micro Circuits Corporation or its subsidiaries. 
It is to be used solely for the purpose of furthering the parties' business relationship. 
All unauthorized review, use, disclosure or distribution is prohibited. 
If you are not the intended recipient, please contact the sender by reply e-mail 
and destroy all copies of the original message.
