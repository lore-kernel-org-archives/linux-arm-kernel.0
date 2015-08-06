From: raghumag@gmail.com (raghu MG)
Date: Thu, 6 Aug 2015 11:24:36 +0530
Subject: Armadaxp GPIO interrupts
In-Reply-To: <20150805162155.GE32760@lunn.ch>
References: <CAG1O52Xg88OsifBzmpSdqvC8wQaOW78nC9nnfxugFv1VU1m1LQ@mail.gmail.com>
 <20150804153439.GA28673@lunn.ch>
 <CAG1O52W2Gy_6_DfewtUqoK_J+Y=KwVGyygNaPu2xyPM_ZkLfcQ@mail.gmail.com>
 <CAG1O52VQPpeGkA8bqYbPMTiT9Mua1yHi3H3osqJsHqm-RRKzow@mail.gmail.com>
 <20150805162155.GE32760@lunn.ch>
Message-ID: <CAG1O52WPFfm+XGk01iUVWLu=-Dm7bcDVmhv3P8iQDH+HHjsLUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

My platform/board is ATCA carrier card which is getting interface to I/O card.
The I/O card is hot-pluggable  or Jack-in or Jack out.
Also I/O card consists of hot-plugable SFP interface.
These events are triggered using GPIO's

So the events the carrier card recieves are
1) If I/O card is either Jacked-in or Jacked-out ,respective GPIO
pin-x triggers an event
2) If SFP is pushed into I/O card the respective GPIO pin-y triggers an event.




Another observation about  "irq: Cannot allocate irq_descs @ IRQ47/79/111".
This is warning & irq_descs are already allocated , the overall
initialization/probe function doesn't get effected.
mvebu_gpio_irq_handler is only called if I register a another handler
at irq=82/83/84/85/87/88/89/90/92. I am registering this handler using
minimal kernel module.
My understanding of Linux IRQ/interrupt mechanism is limited to
request_irq, but registering domain & then IRQ is bit not clear.

Regards
Raghu




On Wed, Aug 5, 2015 at 9:51 PM, Andrew Lunn <andrew@lunn.ch> wrote:
> On Wed, Aug 05, 2015 at 08:31:27PM +0530, raghu MG wrote:
>> Hi Andrew,
>>
>> The issue I found was  irq_alloc_descs is called twice
>> 1st time inside   mvebu_gpio_probe & 2nd time inside irq_domain_add_simple.
>
> So i'm somewhat confused. I just tested on my Kirkwood and 370
> platforms, and an Armada XP WRT1900AC using 4.2.0-rc5, all which use
> the same gpio driver.
>
> They boot fine, the gpio driver is loaded, and the interrupt for the
> gpio connected to a button are listed in /proc/interrupts. The
> gpio-key driver is also able to use the gpio and the input-events
> program does show events when i press the button.
>
> So what is different with your platform?
>
>    Andrew
