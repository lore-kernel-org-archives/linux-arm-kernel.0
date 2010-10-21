From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 21 Oct 2010 11:04:28 +0200
Subject: [PATCH 1/3] drivers: misc: add omap_hwspinlock driver
In-Reply-To: <AANLkTikz-_qhjygzek4tR0CtDLih3ZQyy1mPKnXAiOiV@mail.gmail.com>
References: <1287387875-14168-1-git-send-email-ohad@wizery.com>
	<201010192308.02018.arnd@arndb.de>
	<AANLkTikz-_qhjygzek4tR0CtDLih3ZQyy1mPKnXAiOiV@mail.gmail.com>
Message-ID: <201010211104.28555.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 21 October 2010, Ohad Ben-Cohen wrote:
> This sounds like adding a set of API that resembles spin_{unlock,lock}_irq.
> 
> My gut feeling here is that while this may be useful and simple at
> certain places, it is somewhat error prone; a driver which would
> erroneously use this at the wrong place will end up enabling
> interrupts where it really shouldn't.
> 
> Don't you feel that proving a simple spin_lock_irqsave-like API is
> actually safer and less error prone ?
> 
> I guess that is one of the reasons why spin_lock_irqsave is much more
> popular than spin_lock_irq - people just know it will never screw up.

People can screw that up in different ways, e.g.

	spin_lock_irqsave(&lock_a, flags);
	spin_lock_irqsave(&lock_b, flags); /* overwrites flags */

	spin_lock_irqrestore(&lock_b, flags);
	spin_lock_irqrestore(&lock_a, flags); /* still disabled! */

I use the presence of spin_lock_irqsave in driver code as an indication
of whether the author had any clue about locking. Most experienced
coders use the right version intuitively, while beginners often just
use _irqsave because they didn't understand the API and they were told
that using this is safe.

	Arnd
