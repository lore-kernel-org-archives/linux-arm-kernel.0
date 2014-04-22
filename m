From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Tue, 22 Apr 2014 13:54:39 +0200
Subject: BUG: spinlock trylock failure on UP, i.MX28 3.12.15-rt25
In-Reply-To: <534DADF1.6060608@meduna.org>
References: <534C3606.7010206@meduna.org> <534C731F.1050406@meduna.org>
 <534DADF1.6060608@meduna.org>
Message-ID: <20140422115439.GA20669@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Stanislav Meduna | 2014-04-16 00:08:49 [+0200]:

>Hmm... how is it in the rt-case guaranteed that the timer interrupt
>does not preempt someone trying to modify the timer? The run_local_timers
>looks to have arrived via hardirq context. The spinlock in the tvec_base
>is a normal one and spin_lock_irqsave does not disable interrupts
>on rt, right?

this is, erm, harmless. We grab the timer lock via trylock in hardirq
context. If the lock is already taken then we fail to get it we go for
plan B. According to lockdep a trylock should not fail on UP. This is
true in general except for this timer case. I was thinking abour
disabling this lockdep check?

Sebastian
