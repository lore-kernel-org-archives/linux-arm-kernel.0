From: lkp@intel.com (kbuild test robot)
Date: Mon, 20 Mar 2017 01:30:30 +0800
Subject: [PATCH v2 2/2] fpga: Add support for Xilinx LogiCORE PR Decoupler
In-Reply-To: <1489711910-17443-2-git-send-email-mdf@kernel.org>
Message-ID: <201703200150.3izmZBcU%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Moritz,

[auto build test WARNING on linus/master]
[also build test WARNING on v4.11-rc2 next-20170310]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Moritz-Fischer/doc-Add-bindings-document-for-Xilinx-LogiCore-PR-Decoupler/20170320-005406
config: ia64-allmodconfig (attached as .config)
compiler: ia64-linux-gcc (GCC) 6.2.0
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=ia64 

All warnings (new ones prefixed by >>):

   In file included from include/linux/io.h:25:0,
                    from drivers/fpga/xilinx-pr-decoupler.c:19:
   drivers/fpga/xilinx-pr-decoupler.c: In function 'xlnx_pr_decoupler_enable_set':
   arch/ia64/include/asm/io.h:395:30: warning: large integer implicitly truncated to unsigned type [-Woverflow]
    #define writel(v,a) __writel((v), (a))
                                 ^
>> drivers/fpga/xilinx-pr-decoupler.c:43:3: note: in expansion of macro 'writel'
      writel(CTRL_CMD_COUPLE, priv->io_base);
      ^~~~~~

vim +/writel +43 drivers/fpga/xilinx-pr-decoupler.c

    13	 * but WITHOUT ANY WARRANTY; without even the implied warranty of
    14	 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
    15	 * GNU General Public License for more details.
    16	 */
    17	
    18	#include <linux/clk.h>
  > 19	#include <linux/io.h>
    20	#include <linux/kernel.h>
    21	#include <linux/of_device.h>
    22	#include <linux/module.h>
    23	#include <linux/fpga/fpga-bridge.h>
    24	
    25	#define CTRL_CMD_DECOUPLE	BIT(0)
    26	#define CTRL_CMD_COUPLE		~BIT(0)
    27	
    28	struct xlnx_pr_decoupler_data {
    29		void __iomem *io_base;
    30		struct clk *clk;
    31	};
    32	
    33	static int xlnx_pr_decoupler_enable_set(struct fpga_bridge *bridge, bool enable)
    34	{
    35		int err;
    36		struct xlnx_pr_decoupler_data *priv = bridge->priv;
    37	
    38		err = clk_enable(priv->clk);
    39		if (err)
    40			return err;
    41	
    42		if (enable)
  > 43			writel(CTRL_CMD_COUPLE, priv->io_base);
    44		else
    45			writel(CTRL_CMD_DECOUPLE, priv->io_base);
    46	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 46770 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170320/93af8024/attachment-0001.gz>
