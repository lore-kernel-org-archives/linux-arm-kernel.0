From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 30 Oct 2013 13:07:28 +0000
Subject: [PATCH] ARM: mm: Fix ECC mem policy printk
In-Reply-To: <8986e8f1a3761e45a7927bdb0e54393c9155e6bf.1383137171.git.michal.simek@xilinx.com>
References: <8986e8f1a3761e45a7927bdb0e54393c9155e6bf.1383137171.git.michal.simek@xilinx.com>
Message-ID: <20131030130728.GA16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 30, 2013 at 01:46:18PM +0100, Michal Simek wrote:
> Russell, Will: We discussed this at KS that will be good
> to rephrase it or have different logic around this.
> I am not sure if we can also test that this bit is
> implemented by particular SoC or not.
> 
> Maybe logic should be that if SoC uses this bit
> that message is shown in origin format to declare
> that ECC is enabled or disabled.
> When SoC doesn't implement it then do not show this message.

This is not quite what I meant - by making the change you have, you also
omit to print the data cache policy.

> @@ -556,8 +556,9 @@ static void __init build_mem_type_table(void)
>  		mem_types[MT_CACHECLEAN].prot_sect |= PMD_SECT_WB;
>  		break;
>  	}
> -	printk("Memory policy: ECC %sabled, Data cache %s\n",
> -		ecc_mask ? "en" : "dis", cp->policy);
> +	if (ecc_mask)
> +		pr_info("Memory policy: ECC enabled, Data cache %s\n",
> +			cp->policy);

	pr_info("Memory policy: %sData cache %s\n",
		ecc_mask ? "ECC enabled, " : "", cp->policy);

is more what I was suggesting.
