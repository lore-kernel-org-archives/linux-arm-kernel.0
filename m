From: apatel@apm.com (Anup Patel)
Date: Thu, 28 Feb 2013 19:26:16 +0530
Subject: [PATCH] arm64: add support for uart earlyprintk
In-Reply-To: <512F40B9.6020105@arm.com>
References: <1362049268-26822-1-git-send-email-apatel@apm.com>
 <512F40B9.6020105@arm.com>
Message-ID: <CAMwBHsZugJ+tv9MH5J+WGpVNtNgJYdP8+pwufdDoDOQshTeALw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 28, 2013 at 5:04 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 28/02/13 11:01, Anup Patel wrote:
>
> Hi Anup,
>
>> Signed-off-by: Anup Patel <apatel@apm.com>
>
> A proper patch description would be nice.
Oke will do.

>
>> ---
>>  arch/arm64/kernel/early_printk.c |   16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>
>> diff --git a/arch/arm64/kernel/early_printk.c b/arch/arm64/kernel/early_printk.c
>> index 7e320a2..62953ed 100644
>> --- a/arch/arm64/kernel/early_printk.c
>> +++ b/arch/arm64/kernel/early_printk.c
>> @@ -29,6 +29,21 @@ static void __iomem *early_base;
>>  static void (*printch)(char ch);
>>
>>  /*
>> + * UART (8250/16550) single character TX.
>> + */
>> +static void uart_printch(char ch)
>> +{
>> +#define UART_LSR     0x14
>> +#define UART_TX      0x0
>
> Please use the constants defined in include/uapi/linux/serial_reg.h,
> together with the proper shifts.

Yes, I am fine with reusing constants from serial_reg.h.
Its just that I did not want to include entire header for 2 register accesses.

>
>> +
>> +     while (!(readl_relaxed(early_base + UART_LSR) & 0x20))
>> +             ;
>
> You may want to test both UART_LSR_TEMT and UART_LSR_THRE here.

We only need to check for empty space in Tx FIFO or Tx Holding Register hence
a check on UART_LSR_THRE bit would suffice.
(For more info,
http://en.wikibooks.org/wiki/Serial_Programming/8250_UART_Programming)

>
>> +     writeb_relaxed(ch, early_base + UART_TX);
>> +     while (!(readl_relaxed(early_base + UART_LSR) & 0x20))
>> +             ;
>
> Why do you have to wait again here? It should be enough to do in only
> once when entering the function.

Yes, the second loop seems to be redundant.
Its there because I tried to implement uart_printch() similar to
pl011_printch().

>
>> +}
>> +
>> +/*
>>   * PL011 single character TX.
>>   */
>>  static void pl011_printch(char ch)
>> @@ -47,6 +62,7 @@ struct earlycon_match {
>>
>>  static const struct earlycon_match earlycon_match[] __initconst = {
>>       { .name = "pl011", .printch = pl011_printch, },
>> +     { .name = "uart", .printch = uart_printch, },
>
> "uart" is way too generic. pl011 is an UART too, and I suspect most of
> the backends that are going to be added here over time will be UARTs.
>
> "uart8250" would be a possibility (and actually consistent with the rest
> of the kernel, see drivers/tty/serial/8250/8250_early.c.

Actually, I was thinking of having earlyprintk=8250. What say ?

>
> Cheers,
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
