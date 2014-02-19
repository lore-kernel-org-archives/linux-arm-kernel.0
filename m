From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 19 Feb 2014 17:00:33 +0100
Subject: [PATCH v4 07/13] ARM: dts: mvebu: Add a new set of registers to
 the PMSU node
In-Reply-To: <1392312816-17657-8-git-send-email-gregory.clement@free-electrons.com>
References: <1392312816-17657-1-git-send-email-gregory.clement@free-electrons.com>
 <1392312816-17657-8-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20140219170033.4ca8343b@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Gregory CLEMENT,

On Thu, 13 Feb 2014 18:33:30 +0100, Gregory CLEMENT wrote:

>  - reg: Should contain PMSU registers location and length. First pair
> -  for the per-CPU SW Reset Control registers, second pair for the
> -  Power Management Service Unit.
> +  for the per-CPU SW Reset Control registers, second pair for the CPU
> +  Power Management Service Unit registers, third pair for the Fabric Power
> +  Management Service Unit registers.
>  
>  Example:
>  
> -armada-370-xp-pmsu at d0022000 {
> +armada-370-xp-pmsu at 22000 {
>  	compatible = "marvell,armada-370-xp-pmsu";
> -	reg = <0xd0022100 0x430>,
> -	      <0xd0020800 0x20>;
> +	reg = <0x22100 0x430>,
> +	      <0x20800 0x20>,
> +	      <0x22000 0x24>;

I am not too happy with this because:

 *) We have to remove the second register pair from the PMSU. I haven't
    yet posted the patches on LAKML for SMP on 375 and 38x, but the 375
    doesn't have a PMSU. It however has the same CPU reset control
    registers as 370 and XP. Therefore, these 0x20800 registers have to
    be handled by a separate driver (that uses the reset framework),
    and not handled by the PMSU driver. This way, Armada 370/XP can use
    PMSU+CPU reset, while 375 will only use CPU reset.

 *) I think making the PMSU register start at 0x22100 was a mistake.
    The PMSU registers actually start at 0x22000 and they seem to go all
    the way to 0x23000. So we should have only one register pair. This
    of course raises some backward compatibility questions for the DT.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
