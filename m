From: luffyj@qti.qualcomm.com (Jiang, Luffy)
Date: Thu, 10 Mar 2016 08:06:42 +0000
Subject: why not fill tgid in procid domain of register contextidr
Message-ID: <b73478fa85a34f97ab04c36337e6aa91@aptaiexm02a.ap.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All
I have a question about hardware breakpoint/watchpoint matching condition,
in my understanding, hardware breakpoint and hardware watchpoint will match procid domain of register contextidr, 
so the hw bp/wp can only affect the user space process which i concern.


i found the linux kernel fill the thread id into procid but not process id, the below is the code,
my linux kernel source code version is 3.14, in file arch/arm/mm/context.c, function contextidr_notifier,
static int contextidr_notifier(struct notifier_block *unused, unsigned long cmd, void *t)
{
	u32 contextidr;
	pid_t pid;
	struct thread_info *thread = t;

	if (cmd != THREAD_NOTIFY_SWITCH)
		return NOTIFY_DONE;

	pid = task_pid_nr(thread->task) << ASID_BITS;
	asm volatile(
	"	mrc	p15, 0, %0, c13, c0, 1\n"
	"	and	%0, %0, %2\n"
	"	orr	%0, %0, %1\n"
	"	mcr	p15, 0, %0, c13, c0, 1\n"
	: "=r" (contextidr), "+r" (pid)
	: "I" (~ASID_MASK));
	isb();

	return NOTIFY_OK;
}

in function contextidr_notifier, we can see the pid but not tgid be filled into procid, 
so i think hw watchpoint can only affect some specific thread.
when the process include multi thread, how can let watch point affect for all thread which belong to the same process ?
can we use tgid for procid domain ?




Thank you

Best Regards
Luffy Jiang
(021) 20372301





?
Thank you

Best Regards
Luffy Jiang
(021) 20372301
