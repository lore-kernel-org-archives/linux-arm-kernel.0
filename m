From: lkp@intel.com (kbuild test robot)
Date: Fri, 20 Jan 2017 19:26:31 +0800
Subject: [PATCH v7 2/3] fpga manager: Add cyclone-ps-spi driver for
 Altera FPGAs
In-Reply-To: <1b85ccf11096b8ef6c3a9eee9e5897c27b89a825.1484869881.git.stillcompiling@gmail.com>
Message-ID: <201701201902.krygF9QW%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joshua,

[auto build test WARNING on linus/master]
[also build test WARNING on v4.10-rc4 next-20170120]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Joshua-Clayton/Altera-Cyclone-Passive-Serial-SPI-FPGA-Manager/20170120-172349
config: alpha-allyesconfig (attached as .config)
compiler: alpha-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=alpha 

All warnings (new ones prefixed by >>):

   drivers/fpga/cyclone-ps-spi.c: In function 'rev_buf':
   drivers/fpga/cyclone-ps-spi.c:86:13: warning: comparison of distinct pointer types lacks a cast
     while (buf < fw_end) {
                ^
   In file included from include/linux/delay.h:10:0,
                    from drivers/fpga/cyclone-ps-spi.c:17:
   drivers/fpga/cyclone-ps-spi.c: In function 'cyclonespi_write':
   include/linux/kernel.h:753:16: warning: comparison of distinct pointer types lacks a cast
     (void) (&min1 == &min2);   \
                   ^
   include/linux/kernel.h:756:2: note: in expansion of macro '__min'
     __min(typeof(x), typeof(y),   \
     ^~~~~
   drivers/fpga/cyclone-ps-spi.c:101:19: note: in expansion of macro 'min'
      size_t stride = min(fw_data_end - fw_data, SZ_4K);
                      ^~~
>> drivers/fpga/cyclone-ps-spi.c:103:11: warning: passing argument 1 of 'rev_buf' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
      rev_buf(fw_data, stride);
              ^~~~~~~
   drivers/fpga/cyclone-ps-spi.c:81:13: note: expected 'char *' but argument is of type 'const char *'
    static void rev_buf(char *buf, size_t len)
                ^~~~~~~

vim +103 drivers/fpga/cyclone-ps-spi.c

    95		struct cyclonespi_conf *conf = (struct cyclonespi_conf *)mgr->priv;
    96		const char *fw_data = buf;
    97		const char *fw_data_end = fw_data + count;
    98	
    99		while (fw_data < fw_data_end) {
   100			int ret;
 > 101			size_t stride = min(fw_data_end - fw_data, SZ_4K);
   102	
 > 103			rev_buf(fw_data, stride);
   104			ret = spi_write(conf->spi, fw_data, stride);
   105			if (ret) {
   106				dev_err(&mgr->dev, "spi error in firmware write: %d\n",

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 48649 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170120/acea2400/attachment-0001.gz>
