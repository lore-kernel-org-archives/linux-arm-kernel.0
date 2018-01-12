From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 12 Jan 2018 11:54:34 +0100
Subject: [PATCH v3 2/2] i2c: mv64xxx: Fix clock resource by adding an
 optional bus clock
In-Reply-To: <20180112103956.4875-3-gregory.clement@free-electrons.com>
References: <20180112103956.4875-1-gregory.clement@free-electrons.com>
 <20180112103956.4875-3-gregory.clement@free-electrons.com>
Message-ID: <20180112105434.juefp2apuber3zti@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jan 12, 2018 at 11:39:56AM +0100, Gregory CLEMENT wrote:
> On Armada 7K/8K we need to explicitly enable the bus clock. The bus clock
> is optional because not all the SoCs need them but at least for Armada
> 7K/8K it is actually mandatory.
> 
> The binding documentation is updating accordingly.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  .../devicetree/bindings/i2c/i2c-mv64xxx.txt          | 20 ++++++++++++++++++++
>  drivers/i2c/busses/i2c-mv64xxx.c                     | 12 +++++++++++-
>  2 files changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt b/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
> index 5c30026921ae..3d76bb19492f 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
> @@ -25,6 +25,15 @@ default frequency is 100kHz
>                       whenever you're using the "allwinner,sun6i-a31-i2c"
>                       compatible.
>  
> + - clocks:	   : pointers to the reference clocks for this device, the
> +		     first one is the one used for the clock on the i2c bus,
> +		     the second one is the clock used for the functional part
> +		     of the controller

This documentation is confusing, as usually the functional clock is
the clock driving the bus, as opposed to the interface clock clocking
the bus interface.

> + - clock-names	   : names of used clocks, mandatory if the second clock is
> +		     used, the name must be "core", and "axi" (the latter is
> +		     only for Armada 7K/8K).
> +

Are you sure the i2c controller is on the AXI bus? It seems more
likely to be on an APB bus.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180112/4f2142f6/attachment.sig>
