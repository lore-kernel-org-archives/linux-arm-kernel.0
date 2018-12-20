Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 969F8C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:09:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64A692176F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LN+cIlbo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YbMW8Mrr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64A692176F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3MPcGhaxSCM0XVimaUQ4NcSJKBnY2P3vVjio+FMSSw8=; b=LN+cIlboZ+sTd2
	4KOqQiHQ6gZ33Blhb0SIxLiCb6q92dzXi+GztdrwBa3mQzZPD+gIKl2Oc79JXVUMvu+NcLEQ6S+jS
	j1rXeIwInClCP+l9Q4nYwQJZ5UjpIGZqNYqaCSuxdqyfBKhneMwxp5QKFGnhkBaBBmARjrGuRL3OO
	X9fro9i5FJ6elX1sm2/UivocyHybjiRgGLjUhOHgwIWbS6hQJ7by5/BNAT4P0x/1WqhulBaQHMR+U
	cHQm0yA3EMdbSBkQg91XPQmVN+HzMp5dDMpD8PSO2tavqc3sPWjQL50PYuByj6+MoF5YL8EsiVf5y
	xuyJkAMnGrXdzFxq5R3g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZuKF-0001Bv-4c; Thu, 20 Dec 2018 09:09:03 +0000
Received: from mail-eopbgr00085.outbound.protection.outlook.com ([40.107.0.85]
 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZuJt-0000fA-CA
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 09:08:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KvwJB+Jdo193scJQK2l1siIS1m5ghgNIYOT9cKViA6A=;
 b=YbMW8MrrMBVR+V75pFgxlsgHTXfUugA3r9DuCAdaV2xr2IZJWNl5Caho09TtEPOjLoxiGc5/trLB/y3kDybe83mgY96uTD8IzDBD+yXiUheoFp3ULWAr8fbuCxM6fJsHPNHUyRTBTdVOo1ddk/ZtiAWVCKGHIGYrX/UnFPN0m6g=
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com (52.133.30.10) by
 AM6PR0402MB3797.eurprd04.prod.outlook.com (52.133.29.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.17; Thu, 20 Dec 2018 09:08:32 +0000
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::987c:cb59:96c9:6b71]) by AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::987c:cb59:96c9:6b71%2]) with mapi id 15.20.1425.025; Thu, 20 Dec 2018
 09:08:32 +0000
From: Anson Huang <anson.huang@nxp.com>
To: "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com"
 <mark.rutland@arm.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>, "rui.zhang@intel.com"
 <rui.zhang@intel.com>, "edubezval@gmail.com" <edubezval@gmail.com>,
 "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, Aisheng Dong
 <aisheng.dong@nxp.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>, Andy Gross
 <andy.gross@linaro.org>, "arnd@arndb.de" <arnd@arndb.de>,
 "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>, "heiko@sntech.de"
 <heiko@sntech.de>, "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>, 
 "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
 "amit.kucheria@linaro.org" <amit.kucheria@linaro.org>,
 "ezequiel@collabora.com" <ezequiel@collabora.com>, "olof@lixom.net"
 <olof@lixom.net>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org"
 <linux-pm@vger.kernel.org>
Subject: [PATCH V5 2/4] thermal: imx_sc: add i.MX system controller thermal
 support
Thread-Topic: [PATCH V5 2/4] thermal: imx_sc: add i.MX system controller
 thermal support
Thread-Index: AQHUmEOUhX3p60YUY0CljElNLNFaiw==
Date: Thu, 20 Dec 2018 09:08:32 +0000
Message-ID: <1545296609-20477-3-git-send-email-Anson.Huang@nxp.com>
References: <1545296609-20477-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1545296609-20477-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0091.apcprd03.prod.outlook.com
 (2603:1096:203:72::31) To AM6PR0402MB3911.eurprd04.prod.outlook.com
 (2603:10a6:209:1c::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM6PR0402MB3797;
 6:o5mOUYl15U3HSlx/K8TkLfFsejQRyySLHzxkyVRIcrHcOnz7u0/8PbuftMoD2DewJFjU2X3na/3IXvtTep2acwoDx299jCSsnp00SBQXK18g1NxTKdSgAyXhzytyBD4WL0kehmJTGBUwDux/Fy8v/s2php5LKdbNWE+/SFHIjeXZ1APdlwmKjY/rcFuoQRHnxjz8/rBfJC3UeCrcesuO3kU6gIaBXMO1DIlvduBn10PQZchSoDoxR3emMi8aQlygfxvpW29AxJEzRFRvFUC4DglF0q1l6v2An7cTcxPb9dTrAxCxKPBE+wj20LC3TzVwCwgE4if6GyF53j75rQfZ1ou/BfvUBFAGo+mPKqR6yt2VJlnknFMhdmPIvStZV0UAfC5nN3kUm5+7TzBgrCcHYc/G+kPUW7iYZ6/ip2RHC4EGSBt0mwlFsEJjtv7IqW1tVDS64A/s4VrsQbQLTprjSQ==;
 5:SwwU5Dg4m/sEW8nWbTldtOKFUZRxI0VSzMksiVjrE8toR85xyqPclg4rFqddftkZmvEW7PFK5WQkb163BG2TvVY99oZCgVJklWccGOfZB3VRu2Zs0eVsDCGg89c7rSAo1N58qRNfMEwg/Pna+IaX1EOml7qA/uQdnG2lka+ns6g=;
 7:7H/fcGj0BnlOOucUnsR0N5QDIW623rT6VJwCdUxGn/yH3cUUuxC54xKbPIC7wTUj3oqOVoAMikSXyc3puEkPOunJMXxUG1WttxbbqT81De9+clF+gsL//GXMIxhvPwKYh6gJWpN/yba83r0/zeqcKw==
x-ms-office365-filtering-correlation-id: 4d087b22-bef1-4904-f62a-08d6665ab708
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR0402MB3797; 
x-ms-traffictypediagnostic: AM6PR0402MB3797:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AM6PR0402MB37978B607810161E6119B434F5BF0@AM6PR0402MB3797.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);
 SRVR:AM6PR0402MB3797; BCL:0; PCL:0; RULEID:; SRVR:AM6PR0402MB3797; 
x-forefront-prvs: 0892FA9A88
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(376002)(39860400002)(346002)(136003)(396003)(54534003)(189003)(199004)(6116002)(39060400002)(3846002)(476003)(2616005)(7416002)(5660300001)(66066001)(99286004)(386003)(4326008)(6506007)(446003)(478600001)(50226002)(53936002)(2501003)(2906002)(11346002)(97736004)(256004)(6512007)(305945005)(25786009)(7736002)(8936002)(14454004)(71200400001)(71190400001)(8676002)(81156014)(81166006)(6486002)(486006)(6436002)(106356001)(86362001)(105586002)(110136005)(186003)(102836004)(36756003)(2201001)(52116002)(68736007)(316002)(76176011)(26005)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR0402MB3797;
 H:AM6PR0402MB3911.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: tFCimm41iZoSYWFdTipRm3GduC/khNRwVc/JeLRPrbmQ//aeN+0vzN5mCu94G0I6XCCYPNYjM4yzfp3qIdw4afEjdDvI3DKFQuCaaRpX70DALKaDsaWe0G+6lKY5IF2nj5BEyavhVr0gBlI/41tU8A3f+IxeGWFEOyqvWg1JQLY7769YgLEwjPCtr01KkE4xWKl0HRino4ZxW0Yvq0OWtWHjrCplhx1XqjpRu+AQgg0uf9IC/pBUGCGAQ60/3aoMJ2Z0xXAMJnNd952AC3moLXT/VlohJM1Hs6lgiQNlimBiBYs7qkdY2Ce04SnkkD+V
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d087b22-bef1-4904-f62a-08d6665ab708
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2018 09:08:32.6743 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3797
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_010841_555902_8BAC08FE 
X-CRM114-Status: GOOD (  23.81  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

i.MX8QXP is an ARMv8 SoC which has a Cortex-M4 system controller
inside, the system controller is in charge of controlling power,
clock and thermal sensors etc..

This patch adds i.MX system controller thermal driver support,
Linux kernel has to communicate with system controller via MU
(message unit) IPC to get each thermal sensor's temperature,
it supports multiple sensors which are passed from device tree,
please see the binding doc for details.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
ChangeLog since V4:
    - Add driver dependency on IMX_SCU to avoid compile error when IMX_SCU is NOT selected;
    - Remove unnecessary of different errors handle for imx_scu_get_handle, already included in API.
---
 drivers/thermal/Kconfig          |  11 +++
 drivers/thermal/Makefile         |   1 +
 drivers/thermal/imx_sc_thermal.c | 200 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 212 insertions(+)
 create mode 100644 drivers/thermal/imx_sc_thermal.c

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 0e69edc..8d4601d 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -222,6 +222,17 @@ config IMX_THERMAL
 	  cpufreq is used as the cooling device to throttle CPUs when the
 	  passive trip is crossed.
 
+config IMX_SC_THERMAL
+	tristate "Temperature sensor driver for NXP i.MX SoCs with System Controller"
+	depends on (ARCH_MXC && IMX_SCU) || COMPILE_TEST
+	depends on OF
+	help
+	  Support for Temperature Monitor (TEMPMON) found on NXP i.MX SoCs with
+	  system controller inside, Linux kernel has to communicate with system
+	  controller via MU (message unit) IPC to get temperature from thermal
+	  sensor. It supports one critical trip point and one
+	  passive trip point for each thermal sensor.
+
 config MAX77620_THERMAL
 	tristate "Temperature sensor driver for Maxim MAX77620 PMIC"
 	depends on MFD_MAX77620
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 610344e..1b13f6a 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -41,6 +41,7 @@ obj-$(CONFIG_DB8500_THERMAL)	+= db8500_thermal.o
 obj-$(CONFIG_ARMADA_THERMAL)	+= armada_thermal.o
 obj-$(CONFIG_TANGO_THERMAL)	+= tango_thermal.o
 obj-$(CONFIG_IMX_THERMAL)	+= imx_thermal.o
+obj-$(CONFIG_IMX_SC_THERMAL)	+= imx_sc_thermal.o
 obj-$(CONFIG_MAX77620_THERMAL)	+= max77620_thermal.o
 obj-$(CONFIG_QORIQ_THERMAL)	+= qoriq_thermal.o
 obj-$(CONFIG_DA9062_THERMAL)	+= da9062-thermal.o
diff --git a/drivers/thermal/imx_sc_thermal.c b/drivers/thermal/imx_sc_thermal.c
new file mode 100644
index 0000000..1030a31
--- /dev/null
+++ b/drivers/thermal/imx_sc_thermal.c
@@ -0,0 +1,200 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2018 NXP.
+ */
+
+#include <linux/err.h>
+#include <linux/firmware/imx/sci.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/thermal.h>
+
+#include "thermal_core.h"
+
+#define IMX_SC_MISC_FUNC_GET_TEMP	13
+#define IMX_SC_C_TEMP			0
+
+static struct imx_sc_ipc *thermal_ipc_handle;
+
+struct imx_sc_sensor {
+	struct thermal_zone_device *tzd;
+	u32 resource_id;
+};
+
+struct imx_sc_thermal_data {
+	struct imx_sc_sensor *sensor;
+};
+
+struct req_get_temp {
+	u16 resource_id;
+	u8 type;
+} __packed;
+
+struct resp_get_temp {
+	u16 celsius;
+	u8 tenths;
+} __packed;
+
+struct imx_sc_msg_misc_get_temp {
+	struct imx_sc_rpc_msg hdr;
+	union {
+		struct req_get_temp req;
+		struct resp_get_temp resp;
+	} data;
+} __packed;
+
+static int imx_sc_thermal_get_temp(void *data, int *temp)
+{
+	struct imx_sc_msg_misc_get_temp msg;
+	struct imx_sc_rpc_msg *hdr = &msg.hdr;
+	struct imx_sc_sensor *sensor = data;
+	int ret;
+
+	msg.data.req.resource_id = sensor->resource_id;
+	msg.data.req.type = IMX_SC_C_TEMP;
+
+	hdr->ver = IMX_SC_RPC_VERSION;
+	hdr->svc = IMX_SC_RPC_SVC_MISC;
+	hdr->func = IMX_SC_MISC_FUNC_GET_TEMP;
+	hdr->size = 2;
+
+	ret = imx_scu_call_rpc(thermal_ipc_handle, &msg, true);
+	if (ret) {
+		pr_err("read temp sensor %d failed, ret %d\n",
+			sensor->resource_id, ret);
+		return ret;
+	}
+
+	*temp = msg.data.resp.celsius * 1000 + msg.data.resp.tenths * 100;
+
+	return 0;
+}
+
+static const struct thermal_zone_of_device_ops imx_sc_thermal_ops = {
+	.get_temp = imx_sc_thermal_get_temp,
+};
+
+static int imx_sc_thermal_register_sensor(struct platform_device *pdev,
+					  struct imx_sc_sensor *sensor)
+{
+	struct thermal_zone_device *tzd;
+
+	tzd = devm_thermal_zone_of_sensor_register(&pdev->dev,
+						   sensor->resource_id,
+						   sensor,
+						   &imx_sc_thermal_ops);
+	if (IS_ERR(tzd)) {
+		dev_err(&pdev->dev, "failed to register sensor: %d\n",
+			sensor->resource_id);
+		return PTR_ERR(tzd);
+	}
+
+	sensor->tzd = tzd;
+
+	return 0;
+}
+
+static int imx_sc_thermal_get_sensor_id(struct device_node *sensor_np, u32 *id)
+{
+	struct of_phandle_args sensor_specs;
+	int ret;
+
+	ret = of_parse_phandle_with_args(sensor_np, "thermal-sensors",
+			"#thermal-sensor-cells",
+			0, &sensor_specs);
+	if (ret)
+		return ret;
+
+	if (sensor_specs.args_count >= 1) {
+		*id = sensor_specs.args[0];
+		WARN(sensor_specs.args_count > 1,
+				"%pOFn: too many cells in sensor specifier %d\n",
+				sensor_specs.np, sensor_specs.args_count);
+	} else {
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int imx_sc_thermal_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct device_node *sensor_np = NULL;
+	struct imx_sc_thermal_data *data;
+	struct imx_sc_sensor *sensors;
+	u32 sensor_num;
+	int ret, i;
+
+	ret = imx_scu_get_handle(&thermal_ipc_handle);
+	if (ret)
+		return ret;
+
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	ret = of_property_read_u32(np, "tsens-num", &sensor_num);
+	if (ret || !sensor_num) {
+		dev_err(&pdev->dev, "failed to get valid temp sensor number!\n");
+		return -EINVAL;
+	}
+
+	sensors = devm_kzalloc(&pdev->dev, sizeof(*data->sensor) * sensor_num,
+			       GFP_KERNEL);
+	if (!sensors)
+		return -ENOMEM;
+
+	data->sensor = sensors;
+
+	np = of_find_node_by_name(NULL, "thermal-zones");
+	if (!np)
+		return -ENODEV;
+
+	for (i = 0; i < sensor_num; i++) {
+		struct imx_sc_sensor *sensor = &data->sensor[i];
+
+		sensor_np = of_get_next_child(np, sensor_np);
+		ret = imx_sc_thermal_get_sensor_id(sensor_np, &sensor->resource_id);
+		if (ret < 0) {
+			dev_err(&pdev->dev,
+				"failed to get valid sensor resource id: %d\n",
+				ret);
+			break;
+		}
+
+		ret = imx_sc_thermal_register_sensor(pdev, sensor);
+		if (ret) {
+			dev_err(&pdev->dev, "failed to register thermal sensor: %d\n",
+				ret);
+			break;
+		}
+	}
+
+	of_node_put(np);
+	of_node_put(sensor_np);
+
+	return ret;
+}
+
+static const struct of_device_id imx_sc_thermal_table[] = {
+	{ .compatible = "fsl,imx8qxp-sc-thermal", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, imx_sc_thermal_table);
+
+static struct platform_driver imx_sc_thermal_driver = {
+		.probe = imx_sc_thermal_probe,
+		.driver = {
+			.name = "imx-sc-thermal",
+			.of_match_table = imx_sc_thermal_table,
+		},
+};
+module_platform_driver(imx_sc_thermal_driver);
+
+MODULE_AUTHOR("Anson Huang <Anson.Huang@nxp.com>");
+MODULE_DESCRIPTION("Thermal driver for NXP i.MX SoCs with system controller");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
