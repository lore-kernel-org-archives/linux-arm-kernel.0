From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Mon, 31 Mar 2014 10:28:46 +0200
Subject: [[PATCH 62/75] ARM: l2c: sti: remove cache size override
In-Reply-To: <E1WTYZL-0007H3-HP@rmk-PC.arm.linux.org.uk>
References: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
 <E1WTYZL-0007H3-HP@rmk-PC.arm.linux.org.uk>
Message-ID: <5339273E.4030605@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/28/2014 04:19 PM, Russell King wrote:
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>   arch/arm/mach-sti/board-dt.c | 12 +++---------
>   1 file changed, 3 insertions(+), 9 deletions(-)
>
> diff --git a/arch/arm/mach-sti/board-dt.c b/arch/arm/mach-sti/board-dt.c
> index dc8669efc12d..cf716ae10726 100644
> --- a/arch/arm/mach-sti/board-dt.c
> +++ b/arch/arm/mach-sti/board-dt.c
> @@ -16,15 +16,9 @@
>
>   void __init stih41x_l2x0_init(void)
>   {
> -	u32 way_size = 0x4;
> -	u32 aux_ctrl;
> -	/* may be this can be encoded in macros like BIT*() */
> -	aux_ctrl = L2C_AUX_CTRL_SHARED_OVERRIDE |
> -		   L310_AUX_CTRL_DATA_PREFETCH |
> -		   L310_AUX_CTRL_INSTR_PREFETCH |
> -		   L2C_AUX_CTRL_WAY_SIZE(way_size);
> -
> -	l2x0_of_init(aux_ctrl, L2X0_AUX_CTRL_MASK);
> +	l2x0_of_init(L2C_AUX_CTRL_SHARED_OVERRIDE |
> +		     L310_AUX_CTRL_DATA_PREFETCH |
> +		     L310_AUX_CTRL_INSTR_PREFETCH, 0xc00f0fff);

As discussed last week, the STiH416 SoC has his way size value set to 0 
at reset instead of 4.

I think this should be done by the bootloader instead of the Kernel.
Sadly the bootloader don't set it for now, but I will request it to be 
implemented.

Regards,
Maxime

>   }
>
>   static void __init stih41x_machine_init(void)
>
