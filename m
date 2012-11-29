From: tony@atomide.com (Tony Lindgren)
Date: Thu, 29 Nov 2012 11:11:16 -0800
Subject: [PATCH v2] ARM: implement optimized percpu variable access
In-Reply-To: <1354200764-23751-1-git-send-email-robherring2@gmail.com>
References: <1354200764-23751-1-git-send-email-robherring2@gmail.com>
Message-ID: <20121129191115.GH5312@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Rob Herring <robherring2@gmail.com> [121129 06:55]:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> Use the previously unused TPIDRPRW register to store percpu offsets.
> TPIDRPRW is only accessible in PL1, so it can only be used in the kernel.
> 
> This replaces 2 loads with a mrc instruction for each percpu variable
> access. With hackbench, the performance improvement is 1.4% on Cortex-A9
> (highbank). Taking an average of 30 runs of "hackbench -l 1000" yields:
> 
> Before: 6.2191
> After: 6.1348
> 
> Will Deacon reported similar delta on v6 with 11MPCore.
> 
> The asm "memory" constraints are needed here to ensure the percpu offset
> gets reloaded. Testing by Will found that this would not happen in
> __schedule() which is a bit of a special case as preemption is disabled
> but the execution can move cores.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Acked-by: Will Deacon <will.deacon@arm.com>
> ---
> Changes in v2:
> - Add asm "memory" constraint
> - Only enable on v6K and v7 and avoid enabling for v6 SMP_ON_UP

Thanks, seems to still boot on omap2 with omap2plus_defconfig.
Once the other comments are sorted out:

Acked-by: Tony Lindgren <tony@atomide.com>
