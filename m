From: daniel@caiaq.de (Daniel Mack)
Date: Mon, 2 Nov 2009 12:27:25 +0100
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
Message-ID: <20091102112725.GX14091@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 02, 2009 at 07:18:02AM -0400, Haojian Zhuang wrote:
> On Mon, Nov 2, 2009 at 6:51 AM, Pavel Machek <pavel@ucw.cz> wrote:
> >>
> >> It seems that we're talking on different issue with similar symptom.
> >> Please check my test method. While I'm testing suspend with devices
> >> level, kernel is blocked in console resume. In this level, it won't
> >> call arch_suspend_enable_irqs(). This function call is only invoked in
> >> processor level or below.
> >
> > For me, everything but real suspend works. I do _not_ have serial
> > console for spitz.
> >
> >> Up to now, I can't reproduce the issue you're talking on my platform
> >> yet. I'll check this issue continuously. I also want to know your
> >> hardware information.
> >
> > Spitz, aka Sharp Zaurus c3000.
> >
> 
> I see. You can chech my patch in below. I need to save IPRs in suspend
> resume routine.

Yep - that fixes it on my platform. Great. Add my 'Tested-by' if you
like.

Thanks,
Daniel

> From 1764e836424d42a0654b8b73c402a2dddb118dc4 Mon Sep 17 00:00:00 2001
> From: Haojian Zhuang <haojian.zhuang@marvell.com>
> Date: Mon, 2 Nov 2009 14:02:21 -0500
> Subject: [PATCH] pxa: fix system resume issue on pxa27x and pxa3xx
> 
> Since interrupt handler is changed to use interrupt priority, we also need to
> save and restore these interrupt controller registers in suspend/resume
> routine.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> ---
>  arch/arm/mach-pxa/irq.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-pxa/irq.c b/arch/arm/mach-pxa/irq.c
> index d694ce2..cdc272b 100644
> --- a/arch/arm/mach-pxa/irq.c
> +++ b/arch/arm/mach-pxa/irq.c
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
>  		saved_icmr[i] = _ICMR(irq);
>  		_ICMR(irq) = 0;
>  	}
> +	if (pxa_internal_irq_nr > 128)
> +		BUG();
> +	for (i = 0; i < pxa_internal_irq_nr; i++)
> +		saved_ipr[i] = IPR(i);
> 
>  	return 0;
>  }
> @@ -171,6 +176,8 @@ static int pxa_irq_resume(struct sys_device *dev)
>  		_ICMR(irq) = saved_icmr[i];
>  		_ICLR(irq) = 0;
>  	}
> +	for (i = 0; i < pxa_internal_irq_nr; i++)
> +		IPR(i) = saved_ipr[i];
> 
>  	ICCR = 1;
>  	return 0;
> -- 
> 1.5.6.5
