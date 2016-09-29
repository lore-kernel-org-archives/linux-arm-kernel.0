From: muhammadabdul.wahab@supelec.fr (Muhammad Abdul WAHAB)
Date: Thu, 29 Sep 2016 12:27:21 +0200
Subject: [PATCH] Adding missing features of Coresight PTM components
Message-ID: <f274ff8d-368c-5034-5c1f-4fba60c14711@supelec.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the current driver for Coresight components, two features of PTM
components are missing:

1. Branch Broadcasting (present also in ETM but called Branch Output)
2. Return Stack (only present in PTM v1.0 and PTMv1.1)

These features can be added simply to the code using `mode` field of
`etm_config` struct.

### Modifications in coresight-etm.h
Two defines are added in register definition part of `coresight_etm.h` file
that corresponds to the bitfield of these options. Two defines for mode
field are added as well in the same file. The `ETM_MODE_ALL` field is
modified accordingly.

### Modifs in coresight-etm3x-sysfs.c
As the return stack feature is only available in PTM components, a test is
made to make sure that for ETM components, this part is never executed.
In addition, these two options (Branch Broadcasting and Return Stack) must
not be enabled at the same time because the obtained trace is unpredictable
  in this case (as described in
[PFT architecture v1.1](https://goo.gl/lZ72R1)). For now, a warning is
shown to alert user that the behavior is unpredictable. However, only one
option could be allowed to trace. The user need to change configuration
of PTM.

To enable these features, the correct value should be written in `mode`
file. The values are :

1. Branch Broadcasting (1 << 5)
2. Return Stack (1 << 6)

Signed-off-by: Muhammad Abdul Wahab <muhammadabdul.wahab@centralesupelec.fr>
---
#### Purpose

1. **Branch Broadcast** : The branch broadcast feature is present in ETM
components as well and is called Branch output. It allows to retrieve
addresses for direct branch addresses alongside the indirect branch
addresses. For example, it could be useful in cases when tracing without
source code.
2. **Return Stack** : The return stack option allows to retrieve the return
  addresses of function calls. It can be useful to avoid CRA
(Code Reuse Attacks) by keeping a shadowstack.
### Testing

The trace sink components need to be enabled by accessing through sys file
  system.

     echo 1 > /sys/bus/coresight/devices/@addr.etb/enable\_sink

Then enable the CS source component:

     echo 1 > /sys/bus/coresight/devices/@addr.ptm/enable\_source

By default, CS Source components are configured to trace the kernel.

Then the trace can be read by dumping ETB.

     dd if=/dev/@addr.etb of=trace_kernel.bin

The trace can be visualized by

     hexdump -C trace_kernel.bin

Or stored using

     hexdump -C trace_kernel.bin > trace_kernel.txt

The trace need to be decoded to be readable.All these above steps can now
be performed with Perf Library which was not available at the time I was
playing with DT entries.

diff -uprN -X linux-4.7-vanilla/Documentation/dontdiff 
linux-4.7-vanilla/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c 
linux-4.7/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
--- 
linux-4.7-vanilla/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c 
2016-07-24 21:23:50.000000000 +0200
+++ linux-4.7/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c 
2016-09-28 15:36:39.886542702 +0200
@@ -145,7 +145,7 @@ static ssize_t mode_store(struct device
              goto err_unlock;
          }
          config->ctrl |= ETMCR_STALL_MODE;
-     } else
+    } else
          config->ctrl &= ~ETMCR_STALL_MODE;

      if (config->mode & ETM_MODE_TIMESTAMP) {
@@ -163,6 +163,20 @@ static ssize_t mode_store(struct device
      else
          config->ctrl &= ~ETMCR_CTXID_SIZE;

+    if (config->mode & ETM_MODE_BBROAD)
+        config->ctrl |= ETMCR_BRANCH_BROADCAST;
+    else
+        config->ctrl &= ~ETMCR_BRANCH_BROADCAST;
+
+    if (drvdata->arch == (PFT_ARCH_V1_0 | PFT_ARCH_V1_1)) {
+        if (config->mode & ETM_MODE_RET_STACK) {
+            if (config->mode & ETM_MODE_BBROAD)
+                dev_warn(drvdata->dev, "behavior is unpredictable\n");
+            config->ctrl |= ETMCR_RETURN_STACK_EN;
+        } else
+            config->ctrl &= ~ETMCR_RETURN_STACK_EN;
+    }
+
      if (config->mode & (ETM_MODE_EXCL_KERN | ETM_MODE_EXCL_USER))
          etm_config_trace_mode(config);

diff -uprN -X linux-4.7-vanilla/Documentation/dontdiff 
linux-4.7-vanilla/drivers/hwtracing/coresight/coresight-etm.h 
linux-4.7/drivers/hwtracing/coresight/coresight-etm.h
--- linux-4.7-vanilla/drivers/hwtracing/coresight/coresight-etm.h 
2016-07-24 21:23:50.000000000 +0200
+++ linux-4.7/drivers/hwtracing/coresight/coresight-etm.h 2016-09-28 
15:35:59.862544418 +0200
@@ -89,11 +89,13 @@
  /* ETMCR - 0x00 */
  #define ETMCR_PWD_DWN        BIT(0)
  #define ETMCR_STALL_MODE    BIT(7)
+#define ETMCR_BRANCH_BROADCAST    BIT(8)
  #define ETMCR_ETM_PRG        BIT(10)
  #define ETMCR_ETM_EN        BIT(11)
  #define ETMCR_CYC_ACC        BIT(12)
  #define ETMCR_CTXID_SIZE    (BIT(14)|BIT(15))
  #define ETMCR_TIMESTAMP_EN    BIT(28)
+#define ETMCR_RETURN_STACK_EN    BIT(29)  /* PTM v1.0 & PTM v1.1 */
  /* ETMCCR - 0x04 */
  #define ETMCCR_FIFOFULL        BIT(23)
  /* ETMPDCR - 0x310 */
@@ -110,8 +112,11 @@
  #define ETM_MODE_STALL        BIT(2)
  #define ETM_MODE_TIMESTAMP    BIT(3)
  #define ETM_MODE_CTXID        BIT(4)
+#define ETM_MODE_BBROAD    BIT(5)
+#define ETM_MODE_RET_STACK    BIT(6)
  #define ETM_MODE_ALL        (ETM_MODE_EXCLUDE | ETM_MODE_CYCACC | \
                   ETM_MODE_STALL | ETM_MODE_TIMESTAMP | \
+                 ETM_MODE_BBROAD | ETM_MODE_RET_STACK | \
                   ETM_MODE_CTXID | ETM_MODE_EXCL_KERN | \
                   ETM_MODE_EXCL_USER)
