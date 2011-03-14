From: arno.steffen@googlemail.com (Arno Steffen)
Date: Mon, 14 Mar 2011 14:26:35 +0100
Subject: IRQ handler under load - slow response
In-Reply-To: <20110309152252.GB333@e-circ.dyndns.org>
References: <AANLkTinTCfrPPwP6ZnWZTWW8vmR4=Uaw+OmHK7b99-9g@mail.gmail.com>
	<20110309152252.GB333@e-circ.dyndns.org>
Message-ID: <AANLkTikCSE3xOYsAnSJQQnW9iTrwbvoscU8hikkewGh6@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry for delay with resonse.
Thanks for your help. Most of this options for ps doesn't work on my
busybox embedded system.
Also chrt is not implemented currently. But that inspired me to
another idea. I just announced the irqs in a sperate process:
Is this what you proposed in b) ?

	i = fork();
	if (i == 0) {
		printf("Prio IRQ %d\n",getpriority(PRIO_PROCESS, getpid()));
		setpriority(PRIO_PROCESS, getpid(), -10);
		printf("Prio IRQ %d\n",getpriority(PRIO_PROCESS, getpid()));
		gpio_irq_setup(GPI_IN1, GPIOCFG_FALLINGDETECT_INTR, &irq_handler);
		gpio_irq_setup(GPI_IN2, GPIOCFG_RISINGDETECT_INTR, &irq_handler );
		printf("all IRQ handlers are setup !\n");
		do {sleep(1);} while(1);
		exit(0);
	}

This helps me reducing the delay to 2ms. Not very fast, but much
better than before.
Setting the priority doesn't have any effect by the way.

Best regards
Arno


2011/3/9 Kurt Van Dijck <kurt.van.dijck@eia.be>:
> On Wed, Mar 09, 2011 at 03:02:06PM +0100, Arno Steffen wrote:
>
>> ------------------
>>
>> What have I done wrong?
> You put code with different scheduling needs in the same scheduling pool.
>> Do I have a chance to speed up the response
>> from changing inputs?
>
> I've been playing with scheduling policies before (I'm not the expert).
> My hint:
> your tasklet is executed in the softirq handler. This will run at normal
> priority (see '$ ps -jefHc' for example)
>
> a)
> You could 'chrt --rr PID' of your softirqd
>
> b)
> replace your tasklet with a threaded irq handler, which you can
> 'chrt --rr PID'. This has the effect that only your own piece of code
> is raised in priority.
>>
>> best regards
>> Steffen
> Hope this will help.
> Kurt
>
