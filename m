From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 29 Jan 2015 17:04:03 +0100
Subject: [PATCH] spi/xilinx: Cast ioread32/iowrite32 function pointers
In-Reply-To: <1422543073-21895-1-git-send-email-ricardo.ribalda@gmail.com>
References: <1422543073-21895-1-git-send-email-ricardo.ribalda@gmail.com>
Message-ID: <1597235.QjzCE74z4V@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 29 January 2015 15:51:13 Ricardo Ribalda Delgado wrote:
>          * Setup little endian helper functions first and try to use them
>          * and check if bit was correctly setup or not.
>          */
> -       xspi->read_fn = ioread32;
> -       xspi->write_fn = iowrite32;
> +       xspi->read_fn = (u32 (*)(void __iomem *)) ioread32;
> +       xspi->write_fn = (void (*)(u32, void __iomem *)) iowrite32;
>  
>         xspi->write_fn(XSPI_CR_LOOP, xspi->regs + XSPI_CR_OFFSET);
> 

Casting the type of a function you call seems rather dangerous. Why not
add an inline function in this driver as a wrapper?

	Arnd
