From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 26 Jun 2018 10:27:51 +0100
Subject: [RFC v2 4/4] arm: add refcounting for task stacks
In-Reply-To: <20180618153053.186224-5-zsm@chromium.org>
References: <20180618153053.186224-1-zsm@chromium.org>
 <20180618153053.186224-5-zsm@chromium.org>
Message-ID: <20180626092751.GG17671@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 18, 2018 at 08:30:53AM -0700, Zubin Mithra wrote:
> @@ -285,8 +290,12 @@ static int __die(const char *str, int err, struct pt_regs *regs)
>  		 TASK_COMM_LEN, tsk->comm, task_pid_nr(tsk), end_of_stack(tsk));
>  
>  	if (!user_mode(regs) || in_interrupt()) {
> -		dump_mem(KERN_EMERG, "Stack: ", regs->ARM_sp,
> -			 THREAD_SIZE + (unsigned long)task_stack_page(tsk));
> +		unsigned long stack_page = try_get_task_stack(tsk);
> +		if (stack_page) {
> +			dump_mem(KERN_EMERG, "Stack: ", regs->ARM_sp,
> +				 THREAD_SIZE + stack_page);
> +			put_task_stack(tsk);
> +		}

This one can't - we're running in the context of the task, and so the
stack pages are in use by the CPU in this very function.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
