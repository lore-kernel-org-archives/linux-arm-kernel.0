From: oleksandrs@mellanox.com (Oleksandr Shamray)
Date: Fri, 12 Jan 2018 16:42:35 +0000
Subject: [patch v15 1/4] drivers: jtag: Add JTAG core driver
In-Reply-To: <13433849-cb7d-e2c0-4ce9-d91a6012d7d7@gmail.com>
References: <1514202808-29747-1-git-send-email-oleksandrs@mellanox.com>
 <1514202808-29747-2-git-send-email-oleksandrs@mellanox.com>
 <13433849-cb7d-e2c0-4ce9-d91a6012d7d7@gmail.com>
Message-ID: <AM4PR0501MB2194A5EF09E5F3140F2C211CB1170@AM4PR0501MB2194.eurprd05.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Florian Fainelli [mailto:f.fainelli at gmail.com]
> Sent: 26 ??????? 2017 ?. 1:09
> To: Oleksandr Shamray <oleksandrs@mellanox.com>;
> gregkh at linuxfoundation.org; arnd at arndb.de
> Cc: linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> devicetree at vger.kernel.org; openbmc at lists.ozlabs.org; joel at jms.id.au;
> jiri at resnulli.us; tklauser at distanz.ch; linux-serial at vger.kernel.org; Vadim
> Pasternak <vadimp@mellanox.com>; system-sw-low-level <system-sw-low-
> level at mellanox.com>; robh+dt at kernel.org; openocd-devel-
> owner at lists.sourceforge.net; linux-api at vger.kernel.org;
> davem at davemloft.net; mchehab at kernel.org; Jiri Pirko
> <jiri@mellanox.com>
> Subject: Re: [patch v15 1/4] drivers: jtag: Add JTAG core driver
> 
> 

[snip]

> > +
> > +	case JTAG_IOCXFER:
> > +		if (copy_from_user(&xfer, (void *)arg,
> > +				   sizeof(struct jtag_xfer)))
> > +			return -EFAULT;
> > +
> > +		if (xfer.length >= JTAG_MAX_XFER_DATA_LEN)
> > +			return -EINVAL;
> > +
> > +		if (xfer.type > JTAG_SDR_XFER)
> > +			return -EINVAL;
> > +
> > +		if (xfer.direction > JTAG_WRITE_XFER)
> > +			return -EINVAL;
> > +
> > +		if (xfer.endstate > JTAG_STATE_PAUSEDR)
> > +			return -EINVAL;
> > +
> > +		data_size = DIV_ROUND_UP(xfer.length, BITS_PER_BYTE);
> > +		xfer_data = memdup_user(u64_to_user_ptr(xfer.tdio),
> data_size);
> > +
> > +		if (!xfer_data)
> > +			return -EFAULT;
> > +
> > +		if (jtag->ops->xfer) {
> > +			err = jtag->ops->xfer(jtag, &xfer, xfer_data);
> > +		} else {
> > +			kfree(xfer_data);
> > +			return -EOPNOTSUPP;
> > +		}
> 
> Why don't you move all of the code here into a function which will make the
> error handling consistent? Also, checking whether the jtag adapter

Greg KH <gregkh@linuxfoundation.org> Say to move all of this insight ioctl 

> implements ops->xfer should probably be done before you do the
> memdup_user().

Yes

> > +		if (err) {
> > +			kfree(xfer_data);
> > +			return -EFAULT;
> > +		}
> > +
> > +		if (jtag->ops->mode_set)
> > +			err = jtag->ops->mode_set(jtag, value);
> > +		else
> > +			err = -EOPNOTSUPP;
> > +		break;
> 
> Same here, this can be checked before get_user().
> 

Yes

> > +	if (jtag->opened) {
> > +		mutex_unlock(&jtag->open_lock);
> > +		return -EINVAL;
> 
> -EBUSY maybe?
> 

Yes


> > +
> > +	jtag = kzalloc(sizeof(*jtag) + round_up(priv_size,
> ARCH_DMA_MINALIGN),
> > +		       GFP_KERNEL);
> > +	if (!jtag)
> > +		return NULL;
> 
> If you set ARCH_DMA_MINALIGN to 1 when not defined, what is this
> achieving that kmalloc() is not already doing?
> 

Removed ARCH_DMA_MINALIGN

> > +
> > +	jtag->ops = ops;
> > +	return jtag;
> > +}
> > +EXPORT_SYMBOL_GPL(jtag_alloc);
> > +
> > +void jtag_free(struct jtag *jtag)
> > +{
> > +	kfree(jtag);
> > +}
> > +EXPORT_SYMBOL_GPL(jtag_free);
> > +
> > +int jtag_register(struct jtag *jtag)
> > +{
> > +	char *name;
> > +	int err;
> > +	int id;
> > +
> > +	id = ida_simple_get(&jtag_ida, 0, 0, GFP_KERNEL);
> > +	if (id < 0)
> > +		return id;
> > +
> > +	jtag->id = id;
> > +
> > +	name = kzalloc(MAX_JTAG_NAME_LEN, GFP_KERNEL);
> > +	if (!name) {
> > +		err = -ENOMEM;
> > +		goto err_jtag_alloc;
> > +	}
> 
> Can't you use jtag->miscdev.dev here to simplify the allocation error
> handling?
> 

How, what you mean?

> > +#ifndef ARCH_DMA_MINALIGN
> > +#define ARCH_DMA_MINALIGN 1
> > +#endif
> 
> Why?
> 

Not used now, Deleted

> > +#endif /* __JTAG_H */
> > diff --git a/include/uapi/linux/jtag.h b/include/uapi/linux/jtag.h new
> > file mode 100644 index 0000000..cda2520
> > --- /dev/null
> > +++ b/include/uapi/linux/jtag.h
> 
> [snip]
> 
> > +struct jtag_xfer {
> > +	__u8	type;
> > +	__u8	direction;
> 
> Can these two be an enum referring to what you defined earlier?
> 

Greg KH <gregkh@linuxfoundation.org> say:

"All structures that cross the user/kernel boundry have to use the __ type variables.
No "unsigned char", it has to be "__u8", no "unsigned short", it has to be "__u16", and so on.
Also, watch out for your enumerated types, what's the packing end up looking like on these structures?  Have you verified it works with a 64bit kernel and 32bit userspace all correctly?"

So I use __u8 type instead of enum to avoid errors while crossing 64bit kernel and 32bit userspace.

> > +	__u8	endstate;
> > +	__u32	length;
> > +	__u64	tdio;
> > +};
> --
> Florian

Thaks.
