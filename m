From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 29 Oct 2013 14:51:43 +0100
Subject: [PATCH 1/3] dma: imx-sdma: Add ssi dual fifo script support
In-Reply-To: <9ed025d4e98f716ba80b27acaaa98f43ad3bd75a.1383047327.git.b42378@freescale.com>
References: <cover.1383047327.git.b42378@freescale.com>
 <9ed025d4e98f716ba80b27acaaa98f43ad3bd75a.1383047327.git.b42378@freescale.com>
Message-ID: <20131029135142.GT30088@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 29, 2013 at 08:33:15PM +0800, Nicolin Chen wrote:
> There's a script for SSI missing in current sdma script list. Thus add it.
> This script would allow SSI use its dual fifo mode to transimit/receive
> data without occasional hardware underrun/overrun.
> 
> This patch also fixed a counting error for total number of scripts.

Look at drivers/dma/imx-sdma.c:

> /**
>  * struct sdma_firmware_header - Layout of the firmware image
>  *
>  * @magic		"SDMA"
>  * @version_major	increased whenever layout of struct
>  * sdma_script_start_addrs
>  *			changes.

Can you image why this firmware has a version field? Right, it's because
it encodes the layout of struct sdma_script_start_addrs.

As the comment clearly states you have to *increase this field* when you
add scripts.

Obviously you missed that, as the firmware on lkml posted recently
shows:

> 00000000: 414d4453 00000001 00000001 0000001c SDMA............
                     ^^^^^^^^
                     Still '1'

> 00000010: 00000026 000000b4 0000067a 00000282 &.......z.......
> 00000020: ffffffff 00000000 ffffffff ffffffff ................
> 00000030: ffffffff ffffffff ffffffff ffffffff ................
> 00000040: ffffffff ffffffff 00001a6a ffffffff ........j.......
> 00000050: 000002eb 000018bb ffffffff 00000408 ................
> 00000060: ffffffff 000003c0 ffffffff ffffffff ................
> 00000070: ffffffff 000002ab ffffffff 0000037b ............{...
> 00000080: ffffffff ffffffff 0000044c 0000046e ........L...n...
> 00000090: ffffffff 00001800 ffffffff ffffffff ................
> 000000a0: 00000000 00001800 00001862 00001a16 ........b.......
                              ^^^^^^^^^^^^^^^^^
                              new script addresses introduced


> -#define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V1	34
> +#define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V1	37

And no, this is not a bug. It's your firmware header that is buggy.

What you need is:

#define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V2      37

You (you as a company, not you as a person) knew that it was me who
created this firmware format. So it was absolutely unnecessary to create
an incompatible firmware instead of dropping me a short note.

Please add a version check to the driver as necessary and provide a proper
firmware.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
