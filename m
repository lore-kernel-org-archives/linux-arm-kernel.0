From: rabin@rab.in (Rabin Vincent)
Date: Sun, 21 Oct 2012 20:27:56 +0200
Subject: [PATCH 9/9] ARM: add uprobes support
In-Reply-To: <20121015173147.GA18614@linaro.org>
References: <1350242593-17761-1-git-send-email-rabin@rab.in>
 <1350242593-17761-9-git-send-email-rabin@rab.in>
 <20121015173147.GA18614@linaro.org>
Message-ID: <20121021182742.GB4840@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 15, 2012 at 06:31:47PM +0100, Dave Martin wrote:
> On Sun, Oct 14, 2012 at 09:23:13PM +0200, Rabin Vincent wrote:
> > +static int uprobe_trap_handler(struct pt_regs *regs, unsigned int instr)
> > +{
> > +	unsigned long flags;
> > +
> > +	local_irq_save(flags);
> > +	if ((instr & 0x0fffffff) == UPROBE_SWBP_INSN)
> 
> Is the check unnecessary here?  I think the same comparison will
> happen as a result of evaluating the associated undef_hook.

The check is there because this uprobe_trap_handler() is registered for
two different undefined instructions: UPROBE_SWBP_INSN (the one which is
used to insert the probe) and UPROBE_SS_INSN (the one placed in the XOL
area for simulating single-stepping).
