From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 15 Jul 2015 14:46:03 +0100
Subject: [PATCH v3 3/3] arm: kernel: implement cpuidle_ops with psci
 backend
In-Reply-To: <20150714204138.GW7557@n2100.arm.linux.org.uk>
References: <1436430685-2202-1-git-send-email-jszhang@marvell.com>
 <1436430685-2202-4-git-send-email-jszhang@marvell.com>
 <20150714103421.GU7557@n2100.arm.linux.org.uk>
 <20150714110302.GA334@red-moon>
 <20150714122904.GV7557@n2100.arm.linux.org.uk>
 <20150714145546.GA14556@red-moon>
 <20150714204138.GW7557@n2100.arm.linux.org.uk>
Message-ID: <20150715134603.GA14862@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 14, 2015 at 09:41:38PM +0100, Russell King - ARM Linux wrote:

[...]

> > > Yet, we're stuffing _all_ the PSCI CPU idle code into
> > > drivers/firmware/psci.c, but then stuffing the PSCI OF data structures
> > > into arch/arm.  This is utterly _insane_.
> > 
> > Ok, so we will copy the ARM64 PSCI idle related code to arch/arm
> > and we are done with this, or we will have to ifdef drivers/firmware
> > code, take your pick.
> 
> What the fsck is up with you.  You're talking utter nonsense.
> 
> > > There is nothing ARM specific about these CPU idle ops.  They don't
> > > belong on arch/arm.
> > 
> > See above.
> > 
> > > NAK on this series (and the move of the PSCI code to drivers/firmware)
> > 
> > I do not accept that. You may NAK this series but you can't object to
> > moving PSCI firmware code to drivers/firmware for that reason, so
> > please have a look at Mark's patches again and ACK/NAK them for
> > a valid reason, it has been a while since he asked.
> 
> Sorry, NAK, and end of discussion.  There is nothing more to be said
> here.

I beg to differ. To solve the issue that you brought up with this series,
we can create an arch function that allows to set CPUidle operations, which
would remove the need for the OF construct you did not like, this mirrors
what's done for PSCI smp operations (something similar to smp_set_ops),
does that sound a reasonable approach to you ?

It is not an issue related to CPUidle only, other PSCI functions
(eg psci_cpu_{die/kill} arch/arm/kernel/psci_smp.c) can be shared between
ARM/ARM64 - so moved to drivers/firmware), we would end up with SMP
operations that are initialized with functions that live in
drivers/firmware, if it is done for SMP ops I do not see why it
can't be done for CPUidle operations.

Is the problem related to renaming psci_smp.c to psci.c and adding
CPU_IDLE and SMP ifdeffery in there - as it is done on arm64:

arch/arm64/kernel/psci.c

?

Please let us know, I think we can easily find a way that is acceptable
to you.

As for M.Rutland's series[1], and the patch that moves common PSCI code to
drivers/firmware I reiterate my point, please review it[1] and provide us
with feedback if any otherwise acknowledge the code move, which is the
basis on top of which everything else can be developed, I do not understand
why you are stopping [1] from getting into the kernel since it moves
code from arch/arm to drivers/firmware to have it in a common and shared
place between ARM and ARM64, what's the issue you have with that or put
it differently why are you NAKing it ?

Thank you,
Lorenzo

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/355643.html 
