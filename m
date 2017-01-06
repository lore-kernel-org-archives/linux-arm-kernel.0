From: will.deacon@arm.com (Will Deacon)
Date: Fri, 6 Jan 2017 11:19:51 +0000
Subject: [PATCH] ARM: hw_breakpoint: blacklist Scorpion CPUs
In-Reply-To: <20170105232324.GL17126@codeaurora.org>
References: <1483637556-3974-1-git-send-email-mark.rutland@arm.com>
 <20170105232324.GL17126@codeaurora.org>
Message-ID: <20170106111951.GA15333@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 05, 2017 at 03:23:24PM -0800, Stephen Boyd wrote:
> On 01/05, Mark Rutland wrote:
> > On APQ8060, the kernel crashes in arch_hw_breakpoint_init, taking an
> > undefined instruction trap within write_wb_reg. This is because Scorpion
> > CPUs erroneously appear to set DBGPRSR.SPD when WFI is issued, even if
> > the core is not powered down. When DBGPRSR.SPD is set, breakpoint and
> > watchpoint registers are treated as undefined.
> > 
> > It's possible to trigger similar crashes later on from userspace, by
> > requesting the kernel to install a breakpoint or watchpoint, as we can
> > go idle at any point between the reset of the debug registers and their
> > later use. This has always been the case.
> > 
> > Given that this has always been broken, no-one has complained until now,
> > and there is no clear workaround, disable hardware breakpoints and
> > watchpoints on Scorpion to avoid these issues.
> 
> I believe the workaround is to read DBGPRSR after exit from WFI?

That might be do-able via cpuidle, but it's probably better for somebody
familiar with the SoC PM to write that patch.

> I'm fine with the blacklisting approach though.
> 
> Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

Thanks,

Will
