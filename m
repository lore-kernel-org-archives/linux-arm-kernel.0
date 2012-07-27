From: gregkh@linuxfoundation.org (Greg KH)
Date: Fri, 27 Jul 2012 10:59:39 -0700
Subject: [2/3][PATCH][v2] TDM Framework
In-Reply-To: <1343397940-12975-1-git-send-email-sandeep@freescale.com>
References: <1343397940-12975-1-git-send-email-sandeep@freescale.com>
Message-ID: <20120727175939.GA23105@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 27, 2012 at 07:35:38PM +0530, sandeep at freescale.com wrote:
> +/* Data structures required for sysfs */
> +static struct tdm_sysfs attr = {
> +	.attr.name = "use_latest_data",
> +	.attr.mode = 0664,
> +	.cmd_type = TDM_LATEST_DATA,
> +};

What is this for?

> +int tdm_sysfs_init(void)
> +{
> +	struct kobject *tdm_kobj;
> +	int err = 1;
> +	tdm_kobj = kzalloc(sizeof(*tdm_kobj), GFP_KERNEL);
> +	if (tdm_kobj) {
> +		kobject_init(tdm_kobj, &tdm_type);
> +		if (kobject_add(tdm_kobj, NULL, "%s", "tdm")) {
> +			pr_err("tdm: Sysfs creation failed\n");
> +			kobject_put(tdm_kobj);
> +			err = -EINVAL;
> +			goto out;
> +		}
> +	} else {
> +		pr_err("tdm: Unable to allocate tdm_kobj\n");
> +		err = -ENOMEM;
> +		goto out;
> +	}
> +
> +out:
> +	return err;
> +}

You just leaked memory, what are you trying to do here?

And why are you using "raw" kobjects?  That's a sure sign that something
is really wrong.

Your code doesn't look like it is tied into the driver model at all, why
not?  What are you trying to do here?

Also, when creating new sysfs entries, like you are attempting to do
here (unsuccessfully I might add), you must create Documentation/ABI/
files as well.

And, to top it all off, you do realize you are asking us to do code
review in the middle of the merge window, when we are all busy doing
other things?

greg k-h
