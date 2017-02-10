From: abelvesa@gmail.com (Abel Vesa)
Date: Fri, 10 Feb 2017 17:27:43 +0000
Subject: [PATCHv3] arm: ftrace: Adds support for
 CONFIG_DYNAMIC_FTRACE_WITH_REGS
In-Reply-To: <CACh+v5OiiN2tYPLyXgZswFiJ1daVDgfSFRXuRCDMDoyDsQNGxw@mail.gmail.com>
References: <1486508275-18449-1-git-send-email-abelvesa@linux.com>
 <20170209162956.GH27312@n2100.armlinux.org.uk>
 <CACh+v5NJ5zi4nEQkG+y_SesFuW8NOophD1KDFRG+t7=CtjnNrg@mail.gmail.com>
 <20170210120306.GA6825@nuc>
 <CACh+v5OiiN2tYPLyXgZswFiJ1daVDgfSFRXuRCDMDoyDsQNGxw@mail.gmail.com>
Message-ID: <20170210172743.GC6825@nuc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 10, 2017 at 02:57:38PM +0100, Jean-Jacques Hiblot wrote:
> 2017-02-10 13:03 GMT+01:00 Abel Vesa <abelvesa@gmail.com>:
> > On Fri, Feb 10, 2017 at 11:36:12AM +0100, Jean-Jacques Hiblot wrote:
> >> 2017-02-09 17:29 GMT+01:00 Russell King - ARM Linux <linux@armlinux.org.uk>:
> >> > On Tue, Feb 07, 2017 at 10:57:55PM +0000, Abel Vesa wrote:
> >> >> +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> >> >> +
> >> >> +.macro __ftrace_regs_caller
> >> >> +
> >> >> +     add     ip, sp, #4      @ move in IP the value of SP as it was
> >> >> +                             @ before the push {lr} of the mcount mechanism
> >> >> +     stmdb   sp!, {ip,lr,pc}
> >> >> +     stmdb   sp!, {r0-r11,lr}
> >> >> +
> >> >> +     @ stack content at this point:
> >> >> +     @ 0  4          44    48   52       56   60   64
> >> >> +     @ R0 | R1 | ... | R11 | LR | SP + 4 | LR | PC | previous LR |
> >> >
> >> > How important is this to be close to "struct pt_regs" ?  Do we care about
> >> > r12 being "wrong" ?  The other issue is that pt_regs is actually 72
> >> > bytes in size, not 68 bytes.  So, does that mean we end up inappropriately
> >> > leaking some of the kernel stack to userspace through ftrace?
> >> >
> >> > It's possible to save all the registers like this if we need to provide
> >> > a complete picture of the register set at function entry:
> >> >
> >> >         str     ip, [sp, #-16]!
> >> >         add     ip, sp, #20
> >> >         stmia   sp, {ip, lr, pc}
> >> >         stmdb   sp!, {r0 - r11}
> >> >
> >> > However, is that even correct - don't we want pt_regs' LR and PC to be
> >> > related to the function call itself?  The "previous LR" as you describe
> >> > it is where the called function (the one that is being traced) will
> >> > return to.  The current LR at this point is the address within the
> >> > traced function.  So actually I think this is more strictly correct, if
> >> > I'm understanding the intention here correctly:
> >> >
> >> >         str     ip, [sp, #S_IP - PT_REGS_SIZE]! @ save current IP
> >> >         ldr     ip, [sp, #PT_REGS_SIZE - S_IP]  @ get LR at traced function entry
> >> >         str     lr, [sp, #S_PC - S_IP]          @ save current LR as PC
> >> >         str     ip, [sp, #S_LR - S_IP]          @ save traced function return
> >> >         add     ip, sp, #PT_REGS_SIZE - S_IP + 4
> >> >         str     ip, [sp, #S_SP - SP_IP]         @ save stack pointer at function entry
> >> >         stmdb   sp!, {r0 - r11}
> >> >         @ clear CPSR and old_r0 words
> >> >         mov     r3, #0
> >> >         str     r3, [sp, #S_PSR]
> >> >         str     r3, [sp, #S_OLD_R0]
> >> >
> >> > However, that has the side effect of misaligning the stack (the stack
> >> > needs to be aligned to 8 bytes).  So, if we decide we don't care about
> >> > the saved LR value (except as a mechanism to preserve it across the
> >> > call into the ftrace code):
> >> >
> >> >         str     ip, [sp, #S_IP - PT_REGS_SIZE + 4]!
> >> >         str     lr, [sp, #S_PC - S_IP]
> >> >         ldr     lr, [sp, #PT_REGS_SIZE - 4 - S_IP]
> >> >         add     ip, sp, #PT_REGS_SIZE - S_IP
> >> >         stmib   sp, {ip, lr}
> >> >         stmdb   sp!, {r0 - r11}
> >> >         @ clear CPSR and old_r0 words
> >> >         mov     r3, #0
> >> >         str     r3, [sp, #S_PSR]
> >> >         str     r3, [sp, #S_OLD_R0]
> >> >
> >> > and the return would be:
> >> >
> >> >         ldmia   sp, {r0 - pc}
> >> >
> >> > That all said - maybe someone from the ftrace community can comment on
> >> > how much of pt_regs is actually necessary here?
> >>
> >> I would suggest the following:
> >> r0-r11: filled with current values.
> >> r12 :  the value of r12 doesn't matter (Intra-procedure call scratch
> >> reg), we can either save it or not.
> >> r13 - sp: the value as it was when the instrumented function was
> >> entered. in the mcount case, it's the current sp value - 4, otherwise
> >> it'f sp -4
> >> r14 - lr: the value as it was when the instrumented function was
> >> entered. first element in stack or available in frame depending on
> >> GCC's version (mcount vs __gnu_mcount_nc)
> >> r15 - pc : the address after the modified instruction (value of lr
> >> when the ftrace caller is entered)
> >>
> > So basically you're saying: save all regs, r0 through r15, except r12.
> > Based on that, I think it's easier to save all of them and then restore
> > all of them except r12. Plus, you have to take into consideration all
> > the possible users of ftrace with regs. At some point some implementation
> > of ftrace_regs_call will probably need the value from r12.
> >> I don't think we need CSPR and ORIG_r0.
> > I think we do. As I said before, because PT_REGS is 72 and some function
> > might (in the future) make use of CSPR or ORIG_r0, to ensure there is no
> > stack corruption taking place, we have to provide whole pt_regs, that is
> > 72 (including CSPR and ORIG_r0). Plus, the stack alignment thing Russell
> > mentioned would be fixed.
> You're right for the size of the structure. For the content, I don't
> think we need all of them but it won't hurt to save more than
> necessary.
Exactly.
> >
> > The only problem I don't have a solution for at this point is OLD_LR (or previous LR
> > as it is called in this patch). If we take the approach described earlier,
> 
> previous LR is the lr when the instrumented function is entered, it
> should be stored in pt_regs as r14
> 
No, I disagree. I just realized I was also wrong. It doesn't have to be a part of 
pt_regs at all. prepare_ftrace_return will receive it as first parameter due to this:

 sub     r0, fp, #4              @ lr of instrumented routine (parent)

first instruction in __ftrace_graph_regs_caller.
> > we need to add to pt_regs the OLD_LR which I really don't like because it is
> > breaking the whole purpose of pt_regs (it should only contain one copy of each reg,
> > though it already has the ORIG_r0 in it) and will also break the stack alignment.
> >>
> >> >
> >> > --
> >> > RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> >> > FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
> >> > according to speedtest.net.
