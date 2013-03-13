From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 13 Mar 2013 10:09:49 +0000
Subject: [PATCH v3] ARM: tegra: expose chip ID and revision
In-Reply-To: <1363168080-12697-1-git-send-email-dahuang@nvidia.com>
References: <1363168080-12697-1-git-send-email-dahuang@nvidia.com>
Message-ID: <20130313100949.GA4977@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 13, 2013 at 05:48:00PM +0800, Danny Huang wrote:
> +	soc_dev = soc_device_register(soc_dev_attr);
> +	if (IS_ERR(soc_dev)) {
> +		kfree(soc_dev_attr->soc_id);
> +		kfree(soc_dev_attr->revision);
> +		kfree(soc_dev_attr->family);
> +		kfree(soc_dev_attr);
> +		goto out;
> +	}
> +
> +	parent = soc_device_to_device(soc_dev);
> +	if (IS_ERR(parent))
> +		parent = NULL;

I know other places have done this kind of thing but what use is it?

struct device *soc_device_to_device(struct soc_device *soc_dev)
{
        return &soc_dev->dev;
}

Now, consider that soc_device_register() returns one of two things:
1. A valid pointer - it must be valid, because soc_device_register()
   already dereferences it.
2. An error pointer, trappable with IS_ERR().

You are trapping it with IS_ERR() - that's good news.  So, by the time
we get to soc_device_to_device(), we know that it _is_ a valid pointer.
So why would soc_device_to_device() return an error pointer?
