From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Thu, 2 Nov 2017 13:26:37 -0600
Subject: [PATCH 08/17] coresight: tmc: Add configuration support for
 trace buffer size
In-Reply-To: <20171019171553.24056-9-suzuki.poulose@arm.com>
References: <20171019171553.24056-1-suzuki.poulose@arm.com>
 <20171019171553.24056-9-suzuki.poulose@arm.com>
Message-ID: <20171102192637.GB23320@xps15>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 19, 2017 at 06:15:44PM +0100, Suzuki K Poulose wrote:
> Now that we can dynamically switch between contiguous memory and
> SG table depending on the trace buffer size, provide the support
> for selecting an appropriate buffer size.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  .../ABI/testing/sysfs-bus-coresight-devices-tmc    |  8 ++++++
>  drivers/hwtracing/coresight/coresight-tmc.c        | 32 ++++++++++++++++++++++
>  2 files changed, 40 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc
> index 4fe677ed1305..3675c380caf8 100644
> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc
> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc
> @@ -83,3 +83,11 @@ KernelVersion:	4.7
>  Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
>  Description:	(R) Indicates the capabilities of the Coresight TMC.
>  		The value is read directly from the DEVID register, 0xFC8,
> +
> +What:		/sys/bus/coresight/devices/<memory_map>.tmc/buffer-size
> +Date:		September 2017
> +KernelVersion:	4.15

More like 4.16 now.

> +Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
> +Description:	(RW) Size of the trace buffer for TMC-ETR when used in SYSFS
> +		mode. Writable only for TMC-ETR configurations. The value
> +		should be aligned to the kernel pagesize.
> diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
> index c7201e40d737..2349b1805694 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc.c
> @@ -283,8 +283,40 @@ static ssize_t trigger_cntr_store(struct device *dev,
>  }
>  static DEVICE_ATTR_RW(trigger_cntr);
>  
> +static ssize_t buffer_size_show(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	struct tmc_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +
> +	return sprintf(buf, "%#x\n", drvdata->size);
> +}
> +
> +static ssize_t buffer_size_store(struct device *dev,
> +			     struct device_attribute *attr,
> +			     const char *buf, size_t size)

Indentation (I know trigger_cntr_store() is wrong).

> +{
> +	int ret;
> +	unsigned long val;
> +	struct tmc_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +
> +	if (drvdata->config_type != TMC_CONFIG_TYPE_ETR)
> +		return -EPERM;

I think -EINVAL would be more appropriate but definitely not a big deal.

> +
> +	ret = kstrtoul(buf, 0, &val);
> +	if (ret)
> +		return ret;
> +	/* The buffer size should be page aligned */
> +	if (val & (PAGE_SIZE - 1))
> +		return -EINVAL;
> +	drvdata->size = val;
> +	return size;
> +}
> +
> +static DEVICE_ATTR_RW(buffer_size);
> +
>  static struct attribute *coresight_tmc_attrs[] = {
>  	&dev_attr_trigger_cntr.attr,
> +	&dev_attr_buffer_size.attr,
>  	NULL,
>  };
>  
> -- 
> 2.13.6
> 
