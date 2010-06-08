From: benjamin.zores@alcatel-lucent.com (Benjamin Zores)
Date: Tue, 08 Jun 2010 13:43:44 +0200
Subject: [PATCH 3/3 v4] [ARM] Kirkwood: add support for PCIe1
In-Reply-To: <1275996094-16929-1-git-send-email-saeed@marvell.com>
References: <AANLkTilEM81aUCdIaTyN1s8es6LMETuMOGXh3a67sWgf@mail.gmail.com>
	<1275996094-16929-1-git-send-email-saeed@marvell.com>
Message-ID: <4C0E2CF0.3050307@alcatel-lucent.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/06/2010 13:21, Saeed Bishara wrote:
> @@ -106,17 +108,21 @@ void __init kirkwood_setup_cpu_mbus(void)
>   		      TARGET_PCIE, ATTR_PCIE_IO, KIRKWOOD_PCIE_IO_BUS_BASE);
>   	setup_cpu_win(1, KIRKWOOD_PCIE_MEM_PHYS_BASE, KIRKWOOD_PCIE_MEM_SIZE,
>   		      TARGET_PCIE, ATTR_PCIE_MEM, KIRKWOOD_PCIE_MEM_BUS_BASE);
> +	setup_cpu_win(2, KIRKWOOD_PCIE1_IO_PHYS_BASE, KIRKWOOD_PCIE1_IO_SIZE,
> +		      TARGET_PCIE, ATTR_PCIE1_IO, KIRKWOOD_PCIE1_IO_BUS_BASE);
> +	setup_cpu_win(3, KIRKWOOD_PCIE1_MEM_PHYS_BASE, KIRKWOOD_PCIE1_MEM_SIZE,
> +		      TARGET_PCIE, ATTR_PCIE1_MEM, KIRKWOOD_PCIE1_MEM_BUS_BASE);
>
>    

I'd have used an id, and incremented it at each setup_cpu_win() call.
Also only doing the last 2 calls on 6282.

>   	/* Make sure those units are accessible */
> -	writel(curr | CGC_SATA0 | CGC_SATA1 | CGC_PEX0, CLOCK_GATING_CTRL);
> +	writel(curr | CGC_SATA0 | CGC_SATA1 | CGC_PEX0 | CGC_PEX1, CLOCK_GATING_CTRL);
>
>    

Why not (pseudo code):

int flags = curr | CGC_SATA0 | CGC_SATA1 | CGC_PEX0;
if (6282) flags |= CGC_PEX1;
writel(flags, ...);

> +	/* For PCIe 1: first shutdown the phy */
> +	if (dev == MV88F6282_DEV_ID) {
> +		if (!(kirkwood_clk_ctrl&  CGC_PEX1)) {
> +			writel(readl(PCIE1_LINK_CTRL) | 0x10, PCIE1_LINK_CTRL);
> +			while (1)
> +				if (readl(PCIE1_STATUS)&  0x1)
> +					break;
> +			writel(readl(PCIE1_LINK_CTRL)&  ~0x10, PCIE1_LINK_CTRL);
> +		}
> +	} else  /* keep this bit set for devices that don't have PCIe1 */
> +		kirkwood_clk_ctrl |= CGC_PEX1;
>
>    

the else part is useless with the proposal above i guess.

Except from that, when using your patch I was unable to boot kernel 
anymore on 6281 boards.
I have a quite similar patch that however uses preinit() calls in pcie.c 
for the board to boot again.

I'd like to send it but I'm in discussion with your company whether or 
not I'm allowed to do so.
In the same way I do have patches for MPP and 2nd TWSI interface support 
if it may help.

Ben
