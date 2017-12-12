From: joe@perches.com (Joe Perches)
Date: Tue, 12 Dec 2017 11:47:04 -0800
Subject: [PATCH net-next v5 2/2] net: thunderx: add timestamping support
In-Reply-To: <20171211233641.cs7zdw34qkngicmj@localhost>
References: <20171211141435.2915-1-aleksey.makarov@cavium.com>
 <20171211141435.2915-3-aleksey.makarov@cavium.com>
 <20171211233641.cs7zdw34qkngicmj@localhost>
Message-ID: <1513108024.3036.63.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2017-12-11 at 15:36 -0800, Richard Cochran wrote:
> On Mon, Dec 11, 2017 at 05:14:31PM +0300, Aleksey Makarov wrote:
> > @@ -880,6 +889,46 @@ static void nic_pause_frame(struct nicpf *nic, int vf, struct pfc *cfg)
> >  	}
> >  }
> >  
> > +/* Enable or disable HW timestamping by BGX for pkts received on a LMAC */
> > +static void nic_config_timestamp(struct nicpf *nic, int vf, struct set_ptp *ptp)
> > +{
> > +	struct pkind_cfg *pkind;
> > +	u8 lmac, bgx_idx;
> > +	u64 pkind_val, pkind_idx;
> > +
> > +	if (vf >= nic->num_vf_en)
> > +		return;
> > +
> > +	bgx_idx = NIC_GET_BGX_FROM_VF_LMAC_MAP(nic->vf_lmac_map[vf]);
> > +	lmac = NIC_GET_LMAC_FROM_VF_LMAC_MAP(nic->vf_lmac_map[vf]);
> > +
> > +	pkind_idx = lmac + bgx_idx * MAX_LMAC_PER_BGX;
> > +	pkind_val = nic_reg_read(nic, NIC_PF_PKIND_0_15_CFG | (pkind_idx << 3));
> > +	pkind = (struct pkind_cfg *)&pkind_val;
> > +
> > +	if (ptp->enable && !pkind->hdr_sl) {
> > +		/* Skiplen to exclude 8byte timestamp while parsing pkt
> > +		 * If not configured, will result in L2 errors.
> > +		 */
> > +		pkind->hdr_sl = 4;
> > +		/* Adjust max packet length allowed */
> > +		pkind->maxlen += (pkind->hdr_sl * 2);

Are all compilers smart enough to set this to 8?
I rather doubt a compiler is even allowed to.
