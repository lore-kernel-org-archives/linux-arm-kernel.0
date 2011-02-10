From: akpm@linux-foundation.org (Andrew Morton)
Date: Thu, 10 Feb 2011 12:52:56 -0800
Subject: [PATCH V3 1/1] ST SPEAr: PCIE gadget suppport
In-Reply-To: <4D53B4C1.5080804@st.com>
References: <1296742149-18102-1-git-send-email-pratyush.anand@st.com>
	<20110209152926.0126ac97.akpm@linux-foundation.org>
	<4D53B4C1.5080804@st.com>
Message-ID: <20110210125256.609a1143.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 10 Feb 2011 15:19:53 +0530
pratyush <pratyush.anand@st.com> wrote:

> On 2/10/2011 4:59 AM, Andrew Morton wrote:
> > On Thu, 3 Feb 2011 19:39:09 +0530
> > Pratyush Anand <pratyush.anand@st.com> wrote:
> > 
> >> This is a configurable gadget. can be configured by configfs interface. Any
> >> IP available at PCIE bus can be programmed to be used by host
> >> controller.It supoorts both INTX and MSI.
> >> By default, gadget is configured for INTX and SYSRAM1 is mapped to BAR0
> >> with size 0x1000
> >>
> >>
> >> ...
> >>
> >> --- /dev/null
> >> +++ b/Documentation/ABI/testing/configfs-spear-pcie-gadget
> >> @@ -0,0 +1,30 @@
> >> +What:		/config/pcie-gadget
> >> +Date:		Feb 2011
> >> +KernelVersion:	2.6.37
> >> +Contact:	Pratyush Anand <pratyush.anand@st.com>
> >> +Description:
> >> +
> >> +	Interface is used to configure selected dual mode pcie controller
> >> +	as device and then program its various registers to configure it
> >> +	as a particular device type.
> >> +	This interfaces can be used to show spear's pcie device capability.
> >> +
> >> +	Nodes are only visible when configfs is mounted. To mount configfs
> >> +	in /config directory use:
> >> +	# mount -t configfs none /config/
> >> +
> >> +	/config/pcie-gadget/
> >> +		link ... used to enable ltssm and read its status.
> >> +		int_type ...used to configure and read type of supported
> >> +			interrupt
> >> +		no_of_msi ... used to configure number of MSI vector needed and
> >> +			to read no of MSI granted.
> >> +		inta ... write 1 to assert INTA and 0 to de-assert.
> >> +		send_msi ... write MSI vector to be sent.
> >> +		vendor_id ... used to write and read vendor id (hex)
> >> +		device_id ... used to write and read device id (hex)
> >> +		bar0_size ... used to write and read bar0_size
> >> +		bar0_address ... used to write and read bar0 mapped area in hex.
> >> +		bar0_rw_offset ... used to write and read offset of bar0 where
> >> +			bar0_data will be written or read.
> >> +		bar0_data ... used to write and read data at bar0_rw_offset.
> > 
> > This interface implies that there will only ever be one device in the
> > machine, yes?  Seems a bit short-sighted?
> > 
> 
> This device supports only one BAR in EP mode.

I don't understand that.

What happens if someone builds a computer with three of these devices
in it?

> >> +		flags &= ~PCI_MSI_FLAGS_QMASK;
> >> +		flags |= vec << 1;
> >> +		spear_dbi_write_reg(config, cap + PCI_MSI_FLAGS, 1, flags);
> >> +	} else
> >> +		return -EINVAL;
> >> +
> >> +	strcpy(config->int_type, int_type);
> >> +
> >> +	return count;
> >> +}
> >> +
> >> +static ssize_t pcie_gadget_show_no_of_msi(
> >> +		struct spear_pcie_gadget_config *config,
> >> +		char *buf)
> >> +{
> >> +	struct pcie_app_reg __iomem *app_reg =
> >> +		(struct pcie_app_reg __iomem *)config->va_app_base;
> >> +	u32 cap, vector, vec, flags;
> >> +
> >> +	if ((readl(&app_reg->msg_status) & (1 << CFG_MSI_EN_ID))
> >> +			!= (1 << CFG_MSI_EN_ID))
> >> +		vector = 0;
> >> +	else {
> >> +		cap = pci_find_own_capability(config, PCI_CAP_ID_MSI);
> >> +		spear_dbi_read_reg(config, cap + PCI_MSI_FLAGS, 1, &flags);
> >> +		flags &= ~PCI_MSI_FLAGS_QSIZE;
> >> +		vec = flags >> 4;
> >> +		vector = 1;
> >> +		while (vec--)
> >> +			vector *= 2;
> >> +	}
> >> +	config->configured_msi = vector;
> > 
> > Wait.  A "show" function is modifying kernel state?!?!?
> > 
> 
> this show is a must call part of MSI vector negotiation.
> A device must read first configured number of MSI, before 
> sending any MSI. Here value of vector is read from HW
> and stored in a SW variable. So, it is not programmed
> by any application input.

What happens if a (buggy?) application tries to send an MSI before
calling pcie_gadget_show_no_of_msi()?
