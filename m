From: peterz@infradead.org (Peter Zijlstra)
Date: Thu, 17 Dec 2015 19:42:55 +0100
Subject: [PATCH v4 05/12] arm-cci: PMU: Add support for transactions
In-Reply-To: <1450374559-23315-6-git-send-email-suzuki.poulose@arm.com>
References: <1450374559-23315-1-git-send-email-suzuki.poulose@arm.com>
 <1450374559-23315-6-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20151217184255.GI6344@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 17, 2015 at 05:49:12PM +0000, Suzuki K. Poulose wrote:
> This patch adds the transaction hooks for CCI PMU, which can be
> later exploited to amortise the cost of writing the counters for
> CCI-500 PMU.
> 
> We keep track of only the 'ADD' transactions. While we are in a
> transaction, we keep track of the indices allocated for the events
> and delay the following operations until the transaction is committed.
>  1) Programming the event on the counter
>  2) Enabling the counter
>  3) Setting the period for the event.

So that's not really what the txn interface is for, its meant to
amortize event scheduling.

The above doesn't look like it has a failure case, in which case you can
achieve the same simpler, using pmu::pmu_{dis,en}able().
