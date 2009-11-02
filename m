From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 2 Nov 2009 13:22:58 +0100
Subject: Possible suspend/resume regression in .32-rc?
In-Reply-To: <771cded00911020318u3939a06dq75cd3504d6c0eb50@mail.gmail.com>
References: <20091031013427.GL14091@buzzloop.caiaq.de>
	<20091101205449.GT14091@buzzloop.caiaq.de>
	<20091101213343.GA31345@elf.ucw.cz>
	<20091101220341.GA16698@elf.ucw.cz>
	<771cded00911020122o3bb5cc96q957c8be1ce7cae46@mail.gmail.com>
	<20091102093840.GA11426@elf.ucw.cz>
	<771cded00911020248s2b2b6577o5ec2f3772a09e7b9@mail.gmail.com>
	<20091102105141.GB11426@elf.ucw.cz>
	<771cded00911020318u3939a06dq75cd3504d6c0eb50@mail.gmail.com>
Message-ID: <20091102122258.GA22624@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> >> > Given that it hangs very early, in arch_suspend_enable_irqs() (see my
> >> > other mail), I don't trust your analysis.
> >> >
> >> > I'm not using serial console on spitz, and I have never had successful
> >> > resume with the patch applied.
...
> I see. You can chech my patch in below. I need to save IPRs in suspend
> resume routine.
...
> >From 1764e836424d42a0654b8b73c402a2dddb118dc4 Mon Sep 17 00:00:00 2001
> From: Haojian Zhuang <haojian.zhuang@marvell.com>
> Date: Mon, 2 Nov 2009 14:02:21 -0500
> Subject: [PATCH] pxa: fix system resume issue on pxa27x and pxa3xx
> 
> Since interrupt handler is changed to use interrupt priority, we also need to
> save and restore these interrupt controller registers in suspend/resume
> routine.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>

Acked-by: Pavel Machek <pavel@ucw.cz>
Tested-by: Pavel Machek <pavel@ucw.cz>

> @@ -150,6 +150,7 @@ void __init pxa_init_irq(int irq_nr, set_wake_t fn)
> 
>  #ifdef CONFIG_PM
>  static unsigned long saved_icmr[2];
> +static unsigned long saved_ipr[128];
> 
>  static int pxa_irq_suspend(struct sys_device *dev, pm_message_t state)
>  {
> @@ -159,6 +160,10 @@ static int pxa_irq_suspend(struct sys_device
> *dev, pm_message_t state)

Note: Your mail client is word-wrapping.

>  		saved_icmr[i] = _ICMR(irq);
>  		_ICMR(irq) = 0;
>  	}
> +	if (pxa_internal_irq_nr > 128)
> +		BUG();

BUG_ON()? WARN_ON() then irq_nr = 128? User is very unlikely to read
the BUG() message at this point...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
