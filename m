From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Tue, 28 Apr 2015 14:13:16 +0200
Subject: [PATCH v6 10/15] serial: stm32-usart: Add STM32 USART Driver
In-Reply-To: <552678E7.4040107@mentor.com>
References: <1428424234-28572-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1428424234-28572-11-git-send-email-mcoquelin.stm32@gmail.com>
 <552678E7.4040107@mentor.com>
Message-ID: <CALszF6CTFgVd4D6Ftkf0jW+Hcp53jqrutOHOagDXT-0705aHHQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vladimir,

Thanks for the review, and sorry for the late reply.

2015-04-09 15:04 GMT+02:00 Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>:
> Hi Maxime,
>
> On 07.04.2015 19:30, Maxime Coquelin wrote:
>> This drivers adds support to the STM32 USART controller, which is a
>> standard serial driver.
>>
>> Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
>> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
>> ---
>>  drivers/tty/serial/Kconfig       |  17 +
>>  drivers/tty/serial/Makefile      |   1 +
>>  drivers/tty/serial/stm32-usart.c | 735 +++++++++++++++++++++++++++++++++++++++
>>  include/uapi/linux/serial_core.h |   3 +
>>  4 files changed, 756 insertions(+)
>>  create mode 100644 drivers/tty/serial/stm32-usart.c
>
> [snip]
>
>> +static void stm32_console_write(struct console *co, const char *s, unsigned cnt)
>> +{
>> +     struct uart_port *port = &stm32_ports[co->index].port;
>> +     unsigned long flags;
>> +     u32 old_cr1, new_cr1;
>> +     int locked = 1;
>> +
>> +     if (oops_in_progress) {
>> +             locked = spin_trylock_irqsave(&port->lock, flags);
>> +     } else {
>> +             locked = 1;    ID

>
> locked = 1 is done from the declaration.
Right, I will fix this in next version

>
> Also do you want to add "if (port->sysrq) locked = 0;" check?

Yes, that makes sense. It will be also in v7.
>
>> +             spin_lock_irqsave(&port->lock, flags);
>> +     }
>> +


>
> [snip]
>
> Everything else is fine from point of view.
>
> Reviewed-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>

Regards,
Maxime
>
> --
> With best wishes,
> Vladimir
