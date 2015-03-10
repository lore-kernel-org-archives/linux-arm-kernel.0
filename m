From: broonie@kernel.org (Mark Brown)
Date: Tue, 10 Mar 2015 12:07:50 +0000
Subject: [PATCH 1/3] regulator: don't emit errors in
 {devm_}regulator_bulk_get when defering
In-Reply-To: <9261130.uPvufuEFrr@phil>
References: <1429128.MSqYm0qZ9p@phil>
 <9261130.uPvufuEFrr@phil>
Message-ID: <20150310120750.GE28806@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 10, 2015 at 12:22:06AM +0100, Heiko Stuebner wrote:
> When {devm_}regulator_get returns -EPROBE_DEFER the driver in question will
> try probing again at a later time. So don't spam the log with failure messages
> as this is an expected result of probe ordering.

> -			dev_err(dev, "Failed to get supply '%s': %d\n",
> -				consumers[i].supply, ret);
> +			if (ret != -EPROBE_DEFER)
> +				dev_err(dev, "Failed to get supply '%s': %d\n",
> +					consumers[i].supply, ret);

No, this is not good - you get a nice quiet boot even if the regulator
does not appear which means people have no idea why the driver isn't
loading.  That's not a good user experience, silent error handling is
the main problem I see people running into trying to get their systems
up and running these days.

Really deferred probe is just fundamentally noisy since it's
intentionally tolerating errors like this and of course a lot of the
noise comes from the deferral messages the core prints.

This is also not really connected to the series you're posting it in...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150310/c9524731/attachment-0001.sig>
