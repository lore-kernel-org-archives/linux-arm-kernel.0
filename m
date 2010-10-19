From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Tue, 19 Oct 2010 22:43:34 +0200
Subject: [PATCH 1/3] drivers: misc: add omap_hwspinlock driver
In-Reply-To: <AANLkTimDdPUjo+65vBL0PTQ3b=5NpeVT28XrdkYqx3Ex@mail.gmail.com>
References: <1287387875-14168-1-git-send-email-ohad@wizery.com>
	<1287387875-14168-2-git-send-email-ohad@wizery.com>
	<AANLkTimDdPUjo+65vBL0PTQ3b=5NpeVT28XrdkYqx3Ex@mail.gmail.com>
Message-ID: <AANLkTinNfERyi_bTWc7LOKR1uRLC3E612ubFKBLxWB1E@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 19, 2010 at 7:01 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
>> + ?struct omap_hwspinlock *omap_hwspinlock_request(void);
...
> ERR_PTR() is only appropriate when the caller actually cares about the
> failure code and has different behaviour depending on the result.

Agree; the hwspinlock users can surely live without an explicit error
code from the _request APIs, and some extra robustness can only do
good.

I'll remove it.

> Disabling irqs *might* be a concern as a source of RT latency. ?It
> might be better to make the caller responsible for managing local spin
> locks and irq disable/enable.

This a coming from an hardware requirement, rather than a choice the
user should take.

If a hwspinlock is taken over a long period of time, its other user
(with which we try to achieve synchronization) might be polling the
OMAP interconnect for too long (trying to take the hwspinlock) and
thus preventing it to be used for other transactions.

To prevent such lengthy polling on the interconnect, the hwspinlock
should only be used for very short period of times, with preemption
and interrupts disabled.

That's why we don't give users the choice whether to disable
interrupts or not - it's simply not a decision they should take.

Thanks,
Ohad.
