From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Fri, 9 Dec 2016 01:11:23 +0300
Subject: [bug report] ARM: pxa: add U2D controller and ULPI driver for pxa3xx
Message-ID: <20161208221122.GA4699@elgon.mountain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Igor Grinberg,

The patch 69f22be7b106: "ARM: pxa: add U2D controller and ULPI driver
for pxa3xx" from Jul 27, 2010, leads to the following static checker
warning:

	arch/arm/mach-pxa/pxa3xx-ulpi.c:336 pxa3xx_u2d_probe()
	warn: did you mean to pass the address of 'u2d'

arch/arm/mach-pxa/pxa3xx-ulpi.c
   283  static int pxa3xx_u2d_probe(struct platform_device *pdev)
   284  {
   285          struct pxa3xx_u2d_platform_data *pdata = pdev->dev.platform_data;
   286          struct resource *r;
   287          int err;
   288  
   289          u2d = kzalloc(sizeof(struct pxa3xx_u2d_ulpi), GFP_KERNEL);

u2d is a file scope variable.

   290          if (!u2d) {
   291                  dev_err(&pdev->dev, "failed to allocate memory\n");
   292                  return -ENOMEM;
   293          }
   294  
   295          u2d->clk = clk_get(&pdev->dev, NULL);
   296          if (IS_ERR(u2d->clk)) {
   297                  dev_err(&pdev->dev, "failed to get u2d clock\n");
   298                  err = PTR_ERR(u2d->clk);
   299                  goto err_free_mem;
   300          }
   301  
   302          r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
   303          if (!r) {
   304                  dev_err(&pdev->dev, "no IO memory resource defined\n");
   305                  err = -ENODEV;
   306                  goto err_put_clk;
   307          }
   308  
   309          r = request_mem_region(r->start, resource_size(r), pdev->name);
   310          if (!r) {
   311                  dev_err(&pdev->dev, "failed to request memory resource\n");
   312                  err = -EBUSY;
   313                  goto err_put_clk;
   314          }
   315  
   316          u2d->mmio_base = ioremap(r->start, resource_size(r));
   317          if (!u2d->mmio_base) {
   318                  dev_err(&pdev->dev, "ioremap() failed\n");
   319                  err = -ENODEV;
   320                  goto err_free_res;
   321          }
   322  
   323          if (pdata->init) {
   324                  err = pdata->init(&pdev->dev);
   325                  if (err)
   326                          goto err_free_io;
   327          }
   328  
   329          /* Only PXA310 U2D has OTG functionality */
   330          if (cpu_is_pxa310()) {
   331                  err = pxa310_otg_init(pdata);
   332                  if (err)
   333                          goto err_free_plat;
   334          }
   335  
   336          platform_set_drvdata(pdev, &u2d);

We almost certainly wanted to pass u2d here.  The only reason this works
is because we use the file scope global instead of drvdata. 

   337  
   338          return 0;
   339  
   340  err_free_plat:
   341          if (pdata->exit)
   342                  pdata->exit(&pdev->dev);
   343  err_free_io:
   344          iounmap(u2d->mmio_base);
   345  err_free_res:
   346          release_mem_region(r->start, resource_size(r));
   347  err_put_clk:
   348          clk_put(u2d->clk);
   349  err_free_mem:
   350          kfree(u2d);
   351          return err;
   352  }

regards,
dan carpenter
