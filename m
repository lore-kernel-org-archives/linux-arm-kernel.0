From: lsun@mellanox.com (Liming Sun)
Date: Fri, 26 Oct 2018 18:24:56 +0000
Subject: [PATCH v4 1/4] soc: Add TmFifo driver for Mellanox BlueField Soc
In-Reply-To: <CAK8P3a0VJkQgqaq7na1_KTQzVs4-PvxYghv5_LysW7EdeBM7fw@mail.gmail.com>
References: <b143b40446c1870fb8d422b364ead95d54552be9.1527264077.git.lsun@mellanox.com>
 <1540403734-137721-1-git-send-email-lsun@mellanox.com>
 <CAK8P3a0VJkQgqaq7na1_KTQzVs4-PvxYghv5_LysW7EdeBM7fw@mail.gmail.com>
Message-ID: <AM4PR05MB322089E21DD27295C1B0A946A1F00@AM4PR05MB3220.eurprd05.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Arnd for the comments! Please see the response inline.

- Liming

> -----Original Message-----
> From: arndbergmann at gmail.com [mailto:arndbergmann at gmail.com] On
> Behalf Of Arnd Bergmann
> Sent: Thursday, October 25, 2018 11:58 AM
> To: Liming Sun <lsun@mellanox.com>
> Cc: Olof Johansson <olof@lixom.net>; David Woods
> <dwoods@mellanox.com>; Robin Murphy <robin.murphy@arm.com>; arm-
> soc <arm@kernel.org>; devicetree at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH v4 1/4] soc: Add TmFifo driver for Mellanox BlueField
> Soc
> 
> On 10/24/18, Liming Sun <lsun@mellanox.com> wrote:
> > This commit adds the TmFifo driver for Mellanox BlueField Soc.
> > TmFifo is a shared FIFO which enables external host machine to
> > exchange data with the SoC via USB or PCIe. The driver is based on
> > virtio framework and has console and network access enabled.
> >
> > Reviewed-by: David Woods <dwoods@mellanox.com>
> > Signed-off-by: Liming Sun <lsun@mellanox.com>
> 
> I definitely like the idea of using virtio-net and virtio-console here,
> this is a great way of reusing the existing high-level drivers,
> and i similar in concept (but also much simpler) to what we
> have in drivers/misc/mic/ for another Linux-running machine that
> can be a PCIe add-on card.
> 
> Have you also posted the other half of this driver? I'd like to see
> how it all fits together.

I'll add the (x86) host side driver into this patch series v5 as a separate commit.

> 
> A few style comments:
> 
> > +
> > +#define TMFIFO_GET_FIELD(reg, mask)	FIELD_GET(mask, reg)
> > +
> > +#define TMFIFO_SET_FIELD(reg, mask, value) \
> > +	((reg & ~mask) | FIELD_PREP(mask, value))
> 
> I think it would be nicer to use FIELD_GET/FIELD_PREP
> in the code directly, and avoid adding extra wrappers around them.

Will update it in patch v5.

> 
> > +/* Vring size. */
> > +#define TMFIFO_VRING_SIZE			1024
> > +
> > +/* Console Tx buffer size. */
> > +#define TMFIFO_CONS_TX_BUF_SIZE			(32 * 1024)
> > +
> > +/* Use a timer for house-keeping. */
> > +static int tmfifo_timer_interval = HZ / 10;
> > +
> > +/* Global lock. */
> > +static struct mutex tmfifo_lock;
> 
> Maybe use 'static DEFINE_MUTEX(tmfifo_lock) here and remove the
> initialization call.

Will update it in patch v5.

> 
> > +/* Virtio ring size. */
> > +static int tmfifo_vring_size = TMFIFO_VRING_SIZE;
> > +module_param(tmfifo_vring_size, int, 0444);
> > +MODULE_PARM_DESC(tmfifo_vring_size, "Size of the vring.");
> > +
> > +struct tmfifo;
> > +
> > +/* A flag to indicate TmFifo ready. */
> > +static bool tmfifo_ready;
> > +
> > +/* Virtual devices sharing the TM FIFO. */
> > +#define TMFIFO_VDEV_MAX		(VIRTIO_ID_CONSOLE + 1)
> > +
> > +/* Spin lock. */
> > +static DEFINE_SPINLOCK(tmfifo_spin_lock);
> 
> Generally speaking, it's nicer to write a driver in a way that avoids
> global variables and make the flags and locks all members of a
> device specific structure.

Will update it in patch v5.

> 
> > +struct tmfifo_vdev {
> > +	struct virtio_device vdev;	/* virtual device */
> > +	u8 status;
> > +	u64 features;
> > +	union {				/* virtio config space */
> > +		struct virtio_console_config cons;
> > +		struct virtio_net_config net;
> > +	} config;
> > +	struct tmfifo_vring vrings[TMFIFO_VRING_NUM];
> > +	u8 *tx_buf;			/* tx buffer */
> > +	u32 tx_head;			/* tx buffer head */
> > +	u32 tx_tail;			/* tx buffer tail */
> > +};
> 
> I suppose you did this to keep the driver simple, but it seems a
> little inflexible
> to only support two specific device types. Wouldn't we also want e.g. 9pfs
> or virtio_blk in some configurations?

We could definitely add more when needed, which should be straightforward
due to the virtio framework. For now only network and console are supported
and ben been verified. 

> 
> > +
> > +#define TMFIFO_VDEV_TX_BUF_AVAIL(vdev) \
> > +	(((vdev)->tx_tail >= (vdev)->tx_head) ? \
> > +	(TMFIFO_CONS_TX_BUF_SIZE - 8 - ((vdev)->tx_tail - (vdev)->tx_head))
> : \
> > +	((vdev)->tx_head - (vdev)->tx_tail - 8))
> > +
> > +#define TMFIFO_VDEV_TX_BUF_PUSH(vdev, len) do { \
> > +	(vdev)->tx_tail += (len); \
> > +	if ((vdev)->tx_tail >= TMFIFO_CONS_TX_BUF_SIZE) \
> > +		(vdev)->tx_tail -= TMFIFO_CONS_TX_BUF_SIZE; \
> > +} while (0)
> > +
> > +#define TMFIFO_VDEV_TX_BUF_POP(vdev, len) do { \
> > +	(vdev)->tx_head += (len); \
> > +	if ((vdev)->tx_head >= TMFIFO_CONS_TX_BUF_SIZE) \
> > +		(vdev)->tx_head -= TMFIFO_CONS_TX_BUF_SIZE; \
> > +} while (0)
> 
> It would be nicer to turn these into inline functions rather than macros.

Will update it in patch v5.

> 
> > +/* TMFIFO device structure */
> > +struct tmfifo {
> > +	struct tmfifo_vdev *vdev[TMFIFO_VDEV_MAX];	/* virtual devices */
> > +	struct platform_device *pdev;	/* platform device */
> > +	struct mutex lock;
> > +	void __iomem *rx_base;		/* mapped register base */
> > +	void __iomem *tx_base;		/* mapped register base */
> > +	int tx_fifo_size;		/* number of entries of the Tx FIFO */
> > +	int rx_fifo_size;		/* number of entries of the Rx FIFO */
> > +	unsigned long pend_events;	/* pending bits for deferred process
> */
> > +	int irq[TM_IRQ_CNT];		/* irq numbers */
> > +	struct work_struct work;	/* work struct for deferred process
> */
> > +	struct timer_list timer;	/* keepalive timer */
> > +	struct tmfifo_vring *vring[2];	/* current Tx/Rx ring */
> > +};
> > +
> > +union tmfifo_msg_hdr {
> > +	struct {
> > +		u8 type;		/* message type */
> > +		__be16 len;		/* payload length */
> > +		u8 unused[5];		/* reserved, set to 0 */
> > +	} __packed;
> > +	u64 data;
> > +};
> > +
> > +/*
> > + * Default MAC.
> > + * This MAC address will be read from EFI persistent variable if
> > configured.
> > + * It can also be reconfigured with standard Linux tools.
> > + */
> > +static u8 tmfifo_net_default_mac[6] = {0x00, 0x1A, 0xCA, 0xFF, 0xFF,
> > 0x01};
> > +
> 
> Is a predefined MAC address better than a random one here?
> 
> For DT based systems, we tend to also call of_get_mac_address()
> in order to allow setting a unique address from firmware.

A predefined default MAC address is simpler in this case, which makes 
DHCP or PXE boot easier in development environment. 

For production, the MAC address is stored in persistent UEFI variable 
on the eeprom, which is read in function tmfifo_get_cfg_mac() which 
calls efi.get_variable() to get the MAC address.

> 
> > +/* Forward declaration. */
> > +static void tmfifo_virtio_rxtx(struct virtqueue *vq, bool is_rx);
> > +static void tmfifo_release_pkt(struct virtio_device *vdev,
> > +			       struct tmfifo_vring *vring,
> > +			       struct vring_desc **desc);
> 
> Try to avoid forward declarations by reordering the functions according
> to how they get called.

Will update it in patch v5.

> 
> > +
> > +/* Interrupt handler. */
> > +static irqreturn_t tmfifo_irq_handler(int irq, void *dev_id)
> > +{
> > +	int i = (uintptr_t)dev_id % sizeof(void *);
> > +	struct tmfifo *fifo = dev_id - i;
> > +
> > +	if (i < TM_IRQ_CNT && !test_and_set_bit(i, &fifo->pend_events))
> > +		schedule_work(&fifo->work);
> > +
> > +	return IRQ_HANDLED;
> > +}
> 
> Maybe using a request_threaded_irq() would be a better way to defer
> the handler into IRQ context.

Not sure if I understand this comment correctly... In this case, the implemented handler 
has some mutex_lock() used, which tries to make the logic simple since multiple services 
(network & console) are sharing the same fifo. Thus schedule_work() is used.

> 
>         Arnd
