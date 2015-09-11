From: broonie@kernel.org (Mark Brown)
Date: Fri, 11 Sep 2015 13:04:08 +0100
Subject: [PATCH v4 01/22] driver core: Add pre_probe callback to bus_type
In-Reply-To: <1441628627-5143-2-git-send-email-tomeu.vizoso@collabora.com>
References: <1441628627-5143-1-git-send-email-tomeu.vizoso@collabora.com>
 <1441628627-5143-2-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <20150911120408.GO12027@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 07, 2015 at 02:23:26PM +0200, Tomeu Vizoso wrote:

> +	if (dev->bus && dev->bus->pre_probe) {
> +		ret = dev->bus->pre_probe(dev);
> +		if (ret) {
> +			if (ret == -EPROBE_DEFER)
> +				driver_deferred_probe_add(dev);
> +			ret = 0;
> +			goto out_unlock;
> +		}
> +	}

So if we get an error other than -EPROBE_DEFER we silently ignore it?
That seems surprising and at least worth a comment.

> +	if (dev->bus && dev->bus->pre_probe) {
> +		ret = dev->bus->pre_probe(dev);
> +		if (ret) {
> +			if (ret == -EPROBE_DEFER)
> +				driver_deferred_probe_add(dev);
> +			goto out;
> +		}
> +	}

That's more what I'd expect.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150911/58e60497/attachment.sig>
