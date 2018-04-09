From: rohitkr@codeaurora.org (Rohit Kumar)
Date: Mon, 9 Apr 2018 17:23:58 +0530
Subject: [alsa-devel] [PATCH v4 14/24] ASoC: qdsp6: q6asm: Add support to
 audio stream apis
In-Reply-To: <20180310022456.26739-15-srinivas.kandagatla@linaro.org>
References: <20180310022456.26739-1-srinivas.kandagatla@linaro.org>
 <20180310022456.26739-15-srinivas.kandagatla@linaro.org>
Message-ID: <3661b4c5-c79d-d73e-5e95-57e849775517@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 3/10/2018 7:54 AM, srinivas.kandagatla at linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>
> This patch adds support to open, write and media format commands
> in the q6asm module.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-and-Tested-by: Rohit kumar <rohitkr@codeaurora.org>
> ---
>   sound/soc/qcom/qdsp6/q6asm.c | 744 ++++++++++++++++++++++++++++++++++++++++++-
>   sound/soc/qcom/qdsp6/q6asm.h |  49 +++
>   2 files changed, 792 insertions(+), 1 deletion(-)
>
> diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
> index 8a2ca2ff9ce8..ddbf526358bd 100644
> --- a/sound/soc/qcom/qdsp6/q6asm.c
> +++ b/sound/soc/qcom/qdsp6/q6asm.c
> @@ -9,6 +9,8 @@
>   #include <linux/device.h>
>   #include <linux/spinlock.h>
>   #include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <uapi/sound/asound.h>
>   #include <linux/delay.h>
>   #include <linux/slab.h>
>   #include <linux/mm.h>
> @@ -17,10 +19,36 @@
>   #include "q6dsp-errno.h"
>   #include "q6dsp-common.h"
>   
> +#define ASM_STREAM_CMD_CLOSE			0x00010BCD
> +#define ASM_STREAM_CMD_FLUSH			0x00010BCE
> +#define ASM_SESSION_CMD_PAUSE			0x00010BD3
> +#define ASM_DATA_CMD_EOS			0x00010BDB
> +#define ASM_DEFAULT_POPP_TOPOLOGY		0x00010BE4
Use NULL topology instead of default topology.
#define ASM_NULL_POPP_TOPOLOGY???????????????????? 0x00010C68
> +#define ASM_STREAM_CMD_FLUSH_READBUFS		0x00010C09
> +#define ASM_STREAM_CMD_SET_ENCDEC_PARAM		0x00010C10
[..]
> +	q6asm_add_hdr(ac, &open.hdr, sizeof(open), true, ac->stream_id);
> +
> +	open.hdr.opcode = ASM_STREAM_CMD_OPEN_WRITE_V3;
> +	open.mode_flags = 0x00;
> +	open.mode_flags |= ASM_LEGACY_STREAM_SESSION;
> +
> +	/* source endpoint : matrix */
> +	open.sink_endpointype = ASM_END_POINT_DEVICE_MATRIX;
> +	open.bits_per_sample = bits_per_sample;
> +	open.postprocopo_id = ASM_DEFAULT_POPP_TOPOLOGY;
 ?open.postprocopo_id = ASM_NULL_POPP_TOPOLOGY;
> +
> +	switch (format) {
> +	case FORMAT_LINEAR_PCM:
> +		open.dec_fmt_id = ASM_MEDIA_FMT_MULTI_CHANNEL_PCM_V2;
> +		break;
> +	default:
> +		dev_err(ac->dev, "Invalid format 0x%x\n", format);
> +		return -EINVAL;
> +	}
> +
> +	rc = q6asm_ac_send_cmd_sync(ac, &open);
> +	if (rc < 0)
> +		return rc;
> +
> +	ac->io_mode |= ASM_TUN_WRITE_IO_MODE;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(q6asm_open_write);
