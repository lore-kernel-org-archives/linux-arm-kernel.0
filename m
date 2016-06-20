From: ck.hu@mediatek.com (CK Hu)
Date: Mon, 20 Jun 2016 18:41:51 +0800
Subject: [PATCH v8 2/3] CMDQ: Mediatek CMDQ driver
In-Reply-To: <1464578397-29743-3-git-send-email-hs.liao@mediatek.com>
References: <1464578397-29743-1-git-send-email-hs.liao@mediatek.com>
 <1464578397-29743-3-git-send-email-hs.liao@mediatek.com>
Message-ID: <1466419311.27959.12.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, HS:

One comment inline.

On Mon, 2016-05-30 at 11:19 +0800, HS Liao wrote:
> This patch is first version of Mediatek Command Queue(CMDQ) driver. The
> CMDQ is used to help read/write registers with critical time limitation,
> such as updating display configuration during the vblank. It controls
> Global Command Engine (GCE) hardware to achieve this requirement.
> Currently, CMDQ only supports display related hardwares, but we expect
> it can be extended to other hardwares for future requirements.
> 
> Signed-off-by: HS Liao <hs.liao@mediatek.com>
> Signed-off-by: CK Hu <ck.hu@mediatek.com>
> ---
>  drivers/soc/mediatek/Kconfig    |  10 +
>  drivers/soc/mediatek/Makefile   |   1 +
>  drivers/soc/mediatek/mtk-cmdq.c | 943 ++++++++++++++++++++++++++++++++++++++++
>  include/soc/mediatek/cmdq.h     | 197 +++++++++
>  4 files changed, 1151 insertions(+)
>  create mode 100644 drivers/soc/mediatek/mtk-cmdq.c
>  create mode 100644 include/soc/mediatek/cmdq.h
> 
> diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
> index 0a4ea80..c4ad75c 100644
> --- a/drivers/soc/mediatek/Kconfig
> +++ b/drivers/soc/mediatek/Kconfig
> @@ -1,6 +1,16 @@
>  #
>  # MediaTek SoC drivers
>  #
> +config MTK_CMDQ
> +	bool "MediaTek CMDQ Support"
> +	depends on ARCH_MEDIATEK || COMPILE_TEST
> +	select MTK_INFRACFG
> +	help
> +	  Say yes here to add support for the MediaTek Command Queue (CMDQ)
> +	  driver. The CMDQ is used to help read/write registers with critical
> +	  time limitation, such as updating display configuration during the
> +	  vblank.
> +
>  config MTK_INFRACFG
>  	bool "MediaTek INFRACFG Support"
>  	depends on ARCH_MEDIATEK || COMPILE_TEST
> diff --git a/drivers/soc/mediatek/Makefile b/drivers/soc/mediatek/Makefile
> index 12998b0..f7397ef 100644
> --- a/drivers/soc/mediatek/Makefile
> +++ b/drivers/soc/mediatek/Makefile

[Snip...]

> +
> +static int cmdq_eng_get_thread(u64 flag)
> +{
> +	if (flag & BIT_ULL(CMDQ_ENG_DISP_DSI0))
> +		return CMDQ_THR_DISP_MAIN_IDX;
> +	else if (flag & BIT_ULL(CMDQ_ENG_DISP_DPI0))
> +		return CMDQ_THR_DISP_SUB_IDX;
> +	else
> +		return CMDQ_THR_DISP_MISC_IDX;
> +}

I think cmdq should not have knowledge of client. These statement show
that cmdq know that DSI0-tasks is different with DPI0-tasks. I propose
the 'session' to replace engine flag. For example, main display create
one cmdq_session and external display create another cmdq_session. For
client driver, every tasks created by main display is bound to main
display session. For cmdq driver, it should dynamically bind a session
to a HW thread, and then dispatch tasks of this session to this HW
thread. After HW thread run out of tasks of this session, detach this
session with this thread.
For the problem of remove wfe cmd, I think a session can have a property
of merge_wfe_cmd. For display session, session->merge_wfe_cmd = true.
For other client, it's false.

Here is the sample code to create cmdq_rec with session.

merge_wfe_cmd = true;
cmdq_session_create(merge_wfe_cmd, &primary_display_session);
cmdq_rec_create(dev, primary_display_session, &rec);


Therefore, the below definition can be removed.

> +
> +enum cmdq_eng {
> +	CMDQ_ENG_DISP_AAL,
> +	CMDQ_ENG_DISP_COLOR0,
> +	CMDQ_ENG_DISP_COLOR1,
> +	CMDQ_ENG_DISP_DPI0,
> +	CMDQ_ENG_DISP_DSI0,
> +	CMDQ_ENG_DISP_DSI1,
> +	CMDQ_ENG_DISP_GAMMA,
> +	CMDQ_ENG_DISP_OD,
> +	CMDQ_ENG_DISP_OVL0,
> +	CMDQ_ENG_DISP_OVL1,
> +	CMDQ_ENG_DISP_PWM0,
> +	CMDQ_ENG_DISP_PWM1,
> +	CMDQ_ENG_DISP_RDMA0,
> +	CMDQ_ENG_DISP_RDMA1,
> +	CMDQ_ENG_DISP_RDMA2,
> +	CMDQ_ENG_DISP_UFOE,
> +	CMDQ_ENG_DISP_WDMA0,
> +	CMDQ_ENG_DISP_WDMA1,
> +	CMDQ_ENG_MAX,
> +};
> +


Regards,
CK
