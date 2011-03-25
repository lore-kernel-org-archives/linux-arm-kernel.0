From: arno.steffen@googlemail.com (Arno Steffen)
Date: Fri, 25 Mar 2011 09:46:43 +0100
Subject: IRQ handler under load - slow response
In-Reply-To: <20110324144518.GA27661@e-circ.dyndns.org>
References: <AANLkTinTCfrPPwP6ZnWZTWW8vmR4=Uaw+OmHK7b99-9g@mail.gmail.com>
	<20110309152252.GB333@e-circ.dyndns.org>
	<AANLkTikCSE3xOYsAnSJQQnW9iTrwbvoscU8hikkewGh6@mail.gmail.com>
	<20110314144715.GH333@e-circ.dyndns.org>
	<AANLkTinmQ0seioxSPaj8eqHAwuDpuDSCSmg=BTYHbrkT@mail.gmail.com>
	<20110324144518.GA27661@e-circ.dyndns.org>
Message-ID: <AANLkTikQhKz73sv1so2EepdeP5Nh6ZiLJ4+MKcNkt+u=@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/3/24 Kurt Van Dijck <kurt.van.dijck@eia.be>:
> On Thu, Mar 24, 2011 at 12:56:48PM +0100, Arno Steffen wrote:
>> 2011/3/14 Kurt Van Dijck <kurt.van.dijck@eia.be>:
>> > On Mon, Mar 14, 2011 at 02:26:35PM +0100, Arno Steffen wrote:
>> > Euhm, my proposed b) deals in kernel. I think your example is in userspace?
>> > Maybe I don't understand your precise setup well.
>> >
>> > static irqreturn_t GpioIrqHandler (int irq, void *dev_id)
>> > {
>> > ? ?int s32GpioNumber = 0 ;
>> > ? ?s32GpioNumber = irq - IH_GPIO_BASE;
>> > ? ?set_bit (s32GpioNumber , (volatile unsigned long *) &gsts32GpioIrqStatus);
>> > - ? tasklet_schedule (&GpioTasklet);
>> > - ? return IRQ_HANDLED;
>> > + ? return IRQ_WAKE_THREAD;
>> > }
>> >
>> > -DECLARE_TASKLET(GpioTasklet, GpioIntrTasklet, 0);
>> > static irqreturn_t GpioIrqThread(int irq, void *dev_id)
>> > {
>> > ? ? ? ?/* do whatever the tasklet was supposed to do */
>> > }
>> >
>>
>> Dear Kurt,
>> I did as you proposed, but doesn't have the big picture
>>
>> I think there is a typo in your request_irq change:
>
>> Is this what you mean? What you have suggested is replacing a flag by
>> a pointer - this cannot work. I can't see how ?GpioIrqHandler and
>> GpioIrqThread are connected now.
> my mistake, I had in mind to replace request_irq with 'requist_threaded_irq'.
> sorry for that noise. ?(I hope you did not loose too much time with that :-) ).
>
> ? ? ? ?s32Status = request_threaded_irq((IH_GPIO_BASE + s32AppRecvGpioNum),
> ? ? ? ? ? ? ? ? ? ? ? ?GpioIrqHandler, GpioIrqThread, 0, "GPIOINTR", NULL);
>
> And then, you can pull your tasklet out of the softirq thread into a seperate
> kernel thread (which you can set SCHED_FIFO with sched_setscheduler(2)).
>>
>> I am not sure this help. The kernel thread might become a higher
>> proirity, but what has to be improved is that the IRQ-routine in user
>> space is responding faster.
> This makes your bottom-halve respond regardless of the other load, due to the
> scheduling policy.
> This will not yet impact any userspace stuff. Therefore, set the scheduling
> policy of you userspace task too.
>
> In fact, the latter (setting scheduling policy of the userspace) is probably
> the first step to take. put:
>
> #include <sched.h>
>
>
> int main(...) {
> ? ? ? ?const struct sched_param sched_param = {
> ? ? ? ? ? ? ? ?.sched_priority = 50,
> ? ? ? ?};
> ? ? ? ?int ret;
>
> ? ? ? ?ret = sched_setscheduler(0, SCHED_FIFO, &sched_param);
> ? ? ? ?if (ret < 0)
> ? ? ? ? ? ? ? ?perror(...);
>
> ? ? ? ?....
> }
>
> into your userspace program.
>>
>> Does it make sense to send you the hole code? I am afraid that there
>> is to much potential for misunderstanding.
> This time, it was my wrong info.
> I don't feel like digging in code yet, since it comprises very different parts
> (kernel & userspace).
>> Best regards
>> Arno

I get it working with your help. I see now threads for every IRQ I
anounce to the system. Nevertheless it doesn't change the behaviour,
even after increasing their prio. My assumption is: The kernel IRQs
threads are processed fast, I do have the trouble on the user side of
the IRQ handler.

The best performance I get, if all processes on my device are running
in policy OTHER. As soon as my code is running in FIFO or RR I have
problems. If the IRQs-thread has higher priority it works better, but
is far away from reliability of OTHER policy. This is in opposite to
all what I know about scheduling policies.

Best regards
Arno
