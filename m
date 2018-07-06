From: roy.pledge@nxp.com (Roy Pledge)
Date: Fri, 6 Jul 2018 18:51:30 +0000
Subject: [PATCH 0/2] staging/fsl-mc/bus: Move DPIO from staging to
 drivers/soc/fsl
References: <20180705194113.16256-1-roy.pledge@nxp.com>
 <VI1PR0402MB34853F03375D3BCA4791432698470@VI1PR0402MB3485.eurprd04.prod.outlook.com>
Message-ID: <VI1PR04MB4494A72D6734ECAA57BA93C586470@VI1PR04MB4494.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/6/2018 8:25 AM, Horia Geanta wrote:
> On 7/5/2018 10:41 PM, Roy Pledge wrote:
>> Move the NXP DPIO (Datapath I/O driver) from the staging/fsl-mc/bus/dpio
>> directory to the drivers/soc/fsl directory.
>>
>> The DPIO driver enables access to the Queue and Buffer Managemer (QBMAN)
>> hardware of NXP DPAA2 devices. This is a prerequiste for moving the DPAA2
>> Ethernet device driver from the staging directory.
>>
> Roy, Ioana,
>
> Would it be ok to add the following patch on top of the series?
> It's a dependency for dpseci object.
> If not added now I fear it won't be accepted until dpaa2-ethernet
> moves out of staging, thus gating dpseci upstreaming.
>
> Thanks,
> Horia
I can add this to the series - I will respin and send a v2.
>
> --->8---
> Previous commits:
> 6e2387e8f19ed ("staging: fsl-dpaa2/eth: Add Freescale DPAA2 Ethernet driver")
> 39163c0ce0f48 ("staging: fsl-dpaa2/eth: Errors checking update")
> added bits that are not specific to the WRIOP accelerator.
>
> Move these where they belong (in DPIO) such that other accelerators
> can make use of them.
>
> Signed-off-by: Horia Geant? <horia.geanta@nxp.com>
> ---
>  drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c |  4 ++--
>  drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h | 18 +++++-------------
>  drivers/staging/fsl-mc/include/dpaa2-fd.h      | 12 ++++++++++++
>  3 files changed, 19 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
> index 396371728aa1..d5f0ac5c2d1f 100644
> --- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
> +++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
> @@ -455,7 +455,7 @@ static int build_sg_fd(struct dpaa2_eth_priv *priv,
>  	dpaa2_fd_set_format(fd, dpaa2_fd_sg);
>  	dpaa2_fd_set_addr(fd, addr);
>  	dpaa2_fd_set_len(fd, skb->len);
> -	dpaa2_fd_set_ctrl(fd, DPAA2_FD_CTRL_PTA | DPAA2_FD_CTRL_PTV1);
> +	dpaa2_fd_set_ctrl(fd, FD_CTRL_PTA | FD_CTRL_PTV1);
>
>  	if (priv->tx_tstamp && skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)
>  		enable_tx_tstamp(fd, sgt_buf);
> @@ -508,7 +508,7 @@ static int build_single_fd(struct dpaa2_eth_priv *priv,
>  	dpaa2_fd_set_offset(fd, (u16)(skb->data - buffer_start));
>  	dpaa2_fd_set_len(fd, skb->len);
>  	dpaa2_fd_set_format(fd, dpaa2_fd_single);
> -	dpaa2_fd_set_ctrl(fd, DPAA2_FD_CTRL_PTA | DPAA2_FD_CTRL_PTV1);
> +	dpaa2_fd_set_ctrl(fd, FD_CTRL_PTA | FD_CTRL_PTV1);
>
>  	if (priv->tx_tstamp && skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)
>  		enable_tx_tstamp(fd, buffer_start);
> diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
> index 905a4e6be8fa..9269cb05a84b 100644
> --- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
> +++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
> @@ -124,21 +124,13 @@ struct dpaa2_eth_swa {
>  #define DPAA2_FD_FRC_FAICFDV		0x0400
>
>  /* Error bits in FD CTRL */
> -#define DPAA2_FD_CTRL_UFD		0x00000004
> -#define DPAA2_FD_CTRL_SBE		0x00000008
> -#define DPAA2_FD_CTRL_FSE		0x00000020
> -#define DPAA2_FD_CTRL_FAERR		0x00000040
> -
> -#define DPAA2_FD_RX_ERR_MASK		(DPAA2_FD_CTRL_SBE	| \
> -					 DPAA2_FD_CTRL_FAERR)
> -#define DPAA2_FD_TX_ERR_MASK		(DPAA2_FD_CTRL_UFD	| \
> -					 DPAA2_FD_CTRL_SBE	| \
> -					 DPAA2_FD_CTRL_FSE	| \
> -					 DPAA2_FD_CTRL_FAERR)
> +#define DPAA2_FD_RX_ERR_MASK		(FD_CTRL_SBE | FD_CTRL_FAERR)
> +#define DPAA2_FD_TX_ERR_MASK		(FD_CTRL_UFD	| \
> +					 FD_CTRL_SBE	| \
> +					 FD_CTRL_FSE	| \
> +					 FD_CTRL_FAERR)
>
>  /* Annotation bits in FD CTRL */
> -#define DPAA2_FD_CTRL_PTA		0x00800000
> -#define DPAA2_FD_CTRL_PTV1		0x00400000
>  #define DPAA2_FD_CTRL_ASAL		0x00020000	/* ASAL = 128B */
>
>  /* Frame annotation status */
> diff --git a/drivers/staging/fsl-mc/include/dpaa2-fd.h b/drivers/staging/fsl-mc/include/dpaa2-fd.h
> index b55b89ba4eda..2576abaa7779 100644
> --- a/drivers/staging/fsl-mc/include/dpaa2-fd.h
> +++ b/drivers/staging/fsl-mc/include/dpaa2-fd.h
> @@ -67,6 +67,18 @@ struct dpaa2_fd {
>  #define SG_FINAL_FLAG_MASK	0x1
>  #define SG_FINAL_FLAG_SHIFT	15
>
> +/* Error bits in FD CTRL */
> +#define FD_CTRL_ERR_MASK	0x000000FF
> +#define FD_CTRL_UFD		0x00000004
> +#define FD_CTRL_SBE		0x00000008
> +#define FD_CTRL_FLC		0x00000010
> +#define FD_CTRL_FSE		0x00000020
> +#define FD_CTRL_FAERR		0x00000040
> +
> +/* Annotation bits in FD CTRL */
> +#define FD_CTRL_PTA		0x00800000
> +#define FD_CTRL_PTV1		0x00400000
> +
>  enum dpaa2_fd_format {
>  	dpaa2_fd_single = 0,
>  	dpaa2_fd_list,
