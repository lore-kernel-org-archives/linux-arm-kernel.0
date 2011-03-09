From: kurt.van.dijck@eia.be (Kurt Van Dijck)
Date: Wed, 9 Mar 2011 16:22:53 +0100
Subject: IRQ handler under load - slow response
In-Reply-To: <AANLkTinTCfrPPwP6ZnWZTWW8vmR4=Uaw+OmHK7b99-9g@mail.gmail.com>
References: <AANLkTinTCfrPPwP6ZnWZTWW8vmR4=Uaw+OmHK7b99-9g@mail.gmail.com>
Message-ID: <20110309152252.GB333@e-circ.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 09, 2011 at 03:02:06PM +0100, Arno Steffen wrote:

> ------------------
> 
> What have I done wrong?
You put code with different scheduling needs in the same scheduling pool.
> Do I have a chance to speed up the response
> from changing inputs?

I've been playing with scheduling policies before (I'm not the expert).
My hint:
your tasklet is executed in the softirq handler. This will run at normal
priority (see '$ ps -jefHc' for example)

a)
You could 'chrt --rr PID' of your softirqd

b)
replace your tasklet with a threaded irq handler, which you can
'chrt --rr PID'. This has the effect that only your own piece of code
is raised in priority.
> 
> best regards
> Steffen
Hope this will help.
Kurt
