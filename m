From: broonie@kernel.org (Mark Brown)
Date: Thu, 19 Feb 2015 19:27:50 +0900
Subject: [PATCH 1/2] regmap: Add range check in _regmap_raw_read()
In-Reply-To: <1424335239-7475-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1424335193-7431-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1424335239-7475-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <20150219102750.GC3198@finisterre.sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 19, 2015 at 08:40:39AM +0000, Srinivas Kandagatla wrote:

> +	/* Check for readable registers before we start */
> +	for (i = 0; i < count; i++)
> +		if (!regmap_readable(map, reg + (i * map->reg_stride)))
> +			return -EINVAL;

That's starting to look pretty expensive especially if what we're
looking for is just max_register really...  This is one of the reasons
we're not religious about checking for readability everywhere, and
obviously even if we avoid triggering this particular thing we still
have to cope with both the caller and devices that didn't specify
readability.  A cheaper check for just max_register would be less
concerning but it feels like we're trying to paper over a symptom with
this rather than fix a problem.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150219/11ae3d1f/attachment.sig>
