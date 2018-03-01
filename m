From: broonie@kernel.org (Mark Brown)
Date: Thu, 1 Mar 2018 21:04:28 +0000
Subject: [PATCH v3 03/25] ASoC: qcom: qdsp6: Add common qdsp6 helper
 functions
In-Reply-To: <20180213165837.1620-4-srinivas.kandagatla@linaro.org>
References: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
 <20180213165837.1620-4-srinivas.kandagatla@linaro.org>
Message-ID: <20180301210428.GS12864@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 13, 2018 at 04:58:15PM +0000, srinivas.kandagatla at linaro.org wrote:

> +config SND_SOC_QDSP6_COMMON
> +	tristate
> +	default n
> +

Ah, the other default n that had snuck in was actually in an earlier
patch in the series!  I'm fairly sure this has come up with earlier
drivers you've submitted...

> +int q6dsp_map_channels(u8 ch_map[PCM_FORMAT_MAX_NUM_CHANNEL], int ch)
> +{
> +	memset(ch_map, 0, PCM_FORMAT_MAX_NUM_CHANNEL);
> +
> +	switch (ch) {
> +	case 1:
> +			ch_map[0] = PCM_CHANNEL_FC;
> +		break;
> +	case 2:
> +			ch_map[0] = PCM_CHANNEL_FL;
> +			ch_map[1] = PCM_CHANNEL_FR;
> +		break;

That's some really funky indentation there...

> +static inline int q6dsp_errno(u32 error)
> +{
> +	int ret = -EINVAL;
> +
> +	if (error <= ARRAY_SIZE(q6dsp_err_codes))
> +		ret = q6dsp_err_codes[error].lnx_err_code;
> +
> +	return ret;
> +}

Is the error handling such a hot path that we need to make the lookup
functions (and the data table with the lookups) static inlines in a
header or could we just move the functions and the data into a C file?
Especially given the string lookups for the errors (which are really
nice to have) it seems wasteful.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180301/ab78fadb/attachment.sig>
