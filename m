From: lkp@intel.com (kbuild test robot)
Date: Sat, 9 Jul 2016 13:59:29 +0800
Subject: [PATCH v2 1/5] drivers: usb: chipidea: Add qoriq platform driver
In-Reply-To: <1468038656-10345-2-git-send-email-rajesh.bhagat@nxp.com>
Message-ID: <201607091350.FGiCmJsm%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[auto build test WARNING on phy/next]
[also build test WARNING on v4.7-rc6 next-20160708]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Rajesh-Bhagat/drivers-usb-chipidea-Add-qoriq-platform-driver/20160709-130557
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git next
config: blackfin-allmodconfig (attached as .config)
compiler: bfin-uclinux-gcc (GCC) 4.6.3
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=blackfin 

All warnings (new ones prefixed by >>):

   drivers/usb/chipidea/ci_hdrc_qoriq.c: In function 'ci_hdrc_qoriq_usb_setup':
>> drivers/usb/chipidea/ci_hdrc_qoriq.c:85:2: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 4 has type 'resource_size_t' [-Wformat]
   drivers/usb/chipidea/ci_hdrc_qoriq.c:85:2: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 5 has type 'resource_size_t' [-Wformat]

vim +85 drivers/usb/chipidea/ci_hdrc_qoriq.c

    69		clk_disable_unprepare(data->clk);
    70	}
    71	
    72	static int ci_hdrc_qoriq_usb_setup(struct platform_device *pdev)
    73	{
    74		u32 reg;
    75		struct resource *res;
    76		struct device *dev = &pdev->dev;
    77		struct ci_hdrc_qoriq_data *data = platform_get_drvdata(pdev);
    78	
    79		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
    80		if (!res) {
    81			dev_err(dev, "failed to get I/O memory\n");
    82			return -ENOENT;
    83		}
    84	
  > 85		dev_dbg(dev, "res->start %llx, resource_size(res) %llx\n", res->start,
    86			resource_size(res));
    87		data->qoriq_regs = devm_ioremap(dev, res->start, resource_size(res));
    88		if (IS_ERR(data->qoriq_regs)) {
    89			dev_err(dev, "failed to remap I/O memory\n");
    90			return -ENOMEM;
    91		}
    92	
    93		data->phy_mode = of_usb_get_phy_mode(pdev->dev.of_node);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 40629 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160709/ca0e5ac7/attachment-0001.obj>
