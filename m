From: peterz@infradead.org (Peter Zijlstra)
Date: Wed, 12 Mar 2014 17:30:26 +0100
Subject: [RFC PATCH V3 3/6] arm: mm: implement get_user_pages_fast
In-Reply-To: <CAPvkgC1sphjikAaUXSEyRMiQ+wDNwgTw-mhL++DzBLGBqMdtTg@mail.gmail.com>
References: <1394631623-17883-1-git-send-email-steve.capper@linaro.org>
 <1394631623-17883-4-git-send-email-steve.capper@linaro.org>
 <20140312141800.GD27965@twins.programming.kicks-ass.net>
 <CAPvkgC1sphjikAaUXSEyRMiQ+wDNwgTw-mhL++DzBLGBqMdtTg@mail.gmail.com>
Message-ID: <20140312163026.GI27965@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 12, 2014 at 04:20:15PM +0000, Steve Capper wrote:
> On 12 March 2014 14:18, Peter Zijlstra <peterz@infradead.org> wrote:
> > Since you just went through the trouble of enabling RCU pagetable
> > freeing, you might also replace these local_irq_save/restore with
> > rcu_read_{,un}lock().
> 
> Hi Peter,
> This critical section also needs to block the THP splitting code. At
> the moment an IPI is broadcast in pmdp_splitting_flush. I'm not sure
> how to adapt that to block on an rcu_read_lock, I'll have a think.

Ah, I've not looked at THP much at all.

Would it be sufficient to make sure to fail the pmd get_page()
equivalent early enough?
