From: lkp@intel.com (kbuild test robot)
Date: Fri, 22 Sep 2017 16:04:41 +0800
Subject: [RESEND PATCH v2 2/5] mtd: spi-nor: cadence-quadspi: add a delay
 in write sequence
In-Reply-To: <20170919105605.18533-3-vigneshr@ti.com>
Message-ID: <201709221614.9GmeyqNH%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vignesh,

[auto build test WARNING on l2-mtd-boris/spi-nor/next]
[also build test WARNING on v4.14-rc1 next-20170921]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Vignesh-R/K2G-Add-QSPI-support/20170922-152110
base:   git://git.infradead.org/l2-mtd.git spi-nor/next
config: sparc64-allmodconfig (attached as .config)
compiler: sparc64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=sparc64 

All warnings (new ones prefixed by >>):

   drivers/mtd/spi-nor/cadence-quadspi.c: In function 'cqspi_probe':
>> drivers/mtd/spi-nor/cadence-quadspi.c:1230:10: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     data  = (u32)of_device_get_match_data(&pdev->dev);
             ^

vim +1230 drivers/mtd/spi-nor/cadence-quadspi.c

  1164	
  1165	static int cqspi_probe(struct platform_device *pdev)
  1166	{
  1167		struct device_node *np = pdev->dev.of_node;
  1168		struct device *dev = &pdev->dev;
  1169		struct cqspi_st *cqspi;
  1170		struct resource *res;
  1171		struct resource *res_ahb;
  1172		u32 data;
  1173		int ret;
  1174		int irq;
  1175	
  1176		cqspi = devm_kzalloc(dev, sizeof(*cqspi), GFP_KERNEL);
  1177		if (!cqspi)
  1178			return -ENOMEM;
  1179	
  1180		mutex_init(&cqspi->bus_mutex);
  1181		cqspi->pdev = pdev;
  1182		platform_set_drvdata(pdev, cqspi);
  1183	
  1184		/* Obtain configuration from OF. */
  1185		ret = cqspi_of_get_pdata(pdev);
  1186		if (ret) {
  1187			dev_err(dev, "Cannot get mandatory OF data.\n");
  1188			return -ENODEV;
  1189		}
  1190	
  1191		/* Obtain QSPI clock. */
  1192		cqspi->clk = devm_clk_get(dev, NULL);
  1193		if (IS_ERR(cqspi->clk)) {
  1194			dev_err(dev, "Cannot claim QSPI clock.\n");
  1195			return PTR_ERR(cqspi->clk);
  1196		}
  1197	
  1198		/* Obtain and remap controller address. */
  1199		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
  1200		cqspi->iobase = devm_ioremap_resource(dev, res);
  1201		if (IS_ERR(cqspi->iobase)) {
  1202			dev_err(dev, "Cannot remap controller address.\n");
  1203			return PTR_ERR(cqspi->iobase);
  1204		}
  1205	
  1206		/* Obtain and remap AHB address. */
  1207		res_ahb = platform_get_resource(pdev, IORESOURCE_MEM, 1);
  1208		cqspi->ahb_base = devm_ioremap_resource(dev, res_ahb);
  1209		if (IS_ERR(cqspi->ahb_base)) {
  1210			dev_err(dev, "Cannot remap AHB address.\n");
  1211			return PTR_ERR(cqspi->ahb_base);
  1212		}
  1213	
  1214		init_completion(&cqspi->transfer_complete);
  1215	
  1216		/* Obtain IRQ line. */
  1217		irq = platform_get_irq(pdev, 0);
  1218		if (irq < 0) {
  1219			dev_err(dev, "Cannot obtain IRQ.\n");
  1220			return -ENXIO;
  1221		}
  1222	
  1223		ret = clk_prepare_enable(cqspi->clk);
  1224		if (ret) {
  1225			dev_err(dev, "Cannot enable QSPI clock.\n");
  1226			return ret;
  1227		}
  1228	
  1229		cqspi->master_ref_clk_hz = clk_get_rate(cqspi->clk);
> 1230		data  = (u32)of_device_get_match_data(&pdev->dev);
  1231		if (data & CQSPI_NEEDS_WR_DELAY)
  1232			cqspi->wr_delay = 5 * DIV_ROUND_UP(NSEC_PER_SEC,
  1233							   cqspi->master_ref_clk_hz);
  1234	
  1235		ret = devm_request_irq(dev, irq, cqspi_irq_handler, 0,
  1236				       pdev->name, cqspi);
  1237		if (ret) {
  1238			dev_err(dev, "Cannot request IRQ.\n");
  1239			goto probe_irq_failed;
  1240		}
  1241	
  1242		cqspi_wait_idle(cqspi);
  1243		cqspi_controller_init(cqspi);
  1244		cqspi->current_cs = -1;
  1245		cqspi->sclk = 0;
  1246	
  1247		ret = cqspi_setup_flash(cqspi, np);
  1248		if (ret) {
  1249			dev_err(dev, "Cadence QSPI NOR probe failed %d\n", ret);
  1250			goto probe_setup_failed;
  1251		}
  1252	
  1253		return ret;
  1254	probe_irq_failed:
  1255		cqspi_controller_enable(cqspi, 0);
  1256	probe_setup_failed:
  1257		clk_disable_unprepare(cqspi->clk);
  1258		return ret;
  1259	}
  1260	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 51321 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170922/bff7da17/attachment-0001.gz>
