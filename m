From: lkp@intel.com (kbuild test robot)
Date: Wed, 16 May 2018 04:17:17 +0800
Subject: [xlnx:master 1122/1651]
 drivers/dma//xilinx/xilinx_ps_pcie_platform.c:2957:14: error: 'DMA_SG'
 undeclared; did you mean 'DMA_PQ'?
Message-ID: <201805160459.8Bl77sL1%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx master
head:   c3ad4b9f92cef73b118446312f39f2dbe9fc0ff1
commit: 818f168696f561c127f161379eb5b8d1835218a2 [1122/1651] Merge tag 'v4.14' into master
config: x86_64-allmodconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        git checkout 818f168696f561c127f161379eb5b8d1835218a2
        # save the attached .config to linux build tree
        make ARCH=x86_64 

Note: the xlnx/master HEAD c3ad4b9f92cef73b118446312f39f2dbe9fc0ff1 builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   In file included from drivers/net/ethernet/cadence/macb_pci.c:29:0:
>> drivers/net/ethernet/cadence/macb.h:927:2: error: unknown type name 'phy_interface_t'
     phy_interface_t  phy_interface;
     ^~~~~~~~~~~~~~~
>> drivers/net/ethernet/cadence/macb.h:943:24: error: field 'ptp_caps' has incomplete type
     struct ptp_clock_info ptp_caps;
                           ^~~~~~~~
--
>> drivers/media//platform/xilinx/xilinx-csi2rxss.c:43:10: fatal error: media/v4l2-of.h: No such file or directory
    #include <media/v4l2-of.h>
             ^~~~~~~~~~~~~~~~~
   compilation terminated.
--
   In file included from drivers/dma//xilinx/xilinx_ps_pcie.h:16:0,
                    from drivers/dma//xilinx/xilinx_ps_pcie_platform.c:15:
   drivers/dma//xilinx/xilinx_ps_pcie_platform.c: In function 'xlnx_pcie_dma_driver_probe':
>> drivers/dma//xilinx/xilinx_ps_pcie_platform.c:2957:14: error: 'DMA_SG' undeclared (first use in this function); did you mean 'DMA_PQ'?
     dma_cap_set(DMA_SG, xdev->common.cap_mask);
                 ^
   include/linux/dmaengine.h:1201:46: note: in definition of macro 'dma_cap_set'
    #define dma_cap_set(tx, mask) __dma_cap_set((tx), &(mask))
                                                 ^~
   drivers/dma//xilinx/xilinx_ps_pcie_platform.c:2957:14: note: each undeclared identifier is reported only once for each function it appears in
     dma_cap_set(DMA_SG, xdev->common.cap_mask);
                 ^
   include/linux/dmaengine.h:1201:46: note: in definition of macro 'dma_cap_set'
    #define dma_cap_set(tx, mask) __dma_cap_set((tx), &(mask))
                                                 ^~
>> drivers/dma//xilinx/xilinx_ps_pcie_platform.c:2972:15: error: 'struct dma_device' has no member named 'device_prep_dma_sg'; did you mean 'device_prep_dma_pq'?
     xdev->common.device_prep_dma_sg = xlnx_ps_pcie_dma_prep_dma_sg;
                  ^~~~~~~~~~~~~~~~~~
                  device_prep_dma_pq
--
   drivers/dma//xilinx/xilinx_ps_pcie_dma_client.c: In function 'initiate_sync_transfer':
>> drivers/dma//xilinx/xilinx_ps_pcie_dma_client.c:310:17: error: 'struct dma_device' has no member named 'device_prep_dma_sg'; did you mean 'device_prep_dma_pq'?
      txd = device->device_prep_dma_sg(chan, dst_sg->sgl,
                    ^~~~~~~~~~~~~~~~~~
                    device_prep_dma_pq
   drivers/dma//xilinx/xilinx_ps_pcie_dma_client.c: In function 'initiate_async_transfer':
   drivers/dma//xilinx/xilinx_ps_pcie_dma_client.c:697:17: error: 'struct dma_device' has no member named 'device_prep_dma_sg'; did you mean 'device_prep_dma_pq'?
      txd = device->device_prep_dma_sg(chan, dst_sg->sgl,
                    ^~~~~~~~~~~~~~~~~~
                    device_prep_dma_pq

vim +2957 drivers/dma//xilinx/xilinx_ps_pcie_platform.c

361e9379 Ravi Shankar Jonnalagadda 2017-04-28  2909  
5b2dbdec Ravi Shankar Jonnalagadda 2017-08-08  2910  	xdev->is_rootdma = device_property_read_bool(&platform_dev->dev,
5b2dbdec Ravi Shankar Jonnalagadda 2017-08-08  2911  						     "rootdma");
5b2dbdec Ravi Shankar Jonnalagadda 2017-08-08  2912  
361e9379 Ravi Shankar Jonnalagadda 2017-04-28  2913  	xdev->dev = &platform_dev->dev;
5b2dbdec Ravi Shankar Jonnalagadda 2017-08-08  2914  	xdev->board_number = board_number;
361e9379 Ravi Shankar Jonnalagadda 2017-04-28  2915  
5b2dbdec Ravi Shankar Jonnalagadda 2017-08-08  2916  	err = device_property_read_u32(&platform_dev->dev, "numchannels",
5b2dbdec Ravi Shankar Jonnalagadda 2017-08-08  2917  				       &xdev->num_channels);
5b2dbdec Ravi Shankar Jonnalagadda 2017-08-08  2918  	if (err) {
361e9379 Ravi Shankar Jonnalagadda 2017-04-28  2919  		dev_err(&platform_dev->dev,
361e9379 Ravi Shankar Jonnalagadda 2017-04-28  2920  			"Unable to find numchannels property\n");
361e9379 Ravi Shankar Jonnalagadda 2017-04-28  2921  		goto platform_driver_probe_return;
361e9379 Ravi Shankar Jonnalagadda 2017-04-28  2922  	}
361e9379 Ravi Shankar Jonnalagadda 2017-04-28  2923  
361e9379 Ravi Shankar Jonnalagadda 2017-04-28  2924  	if (xdev->num_channels == 0 || xdev->num_channels >
361e9379 Ravi Shankar Jonnalagadda 2017-04-28  2925  		MAX_ALLOWED_CHANNELS_IN_HW) {
361e9379 Ravi Shankar Jonnalagadda 2017-04-28  2926  		dev_warn(&platform_dev->dev,
361e9379 Ravi Shankar Jonnalagadda 2017-04-28  2927  			 "Invalid xlnx-num_channels property value\n");
361e9379 Ravi Shankar Jonnalagadda 2017-04-28  2928  		xdev->num_channels = MAX_ALLOWED_CHANNELS_IN_HW;
361e9379 Ravi Shankar Jonnalagadda 2017-04-28  2929  	}
361e9379 Ravi Shankar Jonnalagadda 2017-04-28  2930  
361e9379 Ravi Shankar Jonnalagadda 2017-04-28  2931  	xdev->channels =
361e9379 Ravi Shankar Jonnalagadda 2017-04-28  2932  	(struct ps_pcie_dma_chan *)devm_kzalloc(&platform_dev->dev,
361e9379 Ravi Shankar Jonnalagadda 2017-04-28  2933  						sizeof(struct ps_pcie_dma_chan)
361e9379 Ravi Shankar Jonnalagadda 2017-04-28  2934  							* xdev->num_channels,
361e9379 Ravi Shankar Jonnalagadda 2017-04-28  2935  						GFP_KERNEL);
361e9379 Ravi Shankar Jonnalagadda 2017-04-28  2936  	if (!xdev->channels) {
361e9379 Ravi Shankar Jonnalagadda 2017-04-28  2937  		err = -ENOMEM;
361e9379 Ravi Shankar Jonnalagadda 2017-04-28  2938  		goto platform_driver_probe_return;
361e9379 Ravi Shankar Jonnalagadda 2017-04-28  2939  	}
361e9379 Ravi Shankar Jonnalagadda 2017-04-28  2940  
5b2dbdec Ravi Shankar Jonnalagadda 2017-08-08  2941  	if (xdev->is_rootdma)
5b2dbdec Ravi Shankar Jonnalagadda 2017-08-08  2942  		err = read_rootdma_config(platform_dev, xdev);
5b2dbdec Ravi Shankar Jonnalagadda 2017-08-08  2943  	else
5b2dbdec Ravi Shankar Jonnalagadda 2017-08-08  2944  		err = read_epdma_config(platform_dev, xdev);
361e9379 Ravi Shankar Jonnalagadda 2017-04-28  2945  
5b2dbdec Ravi Shankar Jonnalagadda 2017-08-08  2946  	if (err) {
5b2dbdec Ravi Shankar Jonnalagadda 2017-08-08  2947  		dev_err(&platform_dev->dev,
5b2dbdec Ravi Shankar Jonnalagadda 2017-08-08  2948  			"Unable to initialize dma configuration\n");
361e9379 Ravi Shankar Jonnalagadda 2017-04-28  2949  		goto platform_driver_probe_return;
361e9379 Ravi Shankar Jonnalagadda 2017-04-28  2950  	}
361e9379 Ravi Shankar Jonnalagadda 2017-04-28  2951  
361e9379 Ravi Shankar Jonnalagadda 2017-04-28  2952  	/* Initialize the DMA engine */
361e9379 Ravi Shankar Jonnalagadda 2017-04-28  2953  	INIT_LIST_HEAD(&xdev->common.channels);
361e9379 Ravi Shankar Jonnalagadda 2017-04-28  2954  
361e9379 Ravi Shankar Jonnalagadda 2017-04-28  2955  	dma_cap_set(DMA_SLAVE, xdev->common.cap_mask);
361e9379 Ravi Shankar Jonnalagadda 2017-04-28  2956  	dma_cap_set(DMA_PRIVATE, xdev->common.cap_mask);
361e9379 Ravi Shankar Jonnalagadda 2017-04-28 @2957  	dma_cap_set(DMA_SG, xdev->common.cap_mask);
361e9379 Ravi Shankar Jonnalagadda 2017-04-28  2958  	dma_cap_set(DMA_INTERRUPT, xdev->common.cap_mask);
361e9379 Ravi Shankar Jonnalagadda 2017-04-28  2959  
361e9379 Ravi Shankar Jonnalagadda 2017-04-28  2960  	xdev->common.src_addr_widths = DMA_SLAVE_BUSWIDTH_UNDEFINED;
361e9379 Ravi Shankar Jonnalagadda 2017-04-28  2961  	xdev->common.dst_addr_widths = DMA_SLAVE_BUSWIDTH_UNDEFINED;
361e9379 Ravi Shankar Jonnalagadda 2017-04-28  2962  	xdev->common.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
361e9379 Ravi Shankar Jonnalagadda 2017-04-28  2963  	xdev->common.device_alloc_chan_resources =
361e9379 Ravi Shankar Jonnalagadda 2017-04-28  2964  		xlnx_ps_pcie_dma_alloc_chan_resources;
361e9379 Ravi Shankar Jonnalagadda 2017-04-28  2965  	xdev->common.device_free_chan_resources =
361e9379 Ravi Shankar Jonnalagadda 2017-04-28  2966  		xlnx_ps_pcie_dma_free_chan_resources;
361e9379 Ravi Shankar Jonnalagadda 2017-04-28  2967  	xdev->common.device_terminate_all = xlnx_ps_pcie_dma_terminate_all;
361e9379 Ravi Shankar Jonnalagadda 2017-04-28  2968  	xdev->common.device_tx_status =  dma_cookie_status;
361e9379 Ravi Shankar Jonnalagadda 2017-04-28  2969  	xdev->common.device_issue_pending = xlnx_ps_pcie_dma_issue_pending;
361e9379 Ravi Shankar Jonnalagadda 2017-04-28  2970  	xdev->common.device_prep_dma_interrupt =
361e9379 Ravi Shankar Jonnalagadda 2017-04-28  2971  		xlnx_ps_pcie_dma_prep_interrupt;
361e9379 Ravi Shankar Jonnalagadda 2017-04-28 @2972  	xdev->common.device_prep_dma_sg = xlnx_ps_pcie_dma_prep_dma_sg;
361e9379 Ravi Shankar Jonnalagadda 2017-04-28  2973  	xdev->common.device_prep_slave_sg = xlnx_ps_pcie_dma_prep_slave_sg;
361e9379 Ravi Shankar Jonnalagadda 2017-04-28  2974  	xdev->common.residue_granularity = DMA_RESIDUE_GRANULARITY_SEGMENT;
361e9379 Ravi Shankar Jonnalagadda 2017-04-28  2975  
361e9379 Ravi Shankar Jonnalagadda 2017-04-28  2976  	for (i = 0; i < xdev->num_channels; i++) {
8ddb7910 Ravi Shankar Jonnalagadda 2017-05-12  2977  		err = probe_channel_properties(platform_dev, xdev, i);
361e9379 Ravi Shankar Jonnalagadda 2017-04-28  2978  
361e9379 Ravi Shankar Jonnalagadda 2017-04-28  2979  		if (err != 0) {
5b2dbdec Ravi Shankar Jonnalagadda 2017-08-08  2980  			dev_err(xdev->dev,
361e9379 Ravi Shankar Jonnalagadda 2017-04-28  2981  				"Unable to read channel properties\n");
361e9379 Ravi Shankar Jonnalagadda 2017-04-28  2982  			goto platform_driver_probe_return;
361e9379 Ravi Shankar Jonnalagadda 2017-04-28  2983  		}
361e9379 Ravi Shankar Jonnalagadda 2017-04-28  2984  	}
361e9379 Ravi Shankar Jonnalagadda 2017-04-28  2985  
5b2dbdec Ravi Shankar Jonnalagadda 2017-08-08  2986  	if (xdev->is_rootdma)
5b2dbdec Ravi Shankar Jonnalagadda 2017-08-08  2987  		err = platform_irq_setup(xdev);
5b2dbdec Ravi Shankar Jonnalagadda 2017-08-08  2988  	else
8ddb7910 Ravi Shankar Jonnalagadda 2017-05-12  2989  		err = irq_setup(xdev);
8ddb7910 Ravi Shankar Jonnalagadda 2017-05-12  2990  	if (err) {
5b2dbdec Ravi Shankar Jonnalagadda 2017-08-08  2991  		dev_err(xdev->dev, "Cannot request irq lines for device %d\n",
5b2dbdec Ravi Shankar Jonnalagadda 2017-08-08  2992  			xdev->board_number);
8ddb7910 Ravi Shankar Jonnalagadda 2017-05-12  2993  		goto platform_driver_probe_return;
8ddb7910 Ravi Shankar Jonnalagadda 2017-05-12  2994  	}
8ddb7910 Ravi Shankar Jonnalagadda 2017-05-12  2995  
361e9379 Ravi Shankar Jonnalagadda 2017-04-28  2996  	err = dma_async_device_register(&xdev->common);
361e9379 Ravi Shankar Jonnalagadda 2017-04-28  2997  	if (err) {
5b2dbdec Ravi Shankar Jonnalagadda 2017-08-08  2998  		dev_err(xdev->dev,
361e9379 Ravi Shankar Jonnalagadda 2017-04-28  2999  			"Unable to register board %d with dma framework\n",
5b2dbdec Ravi Shankar Jonnalagadda 2017-08-08  3000  			xdev->board_number);
361e9379 Ravi Shankar Jonnalagadda 2017-04-28  3001  		goto platform_driver_probe_return;
361e9379 Ravi Shankar Jonnalagadda 2017-04-28  3002  	}
361e9379 Ravi Shankar Jonnalagadda 2017-04-28  3003  
361e9379 Ravi Shankar Jonnalagadda 2017-04-28  3004  	platform_set_drvdata(platform_dev, xdev);
361e9379 Ravi Shankar Jonnalagadda 2017-04-28  3005  
5b2dbdec Ravi Shankar Jonnalagadda 2017-08-08  3006  	board_number++;
5b2dbdec Ravi Shankar Jonnalagadda 2017-08-08  3007  
5b2dbdec Ravi Shankar Jonnalagadda 2017-08-08  3008  	dev_info(&platform_dev->dev, "PS PCIe Platform driver probed\n");
361e9379 Ravi Shankar Jonnalagadda 2017-04-28  3009  	return 0;
361e9379 Ravi Shankar Jonnalagadda 2017-04-28  3010  
361e9379 Ravi Shankar Jonnalagadda 2017-04-28  3011  platform_driver_probe_return:
361e9379 Ravi Shankar Jonnalagadda 2017-04-28  3012  	return err;
361e9379 Ravi Shankar Jonnalagadda 2017-04-28  3013  }
361e9379 Ravi Shankar Jonnalagadda 2017-04-28  3014  

:::::: The code at line 2957 was first introduced by commit
:::::: 361e937922b2073151335141bcd67b37f46b52fb PCI: ZYNQMP EP driver: Adding support for ZynqMP ep driver

:::::: TO: Ravi Shankar Jonnalagadda <venkata.ravi.jonnalagadda@xilinx.com>
:::::: CC: Michal Simek <michal.simek@xilinx.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 61983 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180516/69687a2f/attachment-0001.gz>
