From: ck.hu@mediatek.com (CK Hu)
Date: Thu, 23 Jun 2016 14:03:49 +0800
Subject: [PATCH v8 2/3] CMDQ: Mediatek CMDQ driver
In-Reply-To: <1464578397-29743-3-git-send-email-hs.liao@mediatek.com>
References: <1464578397-29743-1-git-send-email-hs.liao@mediatek.com>
 <1464578397-29743-3-git-send-email-hs.liao@mediatek.com>
Message-ID: <1466661829.15112.26.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, HS:

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

[...]

> +
> +/* events for CMDQ and display */
> +enum cmdq_event {
> +	/* Display start of frame(SOF) events */
> +	CMDQ_EVENT_DISP_OVL0_SOF = 11,
> +	CMDQ_EVENT_DISP_OVL1_SOF = 12,
> +	CMDQ_EVENT_DISP_RDMA0_SOF = 13,
> +	CMDQ_EVENT_DISP_RDMA1_SOF = 14,
> +	CMDQ_EVENT_DISP_RDMA2_SOF = 15,
> +	CMDQ_EVENT_DISP_WDMA0_SOF = 16,
> +	CMDQ_EVENT_DISP_WDMA1_SOF = 17,
> +	/* Display end of frame(EOF) events */
> +	CMDQ_EVENT_DISP_OVL0_EOF = 39,
> +	CMDQ_EVENT_DISP_OVL1_EOF = 40,
> +	CMDQ_EVENT_DISP_RDMA0_EOF = 41,
> +	CMDQ_EVENT_DISP_RDMA1_EOF = 42,
> +	CMDQ_EVENT_DISP_RDMA2_EOF = 43,
> +	CMDQ_EVENT_DISP_WDMA0_EOF = 44,
> +	CMDQ_EVENT_DISP_WDMA1_EOF = 45,
> +	/* Mutex end of frame(EOF) events */
> +	CMDQ_EVENT_MUTEX0_STREAM_EOF = 53,
> +	CMDQ_EVENT_MUTEX1_STREAM_EOF = 54,
> +	CMDQ_EVENT_MUTEX2_STREAM_EOF = 55,
> +	CMDQ_EVENT_MUTEX3_STREAM_EOF = 56,
> +	CMDQ_EVENT_MUTEX4_STREAM_EOF = 57,
> +	/* Display underrun events */
> +	CMDQ_EVENT_DISP_RDMA0_UNDERRUN = 63,
> +	CMDQ_EVENT_DISP_RDMA1_UNDERRUN = 64,
> +	CMDQ_EVENT_DISP_RDMA2_UNDERRUN = 65,
> +	/* Keep this at the end of HW events */
> +	CMDQ_MAX_HW_EVENT_COUNT = 260,
> +};

The value of these symbol is just the GCE-HW-defined value. I think it's
not appropriate to expose HW-defined value to client. For another SoC
GCE HW, these definition may change.

One way to solve this problem is to translate symbol to value
internally. But these events looks like interrupt and the value may vary
by each SoC, to prevent driver modified frequently, it's better to place
the value definition in device tree. It may looks like:

mmsys: clock-controller at 14000000 {
	compatible = "mediatek,mt8173-mmsys";
	mediatek,gce = <&gce>;
	gce-events = <53 54>;
	gce-event-names = "MUTEX0_EOF","MUTEX1_EOF";
}

For cmdq driver, you just need modify interface from

int cmdq_rec_wfe(struct cmdq_rec *rec, enum cmdq_event event)
int cmdq_rec_clear_event(struct cmdq_rec *rec, enum cmdq_event event)

to

int cmdq_rec_wfe(struct cmdq_rec *rec, u32 event)
int cmdq_rec_clear_event(struct cmdq_rec *rec, u32 event)

Regards,
CK
