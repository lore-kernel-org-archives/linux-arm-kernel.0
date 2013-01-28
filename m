From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 28 Jan 2013 15:08:46 -0700
Subject: [PATCH v2 11/27] clk: mvebu: create parent-child relation for
 PCIe clocks on Armada 370
In-Reply-To: <1359399397-29729-12-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1359399397-29729-12-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <5106F6EE.4000101@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/28/2013 11:56 AM, Thomas Petazzoni wrote:
> The Armada 370 has two gatable clocks for each PCIe interface, and we
> want both of them to be enabled. We therefore make one of the two
> clocks a child of the other, as we did for the sataX and sataXlnk
> clocks on Armada XP.

> diff --git a/drivers/clk/mvebu/clk-gating-ctrl.c b/drivers/clk/mvebu/clk-gating-ctrl.c

> @@ -119,8 +119,8 @@ static const struct mvebu_soc_descr __initconst armada_370_gating_descr[] = {
>  	{ "pex1_en", NULL,  2 },
>  	{ "ge1", NULL, 3 },
>  	{ "ge0", NULL, 4 },
> -	{ "pex0", NULL, 5 },
> -	{ "pex1", NULL, 9 },
> +	{ "pex0", "pex0_en", 5 },
> +	{ "pex1", "pex1_en", 9 },

I must admit, I know nothing about struct mvebu_soc_descr, but I'm
having a hard time seeing how that code change makes one of those clock
a parent of the other, since the pex0 entry doesn't reference anything
"pex1"-related, nor vice-versa. Is more explanation in the commit
message warranted here?
