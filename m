From: jslaby@suse.cz (Jiri Slaby)
Date: Wed, 13 Sep 2017 08:04:57 +0200
Subject: [PATCH] sysrq : fix Show Regs call trace on ARM
In-Reply-To: <17da8267-c4aa-dc0f-1150-4fd5efe0073c@windriver.com>
References: <20170911031142.254308-1-jibin.xu@windriver.com>
 <8c09c309-e088-1dd6-8d6f-f8929acf0f5f@suse.cz>
 <5dd5bb30-15af-ab44-8b56-57c3c1d53bc4@windriver.com>
 <17da8267-c4aa-dc0f-1150-4fd5efe0073c@windriver.com>
Message-ID: <ac1a099b-2e7e-8001-24a2-679a0b7077a5@suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/11/2017, 01:22 PM, Jibin Xu wrote:
> Hi,Jiri: 
> 
> I tested get_irq_regs() behave in the softirq context,
> I called get_irq_regs() by a tasklet, It returns NULL.My understanding is get_irq_regs() can return the right result
> only in hardware IRQ,otherwise it returns ?????????L.
> So I think in_irq() would be better.

Hi,

tasklets are run in the process context (in a kthread). But what about
timers? HARDIRQ is decremented, SOFTIRQ remains set and sysrq handlers
are called in such conditions (in_interrupt() is true, in_irq() is
false). At that moment, irq_regs are still set and valid IMO.

But I would believe for now that sysrq handlers are not invoked from
softirq context. AFAIK they are called only from hardirq (serial port or
keyboard IRQ handler) or process context (write to /proc/sysrq-trigger).
So this change *should* be safe unless someone else objects there are
some kgdb special cases or something.

> thanks,
> Jibin Xu
> 
> On 2017???09???11??? 17:55, Jibin Xu wrote:
> 
>> Hi,Jiri:
>> get_irq_regs() in the softirq context return NULL.
>> thanks,
>> Jibin Xu
>> On 2017???09???11??? 13:24, Jiri Slaby wrote:
>>> On 09/11/2017, 05:11 AM, Jibin Xu wrote:
>>> ...
>>>> --- a/drivers/tty/sysrq.c
>>>> +++ b/drivers/tty/sysrq.c
>>>> @@ -245,8 +245,10 @@ static void sysrq_handle_showallcpus(int key)
>>>> ???????????? * architecture has no support for it:
>>>> ???????????? */
>>>> ?????????? if (!trigger_all_cpu_backtrace()) {
>>>> -?????????????? struct pt_regs *regs = get_irq_regs();
>>>> +?????????????? struct pt_regs *regs = NULL;
>>>> ?? 
>>>> +?????????????? if (in_irq())
>>>> +?????????????????????? regs = get_irq_regs();
>>> Maybe a stupid question: how does get_irq_regs() behave in the softirq
>>> context? I.e. what about s/in_irq/in_interrupt/?
>>> thanks,
>>
> 


-- 
js
suse labs
