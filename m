From: stano@meduna.org (Stanislav Meduna)
Date: Fri, 21 Mar 2014 09:21:41 +0100
Subject: mxs-auart gives data from previous run after close and reopen
In-Reply-To: <532B985A.7060505@hurleysoftware.com>
References: <5323625B.4010203@meduna.org> <532B985A.7060505@hurleysoftware.com>
Message-ID: <532BF695.3030900@meduna.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21.03.2014 02:39, Peter Hurley wrote:

> Does disabling the fifo on shutdown clear the fifo?

I did not try this, but if my theory is correct, it would
not help, as all this does is reducing the FIFO length
to one character. So you'd still get up to two characters:
one in the "FIFO" - it could get there a microsecond after
you disable the FIFO before you gate the clock - and one
being received into the shift register (garbled by shutting
down the clock in the middle of the reception that was
resumed when clock was resumed on startup). Note that one
can get preempted here, so the instructions next to each
other can be milliseconds apart in reality.

IMHO we need a soft-reset here.

Regards
-- 
                                     Stano
