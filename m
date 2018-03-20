From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Tue, 20 Mar 2018 15:14:44 +0300
Subject: [bug report] phy: stm32: add support for STM32 USB PHY Controller
 (USBPHYC)
Message-ID: <20180320121443.GA6223@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Amelie Delaunay,

The patch 94c358da3a05: "phy: stm32: add support for STM32 USB PHY
Controller (USBPHYC)" from Mar 2, 2018, leads to the following static
checker warning:

	drivers/phy/st/phy-stm32-usbphyc.c:371 stm32_usbphyc_probe()
	error: uninitialized symbol 'i'.

drivers/phy/st/phy-stm32-usbphyc.c
   360          for_each_child_of_node(np, child) {
   361                  struct stm32_usbphyc_phy *usbphyc_phy;
   362                  struct phy *phy;
   363                  u32 index;
   364                  int i;
                        ^^^^^
   365  
   366                  phy = devm_phy_create(dev, child, &stm32_usbphyc_phy_ops);
   367                  if (IS_ERR(phy)) {
   368                          ret = PTR_ERR(phy);
   369                          if (ret != -EPROBE_DEFER)
   370                                  dev_err(dev,
   371                                          "failed to create phy%d: %d\n", i, ret);
                                                                                ^

   372                          goto put_child;
   373                  }
   374  
   375                  usbphyc_phy = devm_kzalloc(dev, sizeof(*usbphyc_phy),
   376                                             GFP_KERNEL);
   377                  if (!usbphyc_phy) {
   378                          ret = -ENOMEM;
   379                          goto put_child;
   380                  }
   381  
   382                  for (i = 0; i < NUM_SUPPLIES; i++)
   383                          usbphyc_phy->supplies[i].supply = supplies_names[i];
   384  
   385                  ret = devm_regulator_bulk_get(&phy->dev, NUM_SUPPLIES,
   386                                                usbphyc_phy->supplies);
   387                  if (ret) {
   388                          if (ret != -EPROBE_DEFER)
   389                                  dev_err(&phy->dev,
   390                                          "failed to get regulators: %d\n", ret);
   391                          goto put_child;
   392                  }

regards,
dan carpenter
