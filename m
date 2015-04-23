From: jonathar@broadcom.com (Jonathan Richardson)
Date: Thu, 23 Apr 2015 11:07:39 -0700
Subject: [PATCH 2/2] misc: Add initial Digital Timing Engine (DTE) driver
 for cygnus
In-Reply-To: <6346218.3x3hbSlxMs@wuerfel>
References: <1429744923-2007-1-git-send-email-jonathar@broadcom.com>
 <1429744923-2007-3-git-send-email-jonathar@broadcom.com>
 <6346218.3x3hbSlxMs@wuerfel>
Message-ID: <553934EB.4050701@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Thanks for the initial feedback. I'll investigate your suggestions and
get back to you if I have any questions before making some of the API
changes you've suggested.

On 15-04-23 01:04 AM, Arnd Bergmann wrote:
> On Wednesday 22 April 2015 16:22:03 Jonathan Richardson wrote:
>> Reviewed-by: Scott Branden <sbranden@broadcom.com>
>> Tested-by: Scott Branden <sbranden@broadcom.com>
>> Signed-off-by: Jonathan Richardson <jonathar@broadcom.com>
> 
> No description at all?
> 
> You are introducing a new subsystem here, which means you get to put
> a lot of thought into the API design, to ensure that it works with
> other drivers of the same type, and that we don't already have
> a subsystem that does what you need here.
> 
> Please write a few pages of text about the tradeoffs that went into
> the internal and user-facing API design, and explain the differences
> to the existing infrastructure we have for the clocksource, clockevent,
> k_clock, posix timers, posix timers, timerfd, rtc, and ptp frameworks,
> in particular why your hardware cannot fit into the existing frameworks
> and has to have a new one.
> 
>> +struct bcm_cygnus_dte *dte_get_dev_from_devname(const char *devname)
>> +{
>> +	struct bcm_cygnus_dte *cygnus_dte = NULL;
>> +	bool found = false;
>> +
>> +	if (!devname)
>> +		return NULL;
>> +
>> +	list_for_each_entry(cygnus_dte, &dtedev_list, node) {
>> +		if (!strcmp(dev_name(&cygnus_dte->pdev->dev), devname)) {
>> +			/* Matched on device name */
>> +			found = true;
>> +			break;
>> +		}
>> +	}
>> +
>> +	return found ? cygnus_dte : NULL;
>> +}
>> +EXPORT_SYMBOL(dte_get_dev_from_devname);
> 
> No, don't match on a device name. If you must have a reference, use
> a phandle in DT.
> 
>> +int dte_get_timestamp(
>> +		struct bcm_cygnus_dte *cygnus_dte,
>> +		enum dte_client client,
>> +		struct timespec *ts)
> 
> Please use timespec64 or ktime_t for internal interfaces.
> 
>> +	case DTE_IOCTL_SET_DIVIDER:
> 
> For the IOCTLs, please write a documentation in man-page form. No need
> for troff formatting, plain text is fine.
> 
>> +/**
>> + * DTE Client
>> + */
>> +enum dte_client {
>> +	DTE_CLIENT_MIN = 0,
>> +	DTE_CLIENT_I2S0_BITCLOCK = 0,
>> +	DTE_CLIENT_I2S1_BITCLOCK,
>> +	DTE_CLIENT_I2S2_BITCLOCK,
>> +	DTE_CLIENT_I2S0_WORDCLOCK,
>> +	DTE_CLIENT_I2S1_WORDCLOCK,
>> +	DTE_CLIENT_I2S2_WORDCLOCK,
>> +	DTE_CLIENT_LCD_CLFP,
>> +	DTE_CLIENT_LCD_CLLP,
>> +	DTE_CLIENT_GPIO14,
>> +	DTE_CLIENT_GPIO15,
>> +	DTE_CLIENT_GPIO22,
>> +	DTE_CLIENT_GPIO23,
>> +	DTE_CLIENT_MAX,
>> +};
> 
> Make this more abstract, so we can reuse the API for other vendors.
> 
>> +#define DTE_IOCTL_BASE          'd'
>> +#define DTE_IO(nr)              _IO(DTE_IOCTL_BASE, nr)
>> +#define DTE_IOR(nr, type)       _IOR(DTE_IOCTL_BASE, nr, type)
>> +#define DTE_IOW(nr, type)       _IOW(DTE_IOCTL_BASE, nr, type)
>> +#define DTE_IOWR(nr, type)      _IOWR(DTE_IOCTL_BASE, nr, type)
>> +
>> +#define DTE_IOCTL_SET_DIVIDER       DTE_IOW(0x00, struct dte_data)
>> +#define DTE_IOCTL_ENABLE_TIMESTAMP  DTE_IOW(0x01, struct dte_data)
>> +#define DTE_IOCTL_SET_IRQ_INTERVAL  DTE_IOW(0x02, struct dte_data)
>> +#define DTE_IOCTL_GET_TIMESTAMP     DTE_IOWR(0x03, struct dte_timestamp)
>> +#define DTE_IOCTL_SET_TIME          DTE_IOW(0x04, struct timespec)
>> +#define DTE_IOCTL_GET_TIME          DTE_IOR(0x05, struct timespec)
> 
> Instead of timespec, use a pair of '__u64' values, or alternatively
> just a '__u64' for nanoseconds if the API does not have to cover
> times before 1970 or after 2262.
> 
>> +#define DTE_IOCTL_ADJ_TIME          DTE_IOW(0x06, int64_t)
>> +#define DTE_IOCTL_ADJ_FREQ          DTE_IOW(0x07, int32_t)
> 
> Maybe 'struct timex' for the adjustment?
> 
> Also, how about adding new syscalls along the lines of
> the timerfd stuff instead of using ioctl?
> 
>> +struct dte_data {
>> +	enum dte_client client;
>> +	unsigned int data;
>> +};
> 
> No 'enum' in ioctl data, always use '__u32' etc.
> 
>> +
>> +struct dte_timestamp {
>> +	enum dte_client client;
>> +	struct timespec ts;
>> +};
> 
> Instead of timespec, use a pair of '__u64' values, or alternatively
> just a '__u64' for nanoseconds if the API does not have to cover
> times before 1970 or after 2262.
> 
>> +struct bcm_cygnus_dte;
>> +
>> +extern struct bcm_cygnus_dte *dte_get_dev_from_devname(
>> +		const char *devname);
>> +extern int dte_enable_timestamp(
>> +		struct bcm_cygnus_dte *cygnus_dte,
>> +		enum dte_client client,
>> +		int enable);
> 
> 
> Put the internal declarations into one header in include/linux, and the
> user space facing ones in another one in include/uapi/linux.
> 
> 	Arnd
> 
