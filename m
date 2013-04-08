From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 8 Apr 2013 23:29:07 +0200
Subject: [RFC PATCH arm: initial TI-Nspire support]
In-Reply-To: <op.wu8ng3wyu7prd4@fabians-laptop.fritz.box>
References: <6FE4B33E-A503-4A75-AEED-831CB2C06D83@gmail.com>
 <201304082138.15875.arnd@arndb.de>
 <op.wu8ng3wyu7prd4@fabians-laptop.fritz.box>
Message-ID: <201304082329.08105.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 08 April 2013, Fabian Vogt wrote:
> Yes, I've heard that before, but than it would work/not work independently
> of NO_HZ. Can printk's be executet within console_lock() ..  
> console_unlock() blocks?

I think it's legal to call printk in that case, but the message will
not be printed until you reach the console_unlock()

> If not, it could be fb_notifier_call_chain, too, but that wouldn't be  
> likely at all.
> I also tried spinlock/mutex debugging and soft lockup detection,
> but neither of them outputs anything.

Unfortunately, lockdep does not help with console_lock, since that
is a weird semaphore variant, not a standard mutex or spinlock.

	Arnd
