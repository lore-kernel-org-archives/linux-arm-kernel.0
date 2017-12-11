From: richardcochran@gmail.com (Richard Cochran)
Date: Mon, 11 Dec 2017 15:36:41 -0800
Subject: [PATCH net-next v5 2/2] net: thunderx: add timestamping support
In-Reply-To: <20171211141435.2915-3-aleksey.makarov@cavium.com>
References: <20171211141435.2915-1-aleksey.makarov@cavium.com>
 <20171211141435.2915-3-aleksey.makarov@cavium.com>
Message-ID: <20171211233641.cs7zdw34qkngicmj@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 11, 2017 at 05:14:31PM +0300, Aleksey Makarov wrote:
> @@ -880,6 +889,46 @@ static void nic_pause_frame(struct nicpf *nic, int vf, struct pfc *cfg)
>  	}
>  }
>  
> +/* Enable or disable HW timestamping by BGX for pkts received on a LMAC */
> +static void nic_config_timestamp(struct nicpf *nic, int vf, struct set_ptp *ptp)
> +{
> +	struct pkind_cfg *pkind;
> +	u8 lmac, bgx_idx;
> +	u64 pkind_val, pkind_idx;
> +
> +	if (vf >= nic->num_vf_en)
> +		return;
> +
> +	bgx_idx = NIC_GET_BGX_FROM_VF_LMAC_MAP(nic->vf_lmac_map[vf]);
> +	lmac = NIC_GET_LMAC_FROM_VF_LMAC_MAP(nic->vf_lmac_map[vf]);
> +
> +	pkind_idx = lmac + bgx_idx * MAX_LMAC_PER_BGX;
> +	pkind_val = nic_reg_read(nic, NIC_PF_PKIND_0_15_CFG | (pkind_idx << 3));
> +	pkind = (struct pkind_cfg *)&pkind_val;
> +
> +	if (ptp->enable && !pkind->hdr_sl) {
> +		/* Skiplen to exclude 8byte timestamp while parsing pkt
> +		 * If not configured, will result in L2 errors.
> +		 */
> +		pkind->hdr_sl = 4;
> +		/* Adjust max packet length allowed */
> +		pkind->maxlen += (pkind->hdr_sl * 2);
> +		bgx_config_timestamping(nic->node, bgx_idx, lmac, true);
> +		nic_reg_write(nic,
> +			      NIC_PF_RX_ETYPE_0_7 | (1 << 3),
> +			      (ETYPE_ALG_ENDPARSE << 16) | ETH_P_1588);

don't need three lines for this function call.

> +	} else if (!ptp->enable && pkind->hdr_sl) {
> +		pkind->maxlen -= (pkind->hdr_sl * 2);
> +		pkind->hdr_sl = 0;
> +		bgx_config_timestamping(nic->node, bgx_idx, lmac, false);
> +		nic_reg_write(nic,
> +			      NIC_PF_RX_ETYPE_0_7 | (1 << 3),
> +			      (1ULL << 16) | ETH_P_8021Q); /* reset value */

here neither.  Also avoid comment on the LHS.  If 1<<16 means "reset"
then just define a macro.

> +	}
> +
> +	nic_reg_write(nic, NIC_PF_PKIND_0_15_CFG | (pkind_idx << 3), pkind_val);
> +}
> +

Thanks,
Richard
