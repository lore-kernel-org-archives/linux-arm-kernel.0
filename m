From: peterz@infradead.org (Peter Zijlstra)
Date: Mon, 13 Jan 2014 13:04:35 +0100
Subject: [PATCH 1/1] mmc: sdhci: fix lockdep error on tunning routine
In-Reply-To: <CAA+hA=TRQP7hS3+iXyHg3FuNQKA=chJi7Ne47Ew_4RJcQ6yong@mail.gmail.com>
References: <1387797184-18958-1-git-send-email-b29396@freescale.com>
 <CAA+hA=TRQP7hS3+iXyHg3FuNQKA=chJi7Ne47Ew_4RJcQ6yong@mail.gmail.com>
Message-ID: <20140113120435.GQ31570@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 26, 2013 at 03:58:20PM +0800, Dong Aisheng wrote:
> > It's strange that this issue did not happen on kernel 3.10.17 with the same
> > code. And looking at the code, before call spin_lock we already disable the mmc
> > controller irq, per on my understanding, the deadlock given by lockdep may not
> > be able to happen(pls fix me if wrong).
> > May the lockdep not track the specific irq disable?
> > Copy lockdep guy to comment.

No, lockdep also doesn't know only that one line can take this lock.
Lockdep only knows a lock is taken from IRQ context, and disabling one
line still allows IRQs to happen and therefore it yells.
