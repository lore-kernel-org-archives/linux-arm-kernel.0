From: apatel@apm.com (Anup Patel)
Date: Thu, 28 Feb 2013 22:24:04 +0530
Subject: [PATCH] arm64: add support for uart earlyprintk
In-Reply-To: <20130228153129.GA16316@arm.com>
References: <1362049268-26822-1-git-send-email-apatel@apm.com>
 <512F40B9.6020105@arm.com> <20130228121047.GF30747@arm.com>
 <512F5304.4070006@arm.com>
 <CAMwBHsZyd+-T_pEDAaxxthjct27UsS_G-6FXKqGTccbok_NVVA@mail.gmail.com>
 <20130228153129.GA16316@arm.com>
Message-ID: <CAMwBHsbJUyJ-kH7=qZwL9FFy3uT9DrsFizA4WTxHrDujjMhdfw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 28, 2013 at 9:01 PM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> On Thu, Feb 28, 2013 at 02:06:27PM +0000, Anup Patel wrote:
>> On Thu, Feb 28, 2013 at 6:22 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> > On 28/02/13 12:10, Catalin Marinas wrote:
>> >> On Thu, Feb 28, 2013 at 11:34:17AM +0000, Marc Zyngier wrote:
>> >>> On 28/02/13 11:01, Anup Patel wrote:
>> >>>> +}
>> >>>> +
>> >>>> +/*
>> >>>>   * PL011 single character TX.
>> >>>>   */
>> >>>>  static void pl011_printch(char ch)
>> >>>> @@ -47,6 +62,7 @@ struct earlycon_match {
>> >>>>
>> >>>>  static const struct earlycon_match earlycon_match[] __initconst = {
>> >>>>     { .name = "pl011", .printch = pl011_printch, },
>> >>>> +   { .name = "uart", .printch = uart_printch, },
>> >>>
>> >>> "uart" is way too generic. pl011 is an UART too, and I suspect most of
>> >>> the backends that are going to be added here over time will be UARTs.
>> >>>
>> >>> "uart8250" would be a possibility (and actually consistent with the rest
>> >>> of the kernel, see drivers/tty/serial/8250/8250_early.c.
>> >>
>> >> I think it makes more sense to use the existing 8250_early.c driver. It
>> >> has more features than the simple earlyprintk implementation in the
>> >> 64-bit kernel (like parsing more parameters, initialising the UART). The
>> >> only difference is that the early_param is called "earlycon".
>> >
>> > Indeed, this seems to be the best way, as it removes the need for this
>> > patch altogether.
>>
>> The earlycon option does not seem to work on my ARM64 kernel because it uses
>> ioremap_nocache() whereas ARM64 earlyprintk uses early_io_map()
>
> We try to get earlyprintk as early as possible and ioremap() isn't
> available yet, hence the arm64-specific early_io_map(). It looks like
> x86 has a CONFIG_FIX_EARLYCON_MEM to avoid the ioremap() issue but I
> wouldn't add yet another option for arm64.
>
> So we can go with your arm64 patch, once you implement the feedback from
> Marc.
>
> --
> Catalin

Sure, I will incorporate Marc's comments and resend the patch with
more appropriate
subject and description.

Regards,
Anup
CONFIDENTIALITY NOTICE: This e-mail message, including any attachments, 
is for the sole use of the intended recipient(s) and contains information
that is confidential and proprietary to Applied Micro Circuits Corporation or its subsidiaries. 
It is to be used solely for the purpose of furthering the parties' business relationship. 
All unauthorized review, use, disclosure or distribution is prohibited. 
If you are not the intended recipient, please contact the sender by reply e-mail 
and destroy all copies of the original message.
