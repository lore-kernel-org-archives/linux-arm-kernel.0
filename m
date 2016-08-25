From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 25 Aug 2016 17:40:10 +0100
Subject: [PATCH v2 0/7] scpi: Add support for legacy SCPI protocol
In-Reply-To: <73cce388-219d-2daa-811a-059c3d84c2e4@arm.com>
References: <1471952816-30877-1-git-send-email-narmstrong@baylibre.com>
 <f6c7249f-f103-fd91-2c89-a30c191427aa@baylibre.com>
 <73cce388-219d-2daa-811a-059c3d84c2e4@arm.com>
Message-ID: <ed4ec39d-2b3a-1223-00c3-67d0494e99e6@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 25/08/16 14:45, Sudeep Holla wrote:
>
>
> On 25/08/16 14:18, Neil Armstrong wrote:

[...]

>> Here I used if(is_legacy) to stop duplicating functions, is this ok
>> for you ?
>>
>
> I am still thinking if it can be abstracted well, some kind of mapping
> but haven't thought too much about that yet. Also I was thinking about
> bitmap for high priority commands. I remember doing something before but
> seem to have lost that copy. I will try to dig it out..
>

OK how about something like:

1. in struct scpi_drvinfo
	DECLARE_BITMAP(cmd_priority, SCPI_CMD_COUNT);

2. scpi_send_message
	scpi_chan = test_bit(cmd, scpi_info->cmd_priority) ?
		    scpi_info->channels + 1 : scpi_info->channels;

3. probe
	for (idx = 0; idx < ARRAY_SIZE(hpriority_cmds); idx++)
		set_bit(hpriority_cmds[idx], scpi_info->cmd_priority);

For commands, I am thinking some kind of indirection like the below
patch. See if that helps, I will add the description later, but you can
build your patches on top of it if you think that works and keeps code
simple.

Regards,
Sudeep


-->8

 From afde0d2f1d3381d443445301ab5ec111276934e5 Mon Sep 17 00:00:00 2001
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Thu, 25 Aug 2016 17:21:49 +0100
Subject: [PATCH] firmware: arm_scpi: create command indirection to support
  legacy commands

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
  drivers/firmware/arm_scpi.c | 68 
+++++++++++++++++++++++++++++++++------------
  1 file changed, 51 insertions(+), 17 deletions(-)

diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
index 438893762076..c2063cb76b08 100644
--- a/drivers/firmware/arm_scpi.c
+++ b/drivers/firmware/arm_scpi.c
@@ -129,7 +129,39 @@ enum scpi_std_cmd {
  	SCPI_CMD_SENSOR_ASYNC_VALUE	= 0x1a,
  	SCPI_CMD_SET_DEVICE_PWR_STATE	= 0x1b,
  	SCPI_CMD_GET_DEVICE_PWR_STATE	= 0x1c,
-	SCPI_CMD_COUNT
+};
+
+enum scpi_drv_cmd {
+	SCPI_CAPABILITIES	= 0,
+	GET_DVFS_INFO		= 1,
+	SET_DVFS		= 2,
+	GET_DVFS		= 3,
+	GET_CLOCK_INFO		= 4,
+	SET_CLOCK_VALUE		= 5,
+	GET_CLOCK_VALUE		= 6,
+	PSU_CAPABILITIES	= 7,
+	SENSOR_CAPABILITIES	= 8,
+	SENSOR_INFO		= 9,
+	SENSOR_VALUE		= 10,
+	SET_DEV_PWR_STATE	= 11,
+	GET_DEV_PWR_STATE	= 12,
+	CMD_MAX_COUNT
+};
+
+static int scpi_std_commands[CMD_MAX_COUNT] = {
+	SCPI_CMD_SCPI_CAPABILITIES,
+	SCPI_CMD_GET_DVFS_INFO,
+	SCPI_CMD_SET_DVFS,
+	SCPI_CMD_GET_DVFS,
+	SCPI_CMD_GET_CLOCK_INFO,
+	SCPI_CMD_SET_CLOCK_VALUE,
+	SCPI_CMD_GET_CLOCK_VALUE,
+	SCPI_CMD_PSU_CAPABILITIES,
+	SCPI_CMD_SENSOR_CAPABILITIES,
+	SCPI_CMD_SENSOR_INFO,
+	SCPI_CMD_SENSOR_VALUE,
+	SCPI_CMD_SET_DEVICE_PWR_STATE,
+	SCPI_CMD_GET_DEVICE_PWR_STATE,
  };
   struct scpi_xfer {
@@ -161,6 +193,7 @@ struct scpi_drvinfo {
  	u32 protocol_version;
  	u32 firmware_version;
  	int num_chans;
+	int *cmds;
  	atomic_t next_chan;
  	struct scpi_ops *scpi_ops;
  	struct scpi_chan *channels;
@@ -397,7 +430,7 @@ scpi_clk_get_range(u16 clk_id, unsigned long *min, 
unsigned long *max)
  	struct clk_get_info clk;
  	__le16 le_clk_id = cpu_to_le16(clk_id);
  -	ret = scpi_send_message(SCPI_CMD_GET_CLOCK_INFO, &le_clk_id,
+	ret = scpi_send_message(scpi_info->cmds[GET_CLOCK_INFO], &le_clk_id,
  				sizeof(le_clk_id), &clk, sizeof(clk));
  	if (!ret) {
  		*min = le32_to_cpu(clk.min_rate);
@@ -412,7 +445,7 @@ static unsigned long scpi_clk_get_val(u16 clk_id)
  	struct clk_get_value clk;
  	__le16 le_clk_id = cpu_to_le16(clk_id);
  -	ret = scpi_send_message(SCPI_CMD_GET_CLOCK_VALUE, &le_clk_id,
+	ret = scpi_send_message(scpi_info->cmds[GET_CLOCK_VALUE], &le_clk_id,
  				sizeof(le_clk_id), &clk, sizeof(clk));
  	return ret ? ret : le32_to_cpu(clk.rate);
  }
@@ -425,8 +458,8 @@ static int scpi_clk_set_val(u16 clk_id, unsigned 
long rate)
  		.rate = cpu_to_le32(rate)
  	};
  -	return scpi_send_message(SCPI_CMD_SET_CLOCK_VALUE, &clk, sizeof(clk),
-				 &stat, sizeof(stat));
+	return scpi_send_message(scpi_info->cmds[SET_CLOCK_VALUE], &clk,
+				 sizeof(clk), &stat, sizeof(stat));
  }
   static int scpi_dvfs_get_idx(u8 domain)
@@ -434,8 +467,8 @@ static int scpi_dvfs_get_idx(u8 domain)
  	int ret;
  	u8 dvfs_idx;
  -	ret = scpi_send_message(SCPI_CMD_GET_DVFS, &domain, sizeof(domain),
-				&dvfs_idx, sizeof(dvfs_idx));
+	ret = scpi_send_message(scpi_info->cmds[GET_DVFS], &domain,
+				sizeof(domain),	&dvfs_idx, sizeof(dvfs_idx));
  	return ret ? ret : dvfs_idx;
  }
  @@ -444,7 +477,7 @@ static int scpi_dvfs_set_idx(u8 domain, u8 index)
  	int stat;
  	struct dvfs_set dvfs = {domain, index};
  -	return scpi_send_message(SCPI_CMD_SET_DVFS, &dvfs, sizeof(dvfs),
+	return scpi_send_message(scpi_info->cmds[SET_DVFS], &dvfs, sizeof(dvfs),
  				 &stat, sizeof(stat));
  }
  @@ -468,8 +501,8 @@ static struct scpi_dvfs_info 
*scpi_dvfs_get_info(u8 domain)
  	if (scpi_info->dvfs[domain])	/* data already populated */
  		return scpi_info->dvfs[domain];
  -	ret = scpi_send_message(SCPI_CMD_GET_DVFS_INFO, &domain, sizeof(domain),
-				&buf, sizeof(buf));
+	ret = scpi_send_message(scpi_info->cmds[GET_DVFS_INFO], &domain,
+				sizeof(domain),	&buf, sizeof(buf));
   	if (ret)
  		return ERR_PTR(ret);
@@ -503,8 +536,8 @@ static int scpi_sensor_get_capability(u16 *sensors)
  	struct sensor_capabilities cap_buf;
  	int ret;
  -	ret = scpi_send_message(SCPI_CMD_SENSOR_CAPABILITIES, NULL, 0, &cap_buf,
-				sizeof(cap_buf));
+	ret = scpi_send_message(scpi_info->cmds[SENSOR_CAPABILITIES], NULL, 0,
+				&cap_buf, sizeof(cap_buf));
  	if (!ret)
  		*sensors = le16_to_cpu(cap_buf.sensors);
  @@ -517,7 +550,7 @@ static int scpi_sensor_get_info(u16 sensor_id, 
struct scpi_sensor_info *info)
  	struct _scpi_sensor_info _info;
  	int ret;
  -	ret = scpi_send_message(SCPI_CMD_SENSOR_INFO, &id, sizeof(id),
+	ret = scpi_send_message(scpi_info->cmds[SENSOR_INFO], &id, sizeof(id),
  				&_info, sizeof(_info));
  	if (!ret) {
  		memcpy(info, &_info, sizeof(*info));
@@ -533,7 +566,7 @@ static int scpi_sensor_get_value(u16 sensor, u64 *val)
  	struct sensor_value buf;
  	int ret;
  -	ret = scpi_send_message(SCPI_CMD_SENSOR_VALUE, &id, sizeof(id),
+	ret = scpi_send_message(scpi_info->cmds[SENSOR_VALUE], &id, sizeof(id),
  				&buf, sizeof(buf));
  	if (!ret)
  		*val = (u64)le32_to_cpu(buf.hi_val) << 32 |
@@ -548,7 +581,7 @@ static int scpi_device_get_power_state(u16 dev_id)
  	u8 pstate;
  	__le16 id = cpu_to_le16(dev_id);
  -	ret = scpi_send_message(SCPI_CMD_GET_DEVICE_PWR_STATE, &id,
+	ret = scpi_send_message(scpi_info->cmds[GET_DEV_PWR_STATE], &id,
  				sizeof(id), &pstate, sizeof(pstate));
  	return ret ? ret : pstate;
  }
@@ -561,7 +594,7 @@ static int scpi_device_set_power_state(u16 dev_id, 
u8 pstate)
  		.pstate = pstate,
  	};
  -	return scpi_send_message(SCPI_CMD_SET_DEVICE_PWR_STATE, &dev_set,
+	return scpi_send_message(scpi_info->cmds[SET_DEV_PWR_STATE], &dev_set,
  				 sizeof(dev_set), &stat, sizeof(stat));
  }
  @@ -591,7 +624,7 @@ static int scpi_init_versions(struct scpi_drvinfo 
*info)
  	int ret;
  	struct scp_capabilities caps;
  -	ret = scpi_send_message(SCPI_CMD_SCPI_CAPABILITIES, NULL, 0,
+	ret = scpi_send_message(info->cmds[SCPI_CAPABILITIES], NULL, 0,
  				&caps, sizeof(caps));
  	if (!ret) {
  		info->protocol_version = le32_to_cpu(caps.protocol_version);
@@ -754,6 +787,7 @@ static int scpi_probe(struct platform_device *pdev)
   	scpi_info->channels = scpi_chan;
  	scpi_info->num_chans = count;
+	scpi_info->cmds = scpi_std_commands;
  	platform_set_drvdata(pdev, scpi_info);
   	ret = scpi_init_versions(scpi_info);
-- 
2.7.4
