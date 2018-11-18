From: lkp@intel.com (kbuild test robot)
Date: Mon, 19 Nov 2018 00:33:56 +0800
Subject: [PATCH v1] i2c: i2c-stm32f7: add PM Runtime support
In-Reply-To: <1542365396-9959-1-git-send-email-pierre-yves.mordret@st.com>
References: <1542365396-9959-1-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <201811190057.MW7VcmtZ%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pierre-Yves,

I love your patch! Yet something to improve:

[auto build test ERROR on wsa/i2c/for-next]
[also build test ERROR on v4.20-rc2 next-20181116]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Pierre-Yves-MORDRET/i2c-i2c-stm32f7-add-PM-Runtime-support/20181118-230534
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-next
config: xtensa-allyesconfig (attached as .config)
compiler: xtensa-linux-gcc (GCC) 8.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=8.1.0 make.cross ARCH=xtensa 

All errors (new ones prefixed by >>):

   drivers/i2c/busses/i2c-stm32f7.c: In function 'stm32f7_i2c_probe':
>> drivers/i2c/busses/i2c-stm32f7.c:1913:7: error: 'STM32F7_AUTOSUSPEND_DELAY' undeclared (first use in this function); did you mean 'RPM_REQ_AUTOSUSPEND'?
          STM32F7_AUTOSUSPEND_DELAY);
          ^~~~~~~~~~~~~~~~~~~~~~~~~
          RPM_REQ_AUTOSUSPEND
   drivers/i2c/busses/i2c-stm32f7.c:1913:7: note: each undeclared identifier is reported only once for each function it appears in

vim +1913 drivers/i2c/busses/i2c-stm32f7.c

  1782	
  1783	static int stm32f7_i2c_probe(struct platform_device *pdev)
  1784	{
  1785		struct device_node *np = pdev->dev.of_node;
  1786		struct stm32f7_i2c_dev *i2c_dev;
  1787		const struct stm32f7_i2c_setup *setup;
  1788		struct resource *res;
  1789		u32 irq_error, irq_event, clk_rate, rise_time, fall_time;
  1790		struct i2c_adapter *adap;
  1791		struct reset_control *rst;
  1792		dma_addr_t phy_addr;
  1793		int ret;
  1794	
  1795		i2c_dev = devm_kzalloc(&pdev->dev, sizeof(*i2c_dev), GFP_KERNEL);
  1796		if (!i2c_dev)
  1797			return -ENOMEM;
  1798	
  1799		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
  1800		i2c_dev->base = devm_ioremap_resource(&pdev->dev, res);
  1801		if (IS_ERR(i2c_dev->base))
  1802			return PTR_ERR(i2c_dev->base);
  1803		phy_addr = (dma_addr_t)res->start;
  1804	
  1805		irq_event = irq_of_parse_and_map(np, 0);
  1806		if (!irq_event) {
  1807			dev_err(&pdev->dev, "IRQ event missing or invalid\n");
  1808			return -EINVAL;
  1809		}
  1810	
  1811		irq_error = irq_of_parse_and_map(np, 1);
  1812		if (!irq_error) {
  1813			dev_err(&pdev->dev, "IRQ error missing or invalid\n");
  1814			return -EINVAL;
  1815		}
  1816	
  1817		i2c_dev->clk = devm_clk_get(&pdev->dev, NULL);
  1818		if (IS_ERR(i2c_dev->clk)) {
  1819			dev_err(&pdev->dev, "Error: Missing controller clock\n");
  1820			return PTR_ERR(i2c_dev->clk);
  1821		}
  1822	
  1823		ret = clk_prepare_enable(i2c_dev->clk);
  1824		if (ret) {
  1825			dev_err(&pdev->dev, "Failed to prepare_enable clock\n");
  1826			return ret;
  1827		}
  1828	
  1829		i2c_dev->speed = STM32_I2C_SPEED_STANDARD;
  1830		ret = device_property_read_u32(&pdev->dev, "clock-frequency",
  1831					       &clk_rate);
  1832		if (!ret && clk_rate >= 1000000)
  1833			i2c_dev->speed = STM32_I2C_SPEED_FAST_PLUS;
  1834		else if (!ret && clk_rate >= 400000)
  1835			i2c_dev->speed = STM32_I2C_SPEED_FAST;
  1836		else if (!ret && clk_rate >= 100000)
  1837			i2c_dev->speed = STM32_I2C_SPEED_STANDARD;
  1838	
  1839		rst = devm_reset_control_get(&pdev->dev, NULL);
  1840		if (IS_ERR(rst)) {
  1841			dev_err(&pdev->dev, "Error: Missing controller reset\n");
  1842			ret = PTR_ERR(rst);
  1843			goto clk_free;
  1844		}
  1845		reset_control_assert(rst);
  1846		udelay(2);
  1847		reset_control_deassert(rst);
  1848	
  1849		i2c_dev->dev = &pdev->dev;
  1850	
  1851		ret = devm_request_threaded_irq(&pdev->dev, irq_event,
  1852						stm32f7_i2c_isr_event,
  1853						stm32f7_i2c_isr_event_thread,
  1854						IRQF_ONESHOT,
  1855						pdev->name, i2c_dev);
  1856		if (ret) {
  1857			dev_err(&pdev->dev, "Failed to request irq event %i\n",
  1858				irq_event);
  1859			goto clk_free;
  1860		}
  1861	
  1862		ret = devm_request_irq(&pdev->dev, irq_error, stm32f7_i2c_isr_error, 0,
  1863				       pdev->name, i2c_dev);
  1864		if (ret) {
  1865			dev_err(&pdev->dev, "Failed to request irq error %i\n",
  1866				irq_error);
  1867			goto clk_free;
  1868		}
  1869	
  1870		setup = of_device_get_match_data(&pdev->dev);
  1871		if (!setup) {
  1872			dev_err(&pdev->dev, "Can't get device data\n");
  1873			ret = -ENODEV;
  1874			goto clk_free;
  1875		}
  1876		i2c_dev->setup = *setup;
  1877	
  1878		ret = device_property_read_u32(i2c_dev->dev, "i2c-scl-rising-time-ns",
  1879					       &rise_time);
  1880		if (!ret)
  1881			i2c_dev->setup.rise_time = rise_time;
  1882	
  1883		ret = device_property_read_u32(i2c_dev->dev, "i2c-scl-falling-time-ns",
  1884					       &fall_time);
  1885		if (!ret)
  1886			i2c_dev->setup.fall_time = fall_time;
  1887	
  1888		ret = stm32f7_i2c_setup_timing(i2c_dev, &i2c_dev->setup);
  1889		if (ret)
  1890			goto clk_free;
  1891	
  1892		adap = &i2c_dev->adap;
  1893		i2c_set_adapdata(adap, i2c_dev);
  1894		snprintf(adap->name, sizeof(adap->name), "STM32F7 I2C(%pa)",
  1895			 &res->start);
  1896		adap->owner = THIS_MODULE;
  1897		adap->timeout = 2 * HZ;
  1898		adap->retries = 3;
  1899		adap->algo = &stm32f7_i2c_algo;
  1900		adap->dev.parent = &pdev->dev;
  1901		adap->dev.of_node = pdev->dev.of_node;
  1902	
  1903		init_completion(&i2c_dev->complete);
  1904	
  1905		/* Init DMA config if supported */
  1906		i2c_dev->dma = stm32_i2c_dma_request(i2c_dev->dev, phy_addr,
  1907						     STM32F7_I2C_TXDR,
  1908						     STM32F7_I2C_RXDR);
  1909	
  1910		platform_set_drvdata(pdev, i2c_dev);
  1911	
  1912		pm_runtime_set_autosuspend_delay(i2c_dev->dev,
> 1913						 STM32F7_AUTOSUSPEND_DELAY);
  1914		pm_runtime_use_autosuspend(i2c_dev->dev);
  1915		pm_runtime_set_active(i2c_dev->dev);
  1916		pm_runtime_enable(i2c_dev->dev);
  1917	
  1918		pm_runtime_get_noresume(&pdev->dev);
  1919	
  1920		stm32f7_i2c_hw_config(i2c_dev);
  1921	
  1922		ret = i2c_add_adapter(adap);
  1923		if (ret)
  1924			goto pm_disable;
  1925	
  1926		dev_info(i2c_dev->dev, "STM32F7 I2C-%d bus adapter\n", adap->nr);
  1927	
  1928		pm_runtime_mark_last_busy(i2c_dev->dev);
  1929		pm_runtime_put_autosuspend(i2c_dev->dev);
  1930	
  1931		return 0;
  1932	
  1933	pm_disable:
  1934		pm_runtime_put_noidle(i2c_dev->dev);
  1935		pm_runtime_disable(i2c_dev->dev);
  1936		pm_runtime_set_suspended(i2c_dev->dev);
  1937		pm_runtime_dont_use_autosuspend(i2c_dev->dev);
  1938	
  1939	clk_free:
  1940		clk_disable_unprepare(i2c_dev->clk);
  1941	
  1942		return ret;
  1943	}
  1944	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 55744 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181119/c57fbf61/attachment-0001.gz>
