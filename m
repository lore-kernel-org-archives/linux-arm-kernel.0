From: robh@kernel.org (Rob Herring)
Date: Fri, 1 Apr 2016 12:12:17 -0500
Subject: [PATCH 3/5] dmaengine: mv_xor: add support for Armada 3700 SoC
In-Reply-To: <1459359320-12638-4-git-send-email-gregory.clement@free-electrons.com>
References: <1459359320-12638-1-git-send-email-gregory.clement@free-electrons.com>
 <1459359320-12638-4-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20160401171217.GA5786@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 30, 2016 at 07:35:18PM +0200, Gregory CLEMENT wrote:
> From: Marcin Wojtas <mw@semihalf.com>
> 
> Armada 3700 SoC comprise a single XOR engine compliant with the ones used
> in older Marvell SoC's like Armada XP or 38x. The only thing that neededs

s/neededs/needs/

> modification is the Mbus configuration, which has to be done on two
> levels: global and in device. The first one is inherited from the
> bootlader.  The latter can be opened in a default way, leaving
> arbitration to the bus controller. Hence filled mbus_dram_target_info
> structure is not needed.
> 
> Patch "dmaengine: mv_xor: optimize performance by using a subset
> of the XOR channels" introduced limitation for using XOR engines and
> channels vs number of available CPU's. Those contstraints do not however
> fit Armada 3700 architecture with two possible CPU's and single,
> dual-channel engine. Hence in this commit an adjustment for setting
> maximum available channels is added.
> 
> This patch enables XOR access to DRAM by opening default window to 4GB
> space with specific attribute.
> 
> Signed-off-by: Marcin Wojtas <mw@semihalf.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/dma/mv-xor.txt |  3 +-
>  drivers/dma/mv_xor.c                             | 56 +++++++++++++++++++++---
>  2 files changed, 51 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/mv-xor.txt b/Documentation/devicetree/bindings/dma/mv-xor.txt
> index 276ef815ef32..900328d28231 100644
> --- a/Documentation/devicetree/bindings/dma/mv-xor.txt
> +++ b/Documentation/devicetree/bindings/dma/mv-xor.txt
> @@ -1,7 +1,8 @@
>  * Marvell XOR engines
>  
>  Required properties:
> -- compatible: Should be "marvell,orion-xor" or "marvell,armada-380-xor"
> +- compatible: Should be "marvell,orion-xor", "marvell,armada-380-xor"
> +    or "marvell,armada-3700-xor".

Reformatting to 1 per line would be better. Otherwise,

Acked-by: Rob Herring <robh@kernel.org>

>  - reg: Should contain registers location and length (two sets)
>      the first set is the low registers, the second set the high
>      registers for the XOR engine.
