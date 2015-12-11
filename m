From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Fri, 11 Dec 2015 11:28:45 +0000
Subject: [PATCHv3 5/5] arm-cci: CCI-500: Work around PMU counter writes
In-Reply-To: <20151210154251.GG495@leverpostej>
References: <1447783407-18027-1-git-send-email-suzuki.poulose@arm.com>
 <1447783407-18027-6-git-send-email-suzuki.poulose@arm.com>
 <20151210154251.GG495@leverpostej>
Message-ID: <566AB36D.9050209@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/12/15 15:42, Mark Rutland wrote:
> On Tue, Nov 17, 2015 at 06:03:27PM +0000, Suzuki K. Poulose wrote:
>> The CCI PMU driver sets the event counter to the half of the maximum
>> value(2^31) it can count before we start the counters via
>> pmu_event_set_period(). This is done to give us the best chance to
>> handle the overflow interrupt, taking care of extreme interrupt latencies.


>
> This should work, but it seems very heavyweight given we do it for each
> write.
>
> Can we not amortize this by using the {start,commit,cancel}_txn hooks?
>
> Either we can handle 1-4 and 6-8 in those, or we can copy everything
> into a shadow state and apply it all in one go at commit_txn time.

I took a look at it. The only worrying part is, if pmu->add() will be
called outside *_txn().

from linux/perf_event.h:

         /*
          * Adds/Removes a counter to/from the PMU, can be done inside a
          * transaction, see the ->*_txn() methods.
          *

As of now it is only called within the transactions, but the comment somehow
doesn't look like enforces it.

Thoughts ?

Suzuki
