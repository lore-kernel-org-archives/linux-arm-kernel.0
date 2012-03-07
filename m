From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 7 Mar 2012 18:40:09 +0000
Subject: [PATCH 14/14] ARM: kirkwood: use devicetree to init sata_mv
In-Reply-To: <8503a766f6f75c9acf49abd66d9cdce54807b2b2.1331090356.git.jason@lakedaemon.net>
References: <cover.1331090356.git.jason@lakedaemon.net>
 <8503a766f6f75c9acf49abd66d9cdce54807b2b2.1331090356.git.jason@lakedaemon.net>
Message-ID: <201203071840.09572.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 07 March 2012, Jason Cooper wrote:
> @@ -504,6 +504,16 @@ static int __init kirkwood_clock_gate(void)
>                 kirkwood_clk_ctrl |= CGC_USB0;
>                 of_node_put(np);
>         }
> +
> +       np = of_find_compatible_node(NULL, NULL, "mrvl,orion-sata");
> +       if (np && of_device_is_available(np)) {
> +               int nr_ports;
> +               kirkwood_clk_ctrl |= CGC_SATA0;
> +               of_property_read_u32(np, "nr-ports", &nr_ports);
> +               if (nr_ports > 1)
> +                       kirkwood_clk_ctrl |= CGC_SATA1;
> +               of_node_put(np);
> +       }
>  #endif
>  
>         /* For SATA: first shutdown the phy */

Is it guaranteed that it's always the first port that gets used if there
is only one? If not, this might turn on the wrong one.

	Arnd
