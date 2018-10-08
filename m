From: lkp@intel.com (kbuild test robot)
Date: Tue, 9 Oct 2018 02:02:13 +0800
Subject: [PATCH v4 2/2] PCI: amlogic: Add the Amlogic Meson PCIe
 controller driver
In-Reply-To: <1538999834-156423-3-git-send-email-hanjie.lin@amlogic.com>
References: <1538999834-156423-3-git-send-email-hanjie.lin@amlogic.com>
Message-ID: <201810090223.qIWUG5u1%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yue,

I love your patch! Yet something to improve:

[auto build test ERROR on pci/next]
[also build test ERROR on v4.19-rc7 next-20181008]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Hanjie-Lin/add-the-Amlogic-Meson-PCIe-controller-driver/20181009-001429
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=arm 

All error/warnings (new ones prefixed by >>):

   drivers/pci/controller/dwc/pci-meson.c: In function 'meson_pcie_get_mem_shared':
>> drivers/pci/controller/dwc/pci-meson.c:171:10: warning: return makes pointer from integer without a cast [-Wint-conversion]
      return -ENXIO;
             ^
   In file included from include/linux/node.h:18:0,
                    from include/linux/cpu.h:17,
                    from include/linux/of_device.h:5,
                    from drivers/pci/controller/dwc/pci-meson.c:11:
   drivers/pci/controller/dwc/pci-meson.c: In function 'meson_size_to_payload':
>> drivers/pci/controller/dwc/pci-meson.c:336:12: error: passing argument 1 of '_dev_warn' from incompatible pointer type [-Werror=incompatible-pointer-types]
      dev_warn("input playload size %d, set to default 256\n", size);
               ^
   include/linux/device.h:1420:12: note: in definition of macro 'dev_warn'
     _dev_warn(dev, dev_fmt(fmt), ##__VA_ARGS__)
               ^~~
   include/linux/device.h:1358:6: note: expected 'const struct device *' but argument is of type 'char *'
    void _dev_warn(const struct device *dev, const char *fmt, ...);
         ^~~~~~~~~
>> drivers/pci/controller/dwc/pci-meson.c:336:60: warning: passing argument 2 of '_dev_warn' makes pointer from integer without a cast [-Wint-conversion]
      dev_warn("input playload size %d, set to default 256\n", size);
                                                               ^
   include/linux/device.h:1335:22: note: in definition of macro 'dev_fmt'
    #define dev_fmt(fmt) fmt
                         ^~~
>> drivers/pci/controller/dwc/pci-meson.c:336:3: note: in expansion of macro 'dev_warn'
      dev_warn("input playload size %d, set to default 256\n", size);
      ^~~~~~~~
   include/linux/device.h:1358:6: note: expected 'const char *' but argument is of type 'int'
    void _dev_warn(const struct device *dev, const char *fmt, ...);
         ^~~~~~~~~
   drivers/pci/controller/dwc/pci-meson.c: In function 'meson_pcie_rd_own_conf':
   drivers/pci/controller/dwc/pci-meson.c:405:21: warning: unused variable 'mp' [-Wunused-variable]
     struct meson_pcie *mp = to_meson_pcie(pci);
                        ^~
   drivers/pci/controller/dwc/pci-meson.c: In function 'meson_pcie_wr_own_conf':
   drivers/pci/controller/dwc/pci-meson.c:423:21: warning: unused variable 'mp' [-Wunused-variable]
     struct meson_pcie *mp = to_meson_pcie(pci);
                        ^~
   cc1: some warnings being treated as errors

vim +/_dev_warn +336 drivers/pci/controller/dwc/pci-meson.c

   160	
   161	static void __iomem *meson_pcie_get_mem_shared(struct platform_device *pdev,
   162						struct meson_pcie *mp,
   163						const char *id)
   164	{
   165		struct device *dev = mp->pci.dev;
   166		struct resource *res;
   167	
   168		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, id);
   169		if (!res) {
   170			dev_err(dev, "No REG resource %s\n", id);
 > 171			return -ENXIO;
   172		}
   173	
   174		return devm_ioremap(dev, res->start, resource_size(res));
   175	}
   176	
   177	static int meson_pcie_get_mems(struct platform_device *pdev,
   178				       struct meson_pcie *mp)
   179	{
   180		mp->mem_res.elbi_base = meson_pcie_get_mem(pdev, mp, "elbi");
   181		if (IS_ERR(mp->mem_res.elbi_base))
   182			return PTR_ERR(mp->mem_res.elbi_base);
   183	
   184		mp->mem_res.cfg_base = meson_pcie_get_mem(pdev, mp, "cfg");
   185		if (IS_ERR(mp->mem_res.cfg_base))
   186			return PTR_ERR(mp->mem_res.cfg_base);
   187	
   188		/* Meson SoC has two PCI controllers use same phy register*/
   189		mp->mem_res.phy_base = meson_pcie_get_mem_shared(pdev, mp, "phy");
   190		if (IS_ERR(mp->mem_res.phy_base))
   191			return PTR_ERR(mp->mem_res.phy_base);
   192	
   193		return 0;
   194	}
   195	
   196	static void meson_pcie_power_on(struct meson_pcie *mp)
   197	{
   198		writel(MESON_PCIE_PHY_POWERUP, mp->mem_res.phy_base);
   199	}
   200	
   201	static void meson_pcie_reset(struct meson_pcie *mp)
   202	{
   203		struct meson_pcie_rc_reset *mrst = &mp->mrst;
   204	
   205		reset_control_assert(mrst->phy);
   206		udelay(PCIE_RESET_DELAY);
   207		reset_control_deassert(mrst->phy);
   208		udelay(PCIE_RESET_DELAY);
   209	
   210		reset_control_assert(mrst->port);
   211		reset_control_assert(mrst->apb);
   212		udelay(PCIE_RESET_DELAY);
   213		reset_control_deassert(mrst->port);
   214		reset_control_deassert(mrst->apb);
   215		udelay(PCIE_RESET_DELAY);
   216	}
   217	
   218	static inline struct clk *meson_pcie_probe_clock(struct device *dev,
   219							 const char *id, u64 rate)
   220	{
   221		struct clk *clk;
   222		int ret;
   223	
   224		clk = devm_clk_get(dev, id);
   225		if (IS_ERR(clk))
   226			return clk;
   227	
   228		if (rate) {
   229			ret = clk_set_rate(clk, rate);
   230			if (ret) {
   231				dev_err(dev, "set clk rate failed, ret = %d\n", ret);
   232				return ERR_PTR(ret);
   233			}
   234		}
   235	
   236		ret = clk_prepare_enable(clk);
   237		if (ret) {
   238			dev_err(dev, "couldn't enable clk\n");
   239			return ERR_PTR(ret);
   240		}
   241	
   242		devm_add_action_or_reset(dev,
   243					 (void (*) (void *))clk_disable_unprepare,
   244					 clk);
   245	
   246		return clk;
   247	}
   248	
   249	static int meson_pcie_probe_clocks(struct meson_pcie *mp)
   250	{
   251		struct device *dev = mp->pci.dev;
   252		struct meson_pcie_clk_res *res = &mp->clk_res;
   253	
   254		res->port_clk = meson_pcie_probe_clock(dev, "port", PORT_CLK_RATE);
   255		if (IS_ERR(res->port_clk))
   256			return PTR_ERR(res->port_clk);
   257	
   258		res->mipi_gate = meson_pcie_probe_clock(dev, "pcie_mipi_en", 0);
   259		if (IS_ERR(res->mipi_gate))
   260			return PTR_ERR(res->mipi_gate);
   261	
   262		res->general_clk = meson_pcie_probe_clock(dev, "pcie_general", 0);
   263		if (IS_ERR(res->general_clk))
   264			return PTR_ERR(res->general_clk);
   265	
   266		res->clk = meson_pcie_probe_clock(dev, "pcie", 0);
   267		if (IS_ERR(res->clk))
   268			return PTR_ERR(res->clk);
   269	
   270		return 0;
   271	}
   272	
   273	static inline void meson_elb_writel(struct meson_pcie *mp, u32 val, u32 reg)
   274	{
   275		writel(val, mp->mem_res.elbi_base + reg);
   276	}
   277	
   278	static inline u32 meson_elb_readl(struct meson_pcie *mp, u32 reg)
   279	{
   280		return readl(mp->mem_res.elbi_base + reg);
   281	}
   282	
   283	static inline u32 meson_cfg_readl(struct meson_pcie *mp, u32 reg)
   284	{
   285		return readl(mp->mem_res.cfg_base + reg);
   286	}
   287	
   288	static inline void meson_cfg_writel(struct meson_pcie *mp, u32 val, u32 reg)
   289	{
   290		writel(val, mp->mem_res.cfg_base + reg);
   291	}
   292	
   293	static void meson_pcie_assert_reset(struct meson_pcie *mp)
   294	{
   295		gpiod_set_value_cansleep(mp->reset_gpio, 0);
   296		udelay(500);
   297		gpiod_set_value_cansleep(mp->reset_gpio, 1);
   298	}
   299	
   300	static void meson_pcie_init_dw(struct meson_pcie *mp)
   301	{
   302		u32 val;
   303	
   304		val = meson_cfg_readl(mp, PCIE_CFG0);
   305		val |= APP_LTSSM_ENABLE;
   306		meson_cfg_writel(mp, val, PCIE_CFG0);
   307	
   308		val = meson_elb_readl(mp, PCIE_PORT_LINK_CTRL_OFF);
   309		val &= ~LINK_CAPABLE_MASK;
   310		meson_elb_writel(mp, val, PCIE_PORT_LINK_CTRL_OFF);
   311	
   312		val = meson_elb_readl(mp, PCIE_PORT_LINK_CTRL_OFF);
   313		val |= LINK_CAPABLE_X1 | FAST_LINK_MODE;
   314		meson_elb_writel(mp, val, PCIE_PORT_LINK_CTRL_OFF);
   315	
   316		val = meson_elb_readl(mp, PCIE_GEN2_CTRL_OFF);
   317		val &= ~NUM_OF_LANES_MASK;
   318		meson_elb_writel(mp, val, PCIE_GEN2_CTRL_OFF);
   319	
   320		val = meson_elb_readl(mp, PCIE_GEN2_CTRL_OFF);
   321		val |= NUM_OF_LANES_X1 | DIRECT_SPEED_CHANGE;
   322		meson_elb_writel(mp, val, PCIE_GEN2_CTRL_OFF);
   323	
   324		meson_elb_writel(mp, 0x0, PCIE_BASE_ADDR0);
   325		meson_elb_writel(mp, 0x0, PCIE_BASE_ADDR1);
   326	}
   327	
   328	static int meson_size_to_payload(int size)
   329	{
   330		/*
   331		 * dwc supports 2^(val+7) payload size, which val is 0~5 default to 1.
   332		 * So if input size is not 2^order alignment or less than 2^7 or bigger
   333		 * than 2^12, just set to default size 2^(1+7).
   334		 */
   335		if (size & (size - 1) || size < 128 || size > 4096) {
 > 336			dev_warn("input playload size %d, set to default 256\n", size);
   337			return 1;
   338		}
   339	
   340		return fls(size) - 8;
   341	}
   342	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 67161 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181009/63c62fef/attachment-0001.gz>
