From: ck.hu@mediatek.com (CK Hu)
Date: Thu, 28 Jun 2018 09:07:08 +0800
Subject: [PATCH v21 4/4] soc: mediatek: Add Mediatek CMDQ helper
In-Reply-To: <1530099833.31725.7.camel@mhfsdcap03>
References: <1517383693-25591-1-git-send-email-houlong.wei@mediatek.com>
 <1517383693-25591-5-git-send-email-houlong.wei@mediatek.com>
 <1519200345.8716.68.camel@mtksdaap41> <1530099833.31725.7.camel@mhfsdcap03>
Message-ID: <1530148028.6193.9.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Houlong:

On Wed, 2018-06-27 at 19:43 +0800, houlong wei wrote:
> On Wed, 2018-02-21 at 16:05 +0800, CK Hu wrote:
> > Hi, Houlong:
> > 
> > I've one more inline comment.
> > 
> > On Wed, 2018-01-31 at 15:28 +0800, houlong.wei at mediatek.com wrote:
> > > From: "hs.liao at mediatek.com" <hs.liao@mediatek.com>
> > > 
> > > Add Mediatek CMDQ helper to create CMDQ packet and assemble GCE op code.
> > > 
> > > Signed-off-by: Houlong Wei <houlong.wei@mediatek.com>
> > > Signed-off-by: HS Liao <hs.liao@mediatek.com>
> > > ---
> > >  drivers/soc/mediatek/Kconfig           |   12 ++
> > >  drivers/soc/mediatek/Makefile          |    1 +
> > >  drivers/soc/mediatek/mtk-cmdq-helper.c |  322 ++++++++++++++++++++++++++++++++
> > >  include/linux/soc/mediatek/mtk-cmdq.h  |  174 +++++++++++++++++
> > >  4 files changed, 509 insertions(+)
> > >  create mode 100644 drivers/soc/mediatek/mtk-cmdq-helper.c
> > >  create mode 100644 include/linux/soc/mediatek/mtk-cmdq.h
> > > 
> > > diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
> > > index a7d0667..e66582e 100644
> > > --- a/drivers/soc/mediatek/Kconfig
> > > +++ b/drivers/soc/mediatek/Kconfig
> > > @@ -4,6 +4,18 @@
> > >  menu "MediaTek SoC drivers"
> > >  	depends on ARCH_MEDIATEK || COMPILE_TEST
> > >  

[...]

> > > +
> > > +static int cmdq_pkt_append_command(struct cmdq_pkt *pkt, enum cmdq_code code,
> > > +				   u32 arg_a, u32 arg_b)
> > > +{
> > > +	u64 *cmd_ptr;
> > > +	int err;
> > > +
> > > +	if (WARN_ON(cmdq_pkt_is_finalized(pkt)))
> > > +		return -EBUSY;
> > > +	if (unlikely(pkt->cmd_buf_size + CMDQ_INST_SIZE > pkt->buf_size)) {
> > > +		err = cmdq_pkt_realloc_cmd_buffer(pkt, pkt->buf_size << 1);
> > 
> > In your design, the command buffer is frequently allocated and freed.
> > But client may not want this mechanism because it have penalty on CPU
> > loading and may have risk of allocation failure. The client may
> > pre-allocate the command buffer and reuse it. So it's better to let
> > client decide which buffer management it want. That means cmdq helper do
> > not allocate command buffer and do not reallocate it. The working flow
> > would be:
> > 
> > For client that want to pre-allocate buffer:
> > (1) Client pre-allocate a command buffer with a pre-calculated size.
> > (Programmer should make sure that all command would not exceed this
> > size)
> > (2) Client use cmdq helper function to generate command in command
> > buffer. If command buffer is full, helper still increase
> > pkt->cmd_buf_size but do not write command into command buffer.
> > (3) When client flush packet, cmdq helper could check whether
> > pkt->cmd_buf_size is greater than pkt->buf_size, if so, return error and
> > programmer should modify the pre-calculated size in step (1).
> > (4) Wait for command done.
> > (5) Set pkt->cmd_buf_size to zero and directly goto step (2) to reuse
> > this command buffer.
> > 
> > For client that want to dynamically allocate buffer:
> > (1) Client dynamically allocate a command buffer with a initial size,
> > for example, 1024 bytes.
> > (2) Client use cmdq helper function to generate command in command
> > buffer. If command buffer is full, helper still increase
> > pkt->cmd_buf_size but do not write command into command buffer.
> > (3) When client flush packet, cmdq helper could check whether
> > pkt->cmd_buf_size is greater than pkt->buf_size, if so, return error and
> > client goto step (1) and reallocate a command buffer with pkt->buf_size.
> > (4) Wait for command done.
> > (5) Free the command buffer.
> > 
> > Because the reallocation is so complicated, for client that want to
> > dynamically allocate buffer, the initial buffer size could also be
> > pre-calculated that you need not to reallocate it. Once the buffer is
> > full, programmer should also fix the accurate buffer size.
> > 
> > Regards,
> > CK
> > 
> 
> Hi CK, thanks for your explanation and suggestion. Currently, the cmdq
> buffer is allocated in cmdq_pkt_create and its initial size is
> PAGE_SIZE. In most case of display scenario, PAGE_SIZE(4096) bytes are
> enough.
> 

You use the tern 'most' means you still need to consider the size over
PAGE_SIZE. If in current application, PAGE_SIZE is enough for display, I
think you still should remove this reallocation in the first patch
because you need not to reallocation. Once the display need more than
PAGE_SIZE, you send the another patch that support client to set the
initial size. I think we should make the first patch as simple as
possible, and you could add another patch to improve it.

Regards,
CK

> > > +		if (err < 0)
> > > +			return err;
> > > +	}
> > > +	cmd_ptr = pkt->va_base + pkt->cmd_buf_size;
> > > +	(*cmd_ptr) = (u64)((code << CMDQ_OP_CODE_SHIFT) | arg_a) << 32 | arg_b;
> > > +	pkt->cmd_buf_size += CMDQ_INST_SIZE;
> > > +	return 0;
> > > +}
> > > +

[...]
> 
> 
