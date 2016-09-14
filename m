From: joe@perches.com (Joe Perches)
Date: Wed, 14 Sep 2016 12:05:19 -0700
Subject: [GIT PULL] Greybus driver subsystem for 4.9-rc1
In-Reply-To: <20160914182952.GA21615@kroah.com>
References: <20160914100949.GA6179@kroah.com>
 <20160914173625.GB15356@leverpostej> <20160914180754.GA16053@kroah.com>
 <20160914182952.GA21615@kroah.com>
Message-ID: <1473879919.32273.47.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2016-09-14 at 20:29 +0200, Greg KH wrote:

trivial note:

> +static size_t gb_timesync_log_frame_time(struct gb_timesync_svc *timesync_svc,
> +					 char *buf, size_t buflen)
> +{
> +	struct gb_svc *svc = timesync_svc->svc;
> +	struct gb_host_device *hd;
> +	struct gb_timesync_interface *timesync_interface;
> +	struct gb_interface *interface;
> +	unsigned int len;
> +	size_t off;
> +
> +	/* AP/SVC */
> +	off = snprintf(buf, buflen, "%s frametime: ap=%llu %s=%llu ",
> +		       greybus_bus_type.name,
> +		       timesync_svc->ap_ping_frame_time, dev_name(&svc->dev),
> +		       timesync_svc->svc_ping_frame_time);
> +	len = buflen - off;
> +
> +	/* APB/GPB */
> +	if (len < buflen) {
> +		hd = timesync_svc->timesync_hd->hd;
> +		off += snprintf(&buf[off], len, "%s=%llu ", dev_name(&hd->dev),
> +				timesync_svc->timesync_hd->ping_frame_time);
> +		len = buflen - off;
> +	}
> +
> +	list_for_each_entry(timesync_interface,
> +			    &timesync_svc->interface_list, list) {
> +		if (len < buflen) {
> +			interface = timesync_interface->interface;
> +			off += snprintf(&buf[off], len, "%s=%llu ",
> +					dev_name(&interface->dev),
> +					timesync_interface->ping_frame_time);
> +			len = buflen - off;
> +		}
> +	}
> +	if (len < buflen)
> +		off += snprintf(&buf[off], len, "\n");
> +	return off;
> +}

The unnecessary trailing blank can be avoided by converting

	snprintf(, "format ', ...);
	for (...)
		snprintf(, "format ", ...);
	snprintf(, "\n");

to

	snprintf(, "format', ...);
	for (...)
		snprintf(, " format", ...);
	snprintf(, "\n");

> 
