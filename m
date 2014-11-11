From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 11 Nov 2014 19:42:26 +0100
Subject: Samsung/S3C6410/Mini6410: how to handle NAND's "clock off"
In-Reply-To: <201411111910.34231.juergen@kreuzholzen.de>
References: <201411111910.34231.juergen@kreuzholzen.de>
Message-ID: <20141111184226.GH27002@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 11, 2014 at 07:10:33PM +0100, Juergen Borleis wrote:
> Hi,
> 
> the S3C2410 NAND driver [1] can still be used for NANDs attached to an S3C6410
> SoC. But this driver has a "nice" feature called "clock off" to save some
> power while not in use. I tried it here on my Mini6410 platform and it freezes
> the system.
> 
> The clock tree is somehow:
> 
> [...]
>   hclk                      4            4   133000000          0 0
>      hclk_mfc               0            0   133000000          0 0
>      hclk_mem0              2            2   133000000          0 0
>         mem0_srom           0            0   133000000          0 0
>         mem0_nfcon          1            1   133000000          0 0
>         mem0_onenand0       0            0   133000000          0 0
>         mem0_onenand1       0            0   133000000          0 0
>         mem0_cfcon          0            0   133000000          0 0
> [...]
> 
> On the Mini6410 the "mem0_nfcon" clock is the only single user of the
> "hclk_mem0". And this clock is required to keep the access to the external
> network device enabled. When the NAND driver disables its clock "mem0_nfcon",
> the "hclk_mem0" gets also disabled because there is no consumer anymore. The
> next time the network driver tries to access its device, the SoC freezes.
Sounds like the network driver should hold a reference to hclk_mem0. I
assume the system uses a device tree? This is the dm9000 driver? It
doesn't seem to use clk stuff, but it should be possible to add an
optional clk entry.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
