From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Thu, 29 Apr 2010 07:44:14 -0700
Subject: [PATCH 02/14] omap: Make uncompress code and DEBUG_LL code generic
In-Reply-To: <20100126201239.15382.34792.stgit@baageli.muru.com>
References: <20100126200646.15382.52167.stgit@baageli.muru.com>
	<20100126201239.15382.34792.stgit@baageli.muru.com>
Message-ID: <1272552254.3051.121.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-01-26 at 12:12 -0800, Tony Lindgren wrote:
> Define arch_decomp_setup() the same way as some other
> architectures do. Use arch_id to configure the debug uart
> based on the machine_is by storing it into the uart
> scratchpad register for DEBUG_LL code to use.
> 
> Note that to avoid merge conflicts, this patch is using
> hardcoded register r1 until tmp register is being passed
> for all addruart macros.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>

This has been working well, but has a couple serious limitations:

1. assumes bootloader has enabled UART1 clocks
2. assumes all SoCs supported have the same UART1 base

With more platforms using USB-based UARTs, assumption (1) may not be
safe for very long, as bootloaders for these platforms don't really
*need* to enable UART1.  Currently, they happen to mainly because of
copied init code from other platforms. 

But more importantly, there are more OMAP derivative parts coming soon,
and one in particular coming soon[1] breaks assumption 2 by having a
different UART1 base (yes, it's branded as a DaVinci, but it's an OMAP
core as far as linux is concerned.  Don't get me started on TI
branding.)

To fix both problems, maybe we should just use a fixed memory location
to pass this temporary data from uncompress to the kernel.  We've had a
similar problem on DaVinci recently and a proposal has been made (and
tested) to use memory just below the page tables[2].)

Any comments on this proposal?  or alternative suggestions?

Kevin

[1] http://www.ti.com/ww/en/dsp/davinci-netra/index.shtml
[2] https://patchwork.kernel.org/patch/94724/
