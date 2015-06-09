From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 9 Jun 2015 14:29:41 +0200
Subject: [PATCH v2] mtd: nand: Sunxi calculate timing cfg
In-Reply-To: <1433849498-3270-1-git-send-email-r.spliet@ultimaker.com>
References: <1433849498-3270-1-git-send-email-r.spliet@ultimaker.com>
Message-ID: <20150609142941.069f468d@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue,  9 Jun 2015 13:31:38 +0200
Roy Spliet <r.spliet@ultimaker.com> wrote:


>  
> +	/* T16 - T19 + tCAD */
> +	tWB  = sunxi_nand_lookup_timing(tWB_lut, timings->tWB_max,
> +			min_clk_period);
> +	tADL = DIV_ROUND_UP(timings->tADL_min, min_clk_period) >> 3;
> +	tWHR = DIV_ROUND_UP(timings->tWHR_min, min_clk_period) >> 3;
> +	tRHW = sunxi_nand_lookup_timing(tRHW_lut, timings->tRHW_min,
> +			min_clk_period);
> +	tCAD = 0x7;
> +	chip->timing_cfg = (tWB & 0x3) |
> +			   (tADL & 0x3) << 2 |
> +			   (tWHR & 0x3) << 4 |
> +			   (tRHW & 0x3) << 6 |
> +			   (tCAD & 0x7) << 8;

Yet another comment: could you define a macro to create the timing_cfg
value ?

#define NFC_TIMING_CFG(tWB, tADL, tWHR, tRHW, tCAD)		\
	((tWB) & 0x3) | (((tADL) & 0x3) << 2) |			\
	(((tWHR) & 0x3) << 4) | (((tRHW) & 0x3) << 6) |		\
	(((tCAD) & 0x7) << 8);



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
