From: valdis.kletnieks@vt.edu (valdis.kletnieks at vt.edu)
Date: Thu, 15 Nov 2018 11:49:09 -0500
Subject: [ARM64] Printing IRQ stack usage information
In-Reply-To: <CAOuPNLiLj9be5iUdpUiLqiTge-xYY_v4_VLs-ah2_PygG7vxdg@mail.gmail.com>
References: <CAOuPNLiLj9be5iUdpUiLqiTge-xYY_v4_VLs-ah2_PygG7vxdg@mail.gmail.com>
Message-ID: <28496.1542300549@turing-police.cc.vt.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 15 Nov 2018 18:52:39 +0530, Pintu Agarwal said:

> Currently, when I tested this (as a proc interface), I got the below output:
> CPU    UNUSED-STACK    ACTUAL-STACK
>  0         16368                     16384

> 3) How should I test it to get the different usage values for unused stack ?
>     Can I get these values by implementing a sample interrupt handler,
> and printing information from there?

Hint 1:  If you're in a state where seq_printf() is legal, how many IRQ's are
on this processor's IRQ stack?

Hint 2:  What are the chances that some other CPU is currently in an IRQ?
(run 'top' and look for what percent of time that's happening)

Hint 3: what are the chances that the value of irq_stack_ptr is already stale
by the time seq_printf() finishes running?

Hint 4: what happens to the validity of your output if you get rescheduled
in the middle of that for_each loop?

(In other words, this code is terribly racy and is probably not going to answer
whatever debugging question you were working on..  If your question is "Did one
of the CPUs blow out its IRQ stack (or come close to doing so)?" there's better
approaches.


-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 486 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181115/96cbc85a/attachment.sig>
