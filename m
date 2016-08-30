From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Tue, 30 Aug 2016 19:20:55 +0200
Subject: [RESEND PATCH, v5 4/5] usb: Add MediaTek USB3 DRD Driver
In-Reply-To: <1472204307.27677.41.camel@mhfsdcap03>
References: <1472094329-18466-1-git-send-email-chunfeng.yun@mediatek.com>
 <1472094329-18466-5-git-send-email-chunfeng.yun@mediatek.com>
 <1472113973.2877.22.camel@suse.com>
 <1472204307.27677.41.camel@mhfsdcap03>
Message-ID: <20160830172055.GA29742@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 26, 2016 at 05:38:27PM +0800, chunfeng yun wrote:
> Hi,
> 
> On Thu, 2016-08-25 at 10:32 +0200, Oliver Neukum wrote:
> > On Thu, 2016-08-25 at 11:05 +0800, Chunfeng Yun wrote:
> > > This patch adds support for the MediaTek USB3 controller
> > > integrated into MT8173. It can be configured as Dual-Role
> > > Device (DRD), Peripheral Only and Host Only (xHCI) modes.
> > > 
> > 
> > > +/**
> > > + * General Purpose Descriptor (GPD):
> > > + *	The format of TX GPD is a little different from RX one.
> > > + *	And the size of GPD is 16 bytes.
> > > + *
> > > + * @flag:
> > > + *	bit0: Hardware Own (HWO)
> > > + *	bit1: Buffer Descriptor Present (BDP), always 0, BD is not supported
> > > + *	bit2: Bypass (BPS), 1: HW skips this GPD if HWO = 1
> > > + *	bit7: Interrupt On Completion (IOC)
> > > + * @chksum: This is used to validate the contents of this GPD;
> > > + *	If TXQ_CS_EN / RXQ_CS_EN bit is set, an interrupt is issued
> > > + *	when checksum validation fails;
> > > + *	Checksum value is calculated over the 16 bytes of the GPD by default;
> > > + * @data_buf_len (RX ONLY): This value indicates the length of
> > > + *	the assigned data buffer
> > > + * @next_gpd: Physical address of the next GPD
> > > + * @buffer: Physical address of the data buffer
> > > + * @buf_len:
> > > + *	(TX): This value indicates the length of the assigned data buffer
> > > + *	(RX): The total length of data received
> > > + * @ext_len: reserved
> > > + * @ext_flag:
> > > + *	bit5 (TX ONLY): Zero Length Packet (ZLP),
> > > + */
> > > +struct qmu_gpd {
> > > +	u8 flag;
> > > +	u8 chksum;
> > > +	u16 data_buf_len;
> > > +	u32 next_gpd;
> > > +	u32 buffer;
> > > +	u16 buf_len;
> > > +	u8 ext_len;
> > > +	u8 ext_flag;
> > > +} __packed;
> > 
> > It looks like this is shared with hardware in memory.
> > But you leave the endianness of the bigger fields undeclared.
> > 
> The driver only supports Little-Endian SoCs currently, because I have no
> Big-Endian platform to test it.

that's ok, you still have to mark the endian of the data and use it in
that manner, you can't just not worry about it.

Please fix up.

thanks,

greg k-h
