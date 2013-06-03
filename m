From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 3 Jun 2013 12:57:53 -0400
Subject: [PATCH] ARM: atags: add support for Marvell's u-boot
In-Reply-To: <1370277937-2965-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1370277937-2965-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130603165753.GL3803@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 03, 2013 at 06:45:37PM +0200, Thomas Petazzoni wrote:
> From: Willy Tarreau <w@1wt.eu>
> 
> Marvell uses a specific atag in its u-boot which includes among other
> information the MAC addresses for up to 4 network interfaces. This
> atag is parsed, and if found the MAC addresses are extracted there and
> assigned to node aliases eth0..3 with the name "mac-address".
> 
> This allows, with the non-DT capable bootloaders currently used on
> most Marvell platforms, to get a proper MAC address for the different
> interfaces.
> 
> Signed-off-by: Willy Tarreau <w@1wt.eu>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/boot/compressed/atags_to_fdt.c |  8 +++++++-
>  arch/arm/include/uapi/asm/setup.h       | 18 ++++++++++++++++++
>  2 files changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/compressed/atags_to_fdt.c b/arch/arm/boot/compressed/atags_to_fdt.c
> index aabc02a..7f405ed 100644
> --- a/arch/arm/boot/compressed/atags_to_fdt.c
> +++ b/arch/arm/boot/compressed/atags_to_fdt.c
> @@ -16,7 +16,7 @@ static int node_offset(void *fdt, const char *node_path)
>  }
>  
>  static int setprop(void *fdt, const char *node_path, const char *property,
> -		   uint32_t *val_array, int size)
> +		   void *val_array, int size)
>  {
>  	int offset = node_offset(fdt, node_path);
>  	if (offset < 0)
> @@ -147,6 +147,12 @@ int atags_to_fdt(void *atag_list, void *fdt, int total_space)
>  					initrd_start);
>  			setprop_cell(fdt, "/chosen", "linux,initrd-end",
>  					initrd_start + initrd_size);
> +		} else if (atag->hdr.tag == ATAG_MV_UBOOT) {
> +			/* This ATAG provides up to 4 MAC addresses */
> +			setprop(fdt, "eth0", "mac-address", atag->u.mv_uboot.macaddr[0], 6);
> +			setprop(fdt, "eth1", "mac-address", atag->u.mv_uboot.macaddr[1], 6);
> +			setprop(fdt, "eth2", "mac-address", atag->u.mv_uboot.macaddr[2], 6);
> +			setprop(fdt, "eth3", "mac-address", atag->u.mv_uboot.macaddr[3], 6);

Won't this override a user editing the 'local-mac-address' property in
the dts?  Since we're dealing with appended dtbs, there's a higher
probability of the user doing such a thing.

I'll admit it's a corner case, but I'd like to make sure we've thought
through the use cases and aren't making things more complicated than
necessary.

thx,

Jason.
