From: lkp@intel.com (kbuild test robot)
Date: Mon, 7 Dec 2015 23:25:21 +0800
Subject: [PATCH linux-next 5/5] mtd: atmel-quadspi: add driver for Atmel
 QSPI controller
In-Reply-To: <32396dbdec3df0bc21062a46447f02ad348c47f0.1449494420.git.cyrille.pitchen@atmel.com>
Message-ID: <201512072340.a1OuJD0t%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Cyrille,

[auto build test ERROR on next-20151207]

url:    https://github.com/0day-ci/linux/commits/Cyrille-Pitchen/mtd-spi-nor-add-driver-for-Atmel-QSPI-controller/20151207-221330
config: i386-allmodconfig (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers/mtd/spi-nor/atmel-quadspi.c: In function 'atmel_qspi_run_transfer':
>> drivers/mtd/spi-nor/atmel-quadspi.c:296:3: error: implicit declaration of function '_memcpy_toio' [-Werror=implicit-function-declaration]
      _memcpy_toio(ahb_mem, cmd->tx_buf, cmd->buf_len);
      ^
>> drivers/mtd/spi-nor/atmel-quadspi.c:298:3: error: implicit declaration of function '_memcpy_fromio' [-Werror=implicit-function-declaration]
      _memcpy_fromio(cmd->rx_buf, ahb_mem, cmd->buf_len);
      ^
   cc1: some warnings being treated as errors

coccinelle warnings: (new ones prefixed by >>)

>> drivers/mtd/spi-nor/atmel-quadspi.c:682:6-17: Move constant to right.
--
>> drivers/mtd/spi-nor/atmel-quadspi.c:758:5-11: inconsistent IS_ERR and PTR_ERR on line 760.

Please review and possibly fold the followup patch.

vim +/_memcpy_toio +296 drivers/mtd/spi-nor/atmel-quadspi.c

   290	
   291		/* Then fallback to a PIO transfer (memcpy() DOES NOT work!) */
   292		ahb_mem = aq->mem;
   293		if (cmd->enable.bits.address)
   294			ahb_mem += cmd->address;
   295		if (cmd->tx_buf)
 > 296			_memcpy_toio(ahb_mem, cmd->tx_buf, cmd->buf_len);
   297		else
 > 298			_memcpy_fromio(cmd->rx_buf, ahb_mem, cmd->buf_len);
   299	
   300		return 0;
   301	}

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 53054 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151207/de27c142/attachment-0001.obj>
