From: hs.liao@mediatek.com (Horng-Shyang Liao)
Date: Thu, 23 Jun 2016 15:54:40 +0800
Subject: [PATCH v8 2/3] CMDQ: Mediatek CMDQ driver
In-Reply-To: <1466661829.15112.26.camel@mtksdaap41>
References: <1464578397-29743-1-git-send-email-hs.liao@mediatek.com>
 <1464578397-29743-3-git-send-email-hs.liao@mediatek.com>
 <1466661829.15112.26.camel@mtksdaap41>
Message-ID: <1466668480.12124.15.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi CK,

On Thu, 2016-06-23 at 14:03 +0800, CK Hu wrote:
> Hi, HS:
> 
> On Mon, 2016-05-30 at 11:19 +0800, HS Liao wrote:
> [...]
> 
> > +
> > +/* events for CMDQ and display */
> > +enum cmdq_event {
> > +	/* Display start of frame(SOF) events */
> > +	CMDQ_EVENT_DISP_OVL0_SOF = 11,
> > +	CMDQ_EVENT_DISP_OVL1_SOF = 12,
> > +	CMDQ_EVENT_DISP_RDMA0_SOF = 13,
> > +	CMDQ_EVENT_DISP_RDMA1_SOF = 14,
> > +	CMDQ_EVENT_DISP_RDMA2_SOF = 15,
> > +	CMDQ_EVENT_DISP_WDMA0_SOF = 16,
> > +	CMDQ_EVENT_DISP_WDMA1_SOF = 17,
> > +	/* Display end of frame(EOF) events */
> > +	CMDQ_EVENT_DISP_OVL0_EOF = 39,
> > +	CMDQ_EVENT_DISP_OVL1_EOF = 40,
> > +	CMDQ_EVENT_DISP_RDMA0_EOF = 41,
> > +	CMDQ_EVENT_DISP_RDMA1_EOF = 42,
> > +	CMDQ_EVENT_DISP_RDMA2_EOF = 43,
> > +	CMDQ_EVENT_DISP_WDMA0_EOF = 44,
> > +	CMDQ_EVENT_DISP_WDMA1_EOF = 45,
> > +	/* Mutex end of frame(EOF) events */
> > +	CMDQ_EVENT_MUTEX0_STREAM_EOF = 53,
> > +	CMDQ_EVENT_MUTEX1_STREAM_EOF = 54,
> > +	CMDQ_EVENT_MUTEX2_STREAM_EOF = 55,
> > +	CMDQ_EVENT_MUTEX3_STREAM_EOF = 56,
> > +	CMDQ_EVENT_MUTEX4_STREAM_EOF = 57,
> > +	/* Display underrun events */
> > +	CMDQ_EVENT_DISP_RDMA0_UNDERRUN = 63,
> > +	CMDQ_EVENT_DISP_RDMA1_UNDERRUN = 64,
> > +	CMDQ_EVENT_DISP_RDMA2_UNDERRUN = 65,
> > +	/* Keep this at the end of HW events */
> > +	CMDQ_MAX_HW_EVENT_COUNT = 260,
> > +};
> 
> The value of these symbol is just the GCE-HW-defined value. I think it's
> not appropriate to expose HW-defined value to client. For another SoC
> GCE HW, these definition may change.

Agree.

> One way to solve this problem is to translate symbol to value
> internally. But these events looks like interrupt and the value may vary
> by each SoC, to prevent driver modified frequently, it's better to place
> the value definition in device tree. It may looks like:
> 
> mmsys: clock-controller at 14000000 {
> 	compatible = "mediatek,mt8173-mmsys";
> 	mediatek,gce = <&gce>;
> 	gce-events = <53 54>;

However, client still needs to know the HW-defined value by using
this solution.

> 	gce-event-names = "MUTEX0_EOF","MUTEX1_EOF";
> }
> 
> For cmdq driver, you just need modify interface from
> 
> int cmdq_rec_wfe(struct cmdq_rec *rec, enum cmdq_event event)
> int cmdq_rec_clear_event(struct cmdq_rec *rec, enum cmdq_event event)
> 
> to
> 
> int cmdq_rec_wfe(struct cmdq_rec *rec, u32 event)
> int cmdq_rec_clear_event(struct cmdq_rec *rec, u32 event)

I think an easy way for this issue is just removing HW-defined values
from include/soc/mediatek/cmdq.h (but keeping enum), and then mapping
abstract values into real values in driver.
The benefit of this solution is that we can keep interface and leave SoC
specific code into driver.
What do you think?

> Regards,
> CK

Thanks,
HS
