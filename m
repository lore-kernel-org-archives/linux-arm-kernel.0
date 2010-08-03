From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Tue, 3 Aug 2010 14:44:30 +0200
Subject: [patch 2/2] arm: Implement l2x0 cache disable functions
In-Reply-To: <20100705113227.750612927@linutronix.de>
References: <20100705113029.082013074@linutronix.de>
	<20100705113227.750612927@linutronix.de>
Message-ID: <AANLkTikHNFS9j-RuGd41qbFekMsTK5U-G+JZw+UedFdN@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/7/5 Thomas Gleixner <tglx@linutronix.de>:

> Add flush_all, inv_all and disable functions to the l2x0 code. These
> functions are called from kexec code to prevent random crashes in the
> new kernel.
> (...)
> +static void l2x0_disable(void)
> +{
> + ? ? ? unsigned long flags;
> +
> + ? ? ? spin_lock_irqsave(&l2x0_lock, flags);
> + ? ? ? writel(0, l2x0_base + L2X0_CTRL);
> + ? ? ? spin_unlock_irqrestore(&l2x0_lock, flags);
> +}
> +

Does this take into account this comment from Srinidhi:

[Srinidhi KASAGAR wrote]
> I think it's a problem for PL310 controller where the access to
> L2X0_CTRL is secure, accessing this in non-secure mode will fault.

I'm worried that a writel() into the CTRL register like that will cause
a bus error on platforms that have L2x0 in Trusted World (TrustZone)?
Or that it may be ignored simply on such platforms causing
trouble that way?

Yours,
Linus Walleij
