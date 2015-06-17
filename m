From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 17 Jun 2015 17:24:23 +0200
Subject: [PATCH 1/9] ARM: mvebu: fix suspend to RAM on big-endian
 configurations
In-Reply-To: <1434456785-23696-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1434456785-23696-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1434456785-23696-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <55819127.1040306@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On 16/06/2015 14:12, Thomas Petazzoni wrote:
> The current Armada XP suspend to RAM implementation, as added in
> commit 27432825ae19f ("ARM: mvebu: Armada XP GP specific
> suspend/resume code") does not handle big-endian configurations
> properly: the small bit of assembly code putting the DRAM in
> self-refresh and toggling the GPIOs to turn off power forgets to
> convert the values to little-endian.
> 
> This commit fixes that by making sure the two values we will write to
> the DRAM controller register and GPIO register are already in
> little-endian before entering the critical assembly code.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: <stable@vger.kernel.org> # v3.19+
> Fixes: 27432825ae19f ("ARM: mvebu: Armada XP GP specific suspend/resume code")


Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

applied on mvebu/fixes

Thanks,

Gregory

> ---
>  arch/arm/mach-mvebu/pm-board.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/mach-mvebu/pm-board.c b/arch/arm/mach-mvebu/pm-board.c
> index 6dfd4ab..301ab38 100644
> --- a/arch/arm/mach-mvebu/pm-board.c
> +++ b/arch/arm/mach-mvebu/pm-board.c
> @@ -43,6 +43,9 @@ static void mvebu_armada_xp_gp_pm_enter(void __iomem *sdram_reg, u32 srcmd)
>  	for (i = 0; i < ARMADA_XP_GP_PIC_NR_GPIOS; i++)
>  		ackcmd |= BIT(pic_raw_gpios[i]);
>  
> +	srcmd = cpu_to_le32(srcmd);
> +	ackcmd = cpu_to_le32(ackcmd);
> +
>  	/*
>  	 * Wait a while, the PIC needs quite a bit of time between the
>  	 * two GPIO commands.
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
