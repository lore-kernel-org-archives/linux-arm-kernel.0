From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 29 Jan 2013 23:25:27 +0100
Subject: Oddities with Energymicro's efm32
Message-ID: <20130129222527.GA30975@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I'm stuck with debugging a problem on my GiantGecko board (Cortex-M3
efm32 SoC).

Up to now I used the flash built into the SoC. But as it only has a size
of 1 MiB I had to switch to the external flash---at least for
development.

I guess because of changed timing settings this triggers a problem with
the stack pointer. The following code is executed:

8c009e80 <update_process_times>:
8c009e80:       b570            push    {r4, r5, r6, lr}
8c009e82:       466b            mov     r3, sp
8c009e84:       f423 54ff       bic.w   r4, r3, #8160   ; 0x1fe0
8c009e88:       f024 041f       bic.w   r4, r4, #31
8c009e8c:       4606            mov     r6, r0
8c009e8e:       4810            ldr     r0, [pc, #64]   ; (8c009ed0 <update_process_times+0x50>)
8c009e90:       68e5            ldr     r5, [r4, #12]
8c009e92:       f7f8 fc9b       bl      8c0027cc <printascii>
8c009e96:       f5b4 5f00       cmp.w   r4, #8192       ; 0x2000
8c009e9a:       d806            bhi.n   8c009eaa <update_process_times+0x2a>
8c009e9c:       4668            mov     r0, sp
8c009e9e:       f7f8 fc6b       bl      8c002778 <printhex8>
8c009ea2:       480c            ldr     r0, [pc, #48]   ; (8c009ed4 <update_process_times+0x54>)
8c009ea4:       f7f8 fc92       bl      8c0027cc <printascii>
8c009ea8:       e7fe            b.n     8c009ea8 <update_process_times+0x28>

printascii is a function to print out a debug message, printhex prints
out the value of r0. The code corresponds to this C-Code:

#define THREAD_SIZE 8192
static inline struct thread_info *current_thread_info(void)
{       
        register unsigned long sp asm ("sp");
        return (struct thread_info *)(sp & ~(THREAD_SIZE - 1));
}


void update_process_times(int user_tick)
{
	...
        printascii("up1\n");
        if (current_thread_info() <= 0x2000) {
                asm volatile("mov r0, sp\n" "bl printhex8" : : : "cc", "r0", "r1", "r2", "r3");
                printascii("br0ken\n");
                while (1) {}
        }
	...
}

That is the condition of the if is

	(sp & ~0x1fff) <= 0x2000

. If it triggers, the value of sp is printed. When the function in
question is called for the second time the condition is true and sp is
printed as 0x88009e88. The value of r4 is 0 then. The values on the
stack don't look reasonable:

	88009e70: 8c0ed2b8 8c01c75f 8c01c78d 88016980 
	88009e80: 88018de4 8c01c797 88016900 88016900 
	88009e90: 88016980 88018de4 0000001d 00000000 
	88009ea0: 00000000 8c00306b 8c00305d 8c01d0a5 
	88009eb0: 88018de4 88016980 88018de4 00000000 
	88009ec0: 88026820 00000000 88009f44 88009f70 
	88009ed0: 8c0ed2b1 8c01d1a7 88018de4 8c01e5c9 
	88009ee0: 0000001d 8c01cd6b 0000001d 8c000cdb 

which means that the value saved on the stack for lr would have been
0x88018de4 which is outside of the kernel image. It's a RAM address. So
sp probably was wrong when the function was entered, too. But even in
the case that the caller corrupted sp, why isn't it < 0x2000 when
printed out in the body of the if?

The code is run with irqs off (PRIMASK=1). So the only things that could
happen to influence sp between 0x8c009e82 and 0x8c009e9c are Reset, NMI
and HardFault. For each of them the handler wouldn't return, so they can
be ruled out.

The timing settings for flash and sram are copied from Energymicro's
Board Support Package, so they should be ok, too.

This is hard to debug because I cannot set breakpoints in the external
flash and I didn't get tracing up and running up to now. Also the
problem is very sensible to changes: If I add instrumentation to the
exception entry code the problem doesn't reproduce any more.

I'm out of ideas now. So if you have an idea that would be great. If you
want to reproduce I can provide you source code and/or binaries. Also if
you have questions or see a gap in my conclusions, don't hesitate to
contact me.

Thanks for your time,
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
