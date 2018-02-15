From: will.deacon@arm.com (Will Deacon)
Date: Thu, 15 Feb 2018 15:33:07 +0000
Subject: arm64/v4.16-rc1: KASAN: use-after-free Read in finish_task_switch
In-Reply-To: <20180215142239.GF16623@arm.com>
References: <20180214120254.qq4w4s42ecxio7lu@lakrids.cambridge.arm.com>
 <20180214150739.GH2992@arm.com>
 <20180214165131.o25r3hhrtrjk3ejq@lakrids.cambridge.arm.com>
 <254787533.21950.1518634424009.JavaMail.zimbra@efficios.com>
 <20180215142239.GF16623@arm.com>
Message-ID: <20180215153307.GA11712@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 15, 2018 at 02:22:39PM +0000, Will Deacon wrote:
> Assuming others agree with this diagnosis, I'm not sure how to fix it.
> It's basically not safe to set current->mm = NULL with preemption enabled.

One thing we could try would be to leave current->mm alone and just do the
mmdrop in finish_task_switch at the point where we put the task_struct for
DEAD tasks. mm_update_next_owner might need updating so that it doesn't
re-assign current as the owner and run into a BUG_ON.


Will
