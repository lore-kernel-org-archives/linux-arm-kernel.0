From: jamie@shareable.org (Jamie Lokier)
Date: Wed, 23 Jun 2010 01:44:22 +0100
Subject: Possible methods for the kernel to terminate a process
In-Reply-To: <BAY134-W142753895B5626C329E273BDC40@phx.gbl>
References: <BAY134-W142753895B5626C329E273BDC40@phx.gbl>
Message-ID: <20100623004422.GB22367@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Xiachen Dong wrote:
> 
> Hi,
> 
> We have a quick question. Besides sending signals, are there any other ways for the kernel to terminate a process?
> 
> We have such question because we try to kill a user space process by the shell command kill and we cannot kill it probably because it is in an un-interruptible sleep/wait. 
> 
> However, we still wish to be able to kill the user space process under this circumstance. To our knowledge of the kernel, if the kernel wants to kill a process when special event such as exception happens, it usually sends a signal to the process. We really cannot think of any other methods for a kernel to terminate a process.
> 
> Can anyone provide some hints on this? Is rebooting the machine the only solution to the problem?

You can't kill a task that's in TASK_UNINTERRUPTIBLE state, except by
the condition the task is waiting on changing.

That's been a well known problem with unix for decades, because
uninterruptible wait is used for some things (like reading a disk
file) that it seems reasonable to be able to kill.

So, to fix that, TASK_KILLABLE was added.  It means you can't
interrupt the process with most signals, but you can at least "kill
-9" the process (SIGKILL).

I think for what you're asking, if the problem is some processes tend
to block on particular device drivers, or processes blocked while
accessing files gets stuck, or things like that, the best thing is to
look at the places they might be in TASK_UNINTERRUPTIBLE and
*carefully* change the code to use TASK_KILLABLE and handle the killed
condition.

It's not possible to just search-and-replace TASK_UNINTERRUPTIBLE.
You have to make sure the killed condition is handled by cleaning up
locked resources, and only then change to killable.

-- Jamie
