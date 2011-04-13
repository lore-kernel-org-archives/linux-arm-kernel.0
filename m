From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Wed, 13 Apr 2011 11:45:19 +0300
Subject: [PATCH 1/2] ux500: Adding support for u8500 Hsem functionality V2
In-Reply-To: <4DA4A44D.5020208@linaro.org>
References: <1302535464-12294-1-git-send-email-mathieu.poirier@linaro.org>
	<201104121946.01618.arnd@arndb.de> <4DA4A44D.5020208@linaro.org>
Message-ID: <BANLkTi=UnOdSskB5_+2bNH9B6MT=LDEOEQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 12, 2011 at 10:13 PM, Mathieu Poirier
<mathieu.poirier@linaro.org> wrote:
>>> +struct u8500_hsem {
>>> + ? ? ? struct hwspinlock lock;
>>> + ? ? ? void __iomem *addr;
>>> +};
>>
>> It seems inconsistent to name it sem instead of spinlock.
>>
> This is a good point and I've been going back and forth on that one. ?TI's
> implementation is based on 'spinlock' but in this case there is not a single
> mention of a 'spinlock' in the CPU's reference manual, leaving potential
> users to wonder if spinlock == hsem.

I figured out this was your line of thought.

Looking forward, though, we have some design decisions to do which are
related to this spinlock vs. semaphore issue - it's much more than
just names.

While the OMAP hardware currently has only these hwspinlocks modules,
which require the host to spin until they become free, we now have two
other systems (the u8500 and TI's C6474) which also support additional
semaphore-like functionality of queuing, owner semantics and interrupt
notification (so the host wouldn't have to spin, and the lock can be
used for a wider range of non-atomic use cases).

Sadly, the specs of the u8500 are closed, which makes it somewhat hard
to start any reasonable design discussions.

Btw, last I heard, mainline c6x support is coming. but it's not there yet.
