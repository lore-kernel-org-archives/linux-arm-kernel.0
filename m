From: cbostic@linux.vnet.ibm.com (Christopher Bostic)
Date: Tue, 4 Apr 2017 14:10:59 -0500
Subject: [PATCH v4 19/23] drivers/fsi: Add GPIO based FSI master (fwd)
In-Reply-To: <alpine.DEB.2.20.1703302337590.2105@hadrien>
References: <alpine.DEB.2.20.1703302337590.2105@hadrien>
Message-ID: <c993bd4c-dea5-a02b-63dd-57a0d548b030@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 3/30/17 4:39 PM, Julia Lawall wrote:
> Is master on line 514 allocated with kmalloc, or the devm call on line
> 522?
Hi Julia,

Its allocated with the devm call on line 522.   The kfree  on line 514 
wouldn't be necessary in that case - will remove.
Thanks for pointing that out.

Chris

> julia
>
> ---------- Forwarded message ----------
> Date: Fri, 31 Mar 2017 00:15:09 +0800
> From: kbuild test robot <fengguang.wu@intel.com>
> To: kbuild at 01.org
> Cc: Julia Lawall <julia.lawall@lip6.fr>
> Subject: Re: [PATCH v4 19/23] drivers/fsi: Add GPIO based FSI master
>
> Hi Chris,
>
> [auto build test WARNING on linus/master]
> [also build test WARNING on v4.11-rc4 next-20170330]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Christopher-Bostic/FSI-device-driver-implementation/20170330-184914
> :::::: branch date: 5 hours ago
> :::::: commit date: 5 hours ago
>
>>> drivers/fsi/fsi-master-gpio.c:514:1-6: WARNING: invalid free of devm_ allocated data
> git remote add linux-review https://github.com/0day-ci/linux
> git remote update linux-review
> git checkout f4bd3b6a41c7a59e9ce2e65947a4d3dfc2ee4a29
> vim +514 drivers/fsi/fsi-master-gpio.c
>
> f4bd3b6a Chris Bostic 2017-03-29  498  {
> f4bd3b6a Chris Bostic 2017-03-29  499  	struct fsi_master_gpio *master = to_fsi_master_gpio(_master);
> f4bd3b6a Chris Bostic 2017-03-29  500
> f4bd3b6a Chris Bostic 2017-03-29  501  	if (link != 0)
> f4bd3b6a Chris Bostic 2017-03-29  502  		return -ENODEV;
> f4bd3b6a Chris Bostic 2017-03-29  503  	if (master->gpio_enable)
> f4bd3b6a Chris Bostic 2017-03-29  504  		gpiod_set_value(master->gpio_enable, 1);
> f4bd3b6a Chris Bostic 2017-03-29  505
> f4bd3b6a Chris Bostic 2017-03-29  506  	return 0;
> f4bd3b6a Chris Bostic 2017-03-29  507  }
> f4bd3b6a Chris Bostic 2017-03-29  508
> f4bd3b6a Chris Bostic 2017-03-29  509  static void fsi_master_gpio_release(struct device *dev)
> f4bd3b6a Chris Bostic 2017-03-29  510  {
> f4bd3b6a Chris Bostic 2017-03-29  511  	struct fsi_master_gpio *master = to_fsi_master_gpio(
> f4bd3b6a Chris Bostic 2017-03-29  512  						dev_to_fsi_master(dev));
> f4bd3b6a Chris Bostic 2017-03-29  513
> f4bd3b6a Chris Bostic 2017-03-29 @514  	kfree(master);
> f4bd3b6a Chris Bostic 2017-03-29  515  }
> f4bd3b6a Chris Bostic 2017-03-29  516
> f4bd3b6a Chris Bostic 2017-03-29  517  static int fsi_master_gpio_probe(struct platform_device *pdev)
> f4bd3b6a Chris Bostic 2017-03-29  518  {
> f4bd3b6a Chris Bostic 2017-03-29  519  	struct fsi_master_gpio *master;
> f4bd3b6a Chris Bostic 2017-03-29  520  	struct gpio_desc *gpio;
> f4bd3b6a Chris Bostic 2017-03-29  521
> f4bd3b6a Chris Bostic 2017-03-29  522  	master = devm_kzalloc(&pdev->dev, sizeof(*master), GFP_KERNEL);
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
>
