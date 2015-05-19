From: joe@perches.com (Joe Perches)
Date: Mon, 18 May 2015 19:21:33 -0700
Subject: [PATCH net-next v4 2/2] net: Adding support for Cavium ThunderX
 network controller
In-Reply-To: <1432000757-28700-3-git-send-email-aleksey.makarov@auriga.com>
References: <1432000757-28700-1-git-send-email-aleksey.makarov@auriga.com>
 <1432000757-28700-3-git-send-email-aleksey.makarov@auriga.com>
Message-ID: <1432002093.2870.130.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-05-18 at 18:59 -0700, Aleksey Makarov wrote:
> From: Sunil Goutham <sgoutham@cavium.com>

trivial note, I didn't read the whole thing.

> diff --git a/drivers/net/ethernet/cavium/thunder/nic.h b/drivers/net/ethernet/cavium/thunder/nic.h
[]
> +/* Set Maximum frame size */
> +struct set_frs_msg {
> +	u8    vf_id;
> +	u16   max_frs;
> +};
> +
> +/* Set CPI algorithm type */
> +struct cpi_cfg_msg {
> +	u8    vf_id;
> +	u8    rq_cnt;
> +	u8    cpi_alg;
> +};
> +
> +#ifdef VNIC_RSS_SUPPORT
> +/* Get RSS table size */
> +struct rss_sz_msg {
> +	u8    vf_id;
> +	u16   ind_tbl_size;
> +};

Are these missing __packed?

> +/* Physical interface link status */
> +struct bgx_link_status {
> +	u8    link_up;
> +	u8    duplex;
> +	u32   speed;
> +};

[]

> +#ifdef	NIC_DEBUG
> +#define	nic_dbg(dev, fmt, arg...) \
> +		dev_info(dev, fmt, ##arg)

I think it's better to emit debug information at KERN_DEUG

> +#else
> +#define	nic_dbg(dev, fmt, arg...) do {} while (0)

This could/should still verify the format & args with an if (0)
#define	nic_dbg(dev, fmt, ...)				\
do {							\
	if (0)						\
		dev_dbgdev, fmt, ##__VA_ARGS__);	\
} while (0)

> +/* PF -> VF mailbox communication APIs */
> +static void nic_enable_mbx_intr(struct nicpf *nic)
> +{
> +	/* Enable mailbox interrupt for all 128 VFs */
> +	nic_reg_write(nic, NIC_PF_MAILBOX_ENA_W1S, ~0x00ull);
> +	nic_reg_write(nic, NIC_PF_MAILBOX_ENA_W1S + sizeof(u64), ~0x00ull);

~0x00ull is a bit odd.  ~0ull is more common

> +}
> +
> +static void nic_clear_mbx_intr(struct nicpf *nic, int vf, int mbx_reg)
> +{
> +	nic_reg_write(nic, NIC_PF_MAILBOX_INT + (mbx_reg << 3), (1ULL << vf));

Maybe use BIT_ULL(vf)

> +static int nic_sriov_init(struct pci_dev *pdev, struct nicpf *nic)
> +{
[]
> +	dev_info(&pdev->dev, "SRIOV enabled, numer of VF available %d\n",

number

> diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_main.c b/drivers/net/ethernet/cavium/thunder/nicvf_main.c

> +static void nicvf_dump_packet(struct net_device *netdev, struct sk_buff *skb)
> +{
> +	int i;
> +
> +	pr_info("%s: skb 0x%p, len=%d\n",
> +		netdev->name, skb, skb->len);
> +	for (i = 0; i < skb->len; i++) {
> +		if ((i % 16) == 0)
> +			pr_info("\n");
> +		pr_info(" %02x", ((u8 *)skb->data)[i]);
> +	}
> +	pr_info("\n");

This creates a mess.  Try print_hex_dump instead.

> +static inline void nicvf_set_rx_frame_cnt(struct nicvf *nic,
> +					  struct sk_buff *skb)
> +{
> +	if (skb->len <= 64)
> +		nic->drv_stats.rx_frames_64++;
> +	else if ((skb->len > 64) && (skb->len <= 127))

The first condition in the subsequent "else if"s isn't necessary.
It's already known by the preceding tests.

	if (skb->len <= 64)
		...
	else if (skb->len <= 127)
		...
	else if (skb->len <= 255)
		etc...

> +		nic->drv_stats.rx_frames_127++;
> +	else if ((skb->len > 127) && (skb->len <= 255))
> +		nic->drv_stats.rx_frames_255++;
> +	else if ((skb->len > 255) && (skb->len <= 511))
> +		nic->drv_stats.rx_frames_511++;
> +	else if ((skb->len > 511) && (skb->len <= 1023))
> +		nic->drv_stats.rx_frames_1023++;
> +	else if ((skb->len > 1023) && (skb->len <= 1518))
> +		nic->drv_stats.rx_frames_1518++;
> +	else if (skb->len > 1518)
> +		nic->drv_stats.rx_frames_jumbo++;
> +}
