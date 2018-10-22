From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Mon, 22 Oct 2018 14:40:07 +0200
Subject: [PATCH v2 0/7] spi: add support for octal mode
In-Reply-To: <1539605534-22302-1-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1539605534-22302-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Message-ID: <20181022144007.367830c6@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+Mark

Hi Yogesh,

On Mon, 15 Oct 2018 12:13:57 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> Add support for octal mode IO data transfer.
> Micron flash, mt35xu512aba, supports octal mode data transfer and
> NXP FlexSPI controller supports 8 data lines for data transfer (Rx/Tx).
> 
> Patch series
> * Add support for octal mode flags and parsing of same in spi driver.
> * Add parsing logic for spi-mem framework and m25p80.c device file.
> * Add opcodes for octal I/O commands in spi-nor framework, Read and Write proto for (1-1-8/1-8-8) mode.
>   Opcodes are added as per octal data IO commands required for mt35xu512aba [1] flash.
> * Add mode bit required for octal mode in nxp-fspi driver [2].
> * Define binding property 'spi-rx/tx-bus-width' for LX2160ARDB target [2].
> 
> Cherry pick below 2 patches (from: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git):
>     c639f871febe6667d9afce28108c634e5636c735 spi: spi-mem: Fix inverted logic in op sanity check
>     db122eb8a749a1eff038f9a282c620ab16c4be1d spi: spi-mem: Add extra sanity checks on the op param
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
> [1] https://patchwork.ozlabs.org/project/linux-mtd/list/?series=70384
> [2] https://patchwork.ozlabs.org/project/linux-mtd/list/?series=70210
> 
> Yogesh Gaur (7):
>   spi: add support for octal I/O data transfer

I guess you've followed the discussion with Mark on the "mtd: spi-nor:
Proposal for 8-8-8 mode support" series. Can you please send a new
version of this patchset after adding patching spi_setup() to support
octal mode?

Thanks,

Boris
