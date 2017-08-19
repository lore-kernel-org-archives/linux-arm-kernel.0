From: lkp@intel.com (kbuild test robot)
Date: Sat, 19 Aug 2017 09:21:29 +0800
Subject: [patch v3 2/3] drivers: jtag: Add Aspeed SoC 24xx and 25xx
 families JTAG master driver
In-Reply-To: <1502791207-26951-3-git-send-email-oleksandrs@mellanox.com>
Message-ID: <201708190909.9GRNaEaj%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Oleksandr,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.13-rc5 next-20170817]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Oleksandr-Shamray/drivers-jtag-Add-JTAG-core-driver/20170818-114739
config: um-allyesconfig (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=um 

All errors (new ones prefixed by >>):

   arch/um/drivers/vde.o: In function `vde_open_real':
   (.text+0xfb1): warning: Using 'getgrnam' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking
   arch/um/drivers/vde.o: In function `vde_open_real':
   (.text+0xdfc): warning: Using 'getpwuid' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking
   arch/um/drivers/vde.o: In function `vde_open_real':
   (.text+0x1115): warning: Using 'getaddrinfo' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking
   arch/um/drivers/pcap.o: In function `pcap_nametoaddr':
   (.text+0xe475): warning: Using 'gethostbyname' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking
   arch/um/drivers/pcap.o: In function `pcap_nametonetaddr':
   (.text+0xe515): warning: Using 'getnetbyname' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking
   arch/um/drivers/pcap.o: In function `pcap_nametoproto':
   (.text+0xe735): warning: Using 'getprotobyname' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking
   arch/um/drivers/pcap.o: In function `pcap_nametoport':
   (.text+0xe567): warning: Using 'getservbyname' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking
   drivers/auxdisplay/img-ascii-lcd.o: In function `img_ascii_lcd_probe':
   drivers/auxdisplay/img-ascii-lcd.c:386: undefined reference to `devm_ioremap_resource'
   drivers/jtag/jtag-aspeed.o: In function `aspeed_jtag_init':
>> drivers/jtag/jtag-aspeed.c:635: undefined reference to `devm_ioremap_resource'
   collect2: error: ld returned 1 exit status

vim +635 drivers/jtag/jtag-aspeed.c

   627	
   628	int aspeed_jtag_init(struct platform_device *pdev,
   629			     struct aspeed_jtag *aspeed_jtag)
   630	{
   631		struct resource *res;
   632		int err;
   633	
   634		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 > 635		aspeed_jtag->reg_base = devm_ioremap_resource(aspeed_jtag->dev, res);
   636		if (IS_ERR(aspeed_jtag->reg_base)) {
   637			err = -ENOMEM;
   638			goto out_region;
   639		}
   640	
   641		aspeed_jtag->pclk = devm_clk_get(aspeed_jtag->dev, NULL);
   642		if (IS_ERR(aspeed_jtag->pclk)) {
   643			dev_err(aspeed_jtag->dev, "devm_clk_get failed\n");
   644			return PTR_ERR(aspeed_jtag->pclk);
   645		}
   646	
   647		clk_prepare_enable(aspeed_jtag->pclk);
   648	
   649		aspeed_jtag->irq = platform_get_irq(pdev, 0);
   650		if (aspeed_jtag->irq < 0) {
   651			dev_err(aspeed_jtag->dev, "no irq specified\n");
   652			err = -ENOENT;
   653			goto out_region;
   654		}
   655	
   656		/* Enable clock */
   657		aspeed_jtag_write(aspeed_jtag, ASPEED_JTAG_CTL_ENG_EN |
   658				  ASPEED_JTAG_CTL_ENG_OUT_EN, ASPEED_JTAG_CTRL);
   659		aspeed_jtag_write(aspeed_jtag, ASPEED_JTAG_SW_MODE_EN |
   660				  ASPEED_JTAG_SW_MODE_TDIO, ASPEED_JTAG_SW);
   661	
   662		err = devm_request_irq(aspeed_jtag->dev, aspeed_jtag->irq,
   663				       aspeed_jtag_interrupt, 0,
   664				       "aspeed-jtag", aspeed_jtag);
   665		if (err) {
   666			dev_err(aspeed_jtag->dev, "aspeed_jtag unable to get IRQ");
   667			goto out_region;
   668		}
   669		dev_dbg(&pdev->dev, "aspeed_jtag:IRQ %d.\n", aspeed_jtag->irq);
   670	
   671		aspeed_jtag_write(aspeed_jtag, ASPEED_JTAG_ISR_INST_PAUSE |
   672				  ASPEED_JTAG_ISR_INST_COMPLETE |
   673				  ASPEED_JTAG_ISR_DATA_PAUSE |
   674				  ASPEED_JTAG_ISR_DATA_COMPLETE |
   675				  ASPEED_JTAG_ISR_INST_PAUSE_EN |
   676				  ASPEED_JTAG_ISR_INST_COMPLETE_EN |
   677				  ASPEED_JTAG_ISR_DATA_PAUSE_EN |
   678				  ASPEED_JTAG_ISR_DATA_COMPLETE_EN,
   679				  ASPEED_JTAG_ISR);
   680	
   681		aspeed_jtag->flag = 0;
   682		init_waitqueue_head(&aspeed_jtag->jtag_wq);
   683		return 0;
   684	
   685	out_region:
   686		release_mem_region(res->start, resource_size(res));
   687		return err;
   688	}
   689	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 19504 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170819/8ac044d1/attachment-0001.gz>
