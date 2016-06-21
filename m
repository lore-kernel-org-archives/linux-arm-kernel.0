From: hs.liao@mediatek.com (Horng-Shyang Liao)
Date: Tue, 21 Jun 2016 15:46:11 +0800
Subject: [PATCH v8 2/3] CMDQ: Mediatek CMDQ driver
In-Reply-To: <1466474580.6214.29.camel@mtksdaap41>
References: <1464578397-29743-1-git-send-email-hs.liao@mediatek.com>
 <1464578397-29743-3-git-send-email-hs.liao@mediatek.com>
 <1466419311.27959.12.camel@mtksdaap41>
 <1466421720.1918.11.camel@mtksdaap41> <1466474580.6214.29.camel@mtksdaap41>
Message-ID: <1466495171.8045.27.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2016-06-21 at 10:03 +0800, CK Hu wrote:
> On Mon, 2016-06-20 at 19:22 +0800, Horng-Shyang Liao wrote:
> > On Mon, 2016-06-20 at 18:41 +0800, CK Hu wrote:
> > > Hi, HS:
> > > 
> > > One comment inline.
> > > 
> > > On Mon, 2016-05-30 at 11:19 +0800, HS Liao wrote:
> > > > This patch is first version of Mediatek Command Queue(CMDQ) driver. The
> > > > CMDQ is used to help read/write registers with critical time limitation,
> > > > such as updating display configuration during the vblank. It controls
> > > > Global Command Engine (GCE) hardware to achieve this requirement.
> > > > Currently, CMDQ only supports display related hardwares, but we expect
> > > > it can be extended to other hardwares for future requirements.
> > > > 
> > > > Signed-off-by: HS Liao <hs.liao@mediatek.com>
> > > > Signed-off-by: CK Hu <ck.hu@mediatek.com>
> > > > ---
> > > >  drivers/soc/mediatek/Kconfig    |  10 +
> > > >  drivers/soc/mediatek/Makefile   |   1 +
> > > >  drivers/soc/mediatek/mtk-cmdq.c | 943 ++++++++++++++++++++++++++++++++++++++++
> > > >  include/soc/mediatek/cmdq.h     | 197 +++++++++
> > > >  4 files changed, 1151 insertions(+)
> > > >  create mode 100644 drivers/soc/mediatek/mtk-cmdq.c
> > > >  create mode 100644 include/soc/mediatek/cmdq.h
> > > > 
> > > > diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
> > > > index 0a4ea80..c4ad75c 100644
> > > > --- a/drivers/soc/mediatek/Kconfig
> > > > +++ b/drivers/soc/mediatek/Kconfig
> > > > @@ -1,6 +1,16 @@
> > > >  #
> > > >  # MediaTek SoC drivers
> > > >  #
> > > > +config MTK_CMDQ
> > > > +	bool "MediaTek CMDQ Support"
> > > > +	depends on ARCH_MEDIATEK || COMPILE_TEST
> > > > +	select MTK_INFRACFG
> > > > +	help
> > > > +	  Say yes here to add support for the MediaTek Command Queue (CMDQ)
> > > > +	  driver. The CMDQ is used to help read/write registers with critical
> > > > +	  time limitation, such as updating display configuration during the
> > > > +	  vblank.
> > > > +
> > > >  config MTK_INFRACFG
> > > >  	bool "MediaTek INFRACFG Support"
> > > >  	depends on ARCH_MEDIATEK || COMPILE_TEST
> > > > diff --git a/drivers/soc/mediatek/Makefile b/drivers/soc/mediatek/Makefile
> > > > index 12998b0..f7397ef 100644
> > > > --- a/drivers/soc/mediatek/Makefile
> > > > +++ b/drivers/soc/mediatek/Makefile
> > > 
> > > [Snip...]
> > > 
> > > > +
> > > > +static int cmdq_eng_get_thread(u64 flag)
> > > > +{
> > > > +	if (flag & BIT_ULL(CMDQ_ENG_DISP_DSI0))
> > > > +		return CMDQ_THR_DISP_MAIN_IDX;
> > > > +	else if (flag & BIT_ULL(CMDQ_ENG_DISP_DPI0))
> > > > +		return CMDQ_THR_DISP_SUB_IDX;
> > > > +	else
> > > > +		return CMDQ_THR_DISP_MISC_IDX;
> > > > +}
> > > 
> > > I think cmdq should not have knowledge of client. These statement show
> > > that cmdq know that DSI0-tasks is different with DPI0-tasks. I propose
> > > the 'session' to replace engine flag. For example, main display create
> > > one cmdq_session and external display create another cmdq_session. For
> > > client driver, every tasks created by main display is bound to main
> > > display session. For cmdq driver, it should dynamically bind a session
> > > to a HW thread, and then dispatch tasks of this session to this HW
> > > thread. After HW thread run out of tasks of this session, detach this
> > > session with this thread.
> > > For the problem of remove wfe cmd, I think a session can have a property
> > > of merge_wfe_cmd. For display session, session->merge_wfe_cmd = true.
> > > For other client, it's false.
> > 
> > Hi CK,
> > 
> > I think your suggestion is similar to CMDQ 'scenarios',
> > which was removed from CMDQ v2.
> > 
> > Daniel suggests to use engine flags instead of scenarios.
> > Quote from https://patchwork.kernel.org/patch/8068311/ .
> > 'Instead of encoding policy (these arbitrary "scenarios"), perhaps the
> >  cmdq driver should just provide these flag bits, and the display
> >  subsystem can use them to build the "flag" parameter itself.
> > 
> >  After all, the exact configuration of mmsys components is somewhat
> >  flexible.'
> > 
> > Therefore, it would be better to discuss with Daniel before we change
> > it.
> > 
> > 
> > Hi Daniel,
> > 
> > Do you think we should use scenarios or sessions instead of flags?
> > 
> > Thanks,
> > HS
> > 
> 
> Hi, HS:
> 
> 'session' is not similar to 'scenarios'.
> 
> In 'scenarios' mechanism, client bind a task with scenarios and send to
> cmdq. Cmdq transfer scenarios to engine flag, and use engine flag to
> dispatch task to HW thread.
> 
> 
> In 'engine flag' mechanism, proposed by Daniel, client bind a task
> directly with engine flag. Cmdq directly use engine flag to dispatch
> task to HW thread without any translation.
> 
> But neither 'scenarios' mechanism nor 'engine flag' mechanism get rid of
> engine flag, which make cmdq have knowledge of client.
> 
> In 'session' mechanism, there is no engine flag any more. Client bind
> time-sequential tasks to the same session and tasks in different session
> can execute parallelly. One thing cmdq need to know is to dispatch tasks
> with the same session to the same HW thread, so cmdq does not have any
> knowledge of client.
> 
> Daniel focus on reduce translating scenarios to engine flag. I think
> 'session' mechanism does not conflict with his opinion because we does
> not translate 'session' to engine flag. Therefore, I think 'session' is
> the best of these three mechanism.
> 
> Regards,
> CK

Hi CK,

'Session' looks like a group of options for CMDQ.
CMDQ driver can just follow the options to run its flow,
and doesn't need to know its client(s).

We don't have many options now, but it has good flexibility to extend
for future requirements.

I will add it in next version.

Thanks,
HS

> > > Here is the sample code to create cmdq_rec with session.
> > > 
> > > merge_wfe_cmd = true;
> > > cmdq_session_create(merge_wfe_cmd, &primary_display_session);
> > > cmdq_rec_create(dev, primary_display_session, &rec);
> > > 
> > > 
> > > Therefore, the below definition can be removed.
> > > 
> > > > +
> > > > +enum cmdq_eng {
> > > > +	CMDQ_ENG_DISP_AAL,
> > > > +	CMDQ_ENG_DISP_COLOR0,
> > > > +	CMDQ_ENG_DISP_COLOR1,
> > > > +	CMDQ_ENG_DISP_DPI0,
> > > > +	CMDQ_ENG_DISP_DSI0,
> > > > +	CMDQ_ENG_DISP_DSI1,
> > > > +	CMDQ_ENG_DISP_GAMMA,
> > > > +	CMDQ_ENG_DISP_OD,
> > > > +	CMDQ_ENG_DISP_OVL0,
> > > > +	CMDQ_ENG_DISP_OVL1,
> > > > +	CMDQ_ENG_DISP_PWM0,
> > > > +	CMDQ_ENG_DISP_PWM1,
> > > > +	CMDQ_ENG_DISP_RDMA0,
> > > > +	CMDQ_ENG_DISP_RDMA1,
> > > > +	CMDQ_ENG_DISP_RDMA2,
> > > > +	CMDQ_ENG_DISP_UFOE,
> > > > +	CMDQ_ENG_DISP_WDMA0,
> > > > +	CMDQ_ENG_DISP_WDMA1,
> > > > +	CMDQ_ENG_MAX,
> > > > +};
> > > > +
> > > 
> > > 
> > > Regards,
> > > CK
> > > 
> > 
> > 
> 
> 
