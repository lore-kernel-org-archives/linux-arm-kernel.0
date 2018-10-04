From: vigneshr@ti.com (Vignesh R)
Date: Thu, 4 Oct 2018 14:52:18 +0530
Subject: [PATCH 0/4] spi: add support for octal mode data transfer
In-Reply-To: <1538642920-3843-1-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1538642920-3843-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Message-ID: <43cff872-0dc5-d3ce-ca35-082faa0e0e7c@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yogesh,

On Thursday 04 October 2018 02:18 PM, Yogesh Gaur wrote:
> Add support for octal mode IO data transfer.
> Micron flash, mt35xu512aba, supports octal mode data transfer and
> NXP FlexSPI controller supports 8 data lines for data transfer (Rx/Tx).
> 
> Patch series 
> * Add support for octal mode flags and parsing of same in spi driver.
> * Add octal data communication commands required for mt35xu512aba [1] flash.
> * Add support for Read and Write proto for (1-1-8/1-8-8) mode.
> * Add mode bit required for octal mode in nxp-fspi driver [2].
> * Define binding property 'spi-rx/tx-bus-width' for LX2160ARDB target [2].
> 
> Tested on LX2160ARDB target with nxp-fspi driver, below are
> Read performance number of 1-1-1 and 1-1-8 read protocol.
> 
>  root at lxxx:~# cat /proc/mtd
>  dev:    size   erasesize  name
>  mtd0: 04000000 00001000 "spi0.0"
>  mtd1: 04000000 00001000 "spi0.1"
>  root at lxxx:~# time mtd_debug read /dev/mtd0 0x0 0x1000000 0read
>  Copied 16777216 bytes from address 0x00000000 in flash to 0read
>  
>  real    0m2.792s
>  user    0m0.000s
>  sys     0m2.790s
>  root at lxxx:~# time mtd_debug read /dev/mtd1 0x0 0x1000000 0read
>  Copied 16777216 bytes from address 0x00000000 in flash to 0read
>  
>  real    0m0.441s
>  user    0m0.000s
>  sys     0m0.440s
>  root at ls1012ardb:~#
> 
>  Flash device MTD0 configured in 1-1-1 protocol.
>  Flash device MTD1 configured in 1-1-8 protocol.
> 
> [1] https://patchwork.ozlabs.org/project/linux-mtd/list/?series=66317
> [2] https://patchwork.ozlabs.org/project/linux-mtd/list/?series=66887
> 
> Yogesh Gaur (4):
>   spi: add support for octal I/O data transfer
>   mtd: spi-nor: add support for octal mode data transfer
>   spi: nxp-fspi: add mode flag bit for octal support
>   arm64: dts: lx2160a: update fspi node

This is a bit confusing and difficult to follow. I suggest to order
patches such that spi-nor layer changes are at the first, then m25p80
related things, followed by spi-mem (if needed spi) changes and finally
spi-mem controller driver changes.

-- 
Regards
Vignesh
