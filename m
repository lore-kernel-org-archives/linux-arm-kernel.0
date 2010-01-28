From: jamie@shareable.org (Jamie Lokier)
Date: Thu, 28 Jan 2010 14:52:05 +0000
Subject: [PATCH] ARM: Add SWP/SWPB emulation for ARMv7 processors (v4)
In-Reply-To: <1264685461.7064.65.camel@pc1117.cambridge.arm.com>
References: <20100114130700.27721.63614.stgit@e101986-lin>
	<1264685461.7064.65.camel@pc1117.cambridge.arm.com>
Message-ID: <20100128145205.GB24679@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin Marinas wrote:
> On Thu, 2010-01-14 at 13:07 +0000, Leif Lindholm wrote:
> > The SWP instruction was deprecated in the ARMv6 architecture, superseded
> > by the LDREX/STREX family of instructions for
> > load-linked/store-conditional operations. The ARMv7 multiprocessing
> > extensions mandate that SWP/SWPB instructions are treated as undefined
> > from reset, with the ability to enable them through the System Control
> > Register SW bit.
> > 
> > This patch adds the alternative solution to emulate the SWP and SWPB
> > instructions using LDREX/STREX sequences, and log statistics to
> > /proc/cpu/swp_emulation. To correctly deal with copy-on-write, it also
> > modifies cpu_v7_set_pte_ext to change the mappings to priviliged RO when
> > user RO.
> 
> Just a thought - could we not add another kuser helper in the vectors
> page that does this? Your exception trapping code would set regs->ARM_lr
> to the next instruction following SWP and regs->ARM_pc to the helper. 

That would corrupt LR seen by userspace, wouldn't it?
Userspace assumes SWP/SWPB do not change LR.

-- Jamie
