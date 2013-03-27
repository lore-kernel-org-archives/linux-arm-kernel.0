From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 27 Mar 2013 01:38:40 -0700
Subject: [PATCH 1/5] clk: allow reentrant calls into the clk framework
In-Reply-To: <1364355211.22943.8.camel@bilhuang-vm1>
References: <1362026969-11457-1-git-send-email-mturquette@linaro.org>
 <1362026969-11457-2-git-send-email-mturquette@linaro.org>
 <1364355211.22943.8.camel@bilhuang-vm1>
Message-ID: <20130327083840.4014.41560@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Bill Huang (2013-03-26 20:33:31)
> On Thu, 2013-02-28 at 12:49 +0800, Mike Turquette wrote:
> > Reentrancy into the clock framework from the clk.h api is highly
> > desirable.  This feature is necessary for clocks that are prepared and
> > unprepared via i2c_transfer (which includes many PMICs and discrete
> > audio chips) and it is also necessary for performing dynamic voltage &
> > frequency scaling via clock rate-change notifiers.
> > 
> > This patch implements reentrancy by adding a global atomic_t which
> > tracks the context of the current caller.  Context in this case is the
> > return value from get_current().  The clk.h api implementations are
> > modified to first see if the relevant global lock is already held and if
> > so compare the global context (set by whoever is holding the lock)
> > against their own context (via a call to get_current()).  If the two
> > match then this function is a nested call from the one already holding
> > the lock and we procede.  If the context does not match then procede to
> > call mutex_lock and busy-wait for the existing task to complete.
> > 
> > Thus this patch set does not increase concurrency for unrelated calls
> > into the clock framework.  Instead it simply allows reentrancy by the
> > single task which is currently holding the global clock framework lock.
> > 
> > Thanks to Rajagoapl Venkat for the original idea to use get_current()
> > and to David Brown for the suggestion to replace my previous rwlock
> > scheme with atomic operations during code review at ELC 2013.
> > 
> > Signed-off-by: Mike Turquette <mturquette@linaro.org>
> > Cc: Rajagopal Venkat <rajagopal.venkat@linaro.org>
> > Cc: David Brown <davidb@codeaurora.org>
> > ---
> Hi Mike,
> 
> Will this single patch be accepted? I guess you might not merge the
> whole series but I think this one is useful, is it possible that you can
> send out this single patch (or just merge this one) as an improvement of
> CCF? Or you think otherwise?
> 

Bill,

Yes, I plan to merge this single patch for 3.10 and have posted a new
version fixing the issue pointed out by Ulf.  Please leave any review
comments you have.

Thanks,
Mike

> Thanks,
> Bill
