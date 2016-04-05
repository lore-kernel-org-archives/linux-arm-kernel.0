From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue,  5 Apr 2016 11:53:43 -0600
Subject: [PATCH 02/11] coresight: etm4x: adding config and traceid registers
In-Reply-To: <1459878832-15219-1-git-send-email-mathieu.poirier@linaro.org>
References: <1459878832-15219-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1459878832-15219-3-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding new sysFS management interface to query the configuration
and the traceid registers.  Both are required to convey information
to the perf cmd line tools when using ETMv4 tracers as PMU.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 Documentation/ABI/testing/sysfs-bus-coresight-devices-etm4x | 13 +++++++++++++
 drivers/hwtracing/coresight/coresight-etm4x-sysfs.c         |  4 ++++
 2 files changed, 17 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-etm4x b/Documentation/ABI/testing/sysfs-bus-coresight-devices-etm4x
index 2355ed8ae31f..36258bc1b473 100644
--- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-etm4x
+++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-etm4x
@@ -359,6 +359,19 @@ Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
 Description:	(R) Print the content of the Peripheral ID3 Register
 		(0xFEC).  The value is taken directly from the HW.
 
+What:		/sys/bus/coresight/devices/<memory_map>.etm/mgmt/trcconfig
+Date:		February 2016
+KernelVersion:	4.07
+Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
+Description:	(R) Print the content of the trace configuration register
+		(0x010) as currently set by SW.
+
+What:		/sys/bus/coresight/devices/<memory_map>.etm/mgmt/trctraceid
+Date:		February 2016
+KernelVersion:	4.07
+Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
+Description:	(R) Print the content of the trace ID register (0x040).
+
 What:		/sys/bus/coresight/devices/<memory_map>.etm/trcidr/trcidr0
 Date:		April 2015
 KernelVersion:	4.01
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index 5db0de7d4e0e..39a8b077e0c2 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -1972,6 +1972,8 @@ coresight_simple_func(trcoslsr, TRCOSLSR);
 coresight_simple_func(trcpdcr, TRCPDCR);
 coresight_simple_func(trcpdsr, TRCPDSR);
 coresight_simple_func(trclsr, TRCLSR);
+coresight_simple_func(trcconfig, TRCCONFIGR);
+coresight_simple_func(trctraceid, TRCTRACEIDR);
 coresight_simple_func(trcauthstatus, TRCAUTHSTATUS);
 coresight_simple_func(trcdevid, TRCDEVID);
 coresight_simple_func(trcdevtype, TRCDEVTYPE);
@@ -1985,6 +1987,8 @@ static struct attribute *coresight_etmv4_mgmt_attrs[] = {
 	&dev_attr_trcpdcr.attr,
 	&dev_attr_trcpdsr.attr,
 	&dev_attr_trclsr.attr,
+	&dev_attr_trcconfig.attr,
+	&dev_attr_trctraceid.attr,
 	&dev_attr_trcauthstatus.attr,
 	&dev_attr_trcdevid.attr,
 	&dev_attr_trcdevtype.attr,
-- 
2.1.4
