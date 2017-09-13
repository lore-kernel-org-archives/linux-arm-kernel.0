From: jslaby@suse.cz (Jiri Slaby)
Date: Wed, 13 Sep 2017 08:14:30 +0200
Subject: [PATCH] sysrq : fix Show Regs call trace on ARM
In-Reply-To: <ac1a099b-2e7e-8001-24a2-679a0b7077a5@suse.cz>
References: <20170911031142.254308-1-jibin.xu@windriver.com>
 <8c09c309-e088-1dd6-8d6f-f8929acf0f5f@suse.cz>
 <5dd5bb30-15af-ab44-8b56-57c3c1d53bc4@windriver.com>
 <17da8267-c4aa-dc0f-1150-4fd5efe0073c@windriver.com>
 <ac1a099b-2e7e-8001-24a2-679a0b7077a5@suse.cz>
Message-ID: <58805d5d-b520-c27f-b4c6-633d897d90cc@suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/13/2017, 08:04 AM, Jiri Slaby wrote:
> On 09/11/2017, 01:22 PM, Jibin Xu wrote:
>> Hi,Jiri: 
>>
>> I tested get_irq_regs() behave in the softirq context,
>> I called get_irq_regs() by a tasklet, It returns NULL.My understanding is get_irq_regs() can return the right result
>> only in hardware IRQ,otherwise it returns ?????????L.
>> So I think in_irq() would be better.
> 
> Hi,
> 
> tasklets are run in the process context (in a kthread). But what about
> timers? HARDIRQ is decremented, SOFTIRQ remains set and sysrq handlers
> are called in such conditions (in_interrupt() is true, in_irq() is
> false). At that moment, irq_regs are still set and valid IMO.
> 
> But I would believe for now that sysrq handlers are not invoked from
> softirq context. AFAIK they are called only from hardirq (serial port or
> keyboard IRQ handler) or process context (write to /proc/sysrq-trigger).
> So this change *should* be safe unless someone else objects there are
> some kgdb special cases or something.

Oops, serial8250_timeout actually can do so. So yes, sysrq handlers can
be invoked from softirq (timer) context and they still should print the
registers at best.

I have to leave now, will look into it later if someone (you :)) doesn't
beat me to it.

thanks,
-- 
js
suse labs
