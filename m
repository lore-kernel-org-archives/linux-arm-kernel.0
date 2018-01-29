From: juliac@eso.teric.us (Julia Cartwright)
Date: Mon, 29 Jan 2018 09:56:00 -0600
Subject: [patch v18 1/4] drivers: jtag: Add JTAG core driver
In-Reply-To: <1517236305-4880-2-git-send-email-oleksandrs@mellanox.com>
References: <1517236305-4880-1-git-send-email-oleksandrs@mellanox.com>
 <1517236305-4880-2-git-send-email-oleksandrs@mellanox.com>
Message-ID: <20180129155600.GA1924@kryptos.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 29, 2018 at 04:31:42PM +0200, Oleksandr Shamray wrote:
> Initial patch for JTAG driver
> JTAG class driver provide infrastructure to support hardware/software
> JTAG platform drivers. It provide user layer API interface for flashing
> and debugging external devices which equipped with JTAG interface
> using standard transactions.
> 
> Driver exposes set of IOCTL to user space for:
> - XFER:
> - SIR (Scan Instruction Register, IEEE 1149.1 Data Register scan);
> - SDR (Scan Data Register, IEEE 1149.1 Instruction Register scan);
> - RUNTEST (Forces the IEEE 1149.1 bus to a run state for a specified
>   number of clocks).
> - SIOCFREQ/GIOCFREQ for setting and reading JTAG frequency.
> 
> Driver core provides set of internal APIs for allocation and
> registration:
> - jtag_register;
> - jtag_unregister;
> - jtag_alloc;
> - jtag_free;
> 
> Platform driver on registration with jtag-core creates the next
> entry in dev folder:
> /dev/jtagX
> 
> Signed-off-by: Oleksandr Shamray <oleksandrs@mellanox.com>
> Signed-off-by: Jiri Pirko <jiri@mellanox.com>
> Acked-by: Philippe Ombredanne <pombredanne@nexb.com>
[..]
> diff --git a/drivers/jtag/jtag.c b/drivers/jtag/jtag.c
[..]
> +struct jtag *jtag_alloc(size_t priv_size, const struct jtag_ops *ops)
> +{
> +	struct jtag *jtag;
> +
> +	jtag = kzalloc(sizeof(*jtag) + priv_size, GFP_KERNEL);
> +	if (!jtag)
> +		return NULL;
> +
> +	if (!ops)
> +		return NULL;
> +
> +	if (!ops->idle || !ops->mode_set || !ops->status_get || !ops->xfer)
> +		return NULL;

Did you think through this?

You leak 'jtag' here and above.

Perform all the ops checks prior to the allocation.

   Julia
