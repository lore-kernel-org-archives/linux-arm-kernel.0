From: chip@bilbrey.org (Chip Bilbrey)
Date: Sun, 05 Nov 2017 14:32:53 -0800
Subject: [v11,1/4] drivers: jtag: Add JTAG core driver
In-Reply-To: <1509724449-26221-2-git-send-email-oleksandrs@mellanox.com>
References: <1509724449-26221-2-git-send-email-oleksandrs@mellanox.com>
Message-ID: <8760aoz78q.fsf@bilbrey.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Oleksandr Shamray writes:
> diff --git a/include/uapi/linux/jtag.h b/include/uapi/linux/jtag.h
> new file mode 100644
> index 0000000..0b25a83
> --- /dev/null
> +++ b/include/uapi/linux/jtag.h
> [...]
> +/**
> + * enum jtag_xfer_mode:
> + *
> + * @JTAG_XFER_HW_MODE: hardware mode transfer
> + * @JTAG_XFER_SW_MODE: software mode transfer
> + */
> +enum jtag_xfer_mode {
> +	JTAG_XFER_HW_MODE,
> +	JTAG_XFER_SW_MODE,
> +};

Is this essentially selecting between bit-bang mode or not?  Is there a
generally applicable reason to select SW mode over HW (or vice versa)?
This sounds like it's tied to device-specific capability which shouldn't
be exposed in a generic user API.

> +/**
> + * struct jtag_xfer - jtag xfer:
> + *
> + * @mode: access mode
> + * @type: transfer type
> + * @direction: xfer direction
> + * @length: xfer bits len
> + * @tdio : xfer data array
> + * @endir: xfer end state
> + *
> + * Structure represents interface to Aspeed JTAG device for jtag sdr xfer
> + * execution.

Probably should remove the reference to Aspeed here.

> +/* ioctl interface */
> +#define __JTAG_IOCTL_MAGIC	0xb2
> +
> +#define JTAG_IOCRUNTEST	_IOW(__JTAG_IOCTL_MAGIC, 0,\
> +			     struct jtag_run_test_idle)
> +#define JTAG_SIOCFREQ	_IOW(__JTAG_IOCTL_MAGIC, 1, unsigned int)
> +#define JTAG_GIOCFREQ	_IOR(__JTAG_IOCTL_MAGIC, 2, unsigned int)
> +#define JTAG_IOCXFER	_IOWR(__JTAG_IOCTL_MAGIC, 3, struct jtag_xfer)
> +#define JTAG_GIOCSTATUS _IOWR(__JTAG_IOCTL_MAGIC, 4, enum jtag_endstate)

I notice the single-open()-per-device lock was dropped by request in an
earlier revision of your patches, but multiple processes trying to drive
a single JTAG master could wreak serious havoc if transactions get
interleaved. Would something like an added JTAG_LOCKCHAIN/UNLOCKCHAIN
ioctl() for exclusive client access be reasonable to prevent this?

-Chip
