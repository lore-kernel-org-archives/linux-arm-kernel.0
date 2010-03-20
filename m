From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Sat, 20 Mar 2010 11:07:15 +0530
Subject: [PATCH] ARM: Fix "BUG: scheduling while atomic:
	swapper/0/0x00000002"
In-Reply-To: <20100319121312.GA21280@n2100.arm.linux.org.uk>
References: <1268745149-8685-1-git-send-email-santosh.shilimkar@ti.com>
	<20100316204930.GA13948@n2100.arm.linux.org.uk>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C489BF19@dbde02.ent.ti.com>
	<20100319121312.GA21280@n2100.arm.linux.org.uk>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C494809C@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> Sent: Friday, March 19, 2010 5:43 PM
> To: Shilimkar, Santosh
> Cc: linux-arm-kernel at lists.infradead.org; Catalin Marinas
> Subject: Re: [PATCH] ARM: Fix "BUG: scheduling while atomic: swapper/0/0x00000002"
> 
> On Wed, Mar 17, 2010 at 10:51:44AM +0530, Shilimkar, Santosh wrote:
> > On SMP kernel with PREEMPT enabled, if you try to offline the CPU using hot-plug and then
> > bring it back(online), you will get this dump. Since CPU is taken out from idle thread, the
> > process shown is 2.
> 
> Hmm, I don't think this is how we should be solving this problem.
> x86 calls init_idle() on the idle task when it's re-used, and this
> resets the preempt count amongst other things.  So maybe we want to
> do this instead in the __cpu_up path:
> 
> 	if (!idle) {
> 		idle = fork_idle(cpu);
> 		if (IS_ERR(idle)) {
> 			printk(KERN_ERR "CPU%u: fork() failed\n", cpu);
> 			return PTR_ERR(idle);
> 		}
> 		ci->idle = idle;
> -	}
> +	} else {
> +		init_idle(idle);
> +	}
This doesn't fix the dump. Will have look at this in more details on the same lines
as you suggested.

- Santosh
