From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 19 Mar 2010 12:13:12 +0000
Subject: [PATCH] ARM: Fix "BUG: scheduling while atomic:
	swapper/0/0x00000002"
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C489BF19@dbde02.ent.ti.com>
References: <1268745149-8685-1-git-send-email-santosh.shilimkar@ti.com>
	<20100316204930.GA13948@n2100.arm.linux.org.uk>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C489BF19@dbde02.ent.ti.com>
Message-ID: <20100319121312.GA21280@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 17, 2010 at 10:51:44AM +0530, Shilimkar, Santosh wrote:
> On SMP kernel with PREEMPT enabled, if you try to offline the CPU using hot-plug and then
> bring it back(online), you will get this dump. Since CPU is taken out from idle thread, the
> process shown is 2.

Hmm, I don't think this is how we should be solving this problem.
x86 calls init_idle() on the idle task when it's re-used, and this
resets the preempt count amongst other things.  So maybe we want to
do this instead in the __cpu_up path:

	if (!idle) {
		idle = fork_idle(cpu);
		if (IS_ERR(idle)) {
			printk(KERN_ERR "CPU%u: fork() failed\n", cpu);
			return PTR_ERR(idle);
		}
		ci->idle = idle;
-	}
+	} else {
+		init_idle(idle);
+	}
