From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Tue, 11 Jul 2017 14:43:27 +0300
Subject: [bug report] perf: xgene: Add APM X-Gene SoC Performance Monitoring
 Unit driver
Message-ID: <20170711114327.hezq3anev6bzxqz7@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Tai Nguyen,

The patch 832c927d119b: "perf: xgene: Add APM X-Gene SoC Performance
Monitoring Unit driver" from Jul 15, 2016, leads to the following
static checker warning:

	drivers/perf/xgene_pmu.c:1922 xgene_pmu_probe()
	warn: 'xgene_pmu->pcppmu_csr' is an error pointer or valid

drivers/perf/xgene_pmu.c
  1851          if (version < 0)
  1852                  return -ENODEV;
                        ^^^^^^^^^^^^^^
Good.  Direct returns are the way to go if possible.

  1853  
  1854          if (version == PCP_PMU_V3)
  1855                  xgene_pmu->ops = &xgene_pmu_v3_ops;
  1856          else
  1857                  xgene_pmu->ops = &xgene_pmu_ops;
  1858  
  1859          INIT_LIST_HEAD(&xgene_pmu->l3cpmus);
  1860          INIT_LIST_HEAD(&xgene_pmu->iobpmus);
  1861          INIT_LIST_HEAD(&xgene_pmu->mcbpmus);
  1862          INIT_LIST_HEAD(&xgene_pmu->mcpmus);
  1863  
  1864          xgene_pmu->version = version;
  1865          dev_info(&pdev->dev, "X-Gene PMU version %d\n", xgene_pmu->version);
  1866  
  1867          res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
  1868          xgene_pmu->pcppmu_csr = devm_ioremap_resource(&pdev->dev, res);
  1869          if (IS_ERR(xgene_pmu->pcppmu_csr)) {
  1870                  dev_err(&pdev->dev, "ioremap failed for PCP PMU resource\n");
  1871                  rc = PTR_ERR(xgene_pmu->pcppmu_csr);
  1872                  goto err;
                        ^^^^^^^^
If we hit this goto then the kernel will crash.

  1873          }

    [ snip ]

  1916          /* Enable interrupt */
  1917          xgene_pmu->ops->unmask_int(xgene_pmu);
  1918  
  1919          return 0;
  1920  
  1921  err:
  1922          if (xgene_pmu->pcppmu_csr)
  1923                  devm_iounmap(&pdev->dev, xgene_pmu->pcppmu_csr);
  1924          devm_kfree(&pdev->dev, xgene_pmu);

Can't we remove all this cleanup since it's devm_ managed resources?

  1925  
  1926          return rc;
  1927  }

regards,
dan carpenter
