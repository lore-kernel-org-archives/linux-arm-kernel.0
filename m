From: rostedt@goodmis.org (Steven Rostedt)
Date: Tue, 22 Apr 2014 09:46:57 -0400
Subject: BUG: spinlock trylock failure on UP, i.MX28 3.12.15-rt25
In-Reply-To: <20140422115439.GA20669@linutronix.de>
References: <534C3606.7010206@meduna.org> <534C731F.1050406@meduna.org>
 <534DADF1.6060608@meduna.org>
 <20140422115439.GA20669@linutronix.de>
Message-ID: <20140422094657.5b6ca1e2@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[ added Peter ]

On Tue, 22 Apr 2014 13:54:39 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
 
> this is, erm, harmless. We grab the timer lock via trylock in hardirq
> context. If the lock is already taken then we fail to get it we go for
> plan B. According to lockdep a trylock should not fail on UP. This is
> true in general except for this timer case. I was thinking abour
> disabling this lockdep check?

trylock not failing on UP, can that be an issue? I mean, if a hardirq
does a trylock to see if it can grab a lock that is not protected by
disabling irqs, and will go to plan B if it fails, on UP, it will
always get it.  But the issue is still there. That would mean that a
hardirq could have preempted a critical section and doing a trylock
here would succeed when it really should have failed.

-- Steve
