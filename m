From: yvo@apm.com (Y Vo)
Date: Fri, 10 Oct 2014 10:22:34 +0700
Subject: [PATCH v1 1/3] gpio: Add APM X-Gene standby GPIO controller driver
In-Reply-To: <2334188.M3m5hnmS5j@wuerfel>
References: <1412779948-28769-1-git-send-email-yvo@apm.com>
 <1843196.sbXNmZyoMx@wuerfel>
 <CAL4ahLfpubEqi49gy8T9pyrf=1j__LbAsKUyr5i=koNyp0Mmig@mail.gmail.com>
 <2334188.M3m5hnmS5j@wuerfel>
Message-ID: <CAL4ahLeZsT4KN22Jgxa8EJD8eEcWwN-wddCFvXY+8Yvb5hCGFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnd,

Pls see my answer below:

On Thu, Oct 9, 2014 at 7:13 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 09 October 2014 16:31:18 Y Vo wrote:
>> Dear Arnd,
>>
>> Thanks a lot for your review. Pls see my answer on blue text below.
>
> Please do not send html-encoded email, it will get dropped by all mailing
> lists.
>
>>
>> On Wed, Oct 8, 2014 at 10:13 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> > On Wednesday 08 October 2014 21:52:26 Y Vo wrote:
>> > > +
>> > > +#define GICD_SPI_BASE                        0x78010000
>> >
>> > You can't hardcode register locations. Please use the proper interfaces
>> > to do whatever you want.
>> > *APM: We will do that.*
>>
>>
>>
>> >
>> > It's probably not ok to map any GIC registers into the GPIO driver,
>> > it should operate as a nested irqchip.
>> >
>>
>>  *APM: We will find the solution, the problem is we want to read the status
>> of that GPIO in case it is configured IRQ. In this case we must access to
>> GIC to read the true value.*
>
> Can you explain what the hardware does here? Do you mean you have no way
> to read the GPIO level from the GPIO controller for any pin that is
> configured as an interrupt?
>
> Can you route all GPIO pins to arbitrary upstream IRQ lines, or is this
> hardwired in the GPIO block?

APM:  There are 6 GPIOs which can support IRQ, they are fixed to use
external IRQ from XGIC.  (The XGIC is based on the ARM Generic
Interrupt Controller Architecture Specification, Architecture version
2.0, The XGIC provides the mechanism to collect interrupt requests
(IRQs) from both on-chip as well as off-chip sources and deliver them
to the multiple X-Gene1 cores within the X-Gene1 processor),  So there
are no way to read the GPIO DS when configure as an interrupt. They
are specific GPIO for boot another boot chip in X-Gene which can
access when boot up. So this is hardwire in the GPIO block.
GPIO_DS8 ---> External IRQ0 (XGIC40)
GPIO_DS9 ---> External IRQ1 (XGIC41)
...
GPIO_DS13 ---> External IRQ5(XGIC45)

>
>         Arnd
CONFIDENTIALITY NOTICE: This e-mail message, including any attachments, 
is for the sole use of the intended recipient(s) and contains information
that is confidential and proprietary to Applied Micro Circuits Corporation or its subsidiaries. 
It is to be used solely for the purpose of furthering the parties' business relationship. 
All unauthorized review, use, disclosure or distribution is prohibited. 
If you are not the intended recipient, please contact the sender by reply e-mail 
and destroy all copies of the original message.
