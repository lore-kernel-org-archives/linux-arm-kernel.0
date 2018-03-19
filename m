From: Manish.Chopra@cavium.com (Chopra, Manish)
Date: Mon, 19 Mar 2018 20:10:28 +0000
Subject: [PATCH v3 11/18] qlcnic: Eliminate duplicate barriers on
 weakly-ordered archs
In-Reply-To: <1521216991-28706-12-git-send-email-okaya@codeaurora.org>
References: <1521216991-28706-1-git-send-email-okaya@codeaurora.org>
 <1521216991-28706-12-git-send-email-okaya@codeaurora.org>
Message-ID: <DM2PR07MB685740B3E9449FF3B4632E489D40@DM2PR07MB685.namprd07.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Sinan Kaya [mailto:okaya at codeaurora.org]
> Sent: Friday, March 16, 2018 9:46 PM
> To: netdev at vger.kernel.org; timur at codeaurora.org; sulrich at codeaurora.org
> Cc: linux-arm-msm at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> Sinan Kaya <okaya@codeaurora.org>; Patil, Harish <Harish.Patil@cavium.com>;
> Chopra, Manish <Manish.Chopra@cavium.com>; Dept-GE Linux NIC Dev <Dept-
> GELinuxNICDev at cavium.com>; linux-kernel at vger.kernel.org
> Subject: [PATCH v3 11/18] qlcnic: Eliminate duplicate barriers on weakly-ordered
> archs
> 
> Code includes wmb() followed by writel(). writel() already has a barrier on some
> architectures like arm64.
> 
> This ends up CPU observing two barriers back to back before executing the
> register write.
> 
> Since code already has an explicit barrier call, changing writel() to
> writel_relaxed().
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c
> b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c
> index 46b0372..97c146e7 100644
> --- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c
> +++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c
> @@ -478,7 +478,7 @@ irqreturn_t qlcnic_83xx_clear_legacy_intr(struct
> qlcnic_adapter *adapter)
>  	wmb();
> 
>  	/* clear the interrupt trigger control register */
> -	writel(0, adapter->isr_int_vec);
> +	writel_relaxed(0, adapter->isr_int_vec);
>  	intr_val = readl(adapter->isr_int_vec);
>  	do {
>  		intr_val = readl(adapter->tgt_status_reg);
> --
> 2.7.4

Acked-by: Manish Chopra <manish.chopra@cavium.com>

Thanks.
