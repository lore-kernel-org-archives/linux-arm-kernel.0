From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 13 Mar 2017 13:31:12 +0000
Subject: [PATCH] arm64: enable ARCH_WANT_RELAX_ORDER for aarch64
In-Reply-To: <35233df0-3406-e66f-d9d2-bf7ed7814386@huawei.com>
References: <35233df0-3406-e66f-d9d2-bf7ed7814386@huawei.com>
Message-ID: <d97d0876-3e00-1979-72de-35fd81bfedf5@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/03/17 12:03, Ding Tianhong wrote:
> The ARCH_WANT_RELAX_ORDER will enable Relaxed Ordering (RO) which allows
> transactions that do not have any order of completion requirements to
> complete more efficiently compare to the Stricted Ordering (SO) for ixbge
> nic card.

Which ixgbe NIC? As far as I can see we have an arch-level config option
here which applies to one single driver, and doesn't even cover all the
hardware supported by that driver (82598, for example, still has the
#ifndef CONFIG_SPARC in the equivalent place). Looking at the history,
I'd prefer to at least know what the "various issues with certain
chipsets" were, and why they wouldn't affect ARM systems,  before making
any judgement about whether this could be considered universally safe
for arm64.

> The system will see high write-to-memory performance when RO is
> enabled on the data transactions just like the SPARC did.
> 
> The aarch64 pcie controller could both support Relaxed Ordering (RO)

What is "the AArch64 PCIe controller", exactly? Disregarding that
talking of PCIe in terms of the CPU ISA makes little sense, I can barely
name two ARMv8-based systems which nominally use the same PCIe IP, and
the amount of various quirks and incompatibilities I'm aware of leaves
me with the default assumption that any such unqualified blanket
statement is probably wrong. I think we need some much more considered
reasoning here.

> and Stricted Ordering (SO), so enable ARCH_WANT_RELAX_ORDER for ixgbe
> nic card to get much more better performance, and didn't see any
> adverse effects.
> 
> Nic Card(Ixgbe)			Disable RO	|	Enable RO
> Performance(Per thread)		8.4Gb/s		|	9.4Gb/s
> 
> Tested by Iperf on Hip06/Hip07 Soc Board.
> 
> Signed-off-by: Ding Tianhong <dingtianhong@huawei.com>
> ---
>  arch/arm64/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 8c7c244..36249a3 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -115,6 +115,7 @@ config ARM64
>  	select SPARSE_IRQ
>  	select SYSCTL_EXCEPTION_TRACE
>  	select THREAD_INFO_IN_TASK
> +	select ARCH_WANT_RELAX_ORDER

I'd say the first order of business is to rename this config option to
IXBGE_82599_WANT_RELAXED_ORDER so that it's not entirely misleading and
ambiguous. At first glance it looks far more like something scary to do
with memory barriers than a network driver option. Howcome this isn't
just in drivers/net/intel/Kconfig as a "default y if SPARC" bool anyway?

Robin.

>  	help
>  	  ARM 64-bit (AArch64) Linux support.
> 
