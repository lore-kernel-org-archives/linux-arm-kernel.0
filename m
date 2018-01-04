From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 4 Jan 2018 15:58:38 +0100
Subject: [PATCH v2 0/8] ARM: sun9i: SMP support with Multi-Cluster Power
 Management
In-Reply-To: <20180104143754.2425-1-wens@csie.org>
References: <20180104143754.2425-1-wens@csie.org>
Message-ID: <20180104145838.qk5sbtg3vjg33txt@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 04, 2018 at 10:37:46PM +0800, Chen-Yu Tsai wrote:
> This is v2 of my sun9i SMP support with MCPM series which was started
> over two years ago [1]. We've tried to implement PSCI for both the A80
> and A83T. Results were not promising. The issue is that these two chips
> have a broken security extensions implementation. If a specific bit is
> not burned in its e-fuse, most if not all security protections don't
> work [2]. Even worse, non-secure access to the GIC become secure. This
> requires a crazy workaround in the GIC driver which probably doesn't work
> in all cases [3].
> 
> Nicolas mentioned that the MCPM framework is likely overkill in our
> case [4]. However the framework does provide cluster/core state tracking
> and proper sequencing of cache related operations. We could rework
> the code to use standard smp_ops, but I would like to actually get
> a working version in first.
> 
> Much of the sunxi-specific MCPM code is derived from Allwinner code and
> documentation, with some references to the other MCPM implementations,
> as well as the Cortex's Technical Reference Manuals for the power
> sequencing info.
> 
> One major difference compared to other platforms is we currently do not
> have a standalone PMU or other embedded firmware to do the actually power
> sequencing. All power/reset control is done by the kernel. Nicolas
> mentioned that a new optional callback should be added in cases where the
> kernel has to do the actual power down [5]. For now however I'm using a
> dedicated single thread workqueue. CPU and cluster power off work is
> queued from the .{cpu,cluster}_powerdown_prepare callbacks. This solution
> is somewhat heavy, as I have a total of 10 static work structs. It might
> also be a bit racy, as nothing prevents the system from bringing a core
> back before the asynchronous work shuts it down. This would likely
> happen under a heavily loaded system with a scheduler that brings cores
> in and out of the system frequently. In simple use-cases it performs OK.

It all looks sane to me
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180104/8ea853e2/attachment.sig>
