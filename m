From: khilman@linaro.org (Kevin Hilman)
Date: Wed, 21 Aug 2013 09:01:12 -0700
Subject: [GIT PULL 3/3] ARM: shmobile: lager: enable Ether
In-Reply-To: <4901e136aa5c35873701156c4c0af5b3c2c8faee.1375839719.git.horms+renesas@verge.net.au>
 (Simon Horman's message of "Wed, 7 Aug 2013 13:30:25 +0900")
References: <cover.1375839719.git.horms+renesas@verge.net.au>
 <4901e136aa5c35873701156c4c0af5b3c2c8faee.1375839719.git.horms+renesas@verge.net.au>
Message-ID: <87siy3owxj.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Simon Horman <horms+renesas@verge.net.au> writes:

> Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

This one is triggering a new build failure in -next:

arch/arm/mach-shmobile/board-lager.c:99:2: error: unknown field 'register_type' specified in initializer
arch/arm/mach-shmobile/board-lager.c:99:19: error: 'SH_ETH_REG_FAST_RCAR' undeclared here (not in a function)

> +/* Ether */
> +static struct sh_eth_plat_data ether_pdata __initdata = {
> +	.phy			= 0x1,
> +	.edmac_endian		= EDMAC_LITTLE_ENDIAN,
> +	.register_type		= SH_ETH_REG_FAST_RCAR,

and it looks to be because this board is trying to use the register_type
field which was removed by:

commit 8d3214c4e8c8be6efd8ec7a172239ebbd4deb04b
Author: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date:   Sun Aug 18 03:13:26 2013 +0400

    sh_eth: remove 'register_type' field from 'struct sh_eth_plat_data'
    
    Now that the 'register_type' field of the 'sh_eth' driver's platform data is not
    used by the driver anymore, it's time to remove it and  its initializers from
    the SH platform code. Also  move *enum* declaring values for this  field from
    <linux/sh_eth.h>  to  the  local driver's  header file as they're only needed
    by the driver itself  now...
    
    Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>
