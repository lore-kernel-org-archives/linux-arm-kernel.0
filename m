From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Tue, 27 Oct 2015 19:54:40 +0200
Subject: [PATCH] gpio: zynq: Implement irq_(request|release)_resources
In-Reply-To: <CACRpkdYjNWiEdM8kthMXhGXBPYE74hy_xa7bBB6XQrAOaBnehA@mail.gmail.com>
References: <1445607381-7794-1-git-send-email-soren.brinkmann@xilinx.com>
 <CACRpkda4QKEJvwkwGLS7OLTP8Nxu5W05tzbcFXA_FPnBsFtKhw@mail.gmail.com>
 <562FA3EE.5040408@ti.com>
 <CACRpkdYjNWiEdM8kthMXhGXBPYE74hy_xa7bBB6XQrAOaBnehA@mail.gmail.com>
Message-ID: <562FBA60.70002@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/27/2015 06:23 PM, Linus Walleij wrote:
> On Tue, Oct 27, 2015 at 5:18 PM, Grygorii Strashko
> <grygorii.strashko@ti.com> wrote:
>> On 10/27/2015 05:53 PM, Linus Walleij wrote:
>>>
>>> On Fri, Oct 23, 2015 at 3:36 PM, Soren Brinkmann
>>> <soren.brinkmann@xilinx.com> wrote:
>>>
>>>> The driver uses runtime PM to leverage low power techniques. For
>>>> use-cases using GPIO as interrupt the device needs to be in an
>>>> appropriate state.
>>>>
>>>> Reported-by: John Linn <linnj@xilinx.com>
>>>> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
>>>> Tested-by: John Linn <linnj@xilinx.com>
>>>
>>>
>>> As pointed out by Grygorii in
>>> commit aca82d1cbb49af34b69ecd4571a0fe48ad9247c1:
>>>
>>>       The PM runtime API can't be used in atomic contex on -RT even if
>>>       it's configured as irqsafe. As result, below error report can
>>>       be seen when PM runtime API called from IRQ chip's callbacks
>>>       irq_startup/irq_shutdown/irq_set_type, because they are
>>>       protected by RAW spinlock:
>>> (...)
>>>       The IRQ chip interface defines only two callbacks which are executed
>>> in
>>>       non-atomic contex - irq_bus_lock/irq_bus_sync_unlock, so lets move
>>>       PM runtime calls there.
>>>
>>> I.e. these calls are atomic context and it's just luck that it works
>>> and this is fragile.
>>>
>>> Can you please check if you can move it to
>>> irq_bus_lock()/irq_sync_unlock()
>>> like Grygorii does?
>>>
>>
>> This patch rises the question not only about PM runtime, but also
>> about gpiochip_irq_reqres()/gpiochip_irq_relres().
> 
> Do you mean that these functions contain calls to non-atomic
> functions?
> 

Oh. No, I have to be more specific :(
if GPIOx driver defines custom .irq_(request|release)_resources() callbacks
they will *overwrite* standard GPIOirqchip callbacks.
(commit: 8b67a1f "gpio: don't override irq_*_resources() callbacks")

As result, such GPIOx driver should *re-implement* the same functionality in
its .irq_(request|release)_resources() callbacks as implemented in
gpiochip_irq_reqres()/gpiochip_irq_relres().

> I mainly reacted to this because it was pm_* calls, that you
> mentioned explicitly in your patch.
> 
-- 
regards,
-grygorii
