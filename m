From: lsun@mellanox.com (Liming Sun)
Date: Mon, 29 Oct 2018 14:17:42 +0000
Subject: [PATCH v4 1/4] soc: Add TmFifo driver for Mellanox BlueField Soc
In-Reply-To: <CAK8P3a3pi26FJ=vfU3QN=xUS+ktv1W-oqGWkdxc9s_S2HaYf6w@mail.gmail.com>
References: <b143b40446c1870fb8d422b364ead95d54552be9.1527264077.git.lsun@mellanox.com>
 <1540403734-137721-1-git-send-email-lsun@mellanox.com>
 <CAK8P3a0VJkQgqaq7na1_KTQzVs4-PvxYghv5_LysW7EdeBM7fw@mail.gmail.com>
 <AM4PR05MB322089E21DD27295C1B0A946A1F00@AM4PR05MB3220.eurprd05.prod.outlook.com>
 <CAK8P3a3pi26FJ=vfU3QN=xUS+ktv1W-oqGWkdxc9s_S2HaYf6w@mail.gmail.com>
Message-ID: <DB6PR05MB322336054C526251D2A3780CA1F30@DB6PR05MB3223.eurprd05.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks. Please see my response inline.

> -----Original Message-----
> From: arndbergmann at gmail.com [mailto:arndbergmann at gmail.com] On
> Behalf Of Arnd Bergmann
> Sent: Friday, October 26, 2018 2:35 PM
> To: Liming Sun <lsun@mellanox.com>
> Cc: Olof Johansson <olof@lixom.net>; David Woods
> <dwoods@mellanox.com>; Robin Murphy <robin.murphy@arm.com>; arm-
> soc <arm@kernel.org>; devicetree at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH v4 1/4] soc: Add TmFifo driver for Mellanox BlueField
> Soc
> 
> On 10/26/18, Liming Sun <lsun@mellanox.com> wrote:
> >> -----Original Message-----
> >> From: arndbergmann at gmail.com [mailto:arndbergmann at gmail.com] On
> >> Behalf Of Arnd Bergmann
> >> Sent: Thursday, October 25, 2018 11:58 AM
> >> To: Liming Sun <lsun@mellanox.com>
> >> Cc: Olof Johansson <olof@lixom.net>; David Woods
> >> <dwoods@mellanox.com>; Robin Murphy <robin.murphy@arm.com>;
> arm-
> >> soc <arm@kernel.org>; devicetree at vger.kernel.org; linux-arm-
> >> kernel at lists.infradead.org
> >> Subject: Re: [PATCH v4 1/4] soc: Add TmFifo driver for Mellanox BlueField
> >> Soc
> >>
> >> On 10/24/18, Liming Sun <lsun@mellanox.com> wrote:
> >> > +struct tmfifo_vdev {
> >> > +	struct virtio_device vdev;	/* virtual device */
> >> > +	u8 status;
> >> > +	u64 features;
> >> > +	union {				/* virtio config space */
> >> > +		struct virtio_console_config cons;
> >> > +		struct virtio_net_config net;
> >> > +	} config;
> >> > +	struct tmfifo_vring vrings[TMFIFO_VRING_NUM];
> >> > +	u8 *tx_buf;			/* tx buffer */
> >> > +	u32 tx_head;			/* tx buffer head */
> >> > +	u32 tx_tail;			/* tx buffer tail */
> >> > +};
> >>
> >> I suppose you did this to keep the driver simple, but it seems a
> >> little inflexible
> >> to only support two specific device types. Wouldn't we also want e.g.
> >> 9pfs
> >> or virtio_blk in some configurations?
> >
> > We could definitely add more when needed, which should be
> straightforward
> > due to the virtio framework. For now only network and console are
> supported
> > and ben been verified.
> 
> Wouldn't that require a new PCI ID to have the driver on the host
> side match what this side does? I guess I'll see when you post the
> other driver.

Yes, the PCI ID is in the host side driver which will be included in patch v5.

> 
> >> > +/* TMFIFO device structure */
> >> > +struct tmfifo {
> >> > +	struct tmfifo_vdev *vdev[TMFIFO_VDEV_MAX];	/* virtual devices */
> >> > +	struct platform_device *pdev;	/* platform device */
> >> > +	struct mutex lock;
> >> > +	void __iomem *rx_base;		/* mapped register base */
> >> > +	void __iomem *tx_base;		/* mapped register base */
> >> > +	int tx_fifo_size;		/* number of entries of the Tx FIFO */
> >> > +	int rx_fifo_size;		/* number of entries of the Rx FIFO */
> >> > +	unsigned long pend_events;	/* pending bits for deferred process
> >> */
> >> > +	int irq[TM_IRQ_CNT];		/* irq numbers */
> >> > +	struct work_struct work;	/* work struct for deferred process
> >> */
> >> > +	struct timer_list timer;	/* keepalive timer */
> >> > +	struct tmfifo_vring *vring[2];	/* current Tx/Rx ring */
> >> > +};
> >> > +
> >> > +union tmfifo_msg_hdr {
> >> > +	struct {
> >> > +		u8 type;		/* message type */
> >> > +		__be16 len;		/* payload length */
> >> > +		u8 unused[5];		/* reserved, set to 0 */
> >> > +	} __packed;
> >> > +	u64 data;
> >> > +};
> >> > +
> >> > +/*
> >> > + * Default MAC.
> >> > + * This MAC address will be read from EFI persistent variable if
> >> > configured.
> >> > + * It can also be reconfigured with standard Linux tools.
> >> > + */
> >> > +static u8 tmfifo_net_default_mac[6] = {0x00, 0x1A, 0xCA, 0xFF, 0xFF,
> >> > 0x01};
> >> > +
> >>
> >> Is a predefined MAC address better than a random one here?
> >>
> >> For DT based systems, we tend to also call of_get_mac_address()
> >> in order to allow setting a unique address from firmware.
> >
> > A predefined default MAC address is simpler in this case, which makes
> > DHCP or PXE boot easier in development environment.
> >
> > For production, the MAC address is stored in persistent UEFI variable
> > on the eeprom, which is read in function tmfifo_get_cfg_mac() which
> > calls efi.get_variable() to get the MAC address.
> 
> Ok, fair enough. Generally speaking the recommended way of doing
> this is to update the DT properties from eeprom when a network
> driver has no way to store the mac address itself, but I suppose
> you always have UEFI anyway, and this also makes it work in
> the same way across both DT and ACPI.

Yes, we always have UEFI available.

> 
> >> > +/* Interrupt handler. */
> >> > +static irqreturn_t tmfifo_irq_handler(int irq, void *dev_id)
> >> > +{
> >> > +	int i = (uintptr_t)dev_id % sizeof(void *);
> >> > +	struct tmfifo *fifo = dev_id - i;
> >> > +
> >> > +	if (i < TM_IRQ_CNT && !test_and_set_bit(i, &fifo->pend_events))
> >> > +		schedule_work(&fifo->work);
> >> > +
> >> > +	return IRQ_HANDLED;
> >> > +}
> >>
> >> Maybe using a request_threaded_irq() would be a better way to defer
> >> the handler into IRQ context.
> >
> > Not sure if I understand this comment correctly... In this case, the
> > implemented handler
> > has some mutex_lock() used, which tries to make the logic simple since
> > multiple services
> > (network & console) are sharing the same fifo. Thus schedule_work() is
> > used.
> 
> schedule_work() and threaded IRQs are just two different ways of deferring
> into process context where you can do the mutex_lock(). The effect is
> almost the same, but work queues can be delayed for a substantial
> amount of time depending on what other work functions have been
> queued at the same time, and request_threaded_irq() is the more normal
> way of doing this specifically for an IRQ handler, probably saving a couple
> of lines of source code.
> 
> If you have any kind of real-time requirement, you can also assign a
> specific realtime priority to that interrupt thread.

Good information! Currently this FIFO is mainly for mgmt purpose. I'll try the threaded 
IRQs approach to see whether it can be easily converted and make it into the v5 patch.
If not easily, probably a separate commit to improve it later?

> 
>        Arnd
