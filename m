From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 26 May 2016 17:29:04 +0100
Subject: [RFC PATCH 0/2] scpi: Add SCPI framework to handle vendors
 variants
In-Reply-To: <1464255491-18503-1-git-send-email-narmstrong@baylibre.com>
References: <1464255491-18503-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <57472450.4000709@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Neil,

On 26/05/16 10:38, Neil Armstrong wrote:
> Since the current SCPI implementation, based on [0]:
> - is (at leat) JUNO specific

Agreed.

> - does not specify a strong "standard"

Not exactly, it's extensible. Refer section 3.2.2. Get SCP capability
Extended Set Enabled bit.

> - does not specify a strong MHU interface specification
>

Not really required, any mailbox must do.

> SoC vendors could implement a variant with slight changes in message
> indexes,

I assume you mean command index here

> new messages types,

Also fine with extended command set.

> different messages data format or

you mean the header or payload ? If they don't follow the header, then
how can be group them as same protocol ?

> different MHU communication scheme.

Not a problem as I mentioned above.

>
> To keep the spirit of the SCPI interface, add a thin "register" layer to get
> the ops from the parent node and switch the drivers using the ops to use
> the new of_scpi_ops_get() call.
>

All I can see is that you share the code to register such drivers which
is hardly anything. It's hard to say all drivers use same protocol or
interface after this change. I may be missing to see something here so
it would be easy to appreciate/review this change with one user of this.

My idea of extending this driver if vendor implements extensions based
on SCPI specification is something like below:

-- 
Regards,
Sudeep

-->8

diff --git i/drivers/firmware/arm_scpi.c w/drivers/firmware/arm_scpi.c
index 7e3e595c9f30..7e46aa103690 100644
--- i/drivers/firmware/arm_scpi.c
+++ w/drivers/firmware/arm_scpi.c
@@ -46,6 +46,8 @@

  #define CMD_ID_SHIFT		0
  #define CMD_ID_MASK		0x7f
+#define CMD_SET_SHIFT		7
+#define CMD_SET_MASK		0x1
  #define CMD_TOKEN_ID_SHIFT	8
  #define CMD_TOKEN_ID_MASK	0xff
  #define CMD_DATA_SIZE_SHIFT	16
@@ -53,6 +55,10 @@
  #define PACK_SCPI_CMD(cmd_id, tx_sz)			\
  	((((cmd_id) & CMD_ID_MASK) << CMD_ID_SHIFT) |	\
  	(((tx_sz) & CMD_DATA_SIZE_MASK) << CMD_DATA_SIZE_SHIFT))
+#define PACK_EXT_SCPI_CMD(cmd_id, tx_sz)		\
+	((((cmd_id) & CMD_ID_MASK) << CMD_ID_SHIFT) |	\
+	(CMD_SET_MASK << CMD_SET_SHIFT) |	\
+	(((tx_sz) & CMD_DATA_SIZE_MASK) << CMD_DATA_SIZE_SHIFT))
  #define ADD_SCPI_TOKEN(cmd, token)			\
  	((cmd) |= (((token) & CMD_TOKEN_ID_MASK) << CMD_TOKEN_ID_SHIFT))

@@ -132,6 +138,9 @@ enum scpi_std_cmd {
  	SCPI_CMD_COUNT
  };

+enum scpi_vendor_ext_cmd {
+};
+
  struct scpi_xfer {
  	u32 slot; /* has to be first element */
  	u32 cmd;
@@ -165,6 +174,7 @@ struct scpi_drvinfo {
  	struct scpi_ops *scpi_ops;
  	struct scpi_chan *channels;
  	struct scpi_dvfs_info *dvfs[MAX_DVFS_DOMAINS];
+	void *scpi_ext_ops;
  };

  /*
@@ -343,8 +353,8 @@ static void put_scpi_xfer(struct scpi_xfer *t, 
struct scpi_chan *ch)
  	mutex_unlock(&ch->xfers_lock);
  }

-static int scpi_send_message(u8 cmd, void *tx_buf, unsigned int tx_len,
-			     void *rx_buf, unsigned int rx_len)
+static int __scpi_send_message(u8 cmd, void *tx_buf, unsigned int tx_len,
+			       void *rx_buf, unsigned int rx_len, bool extn)
  {
  	int ret;
  	u8 chan;
@@ -359,7 +369,8 @@ static int scpi_send_message(u8 cmd, void *tx_buf, 
unsigned int tx_len,
  		return -ENOMEM;

  	msg->slot = BIT(SCPI_SLOT);
-	msg->cmd = PACK_SCPI_CMD(cmd, tx_len);
+	msg->cmd = extn ? PACK_EXT_SCPI_CMD(cmd, tx_len) :
+			  PACK_SCPI_CMD(cmd, tx_len);
  	msg->tx_buf = tx_buf;
  	msg->tx_len = tx_len;
  	msg->rx_buf = rx_buf;
@@ -384,6 +395,18 @@ static int scpi_send_message(u8 cmd, void *tx_buf, 
unsigned int tx_len,
  	return ret > 0 ? scpi_to_linux_errno(ret) : ret;
  }

+static int scpi_send_message(u8 cmd, void *tx_buf, unsigned int tx_len,
+			     void *rx_buf, unsigned int rx_len)
+{
+	return __scpi_send_message(cmd, tx_buf, tx_len, rx_buf, rx_len, false);
+}
+
+static int scpi_send_ext_message(u8 cmd, void *tx_buf, unsigned int tx_len,
+				 void *rx_buf, unsigned int rx_len)
+{
+	return __scpi_send_message(cmd, tx_buf, tx_len, rx_buf, rx_len, true);
+}
+
  static u32 scpi_get_version(void)
  {
  	return scpi_info->protocol_version;
@@ -574,6 +597,29 @@ static int scpi_init_versions(struct scpi_drvinfo 
*info)
  	return ret;
  }

+static struct scpi_vendor_ext_ops scpi_vendor_ext_ops = {
+};
+
+void *get_scpi_ext_ops(void)
+{
+	return scpi_info ? scpi_info->scpi_ext_ops : NULL;
+}
+EXPORT_SYMBOL_GPL(get_scpi_ext_ops);
+
+static const struct of_device_id scpi_extentions_of_match[] = {
+	{.compatible = "vendor,scpi", .data = &scpi_vendor_ext_ops},
+	{},
+};
+
+static void
+scpi_init_extensions(struct scpi_drvinfo *info, struct device_node *np)
+{
+	const struct of_device_id *of_id;
+
+	if (np && (of_id = of_match_node(scpi_extentions_of_match, np)))
+		info->scpi_ext_ops = (void *)of_id->data;
+}
+
  static ssize_t protocol_version_show(struct device *dev,
  				     struct device_attribute *attr, char *buf)
  {
@@ -745,6 +791,8 @@ static int scpi_probe(struct platform_device *pdev)
  		  FW_REV_PATCH(scpi_info->firmware_version));
  	scpi_info->scpi_ops = &scpi_ops;

+	scpi_init_extensions(scpi_info, np);
+
  	ret = sysfs_create_groups(&dev->kobj, versions_groups);
  	if (ret)
  		dev_err(dev, "unable to create sysfs version group\n");
diff --git i/include/linux/scpi_protocol.h w/include/linux/scpi_protocol.h
index 35de50a65665..052f6aa1ae4b 100644
--- i/include/linux/scpi_protocol.h
+++ w/include/linux/scpi_protocol.h
@@ -72,8 +72,13 @@ struct scpi_ops {
  	int (*sensor_get_value)(u16, u64 *);
  };

+struct scpi_vendor_ext_ops {
+};
+
  #if IS_REACHABLE(CONFIG_ARM_SCPI_PROTOCOL)
  struct scpi_ops *get_scpi_ops(void);
+void *get_scpi_ext_ops(void);
  #else
  static inline struct scpi_ops *get_scpi_ops(void) { return NULL; }
+static inline void *get_scpi_ext_ops(void) { return NULL; }
  #endif
