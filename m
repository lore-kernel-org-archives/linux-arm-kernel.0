From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Wed, 12 Oct 2016 14:32:29 +0300
Subject: [bug report] perf: xgene: Add APM X-Gene SoC Performance Monitoring
 Unit driver
Message-ID: <20161012113229.GA16447@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Tai Nguyen,

The patch 832c927d119b: "perf: xgene: Add APM X-Gene SoC Performance
Monitoring Unit driver" from Jul 15, 2016, leads to the following
static checker warning:

	drivers/perf/xgene_pmu.c:1014 acpi_get_pmu_hw_inf()
	warn: '&res' isn't an ERR_PTR

drivers/perf/xgene_pmu.c
   992  static struct
   993  xgene_pmu_dev_ctx *acpi_get_pmu_hw_inf(struct xgene_pmu *xgene_pmu,
   994                                         struct acpi_device *adev, u32 type)
   995  {
   996          struct device *dev = xgene_pmu->dev;
   997          struct list_head resource_list;
   998          struct xgene_pmu_dev_ctx *ctx;
   999          const union acpi_object *obj;
  1000          struct hw_pmu_info *inf;
  1001          void __iomem *dev_csr;
  1002          struct resource res;
  1003          int enable_bit;
  1004          int rc;
  1005  
  1006          ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
  1007          if (!ctx)
  1008                  return NULL;
  1009  
  1010          INIT_LIST_HEAD(&resource_list);
  1011          rc = acpi_dev_get_resources(adev, &resource_list,
  1012                                      acpi_pmu_dev_add_resource, &res);
  1013          acpi_dev_free_resource_list(&resource_list);
  1014          if (rc < 0 || IS_ERR(&res)) {
                                     ^^^^
Obviously this is a stack address and not an error pointer.  I'm not
sure what was intended here.

  1015                  dev_err(dev, "PMU type %d: No resource address found\n", type);
  1016                  goto err;
  1017          }
  1018  


regards,
dan carpenter
