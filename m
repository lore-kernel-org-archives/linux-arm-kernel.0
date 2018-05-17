From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Thu, 17 May 2018 15:39:02 +0300
Subject: [bug report] ARM: sun9i: smp: Add is_a83t field
Message-ID: <20180517123902.GA8759@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Myl?ne Josserand,

The patch 1631090e34f5: "ARM: sun9i: smp: Add is_a83t field" from May
4, 2018, leads to the following static checker warning:

	arch/arm/mach-sunxi/mc_smp.c:804 sunxi_mc_smp_init()
	error: buffer overflow 'sunxi_mc_smp_data' 2 <= 2 (assuming for loop doesn't break)

arch/arm/mach-sunxi/mc_smp.c
   789          /*
   790           * We can't actually use the enable-method magic in the kernel.
   791           * Our loopback / trampoline code uses the CPU suspend framework,
   792           * which requires the identity mapping be available. It would not
   793           * yet be available if we used the .init_cpus or .prepare_cpus
   794           * callbacks in smp_operations, which we would use if we were to
   795           * use CPU_METHOD_OF_DECLARE
   796           */
   797          for (i = 0; i < ARRAY_SIZE(sunxi_mc_smp_data); i++) {
   798                  ret = of_property_match_string(node, "enable-method",
   799                                                 sunxi_mc_smp_data[i].enable_method);
   800                  if (!ret)
   801                          break;
   802          }
   803  
   804          is_a83t = sunxi_mc_smp_data[i].is_a83t;
                          ^^^^^^^^^^^^^^^^^^^^
Potentially one past the end.

   805  
   806          of_node_put(node);
   807          if (ret)
   808                  return -ENODEV;
                        ^^^^^^^^^^^^^^
This is where we return if we don't hit a break.

   809  

regards,
dan carpenter
