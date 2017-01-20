From: stillcompiling@gmail.com (Joshua Clayton)
Date: Fri, 20 Jan 2017 15:39:50 -0800
Subject: [PATCH v7 2/3] fpga manager: Add cyclone-ps-spi driver for Altera
 FPGAs
In-Reply-To: <201701202037.FWBSni3B%fengguang.wu@intel.com>
References: <201701202037.FWBSni3B%fengguang.wu@intel.com>
Message-ID: <8dff470a-e1b9-1aef-101c-287abcfea380@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Sigh...
On 01/20/2017 04:07 AM, kbuild test robot wrote:
> Hi Joshua,
>
> [auto build test WARNING on linus/master]
> [also build test WARNING on v4.10-rc4 next-20170120]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Joshua-Clayton/Altera-Cyclone-Passive-Serial-SPI-FPGA-Manager/20170120-172349
> reproduce:
>         # apt-get install sparse
>         make ARCH=x86_64 allmodconfig
>         make C=1 CF=-D__CHECK_ENDIAN__
>
>
> sparse warnings: (new ones prefixed by >>)
>
>    include/linux/compiler.h:253:8: sparse: attribute 'no_sanitize_address': unknown attribute
>>> drivers/fpga/cyclone-ps-spi.c:86:20: sparse: incompatible types in comparison expression (different signedness)
>    drivers/fpga/cyclone-ps-spi.c:101:33: sparse: incompatible types in comparison expression (different type sizes)
>    drivers/fpga/cyclone-ps-spi.c: In function 'rev_buf':
>    drivers/fpga/cyclone-ps-spi.c:86:13: warning: comparison of distinct pointer types lacks a cast
>      while (buf < fw_end) {
>                 ^
>    In file included from include/linux/delay.h:10:0,
>                     from drivers/fpga/cyclone-ps-spi.c:17:
>    drivers/fpga/cyclone-ps-spi.c: In function 'cyclonespi_write':
>    include/linux/kernel.h:753:16: warning: comparison of distinct pointer types lacks a cast
>      (void) (&min1 == &min2);   \
>                    ^
>    include/linux/kernel.h:756:2: note: in expansion of macro '__min'
>      __min(typeof(x), typeof(y),   \
>      ^~~~~
>    drivers/fpga/cyclone-ps-spi.c:101:19: note: in expansion of macro 'min'
>       size_t stride = min(fw_data_end - fw_data, SZ_4K);
>                       ^~~
>    drivers/fpga/cyclone-ps-spi.c:103:11: warning: passing argument 1 of 'rev_buf' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
>       rev_buf(fw_data, stride);
>               ^~~~~~~
>    drivers/fpga/cyclone-ps-spi.c:81:13: note: expected 'char *' but argument is of type 'const char *'
>     static void rev_buf(char *buf, size_t len)
>                 ^~~~~~~
>
> vim +86 drivers/fpga/cyclone-ps-spi.c
>
>     70		gpiod_set_value(conf->config, 0);
>     71		for (i = 0; i < (FPGA_MAX_DELAY / FPGA_MIN_DELAY); i++) {
>     72			usleep_range(FPGA_MIN_DELAY, FPGA_MIN_DELAY + 20);
>     73			if (!gpiod_get_value(conf->status))
>     74				return 0;
>     75		}
>     76	
>     77		dev_err(&mgr->dev, "Status pin not ready.\n");
>     78		return -EIO;
>     79	}
>     80	
>     81	static void rev_buf(char *buf, size_t len)
>     82	{
>     83		const u8 *fw_end = (buf + len);
Bah!
u8 * should be char *
>     84	
>     85		/* set buffer to lsb first */
>   > 86		while (buf < fw_end) {
>     87			*buf = bitrev8(*buf);
>     88			buf++;
>     89		}
>     90	}
>     91	
>     92	static int cyclonespi_write(struct fpga_manager *mgr, const char *buf,
>     93				    size_t count)
>     94	{
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
Guess I had better add sparse to my pre send regimen.
v8 posted shortly.
~Joshua
