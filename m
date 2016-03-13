From: clabbe.montjoie@gmail.com (Corentin LABBE)
Date: Sun, 13 Mar 2016 13:40:26 +0100
Subject: [BUG] crypto: sun4i-ss: Random data corruption
Message-ID: <56E55FBA.90703@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello

I had some report of random data corruption of people using cryptsetup with my sun4i-ss driver (via AF_ALG).
Even if it is hard to hit, I could confirm it by continuously moving files on a LUKS encrypted FS and comparing hash of it before and after.
The corruption is always when deciphering the end of 512bytes sector and always of a length multiple of 4.

The only way of removing this random corruption is to transform all spinlock_bh by spinlock_irqsave.
In fact this problem is extremely similar to another bug that I have encountered (https://lkml.org/lkml/2015/10/11/47)
The only difference is that I do not need to remove SG_MITER_ATOMIC for removing the issue.

So my question remains nearly the same than on my first problem: Why disabling irq remove this data corruption ?

Any help/suggestions will be really appreciated since I doesn't understand why this fix works.

Regards

LABBE Corentin
