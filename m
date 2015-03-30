From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Mon, 30 Mar 2015 17:04:40 +0300
Subject: [PATCH 4/5] coresight-stm: adding driver for CoreSight STM
 component
In-Reply-To: <1425078294-13059-5-git-send-email-mathieu.poirier@linaro.org>
References: <1425078294-13059-1-git-send-email-mathieu.poirier@linaro.org>
 <1425078294-13059-5-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <87bnjad1jb.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mathieu Poirier <mathieu.poirier@linaro.org> writes:

> +static int stm_send(void *addr, const void *data, u32 size)
> +{
> +	u32 len = size;
> +
> +	if (((unsigned long)data & 0x1) && (size >= 1)) {
> +		writeb_relaxed(*(u8 *)data, addr);
> +		data++;
> +		size--;
> +	}
> +	if (((unsigned long)data & 0x2) && (size >= 2)) {
> +		writew_relaxed(*(u16 *)data, addr);
> +		data += 2;
> +		size -= 2;
> +	}
> +
> +	/* now we are 32bit aligned */
> +	while (size >= 4) {
> +		writel_relaxed(*(u32 *)data, addr);
> +		data += 4;
> +		size -= 4;
> +	}
> +
> +	if (size >= 2) {
> +		writew_relaxed(*(u16 *)data, addr);
> +		data += 2;
> +		size -= 2;
> +	}
> +	if (size >= 1) {
> +		writeb_relaxed(*(u8 *)data, addr);
> +		data++;
> +		size--;
> +	}
> +
> +	return len;
> +}
> +
> +static int stm_trace_data(unsigned long ch_addr, u32 options,
> +			  const void *data, u32 size)
> +{
> +	void *addr;
> +
> +	options &= ~STM_OPTION_TIMESTAMPED;
> +	addr = (void *)(ch_addr | stm_channel_off(STM_PKT_TYPE_DATA, options));
> +
> +	return stm_send(addr, data, size);
> +}
> +
> +static inline int stm_trace_hw(u32 options, u32 channel, u8 entity_id,
> +			       const void *data, u32 size)
> +{
> +	int len = 0;
> +	unsigned long ch_addr;
> +	struct stm_drvdata *drvdata = stmdrvdata;
> +
> +
> +	/* get the channel address */
> +	ch_addr = (unsigned long)stm_channel_addr(drvdata, channel);
> +
> +	if (drvdata->write_64bit)
> +		len = stm_trace_data_64bit(ch_addr, options, data, size);
> +	else
> +		/* send the payload data */
> +		len = stm_trace_data(ch_addr, options, data, size);
> +
> +	return len;
> +}

As it looks from the above snippet, you're using a stream of DATA
packets for user's payload. I also noticed that you use an ioctl to
trigger timestamps.

Now, in the STP protocol there are, for example, marked data packets
that can be used to mark beginning of a higher-level message,
timestamped data packets that can be used to mean the same thing and
FLAG packets to mark message boundaries.

In my Intel TH code, I'm using D*TS packet for the beginning of a
message (or "frame") and FLAG packet for the the end of a message.

So my question is, is there any specific STP framing pattern that you
use with Coresight STM or should we perhaps figure out a generic framing
pattern and make it part of the stm class as well?

For example, we can replace stm's .write callback with something like

    int (*packet)(struct stm_data *data,
                  unsigned int type,    /* data, flag, trig etc */
                  unsigned int options, /* timestamped, marked */
                  u64 payload);

and let the stm core do the "framing", which, then, will be common and
consistent across different architectures/stm implementations.

> +static long stm_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> +{
> +	u32 options;
> +	struct stm_node *node = file->private_data;
> +
> +	switch (cmd) {
> +	case STM_IOCTL_SET_OPTIONS:
> +		if (copy_from_user(&options, (void __user *)arg, sizeof(u32)))
> +			return -EFAULT;
> +
> +		options &= (STM_OPTION_TIMESTAMPED | STM_OPTION_GUARANTEED);
> +		node->options = options;
> +		break;
> +	case STM_IOCTL_GET_OPTIONS:
> +		options = node->options;
> +		if (copy_to_user((void __user *)arg, &options, sizeof(options)))
> +			return -EFAULT;
> +		break;
> +	default:
> +		return -EINVAL;
> +	};
> +
> +	return 0;
> +}

That way, we also won't need private ioctl()s, or at least, not for this
reason.

How do you feel about this?

Regards,
--
Alex
