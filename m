From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 25 May 2011 00:19:16 +0100
Subject: [GIT PULL] pxa: for next merge
In-Reply-To: <BANLkTin8tX_kfG_R6To+ktNbOW+B93LiqQ@mail.gmail.com>
References: <BANLkTin8tX_kfG_R6To+ktNbOW+B93LiqQ@mail.gmail.com>
Message-ID: <20110524231916.GD4652@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I've just spotted this:

+asmlinkage void __exception_irq_entry icip_handle_irq(struct pt_regs *regs)
+{
+       uint32_t icip, icmr, mask;
+
+       do {
+               icip = __raw_readl(IRQ_BASE + ICIP);
+               icmr = __raw_readl(IRQ_BASE + ICMR);
+               mask = icip & icmr;
+
+               if (mask == 0)
+                       break;
+
+               asm_do_IRQ(fls(mask) - 1, regs);
+       } while (1);
+}

This is bad news.  A function marked as __exception is expected to be
called from the assembly code.  The above is fine, but it then goes on
to call asm_do_IRQ() which is also marked __exception.

This means the unwinder will attempt to dump the saved pt_regs register
state for both asm_do_IRQ() and icip_handle_irq(), resulting in one of
them being garbage.

So I think this needs some thought.

Second point - can't the USB changes go via the USB people?  Have USB
people seen the patch?
