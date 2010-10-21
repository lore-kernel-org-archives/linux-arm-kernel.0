From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Thu, 21 Oct 2010 12:13:42 +0200
Subject: [PATCH 1/3] drivers: misc: add omap_hwspinlock driver
In-Reply-To: <201010211104.28555.arnd@arndb.de>
References: <1287387875-14168-1-git-send-email-ohad@wizery.com>
	<201010192308.02018.arnd@arndb.de>
	<AANLkTikz-_qhjygzek4tR0CtDLih3ZQyy1mPKnXAiOiV@mail.gmail.com>
	<201010211104.28555.arnd@arndb.de>
Message-ID: <AANLkTimWG_38hY2Xq=G7r42eP+zmA24Gaw4-hLVJstVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 21, 2010 at 11:04 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 21 October 2010, Ohad Ben-Cohen wrote:
>> This sounds like adding a set of API that resembles spin_{unlock,lock}_irq.
>>
>> My gut feeling here is that while this may be useful and simple at
>> certain places, it is somewhat error prone; a driver which would
>> erroneously use this at the wrong place will end up enabling
>> interrupts where it really shouldn't.
>>
>> Don't you feel that proving a simple spin_lock_irqsave-like API is
>> actually safer and less error prone ?
>>
>> I guess that is one of the reasons why spin_lock_irqsave is much more
>> popular than spin_lock_irq - people just know it will never screw up.
>
> People can screw that up in different ways, e.g.

Sure...

> I use the presence of spin_lock_irqsave in driver code as an indication
> of whether the author had any clue about locking. Most experienced
> coders use the right version intuitively, while beginners often just
> use _irqsave because they didn't understand the API and they were told
> that using this is safe.

Agree.

I'll add the _irq pair of APIs, this will make the users' code
cleaner. This is valuable especially since all of our current users
have their interrupts enabled anyway.

The change is also pretty trivial:

* move the internal locking implementation to raw_ methods
* the raw_ methods would save the current interrupt state only if
given a placeholder
* wrap those raw_ methods with the desired API (but only support the
_irq and _irqsave flavors)

Thanks,
Ohad.
