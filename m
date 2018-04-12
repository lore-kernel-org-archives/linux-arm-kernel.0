From: ttnguyen@apm.com (Tai Tri Nguyen)
Date: Thu, 12 Apr 2018 10:10:40 -0700
Subject: [bug report] locking/qrwlock, arm64: Move rwlock implementation over
 to qrwlocks causes CPU crashes/stalls when killing java processes
Message-ID: <CACgAJHzeS7CNqLaVckNtS5BNTsqe0ac+u0LwJAr1_1i1=OLcnA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

Recently I have observed the CPU crashes/stalls when rebooting after I
ran cassandra benchmark.
The issue happens randomly.

I could reproduce the issue easier by keep starting/killing cassandra
tests. The issue would occur within about 50 iterations.

I could also reproduce the issue by keep running/killing specjvm2008.
However it takes me much longer time to see the CPU crash/stall issue.

I bisected kernel and found that this changelist below is causing the issue.

commit 087133ac90763cd339b6b67f2998f87dcc136c52
Author: Will Deacon <will.deacon@arm.com>
Date:   Thu Oct 12 13:20:50 2017 +0100

    locking/qrwlock, arm64: Move rwlock implementation over to qrwlocks

    Now that the qrwlock can make use of WFE, remove our homebrewed rwlock
    code in favour of the generic queued implementation.

    Tested-by: Waiman Long <longman@redhat.com>
    Tested-by: Jeremy Linton <jeremy.linton@arm.com>
    Tested-by: Adam Wallis <awallis@codeaurora.org>
    Tested-by: Jan Glauber <jglauber@cavium.com>
    Signed-off-by: Will Deacon <will.deacon@arm.com>
    Acked-by: Peter Zijlstra <peterz@infradead.org>
    Cc: Jeremy.Linton at arm.com
    Cc: Linus Torvalds <torvalds@linux-foundation.org>
    Cc: Thomas Gleixner <tglx@linutronix.de>
    Cc: boqun.feng at gmail.com
    Cc: linux-arm-kernel at lists.infradead.org
    Cc: paulmck at linux.vnet.ibm.com
    Link: http://lkml.kernel.org/r/1507810851-306-5-git-send-email-will.deacon at arm.com
    Signed-off-by: Ingo Molnar <mingo@kernel.org>

Do you have any suggestion or thought how to debug it?

Thanks
-- 
Tai
