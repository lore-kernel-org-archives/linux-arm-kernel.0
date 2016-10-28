From: lkp@intel.com (kbuild test robot)
Date: Sat, 29 Oct 2016 02:55:17 +0800
Subject: [PATCH v2 3/5] fpga manager: Add cyclone-ps-spi driver for
 Altera FPGAs
In-Reply-To: <202cdeff42a2de149c471630110a8b2657ccf5ca.1477669745.git.stillcompiling@gmail.com>
Message-ID: <201610290231.WmljflQZ%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joshua,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.9-rc2 next-20161028]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
[Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
[Check https://git-scm.com/docs/git-format-patch for more information]

url:    https://github.com/0day-ci/linux/commits/Joshua-Clayton/lib-add-bitrev8x4/20161029-012535
config: i386-allmodconfig (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/delay.h:10:0,
                    from drivers/fpga/cyclone-ps-spi.c:14:
   drivers/fpga/cyclone-ps-spi.c: In function 'cyclonespi_write':
>> drivers/fpga/cyclone-ps-spi.c:89:46: error: 'SZ_4K' undeclared (first use in this function)
      size_t stride = min(fw_data_end - fw_data, SZ_4K);
                                                 ^
   include/linux/kernel.h:738:2: note: in definition of macro '__min'
     t2 min2 = (y);     \
     ^~
>> drivers/fpga/cyclone-ps-spi.c:89:19: note: in expansion of macro 'min'
      size_t stride = min(fw_data_end - fw_data, SZ_4K);
                      ^~~
   drivers/fpga/cyclone-ps-spi.c:89:46: note: each undeclared identifier is reported only once for each function it appears in
      size_t stride = min(fw_data_end - fw_data, SZ_4K);
                                                 ^
   include/linux/kernel.h:738:2: note: in definition of macro '__min'
     t2 min2 = (y);     \
     ^~
>> drivers/fpga/cyclone-ps-spi.c:89:19: note: in expansion of macro 'min'
      size_t stride = min(fw_data_end - fw_data, SZ_4K);
                      ^~~

vim +/SZ_4K +89 drivers/fpga/cyclone-ps-spi.c

     8	 * Works on Cyclone V. Should work on cyclone series.
     9	 * May work on other Altera fpgas.
    10	 *
    11	 */
    12	
    13	#include <linux/bitrev.h>
  > 14	#include <linux/delay.h>
    15	#include <linux/fpga/fpga-mgr.h>
    16	#include <linux/gpio/consumer.h>
    17	#include <linux/module.h>
    18	#include <linux/of_gpio.h>
    19	#include <linux/spi/spi.h>
    20	
    21	#define FPGA_RESET_TIME		50   /* time in usecs to trigger FPGA config */
    22	#define FPGA_MIN_DELAY		250  /* min usecs to wait for config status */
    23	
    24	struct cyclonespi_conf {
    25		struct gpio_desc *config;
    26		struct gpio_desc *status;
    27		struct spi_device *spi;
    28	};
    29	
    30	static const struct of_device_id of_ef_match[] = {
    31		{ .compatible = "altr,cyclone-ps-spi-fpga-mgr", },
    32		{}
    33	};
    34	MODULE_DEVICE_TABLE(of, of_ef_match);
    35	
    36	static enum fpga_mgr_states cyclonespi_state(struct fpga_manager *mgr)
    37	{
    38		return mgr->state;
    39	}
    40	
    41	static int cyclonespi_write_init(struct fpga_manager *mgr, u32 flags,
    42					 const char *buf, size_t count)
    43	{
    44		struct cyclonespi_conf *conf = (struct cyclonespi_conf *)mgr->priv;
    45	
    46		if (flags & FPGA_MGR_PARTIAL_RECONFIG) {
    47			dev_err(&mgr->dev, "Partial reconfiguration not supported.\n");
    48			return -EINVAL;
    49		}
    50	
    51		gpiod_set_value(conf->config, 0);
    52		usleep_range(FPGA_RESET_TIME, FPGA_RESET_TIME + 20);
    53		if (gpiod_get_value(conf->status) == 1) {
    54			dev_err(&mgr->dev, "Status pin should be low.\n");
    55			return -EIO;
    56		}
    57	
    58		gpiod_set_value(conf->config, 1);
    59		usleep_range(FPGA_MIN_DELAY, FPGA_MIN_DELAY + 20);
    60		if (gpiod_get_value(conf->status) == 0) {
    61			dev_err(&mgr->dev, "Status pin not ready.\n");
    62			return -EIO;
    63		}
    64	
    65		return 0;
    66	}
    67	
    68	static void rev_buf(void *buf, size_t len)
    69	{
    70		u32 *fw32 = (u32 *)buf;
    71		const u32 *fw_end = (u32 *)(buf + len);
    72	
    73		/* set buffer to lsb first */
    74		while (fw32 < fw_end) {
    75			*fw32 = bitrev8x4(*fw32);
    76			fw32++;
    77		}
    78	}
    79	
    80	static int cyclonespi_write(struct fpga_manager *mgr, const char *buf,
    81				    size_t count)
    82	{
    83		struct cyclonespi_conf *conf = (struct cyclonespi_conf *)mgr->priv;
    84		const char *fw_data = buf;
    85		const char *fw_data_end = fw_data + count;
    86	
    87		while (fw_data < fw_data_end) {
    88			int ret;
  > 89			size_t stride = min(fw_data_end - fw_data, SZ_4K);
    90	
    91			rev_buf((void *)fw_data, stride);
    92			ret = spi_write(conf->spi, fw_data, stride);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 56833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161029/6a9787c0/attachment-0001.gz>
