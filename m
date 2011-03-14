From: kurt.van.dijck@eia.be (Kurt Van Dijck)
Date: Mon, 14 Mar 2011 15:47:15 +0100
Subject: IRQ handler under load - slow response
In-Reply-To: <AANLkTikCSE3xOYsAnSJQQnW9iTrwbvoscU8hikkewGh6@mail.gmail.com>
References: <AANLkTinTCfrPPwP6ZnWZTWW8vmR4=Uaw+OmHK7b99-9g@mail.gmail.com>
	<20110309152252.GB333@e-circ.dyndns.org>
	<AANLkTikCSE3xOYsAnSJQQnW9iTrwbvoscU8hikkewGh6@mail.gmail.com>
Message-ID: <20110314144715.GH333@e-circ.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 14, 2011 at 02:26:35PM +0100, Arno Steffen wrote:
> 
> Sorry for delay with resonse.
No problem.
> Thanks for your help. Most of this options for ps doesn't work on my
> busybox embedded system.
Yep, we use a regular ps for that.
> Also chrt is not implemented currently. But that inspired me to
try a program with sched_setscheduler(2)
> another idea. I just announced the irqs in a sperate process:
> Is this what you proposed in b) ?
> 
> 	i = fork();
> 	if (i == 0) {
> 		printf("Prio IRQ %d\n",getpriority(PRIO_PROCESS, getpid()));
> 		setpriority(PRIO_PROCESS, getpid(), -10);
> 		printf("Prio IRQ %d\n",getpriority(PRIO_PROCESS, getpid()));
> 		gpio_irq_setup(GPI_IN1, GPIOCFG_FALLINGDETECT_INTR, &irq_handler);
> 		gpio_irq_setup(GPI_IN2, GPIOCFG_RISINGDETECT_INTR, &irq_handler );
> 		printf("all IRQ handlers are setup !\n");
> 		do {sleep(1);} while(1);
> 		exit(0);
> 	}
Euhm, my proposed b) deals in kernel. I think your example is in userspace?
Maybe I don't understand your precise setup well.

Anyway, what I meant was something in kernel like:
  s32Status = request_irq((IH_GPIO_BASE + s32AppRecvGpioNum),
                                     GpioIrqHandler,
-				     0,
+                                     GpioIrqThread,
                                     "GPIOINTR",
                                     NULL);

static irqreturn_t GpioIrqHandler (int irq, void *dev_id)
{
    int s32GpioNumber = 0 ;
    s32GpioNumber = irq - IH_GPIO_BASE;
    set_bit (s32GpioNumber , (volatile unsigned long *) &gsts32GpioIrqStatus);
-   tasklet_schedule (&GpioTasklet);
-   return IRQ_HANDLED;
+   return IRQ_WAKE_THREAD;
}

-DECLARE_TASKLET(GpioTasklet, GpioIntrTasklet, 0);
static irqreturn_t GpioIrqThread(int irq, void *dev_id)
{
	/* do whatever the tasklet was supposed to do */
}

no, you get a seperate kernel thread that you can play with (chrt etc.).

> 
> This helps me reducing the delay to 2ms. Not very fast, but much
> better than before.
I was not aware of that there was a userspace process involved.
setting that process to SCHED_RR too (together with the kernel thread when applicable)
is a good idea.

> Setting the priority doesn't have any effect by the way.
Yep, SCHED_RR or SCHED_FIFO will do.
> 
> Best regards
> Arno
