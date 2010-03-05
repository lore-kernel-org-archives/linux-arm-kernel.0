From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 5 Mar 2010 10:23:38 +0100
Subject: sharp c-3000 aka spitz: fix warn_on introduced in 2.6.32-rc1
In-Reply-To: <f17812d71001062333y2e49fa21scf91718da9ae3091@mail.gmail.com>
References: <20100106071026.GD1382@ucw.cz>
	<f17812d71001052317h2bf25fady6bd729b35ef6db63@mail.gmail.com>
	<20100107065230.GA1303@ucw.cz>
	<f17812d71001062333y2e49fa21scf91718da9ae3091@mail.gmail.com>
Message-ID: <20100305092338.GA32433@atrey.karlin.mff.cuni.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> >> > Sharp-SL code uses strange, complex grouping of gpios for wakeups
> >> > toggling. Fortunately, it is unneeded in recent kernels (and actually
> >> > provokes WARN_ONs during resume). Remove it.
> >> >
> >> > Signed-off-by: Pavel Machek <pavel@ucw.cz>
> >>
> >> Pavel,
> >>
> >> The code to be removed below is used to support pxa27x_keypad
> >> to be able to resume from sleep. What's the exact reason to remove
> >> this on spitz?
> >
> > Well, otherwise I get this during resume: (2.6.32 regression)
> >
> > (and similar for matrix-keypad, but dmitry worked around that
> > already).
> >
> > Problem is that gpio-keys and matrix-keypad want to set_wake for each
> > gpio individually, hw can do that, but pxa27x.c breaks it.
> >
> > I don't get it; what is pxa27x_keypad used on? It looks like
> > matrix-keypad subset.
> 
> pxa27x has its own specific keypad controller. And since we now
> use enable_irq_wake, and the keypad controller has only one
> such IRQ_KEYPAD, will have to setup the keypad GPIO wakeup
> as a whole.

But pxa27x keypad controlled is not used on spitz, right? So why do we
break spitz by tying GPIO wakeup settings together?
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
