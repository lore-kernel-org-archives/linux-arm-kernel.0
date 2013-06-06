From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 6 Jun 2013 14:28:51 +0200
Subject: [PATCH 2/5] arm: preserve ATAGS in /chosen/atags in the Device
 Tree
In-Reply-To: <1370414409-29991-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1370414409-29991-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1370414409-29991-3-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130606142851.6dd17cad@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell, Nicolas,

I'd be interested to hear your opinion about the below proposal, that
allows platform-specific code to do its own parsing of ATAGS
information, without cluttering the generic code.

Thanks!

Thomas

On Wed,  5 Jun 2013 08:40:06 +0200, Thomas Petazzoni wrote:
> Some platforms have custom ATAGS that are too specific to be parsed by
> generic code in atags_to_fdt.c, but that would nonetheless be
> useful. For example, Marvell bootloaders pass a custom ATAG that
> contain the MAC address for the various network interfaces of the
> board.
> 
> This commit makes a small addition to the atags_to_fdt logic that
> consists in storing the ATAGS contents in the /chosen/atags node of
> the Device Tree. Some platform-specific can then later make use of
> this data to parse some custom ATAGs.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/boot/compressed/atags_to_fdt.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/compressed/atags_to_fdt.c b/arch/arm/boot/compressed/atags_to_fdt.c
> index aabc02a..8b2ae61 100644
> --- a/arch/arm/boot/compressed/atags_to_fdt.c
> +++ b/arch/arm/boot/compressed/atags_to_fdt.c
> @@ -98,6 +98,7 @@ int atags_to_fdt(void *atag_list, void *fdt, int total_space)
>  	uint32_t mem_reg_property[2 * NR_BANKS];
>  	int memcount = 0;
>  	int ret;
> +	int atagssize = 0;
>  
>  	/* make sure we've got an aligned pointer */
>  	if ((u32)atag_list & 0x3)
> @@ -119,6 +120,7 @@ int atags_to_fdt(void *atag_list, void *fdt, int total_space)
>  		return ret;
>  
>  	for_each_tag(atag, atag_list) {
> +		atagssize += atag->hdr.size * 4;
>  		if (atag->hdr.tag == ATAG_CMDLINE) {
>  			/* Append the ATAGS command line to the device tree
>  			 * command line.
> @@ -153,5 +155,9 @@ int atags_to_fdt(void *atag_list, void *fdt, int total_space)
>  	if (memcount)
>  		setprop(fdt, "/memory", "reg", mem_reg_property, 4*memcount);
>  
> +	if (atagssize)
> +		setprop(fdt, "/chosen", "atags", atag_list,
> +			atagssize);
> +
>  	return fdt_pack(fdt);
>  }



-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
