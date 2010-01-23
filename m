From: utx@penguin.cz (Stanislav Brabec)
Date: Sat, 23 Jan 2010 20:41:09 +0100
Subject: sharp c-3000 aka spitz: fix warn_on introduced in 2.6.32-rc1
In-Reply-To: <f17812d71001062333y2e49fa21scf91718da9ae3091@mail.gmail.com>
References: <20100106071026.GD1382@ucw.cz>
	<f17812d71001052317h2bf25fady6bd729b35ef6db63@mail.gmail.com>
	<20100107065230.GA1303@ucw.cz>
	<f17812d71001062333y2e49fa21scf91718da9ae3091@mail.gmail.com>
Message-ID: <1264275669.9100.11.camel@utx.utx.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Eric Miao wrote:
> >
> > I don't get it; what is pxa27x_keypad used on? It looks like
> > matrix-keypad subset.

> pxa27x has its own specific keypad controller. And since we now
> use enable_irq_wake, and the keypad controller has only one
> such IRQ_KEYPAD, will have to setup the keypad GPIO wakeup
> as a whole.

Looking deeper into it, the problem seems to be elsewhere:
I just added debug message to start and end of set_irq_wake().

And here is what I got during suspend:

set_irq_wake() started IRQ: 191 to 1, desc->wake_depth: 0
set_irq_wake() done IRQ: 191 to 1, desc->wake_depth: 0
set_irq_wake() started IRQ: 108 to 1, desc->wake_depth: 0
set_irq_wake() done IRQ: 108 to 1, desc->wake_depth: 1
set_irq_wake() started IRQ: 113 to 1, desc->wake_depth: 0
set_irq_wake() done IRQ: 113 to 1, desc->wake_depth: 0
set_irq_wake() started IRQ: 187 to 1, desc->wake_depth: 0
set_irq_wake() done IRQ: 187 to 1, desc->wake_depth: 0
set_irq_wake() started IRQ: 130 to 1, desc->wake_depth: 0
set_irq_wake() done IRQ: 130 to 1, desc->wake_depth: 0
set_irq_wake() started IRQ: 132 to 1, desc->wake_depth: 0
set_irq_wake() done IRQ: 132 to 1, desc->wake_depth: 0
set_irq_wake() started IRQ: 134 to 1, desc->wake_depth: 0
set_irq_wake() done IRQ: 134 to 1, desc->wake_depth: 0
set_irq_wake() started IRQ: 135 to 1, desc->wake_depth: 0
set_irq_wake() done IRQ: 135 to 1, desc->wake_depth: 0
set_irq_wake() started IRQ: 31 to 1, desc->wake_depth: 0
set_irq_wake() done IRQ: 31 to 1, desc->wake_depth: 1

I think that if (desc->wake_depth == 0) when set_irq_wake(foo, 1) is
done, then something went wrong. And it is not surprise, that it reports
Unbalanced IRQ on resume.

Note that other people (Cyril Hrubi?) with a bit different .config
report success with gpio keys driver turned on.

My config:
http://www.penguin.cz/~utx/zaurus/feed/images/spitz/config-2.6.33-rc4-spitz

OT: Serial console resume did not work properly even with
no_console_suspend and my patch:
[PATCH 4/8] serial-core: resume serial hardware with no_console_suspend


________________________________________________________________________
Stanislav Brabec
http://www.penguin.cz/~utx/zaurus
