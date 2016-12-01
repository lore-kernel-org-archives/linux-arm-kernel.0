From: lkp@intel.com (kbuild test robot)
Date: Fri, 2 Dec 2016 03:08:33 +0800
Subject: [PATCH v3 3/3] fpga manager: Add cyclone-ps-spi driver for
 Altera FPGAs
In-Reply-To: <e193572d7746e6f6b8666da7ac0f54031fed5214.1480467185.git.stillcompiling@gmail.com>
Message-ID: <201612020310.CmijyVw2%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joshua,

[auto build test WARNING on linus/master]
[also build test WARNING on v4.9-rc7]
[cannot apply to next-20161201]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Joshua-Clayton/lib-add-bitrev8x4/20161202-013521
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   include/linux/compiler.h:253:8: sparse: attribute 'no_sanitize_address': unknown attribute
>> drivers/fpga/cyclone-ps-spi.c:93:33: sparse: incompatible types in comparison expression (different type sizes)
   In file included from include/linux/delay.h:10:0,
                    from drivers/fpga/cyclone-ps-spi.c:14:
   drivers/fpga/cyclone-ps-spi.c: In function 'cyclonespi_write':
   include/linux/kernel.h:739:16: warning: comparison of distinct pointer types lacks a cast
     (void) (&min1 == &min2);   \
                   ^
   include/linux/kernel.h:742:2: note: in expansion of macro '__min'
     __min(typeof(x), typeof(y),   \
     ^~~~~
   drivers/fpga/cyclone-ps-spi.c:93:19: note: in expansion of macro 'min'
      size_t stride = min(fw_data_end - fw_data, SZ_4K);
                      ^~~

vim +93 drivers/fpga/cyclone-ps-spi.c

    77		/* set buffer to lsb first */
    78		while (fw32 < fw_end) {
    79			*fw32 = bitrev8x4(*fw32);
    80			fw32++;
    81		}
    82	}
    83	
    84	static int cyclonespi_write(struct fpga_manager *mgr, const char *buf,
    85				    size_t count)
    86	{
    87		struct cyclonespi_conf *conf = (struct cyclonespi_conf *)mgr->priv;
    88		const char *fw_data = buf;
    89		const char *fw_data_end = fw_data + count;
    90	
    91		while (fw_data < fw_data_end) {
    92			int ret;
  > 93			size_t stride = min(fw_data_end - fw_data, SZ_4K);
    94	
    95			rev_buf((void *)fw_data, stride);
    96			ret = spi_write(conf->spi, fw_data, stride);
    97			if (ret) {
    98				dev_err(&mgr->dev, "spi error in firmware write: %d\n",
    99					ret);
   100				return ret;
   101			}

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
