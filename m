From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 27 Mar 2013 12:35:34 -0600
Subject: [RFC PATCHv1 3/5] arm: mach-kirkwood: seperate PCIe window init
 from other windows
In-Reply-To: <1364407504-13524-4-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1364407504-13524-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1364407504-13524-4-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130327183534.GA9643@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 27, 2013 at 07:05:02PM +0100, Thomas Petazzoni wrote:

This all looks really great to me, I hope to try it as well when I get
time. But just one small suggestion:

> diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
> index ea49476..1b4675f 100644
> +++ b/arch/arm/mach-kirkwood/board-dt.c
> @@ -72,6 +72,8 @@ static void __init kirkwood_of_clk_init(void)
>  
>  static void __init kirkwood_dt_init(void)
>  {
> +	int needs_pcie_wins = 1;
> +
>  	pr_info("Kirkwood: %s, TCLK=%d.\n", kirkwood_id(), kirkwood_tclk);
>  
>  	/*
> @@ -144,6 +146,9 @@ static void __init kirkwood_dt_init(void)
>  	if (of_machine_is_compatible("usi,topkick"))
>  		usi_topkick_init();
>  
> +	if (needs_pcie_wins)
> +		kirkwood_setup_pcie_wins();
> +
>  	of_platform_populate(NULL, kirkwood_dt_match_table, NULL, NULL);
>  }

Moving the window setup into mach-kirkwood/pcie.c:kirkwood_pcie_init
would avoid this needs_pcie_wins thing since kirkwood_pcie_init will
naturally never be called once the other patches are applied.

Cheers,
Jason
