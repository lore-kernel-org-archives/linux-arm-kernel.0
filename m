From: janboe.ye@gmail.com (ye janboe)
Date: Wed, 28 Oct 2009 11:32:09 +0800
Subject: where is the stack of supervisor mode? what's the value of SP_svc
	when the current state is supervisor mode?
In-Reply-To: <COL116-W585ABEF9B902D2CB994C83C2B80@phx.gbl>
References: <COL116-W585ABEF9B902D2CB994C83C2B80@phx.gbl>
Message-ID: <af3ea28a0910272032p6f7e6b0euc10314f8ff780971@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

please reference to cpu_init which initialized these modes stack.

2009/10/28 ?? ? <fxinrong@hotmail.com>:
>
>
> i have a question about the "SWI" instruction.
> when a software interrupt
> exception occurs, the following actions are performed by the
> hardware(arm):
>
> R14_svc = address of next instruction after the SWI
> instruction
> SPSR_svc = CPSR /* save processer status register */
> CPSR[4:0]
> = 0b10011 /* Enter Supervisor mode */
> CPSR[5] = 0 /* Execute in ARM state
> */
> /* CPSR[6] is unchanged */
> CPSR[7] = 1 /* Disable normal interrupts
> */
> /* CPSR[8] is unchanged */
> CPSR[9] = CP15_reg1_EEbit /* Endianness on
> exception entry */
> PC = 0xFFFF0008
>
> after those actions are finished,
> ARM is enter the supervisor mode.
> at this moment, the sp refered by
> instruction is the SP_svc register.
> the question is what is the value of
> SP_svc register currently.
> in a other word, where is the stack of supervisor
> mode.
>
> ENTRY(vector_swi)
> sub sp, sp, #S_FRAME_SIZE @ what's the value
> of SP_svc register at this time?????????
> stmia sp, {r0 - r12} @ Calling r0 -
> r12
> add r8, sp, #S_PC
> stmdb r8, {sp, lr}^ @ Calling sp, lr
> mrs r8, spsr
> @ called from non-FIQ mode, so ok.
> str lr, [sp, #S_PC] @ Save calling
> PC
> str r8, [sp, #S_PSR] @ Save CPSR
> str r0, [sp, #S_OLD_R0] @ Save
> OLD_R0
> zero_fp
> ...
>
> _________________________________________________________________
> Windows Live Hotmail: Your friends can get your Facebook updates, right from Hotmail(R).
> http://www.microsoft.com/middleeast/windows/windowslive/see-it-in-action/social-network-basics.aspx?ocid=PID23461::T:WLMTAGL:ON:WL:en-xm:SI_SB_4:092009
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
