From: greg@kroah.com (Greg KH)
Date: Fri, 20 Jan 2012 11:36:46 -0500
Subject: [PATCH 2/6] drivers/base: add bus for System-on-Chip devices
In-Reply-To: <1327075829-14346-3-git-send-email-lee.jones@linaro.org>
References: <1327075829-14346-1-git-send-email-lee.jones@linaro.org>
 <1327075829-14346-3-git-send-email-lee.jones@linaro.org>
Message-ID: <20120120163646.GA4900@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 20, 2012 at 04:10:25PM +0000, Lee Jones wrote:
> +struct soc_device *soc_device_register(struct soc_device_attribute *soc_dev_attr)
> +{
> +	struct soc_device *soc_dev;
> +	int ret;
> +	int i, j = 0;
> +
> +	soc_dev = kzalloc(sizeof(*soc_dev), GFP_KERNEL);
> +	if (!soc_dev) {
> +	        ret = -ENOMEM;
> +		goto out1;
> +	}
> +
> +	/* Ensure no empty attributes are created. */
> +	for (i = 0; i < sizeof(*soc_attr); i++) {
> +	        if ( soc_attr[i] != NULL ) {
> +		        soc_attr[j++] = soc_attr[i];
> +		}
> +	}
> +	for (i = j; i < sizeof(*soc_attr); i++) {
> +	        soc_attr[i] = NULL;
> +	}

Huh?

Ick, no, don't do this, that's just looney.  Use the api WE ALREADY HAVE
for this type of thing.

Sometimes I wonder why we even write core code, if people just ignore it
and try to do it on their own...

{sigh}

greg k-h
