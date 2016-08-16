From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 16 Aug 2016 11:41:51 +0200
Subject: [RFC PATCH v3 5/8] firmware: Add legacy SCPI protocol driver
In-Reply-To: <cea12544-6dfd-55d4-7c85-68290c720515@arm.com>
References: <1470738562-20026-1-git-send-email-narmstrong@baylibre.com>
 <1470738562-20026-6-git-send-email-narmstrong@baylibre.com>
 <cea12544-6dfd-55d4-7c85-68290c720515@arm.com>
Message-ID: <9b1d633e-6215-23c5-6cc2-bc64d104aa0a@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/15/2016 03:35 PM, Sudeep Holla wrote:
> Hi Neil,
> 
> On 09/08/16 11:29, Neil Armstrong wrote:
>> Add legacy protocol driver for an early published SCPI implementation
>> by supporting old command indexes and structure.
>> This driver also supports vendor messages and rockchip specific
>> mailbox data structure for message passing to SCP.
>>
> 

Hi Sudeep,

> Sorry for the delay but I expected some attempts to reduce the
> duplication of code we have here. I really don't like the duplication of
> the code. As I mentioned earlier it can be reduced. I see lot of scope
> for that and I see that you made zero attempts since v2.

Yes, this post is an intermediate RFC to show to rockchip guys how I could implement support
for their vendor commands, the next RFC will certainly merge the two drivers with minimal code
duplication.

> 
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  drivers/firmware/Kconfig       |  20 ++
>>  drivers/firmware/Makefile      |   1 +
>>  drivers/firmware/legacy_scpi.c | 710 +++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 731 insertions(+)
>>  create mode 100644 drivers/firmware/legacy_scpi.c
>>
>> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
>> index ff85511..f6226b7 100644
>> --- a/drivers/firmware/Kconfig
>> +++ b/drivers/firmware/Kconfig
>> @@ -40,6 +40,26 @@ config ARM_SCPI_POWER_DOMAIN
>>        This enables support for the SCPI power domains which can be
>>        enabled or disabled via the SCP firmware
>>
>> +config LEGACY_SCPI_PROTOCOL
>> +    bool "Legacy System Control and Power Interface (SCPI) Message Protocol"
>> +    default y if ARCH_MESON
>> +    select SCPI_FW
>> +    help
>> +      System Control and Power Interface (SCPI) Message Protocol is
>> +      defined for the purpose of communication between the Application
>> +      Cores(AP) and the System Control Processor(SCP). The MHU peripheral
>> +      provides a mechanism for inter-processor communication between SCP
>> +      and AP.
>> +
>> +      SCP controls most of the power managament on the Application
>> +      Processors. It offers control and management of: the core/cluster
>> +      power states, various power domain DVFS including the core/cluster,
>> +      certain system clocks configuration, thermal sensors and many
>> +      others.
>> +
>> +      This protocol library provides interface for all the client drivers
>> +      making use of the features offered by the legacy SCP protocol.
>> +
> 
> Why do we need this ? If we plan to enable this in defconfig, I would
> rather not introduce this as it serves nothing extra over the
> compatible. We need runtime check for this with DT compatibles.
> 
> 
> [...]
> 
> 
>> +enum legacy_scpi_client_id {
>> +    SCPI_CL_NONE,
>> +    SCPI_CL_CLOCKS,
>> +    SCPI_CL_DVFS,
>> +    SCPI_CL_POWER,
>> +    SCPI_CL_THERMAL,
>> +    SCPI_MAX,
>> +};
>> +
> 
> As I said before these values were introduced by me initially and I
> reckon firmware doesn't depend on that. Have you really tested dropping
> them ? This must go as they are useless and we now have tokens which are
> much better.

I am not sure, I'm currently waiting for Amlogic's SCPI FW specification to be sure
these are not needed at all, in the meantime I will still implement them.

> 
> I will stop here and ask why can't you start with simple change like
> below ? Then we can add or re-define the structures/enums when
> absolutely needed. Please don't just copy the entire driver and make
> changes where-ever needed or please try to adapt to the new driver and
> try to deviate as less as required by the firmware.

It will be done in RFC v4.


> Regards,
> Sudeep

Thanks,
Neil

> 
> --->8
> 
> diff --git i/drivers/firmware/arm_scpi.c w/drivers/firmware/arm_scpi.c
> index 438893762076..b394ffb5939c 100644
> --- i/drivers/firmware/arm_scpi.c
> +++ w/drivers/firmware/arm_scpi.c
> @@ -82,6 +82,9 @@
> 
>  #define MAX_RX_TIMEOUT        (msecs_to_jiffies(30))
> 
> +typedef int (*scpi_send_msg_func)(u8 cmd, void *tx_buf, unsigned int tx_len,
> +                  void *rx_buf, unsigned int rx_len);
> +
>  enum scpi_error_codes {
>      SCPI_SUCCESS = 0, /* Success */
>      SCPI_ERR_PARAM = 1, /* Invalid parameter(s) */
> @@ -162,6 +165,7 @@ struct scpi_drvinfo {
>      u32 firmware_version;
>      int num_chans;
>      atomic_t next_chan;
> +    scpi_send_msg_func send_msg;
>      struct scpi_ops *scpi_ops;
>      struct scpi_chan *channels;
>      struct scpi_dvfs_info *dvfs[MAX_DVFS_DOMAINS];
> @@ -397,8 +401,8 @@ scpi_clk_get_range(u16 clk_id, unsigned long *min, unsigned long *max)
>      struct clk_get_info clk;
>      __le16 le_clk_id = cpu_to_le16(clk_id);
> 
> -    ret = scpi_send_message(SCPI_CMD_GET_CLOCK_INFO, &le_clk_id,
> -                sizeof(le_clk_id), &clk, sizeof(clk));
> +    ret = scpi_info->send_msg(SCPI_CMD_GET_CLOCK_INFO, &le_clk_id,
> +                  sizeof(le_clk_id), &clk, sizeof(clk));
>      if (!ret) {
>          *min = le32_to_cpu(clk.min_rate);
>          *max = le32_to_cpu(clk.max_rate);
> @@ -412,8 +416,8 @@ static unsigned long scpi_clk_get_val(u16 clk_id)
>      struct clk_get_value clk;
>      __le16 le_clk_id = cpu_to_le16(clk_id);
> 
> -    ret = scpi_send_message(SCPI_CMD_GET_CLOCK_VALUE, &le_clk_id,
> -                sizeof(le_clk_id), &clk, sizeof(clk));
> +    ret = scpi_info->send_msg(SCPI_CMD_GET_CLOCK_VALUE, &le_clk_id,
> +                  sizeof(le_clk_id), &clk, sizeof(clk));
>      return ret ? ret : le32_to_cpu(clk.rate);
>  }
> 
> @@ -425,8 +429,8 @@ static int scpi_clk_set_val(u16 clk_id, unsigned long rate)
>          .rate = cpu_to_le32(rate)
>      };
> 
> -    return scpi_send_message(SCPI_CMD_SET_CLOCK_VALUE, &clk, sizeof(clk),
> -                 &stat, sizeof(stat));
> +    return scpi_info->send_msg(SCPI_CMD_SET_CLOCK_VALUE, &clk, sizeof(clk),
> +                   &stat, sizeof(stat));
>  }
> 
>  static int scpi_dvfs_get_idx(u8 domain)
> @@ -434,8 +438,8 @@ static int scpi_dvfs_get_idx(u8 domain)
>      int ret;
>      u8 dvfs_idx;
> 
> -    ret = scpi_send_message(SCPI_CMD_GET_DVFS, &domain, sizeof(domain),
> -                &dvfs_idx, sizeof(dvfs_idx));
> +    ret = scpi_info->send_msg(SCPI_CMD_GET_DVFS, &domain, sizeof(domain),
> +                  &dvfs_idx, sizeof(dvfs_idx));
>      return ret ? ret : dvfs_idx;
>  }
> 
> @@ -444,8 +448,8 @@ static int scpi_dvfs_set_idx(u8 domain, u8 index)
>      int stat;
>      struct dvfs_set dvfs = {domain, index};
> 
> -    return scpi_send_message(SCPI_CMD_SET_DVFS, &dvfs, sizeof(dvfs),
> -                 &stat, sizeof(stat));
> +    return scpi_info->send_msg(SCPI_CMD_SET_DVFS, &dvfs, sizeof(dvfs),
> +                   &stat, sizeof(stat));
>  }
> 
>  static int opp_cmp_func(const void *opp1, const void *opp2)
> @@ -468,8 +472,8 @@ static struct scpi_dvfs_info *scpi_dvfs_get_info(u8 domain)
>      if (scpi_info->dvfs[domain])    /* data already populated */
>          return scpi_info->dvfs[domain];
> 
> -    ret = scpi_send_message(SCPI_CMD_GET_DVFS_INFO, &domain, sizeof(domain),
> -                &buf, sizeof(buf));
> +    ret = scpi_info->send_msg(SCPI_CMD_GET_DVFS_INFO, &domain,
> +                  sizeof(domain), &buf, sizeof(buf));
> 
>      if (ret)
>          return ERR_PTR(ret);
> @@ -503,8 +507,8 @@ static int scpi_sensor_get_capability(u16 *sensors)
>      struct sensor_capabilities cap_buf;
>      int ret;
> 
> -    ret = scpi_send_message(SCPI_CMD_SENSOR_CAPABILITIES, NULL, 0, &cap_buf,
> -                sizeof(cap_buf));
> +    ret = scpi_info->send_msg(SCPI_CMD_SENSOR_CAPABILITIES, NULL, 0,
> +                  &cap_buf, sizeof(cap_buf));
>      if (!ret)
>          *sensors = le16_to_cpu(cap_buf.sensors);
> 
> @@ -517,8 +521,8 @@ static int scpi_sensor_get_info(u16 sensor_id, struct scpi_sensor_info *info)
>      struct _scpi_sensor_info _info;
>      int ret;
> 
> -    ret = scpi_send_message(SCPI_CMD_SENSOR_INFO, &id, sizeof(id),
> -                &_info, sizeof(_info));
> +    ret = scpi_info->send_msg(SCPI_CMD_SENSOR_INFO, &id, sizeof(id),
> +                  &_info, sizeof(_info));
>      if (!ret) {
>          memcpy(info, &_info, sizeof(*info));
>          info->sensor_id = le16_to_cpu(_info.sensor_id);
> @@ -533,8 +537,8 @@ static int scpi_sensor_get_value(u16 sensor, u64 *val)
>      struct sensor_value buf;
>      int ret;
> 
> -    ret = scpi_send_message(SCPI_CMD_SENSOR_VALUE, &id, sizeof(id),
> -                &buf, sizeof(buf));
> +    ret = scpi_info->send_msg(SCPI_CMD_SENSOR_VALUE, &id, sizeof(id),
> +                  &buf, sizeof(buf));
>      if (!ret)
>          *val = (u64)le32_to_cpu(buf.hi_val) << 32 |
>              le32_to_cpu(buf.lo_val);
> @@ -548,8 +552,8 @@ static int scpi_device_get_power_state(u16 dev_id)
>      u8 pstate;
>      __le16 id = cpu_to_le16(dev_id);
> 
> -    ret = scpi_send_message(SCPI_CMD_GET_DEVICE_PWR_STATE, &id,
> -                sizeof(id), &pstate, sizeof(pstate));
> +    ret = scpi_info->send_msg(SCPI_CMD_GET_DEVICE_PWR_STATE, &id,
> +                  sizeof(id), &pstate, sizeof(pstate));
>      return ret ? ret : pstate;
>  }
> 
> @@ -561,8 +565,8 @@ static int scpi_device_set_power_state(u16 dev_id, u8 pstate)
>          .pstate = pstate,
>      };
> 
> -    return scpi_send_message(SCPI_CMD_SET_DEVICE_PWR_STATE, &dev_set,
> -                 sizeof(dev_set), &stat, sizeof(stat));
> +    return scpi_info->send_msg(SCPI_CMD_SET_DEVICE_PWR_STATE, &dev_set,
> +                   sizeof(dev_set), &stat, sizeof(stat));
>  }
> 
>  static struct scpi_ops scpi_ops = {
> @@ -591,8 +595,8 @@ static int scpi_init_versions(struct scpi_drvinfo *info)
>      int ret;
>      struct scp_capabilities caps;
> 
> -    ret = scpi_send_message(SCPI_CMD_SCPI_CAPABILITIES, NULL, 0,
> -                &caps, sizeof(caps));
> +    ret = scpi_info->send_msg(SCPI_CMD_SCPI_CAPABILITIES, NULL, 0,
> +                  &caps, sizeof(caps));
>      if (!ret) {
>          info->protocol_version = le32_to_cpu(caps.protocol_version);
>          info->firmware_version = le32_to_cpu(caps.platform_version);
> @@ -681,6 +685,14 @@ static int scpi_alloc_xfer_list(struct device *dev, struct scpi_chan *ch)
>      return 0;
>  }
> 
> +static const struct of_device_id scpi_of_match[] = {
> +    {.compatible = "arm,scpi", .data = scpi_send_message},
> +    {.compatible = "arm,scpi-legacy", .data = scpi_send_message},
> +    {},
> +};
> +
> +MODULE_DEVICE_TABLE(of, scpi_of_match);
> +
>  static int scpi_probe(struct platform_device *pdev)
>  {
>      int count, idx, ret;
> @@ -688,11 +700,15 @@ static int scpi_probe(struct platform_device *pdev)
>      struct scpi_chan *scpi_chan;
>      struct device *dev = &pdev->dev;
>      struct device_node *np = dev->of_node;
> +    const struct of_device_id *match;
> 
>      scpi_info = devm_kzalloc(dev, sizeof(*scpi_info), GFP_KERNEL);
>      if (!scpi_info)
>          return -ENOMEM;
> 
> +    match = of_match_device(scpi_of_match, dev);
> +    scpi_info->send_msg = match->data;
> +
>      count = of_count_phandle_with_args(np, "mboxes", "#mbox-cells");
>      if (count < 0) {
>          dev_err(dev, "no mboxes property in '%s'\n", np->full_name);
> @@ -778,13 +794,6 @@ static int scpi_probe(struct platform_device *pdev)
>      return of_platform_populate(dev->of_node, NULL, NULL, dev);
>  }
> 
> -static const struct of_device_id scpi_of_match[] = {
> -    {.compatible = "arm,scpi"},
> -    {},
> -};
> -
> -MODULE_DEVICE_TABLE(of, scpi_of_match);
> -
>  static struct platform_driver scpi_driver = {
>      .driver = {
>          .name = "scpi_protocol",
