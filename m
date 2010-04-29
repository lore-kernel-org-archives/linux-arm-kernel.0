From: roland@redhat.com (Roland McGrath)
Date: Wed, 28 Apr 2010 17:08:08 -0700 (PDT)
Subject: [C/R ARM v2][PATCH 1/3] ARM: Rudimentary syscall interfaces
In-Reply-To: Christoffer Dall's message of  Monday,
	26 April 2010 17:43:41 -0400
	<1272318223-28438-2-git-send-email-christofferdall@christofferdall.dk>
References: <1272318223-28438-1-git-send-email-christofferdall@christofferdall.dk>
	<1272318223-28438-2-git-send-email-christofferdall@christofferdall.dk>
Message-ID: <20100429000808.CFFBD7154@magilla.sf.frob.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> + * syscalls.h - Linux syscall interfaces for ARM

s/syscalls/syscall/

> +static inline int get_swi_instruction(struct task_struct *task,
> +				      struct pt_regs *regs,
> +				      unsigned long *instr)
> +{

Why doesn't this just use access_process_vm?

> +/*
> + * This function essentially duplicates the logic from vector_swi in
> + * arch/arm/kernel/entry-common.S. However, that code is in the
> + * critical path for system calls and is hard to factor out without
> + * compromising performance. 
> + */

No clue about the ARM details, not reviewing that.  I think this is too big
to be an inline and should be in some arch/arm/kernel/*.c place instead.
Of course, if (config_aeabi && !config_oabi) is true at compile time, it's
not large at all.  So perhaps just move the compelx cases to a function
and leave the "Pure EABI" fork in the inline.


Thanks,
Roland
