From: abelvesa@gmail.com (Abel Vesa)
Date: Fri, 10 Feb 2017 17:17:52 +0000
Subject: [PATCHv3] arm: ftrace: Adds support for
 CONFIG_DYNAMIC_FTRACE_WITH_REGS
In-Reply-To: <20170210142847.GK27312@n2100.armlinux.org.uk>
References: <1486508275-18449-1-git-send-email-abelvesa@linux.com>
 <20170209162956.GH27312@n2100.armlinux.org.uk>
 <CACh+v5NJ5zi4nEQkG+y_SesFuW8NOophD1KDFRG+t7=CtjnNrg@mail.gmail.com>
 <20170210120306.GA6825@nuc>
 <20170210142847.GK27312@n2100.armlinux.org.uk>
Message-ID: <20170210171752.GB6825@nuc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 10, 2017 at 02:28:47PM +0000, Russell King - ARM Linux wrote:
> On Fri, Feb 10, 2017 at 12:03:06PM +0000, Abel Vesa wrote:
> > The only problem I don't have a solution for at this point is OLD_LR (or
> > previous LR as it is called in this patch).
> 
> If you want the context at function entry, then you need to save the
> registers as they were at that point.
> 
> The stacking of LR in the gnu_mcount thing is there to avoid this problem:
> 
> a:
> 	push	{lr}
> 	bl	__gnu_mcount_mc
> 
> That "bl" instruction can be thought of as being effectively this:
> 
> 	adr	lr, 1f
> 	b	__gnu_mcount_mc
> 1:
> 
> and from that, you can plainly see that "lr" gets corrupted by the call.
> So, to save the register state as it was at point "a", you need to
> save (in order):
> 
> 	r0 through to sp
> 	the saved lr on the stack (which was the value of lr at point a)
> 	the current lr (which is the value of the PC _after_ __gnu_mcount_mc
> 		returns)
> 	cpsr
> 	write zero to old_r0
> 
> Stacking actual value of the PC at the point that you're stacking these
> registers is really senseless - it doesn't convey any useful information
> about the context being saved.
> 
> Does it make sense to leave the compiler's saving of lr on the stack?
> Probably not - which I think my last iteration overwrote with the old_r0
Actually, the "compiler's saving of lr" is needed by prepare_ftrace_return
(which is called from __ftrace_graph_regs_caller/__ftrace_graph_caller) to
be replaced by return_to_handler.

> value.  The only thing my last iteration did not do was save a real value
> for CPSR.
> 
The stack needs to look like this:
Right before __gnu_mcount_mc is called:

  0			    4
  | compiler's saving of lr | ... (we were wrong, stack was actually aligned to 8)

After regs saving in ftrace_regs_caller (the replacer of __gnu_mcount_mc):

  0    4    8     52       56       60   64     68       72                        76
  | R0 | R1 | ... | SP + 4 | new LR | PC | CPSR | OLD_R0 | compiler's saving of lr | ...

  this means the saving needs to be something like this:

   sub     sp, sp, #8        @ space for CPSR and OLD_R0 (not used at this point)
   add     ip, sp, #12       @ move in IP the value of SP as it was ( compute "SP + 4" )
   stmdb   sp!, {ip,lr,pc}   @ push PC, new LR, "SP + 4" (in this order)
   stmdb   sp!, {r0-r11,lr}  @ push new LR, R11 through to R0 (in this order)

And then the restoring needs to be like this:

   ldr     lr, [sp, #PT_REGS_SIZE]  @ load "compiler's saved of lr"
   ldmia   sp, {r0-r11, ip, sp, pc} @ pop r0-r11, "new LR" in ip, "SP + 4" in SP 
                                    @ and "new LR" in PC

After this, SP would be at '76', PC will contain the address of the next instruction
after "b __gnu_mcount_mc", and LR will be "compiler's saved of lr". The only register
that would have a different value than before would be IP.

I know we can skip saving and restoring IP, but it doesn't seem to be worth it.

I hope this time I'm not mistaken.

> I didn't test it either...
> 
> -- 
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
> according to speedtest.net.
