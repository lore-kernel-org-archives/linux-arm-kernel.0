From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 5 Apr 2011 17:05:47 +0100
Subject: RFC: Status of kernel/fiq.c
Message-ID: <20110405160546.GA7976@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I've hit a Thumb-2 compatibility issue in the assembler functions
in kernel/fiq.c, and I'm wondering how to proceed.

With regard to set_fiq_regs() and get_fiq_regs(), does anyone know:

  * whether we still need the stack frame manipulation code in this
	leaf function, e.g.

        "mov    ip, sp\n\
        stmfd  sp!, {fp, ip, lr, pc}\n\
        sub    fp, ip, #4\n\

	etc.

  * what the nop (mov r0,r0) after the CPSR writes is for
        (I'm guessing there may have been some 1-instruction hazard
        here for some old processors, but I'm not aware of a need
        for this in anything current.)

  * should anyone be using fiq.c on v7 platforms?

As the code stands, it could also go wrong if the compiler
happens to allocate r8-r12 or lr for one of the inline asm
constraints -- though this is pretty unlikely to happen, and
I doubt if it ever has happened in practice.


To make this Thumb-2/v7 compatible, I'd prefer to recode a single
version that works for ARM and Thumb and avoids deprecated
instruction forms, but that may result in some ugly ifdefs to work
around the stack frame manipulation etc., unless we can conclude
that that code isn't needed.

Splitting these functions out into a separate assembler file might
also make sense, since that makes it impossible for the compiler
to mess things up, and makes is possible to use ARM()/THUMB()
which is a bit cleaner than #ifdefs.

Comments welcome.

Cheers
---Dave
