From: leoy@marvell.com (Leo Yan)
Date: Tue, 19 Aug 2014 13:31:30 +0800
Subject: [Question]: redundant interrupts for broadcast timer
Message-ID: <53F2E132.10701@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi,

We observed the redundant interrupts for broadcast timer, so want to 
confirm here firstly; pls see below flow:

1. Thread_A starts a hrtimer with 100ms timeout, and then thread_A will 
remove from the runqueue to sleep;
2. The CPU which thread_A runs on will enter idle and call notify 
CLOCK_EVT_NOTIFY_BROADCAST_ENTER, so the CPU will shutdown its local 
timer and set broadcast timer's next event with delta for 100ms;
3. After 70ms later, the CPU is waken up by other peripheral's interrupt 
and thread_A will be waken up as well; thread_A will cancel the hrtimer 
at this point, kernel will remove the timer event from the event queue 
but it will not disable broadcast timer;
4. So after 30ms later, the broadcast timer interrupt will be triggered 
even though the timer has been cancelled by s/w in step 3.

With current timer framework, is upper behaviour expected? Or maybe we 
miss something so that introduce such kind issue?

And i'm interesting now if have some idea to optimize such issue, very 
appreciate for suggestion and comment.

Thanks,
Leo Yan
