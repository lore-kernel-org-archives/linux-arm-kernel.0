From: benjamin.zores@alcatel-lucent.com (Benjamin Zores)
Date: Mon, 07 Jun 2010 10:04:08 +0200
Subject: [PATCH 3/3 v3] [ARM] Kirkwood: add support for PCIe1
In-Reply-To: <1275819882-8373-1-git-send-email-saeed@marvell.com>
References: <alpine.LFD.2.00.1006031224180.24526@xanadu.home>
	<1275819882-8373-1-git-send-email-saeed@marvell.com>
Message-ID: <4C0CA7F8.3080506@alcatel-lucent.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/06/2010 12:24, Saeed Bishara wrote:
> This patch extens the kirkwood's PCIe support up to 2 controllers as in the 6282 devices.
>
> diff --git a/arch/arm/mach-kirkwood/db88f6281-bp-setup.c b/arch/arm/mach-kirkwood/db88f6281-bp-setup.c
> index 39bdf4b..c428348 100644
> --- a/arch/arm/mach-kirkwood/db88f6281-bp-setup.c
> +++ b/arch/arm/mach-kirkwood/db88f6281-bp-setup.c
> @@ -74,9 +74,15 @@ static void __init db88f6281_init(void)
>
>   static int __init db88f6281_pci_init(void)
>   {
> -	if (machine_is_db88f6281_bp())
> -		kirkwood_pcie_init();
> +	if (machine_is_db88f6281_bp()) {
> +		u32 dev, rev;
>
> +		kirkwood_pcie_id(&dev,&rev);
> +		if (dev == MV88F6282_DEV_ID)
> +			kirkwood_pcie_init(KW_PCIE1 | KW_PCIE0);
> +		else
> +			kirkwood_pcie_init(KW_PCIE0);
> +	}
>   	return 0;
>    

This is still not likely to be possible: I don't think a given board can 
have 2 different SoCs.

> +#define CGC_PEX1		(1<<  18)
>   #define CGC_GE1			(1<<  19)
>   #define CGC_TDM			(1<<  20)
>   #define CGC_RESERVED		((1<<  18) | (0x6<<  21))
>    

(1 << 18) is no longer reserved.

Except from that you still miss the mapping definition and phy 
initialization in common.c

See 
http://lists.infradead.org/pipermail/linux-arm-kernel/2010-June/017176.html 
for details.

Ben
