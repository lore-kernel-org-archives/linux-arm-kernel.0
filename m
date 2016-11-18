From: iago.abal@gmail.com (Iago Abal)
Date: Fri, 18 Nov 2016 10:49:03 +0100
Subject: Potential deadlock BUG in Linux 4.9 drivers/dma/coh901318.c
Message-ID: <CAGbDTvr-g4S4qA_ZE00aRcohoQsnMtnQfYBKwkzguzgix_asUQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

With the help of a static bug finder (EBA -
https://github.com/models-team/eba) I have found a potential deadlock
in drivers/dma/coh901318.c. This happens due to a recursive
spin_lock_irqsave on `cohc->lock'.

This bug may have been introduced by commit 84c8447c544b ("DMAENGINE:
COH 901 318 fix bytesleft").

The fix seems easy, I would personally just remove the calls to
spin_(un)lock_irqsave in lines 1805 and 1826. Function
`coh901318_config' is only called by `coh901318_alloc_chan_resources'
which already holds that lock when calling it.

If someone can confirm that all the above is correct, I will be happy
to submit a patch.

The trace is as follows:

1. Function `coh901318_alloc_chan_resources' takes the lock first in line 2165:

    // see https://github.com/torvalds/linux/blob/master/drivers/dma/coh901318.c#L2165
    spin_lock_irqsave(&cohc->lock, flags);

2. Immediately after it calls `coh901318_config' passing the `cohc'
struct to it.

3. The first thing `coh901318_config' does is to take the same
spinlock in line 1805:

    // see https://github.com/torvalds/linux/blob/master/drivers/dma/coh901318.c#L1805
    spin_lock_irqsave(&cohc->lock, flags);

Hope it helps!

-- iago
