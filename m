From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 27 Feb 2013 10:57:23 +0100
Subject: [PATCH] arm: plat-orion: fix address decoding when > 4GB is used
In-Reply-To: <1361958575-2328-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1361958575-2328-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <512DD883.4090809@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/27/2013 10:49 AM, Thomas Petazzoni wrote:
> During the system initialization, the orion_setup_cpu_mbus_target()
> function reads the SDRAM address decoding registers to find out how
> many chip-selects of SDRAM have been enabled, and builds a small array
> with one entry per chip-select. This array is then used by device
> drivers (XOR, Ethernet, etc.) to configure their own address decoding
> windows to the SDRAM.
> 
> However, devices can only access the first 32 bits of the physical
> memory. Even though LPAE is not supported for now, some Marvell boards
> are not showing up with 8 GB of RAM, configured using two SDRAM
> address decoding windows: the first covering the first 4 GB, the
> second covering the last 4 GB. The array built by
> orion_setup_cpu_mbus_target() has therefore two entries, and device
> drivers try to set up two address decoding windows to the
> SDRAM. However, in the device registers for the address decoding, the
> base address is only 32 bits, so those two windows overlap each other,
> and the devices do not work at all.
> 
> This patch makes sure that the array built by
> orion_setup_cpu_mbus_target() only contains the SDRAM decoding windows
> that correspond to the first 4 GB of the memory. To do that, it
> ignores the SDRAM decoding windows for which the 3 low-order bits are
> not zero (the 3 low-order bits of the base register are used to store
> bits 32:35 of the base address, so they actually indicate whether the
> base address is above 4 GB).
> 
> This patch allows the newly introduced armada-xp-gp board to properly
> operate when it is mounted with more than 4 GB of RAM. Without that,
> all devices doing DMA (for example XOR and Ethernet) do not work at
> all.

It fixes the issue I had with Ethernet since severals weeks, you can
definitely add my:

Tested-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
> This patch should definitely be applied for 3.9. It may also be
> considered for 3.8, since other boards than the armada-xp-gp can be
> mounted with more than 4 GB of RAM.
> ---
>  arch/arm/plat-orion/addr-map.c |    7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/plat-orion/addr-map.c b/arch/arm/plat-orion/addr-map.c
> index febe386..41a8363 100644
> --- a/arch/arm/plat-orion/addr-map.c
> +++ b/arch/arm/plat-orion/addr-map.c
> @@ -157,9 +157,12 @@ void __init orion_setup_cpu_mbus_target(const struct orion_addr_map_cfg *cfg,
>  		u32 size = readl(ddr_window_cpu_base + DDR_SIZE_CS_OFF(i));
>  
>  		/*
> -		 * Chip select enabled?
> +		 * We only take care of entries for which the chip
> +		 * select is enabled, and that don't have high base
> +		 * address bits set (devices can only access the first
> +		 * 32 bits of the memory).
>  		 */
> -		if (size & 1) {
> +		if ((size & 1) && !(base & 0x7)) {
>  			struct mbus_dram_window *w;
>  
>  			w = &orion_mbus_dram_info.cs[cs++];
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
