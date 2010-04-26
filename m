From: ben-linux@fluff.org (Ben Dooks)
Date: Mon, 26 Apr 2010 08:09:24 +0100
Subject: [PATCH 1/7] PL330: Add common core driver\
In-Reply-To: <o2m1b68c6791004252320j40360bc3x849eeeefe25fb49@mail.gmail.com>
References: <1271834848-29179-1-git-send-email-jassisinghbrar@gmail.com>
	<20100426045420.GH28105@trinity.fluff.org>
	<o2m1b68c6791004252320j40360bc3x849eeeefe25fb49@mail.gmail.com>
Message-ID: <20100426070924.GH6684@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 26, 2010 at 03:20:59PM +0900, jassi brar wrote:
> On Mon, Apr 26, 2010 at 1:54 PM, Ben Dooks <ben-linux@fluff.org> wrote:
> > On Wed, Apr 21, 2010 at 04:27:28PM +0900, jassisinghbrar at gmail.com wrote:
> >> From: Jassi Brar <jassi.brar@samsung.com>
> 
> .....
> 
> >> +
> >> +#define _FTC ? ? ? ? 0x40
> >> +#define FTC(n) ? ? ? ? ? ? ? (_FTC + (n)*0x4)
> >> +
> >> +#define _CS ? ? ? ? ?0x100
> >> +#define CS(n) ? ? ? ? ? ? ? ?(_CS + (n)*0x8)
> >> +#define CS_CNS ? ? ? ? ? ? ? (1 << 21)
> >> +
> >> +#define _CPC ? ? ? ? 0x104
> >> +#define CPC(n) ? ? ? ? ? ? ? (_CPC + (n)*0x8)
> >> +
> >> +#define _SA ? ? ? ? ?0x400
> >> +#define SA(n) ? ? ? ? ? ? ? ?(_SA + (n)*0x20)
> >> +
> >> +#define _DA ? ? ? ? ?0x404
> >> +#define DA(n) ? ? ? ? ? ? ? ?(_DA + (n)*0x20)
> >> +
> >> +#define _CC ? ? ? ? ?0x408
> >> +#define CC(n) ? ? ? ? ? ? ? ?(_CC + (n)*0x20)
> >> +
> >> +#define CC_SRCINC ? ?(1 << 0)
> >> +#define CC_DSTINC ? ?(1 << 14)
> >> +#define CC_SRCPRI ? ?(1 << 8)
> >> +#define CC_DSTPRI ? ?(1 << 22)
> >> +#define CC_SRCNS ? ? (1 << 9)
> >> +#define CC_DSTNS ? ? (1 << 23)
> >> +#define CC_SRCIA ? ? (1 << 10)
> >> +#define CC_DSTIA ? ? (1 << 24)
> >> +#define CC_SRCBRSTLEN_SHFT ? 4
> >> +#define CC_DSTBRSTLEN_SHFT ? 18
> >> +#define CC_SRCBRSTSIZE_SHFT ?1
> >> +#define CC_DSTBRSTSIZE_SHFT ?15
> >> +#define CC_SRCCCTRL_SHFT ? ? 11
> >> +#define CC_SRCCCTRL_MASK ? ? 0x7
> >> +#define CC_DSTCCTRL_SHFT ? ? 25
> >> +#define CC_DRCCCTRL_MASK ? ? 0x7
> >> +#define CC_SWAP_SHFT 28
> >> +
> >> +#define _LC0 ? ? ? ? 0x40c
> >> +#define LC0(n) ? ? ? ? ? ? ? (_LC0 + (n)*0x20)
> >> +
> >> +#define _LC1 ? ? ? ? 0x410
> >> +#define LC1(n) ? ? ? ? ? ? ? (_LC1 + (n)*0x20)
> >
> > do we really need the _ versions of each of these, or can
> > they be merged into thier non _ counterparts?
> Yes, they could be merged.
> 
> .....
> 
> >> +#define CR0_PERIPH_REQ_SET ? (1 << 0)
> >> +#define CR0_BOOT_EN_SET ? ? ? ? ? ? ?(1 << 1)
> >> +#define CR0_BOOT_MAN_NS ? ? ? ? ? ? ?(1 << 2)
> >> +#define CR0_NUM_CHANS_SHIFT ?4
> >> +#define CR0_NUM_CHANS_MASK ? 0x7
> >> +#define CR0_NUM_PERIPH_SHIFT 12
> >> +#define CR0_NUM_PERIPH_MASK ?0x1f
> >> +#define CR0_NUM_EVENTS_SHIFT 17
> >> +#define CR0_NUM_EVENTS_MASK ?0x1f
> >> +
> >> +#define CR1_ICACHE_LEN_SHIFT 0
> >> +#define CR1_ICACHE_LEN_MASK ?0x7
> >> +#define CR1_NUM_ICACHELINES_SHIFT ? ?4
> >> +#define CR1_NUM_ICACHELINES_MASK ? ? 0xf
> >
> > are these aligned, or is it my mail client ignoring the formatting?
> They are aligned. Maybe it's your mail client.

Ok, hope to sort this out once the computer is fixed.

> ........
> 
> >> +
> >> +/*
> >> + * Mark a _pl330_req as free.
> >> + * We do it by writing DMAEND as the first instruction
> >> + * because no valid request is going to have DMAEND as
> >> + * its first instruction to execute.
> >> + */
> >> +#define MARK_FREE(req) ? ? ? do { \
> >> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? _emit_END(0, (req)->mc_cpu); \
> >> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? (req)->mc_len = 0; \
> >> + ? ? ? ? ? ? ? ? ? ? } while (0)
> >
> > I think inline functions for these would be easier to read.
> you mean alignment that we see here? it's actually correctly
> aligned in an editor.

firstly, on the grounds it avoids the whole \
and secondly on the grounds inline functions get checked by the compiler
whether they're used or not.

I belive any macro over a couple of lines is probably doing too much
work.

> .....
> 
> >> +struct _xfer_spec {
> >> + ? ? u32 ccr;
> >> + ? ? struct pl330_req *r;
> >> + ? ? struct pl330_xfer *x;
> >> +};
> >
> > would have been nice to kerneldoc this or at-least document it.
> It is totally an internal and temporary thing made only to have to
> not pass three args. Except for the func that use it, it doesn't matter
> to any other part.
> 
> .....
> 
> >> +static inline bool _queue_empty(struct pl330_thread *thrd)
> >> +{
> >> + ? ? return (IS_FREE(&thrd->req[0]) && IS_FREE(&thrd->req[1]))
> >> + ? ? ? ? ? ? ? true : false;
> >> +}
> >> +
> >> +static inline bool _queue_full(struct pl330_thread *thrd)
> >> +{
> >> + ? ? return (IS_FREE(&thrd->req[0]) || IS_FREE(&thrd->req[1]))
> >> + ? ? ? ? ? ? ? false : true;
> >> +}
> >
> > return !(IS_FREE(&thrd->req[0]) || IS_FREE(&thrd->req[1]) should
> > also work here.
> Of course.
> sometimes some people have an itch to return a 'true' or 'false'
> for a function that returns bool :)

ok, but that's one strange itch. you should go see a doctor.

> .....
> 
> >> +
> >> +static inline u32 _emit_ADDH(unsigned dry_run, u8 buf[],
> >> + ? ? ? ? ? ? enum pl330_dst da, u16 val)
> >> +{
> >
> > think that should be u8 *buf.
> The 'buf' in all _emit_XXX functions is passed as an offset on
> dma consistent buffer and hence always contiguous.
> Since, it is easier to, and I do, manipulate that buffer like an
> array, they are taken as array.
> Or am i overlooking something?

u8 *ptr; ptr[x] is valid.
 
> .....
> 
> >> +static inline u32 _emit_LD(unsigned dry_run, u8 buf[], ? ? ? enum pl330_cond cond)
> >> +{
> >> + ? ? if (dry_run)
> >> + ? ? ? ? ? ? return SZ_DMALD;
> >> +
> >> + ? ? buf[0] = CMD_DMALD;
> >> +
> >> + ? ? if (cond == SINGLE)
> >> + ? ? ? ? ? ? buf[0] |= (0 << 1) | (1 << 0);
> >> + ? ? else if (cond == BURST)
> >> + ? ? ? ? ? ? buf[0] |= (1 << 1) | (1 << 0);
> >
> > easir to merge CMD_DMALD into these to and just set buf[0] to the value
> > in the first place.
> Ok.
> 
> ......
> 
> >> + ? ? PL330_DBGCMD_DUMP(SZ_DMALD, "\tDMALD%c\n",
> >> + ? ? ? ? ? ? cond == SINGLE ? 'S' : (cond == BURST ? 'B' : 'A'));
> >> +
> >> + ? ? return SZ_DMALD;
> >> +}
> >> +
> >> +static inline u32 _emit_LDP(unsigned dry_run, u8 buf[],
> >> + ? ? ? ? ? ? enum pl330_cond cond, u8 peri)
> >> +{
> >> + ? ? if (dry_run)
> >> + ? ? ? ? ? ? return SZ_DMALDP;
> >> +
> >> + ? ? buf[0] = CMD_DMALDP;
> >> +
> >> + ? ? if (cond == BURST)
> >> + ? ? ? ? ? ? buf[0] |= (1 << 1);
> >> +
> >> + ? ? peri &= 0x1f;
> >> + ? ? peri <<= 3;
> >> + ? ? buf[1] = peri;
> >> +
> >> + ? ? PL330_DBGCMD_DUMP(SZ_DMALDP, "\tDMALDP%c %u\n",
> >> + ? ? ? ? ? ? cond == SINGLE ? 'S' : 'B', peri >> 3);
> >> +
> >> + ? ? return SZ_DMALDP;
> >> +}
> >> +
> >> +static inline u32 _emit_LP(unsigned dry_run, u8 buf[],
> >> + ? ? ? ? ? ? unsigned loop, u8 cnt)
> >> +{
> > could loop be a bool? dry_run certainly should be.
> I'd better do
> 
>     buf[0] |= (loop << 1);

ok, as long as you ensure loop is always 0 or 1. you could also
then merge in the original instruction.
 
> rather than
>      if (loop)
>             buf[0] |= (1 << 1);
> 
> Yes, dry_run should be bool.
> 
> .......
> 
> >> + ? ? if (dry_run)
> >> + ? ? ? ? ? ? return SZ_DMALP;
> >
> > I'm just wondering if these shouldn't be if (!dry_run) { } return SZ_;\
> Just wanted to avoid another level of indent.
> 
> ........
> 
> >> + ? ? buf[0] = CMD_DMALP;
> >> +
> >> + ? ? if (loop)
> >> + ? ? ? ? ? ? buf[0] |= (1 << 1);
> >
> > again, you could probably do
> >
> > ? ? ? buf[0] = loop ? CMD_DMALP | (1 << 1) : CMD_DMALP;
> Since loop is the index, it'd better be
>     buf[0] = CMD_DMALP  |  (loop << 1) ;

ok, seems sensible.
 
> .......
> 
> >> +static inline u32 _emit_SEV(unsigned dry_run, u8 buf[], u8 ev)
> >> +{
> >> + ? ? if (dry_run)
> >> + ? ? ? ? ? ? return SZ_DMASEV;
> >> +
> >> + ? ? buf[0] = CMD_DMASEV;
> >> +
> >> + ? ? ev &= 0x1f;
> >> + ? ? ev <<= 3;
> >
> > is this some common op that should have some form of macro/inline defn?
> Strictly speaking, we could define a macro for preparing such mask for a few
> different instructions which happen to do the same thing.

I'm also wodnering if you could have a overall generate instruction with
this form of arguments, instead of having a whole pile of really similar
code.
 
> ......
> 
> >> +static inline u32 _emit_GO(unsigned dry_run, u8 buf[],
> >> + ? ? ? ? ? ? const struct _arg_GO *arg)
> >> +{
> >> + ? ? u8 chan = arg->chan;
> >> + ? ? u32 addr = arg->addr;
> >> + ? ? unsigned ns = arg->ns;
> >> +
> >> + ? ? if (dry_run)
> >> + ? ? ? ? ? ? return SZ_DMAGO;
> >> +
> >> + ? ? buf[0] = CMD_DMAGO;
> >> + ? ? buf[0] |= (ns << 1);
> >
> > again, you could have probably merged these two into one.
> Ok
> 
> ......
> 
> >> +static inline u32 _state(struct pl330_thread *thrd)
> >> +{
> >> + ? ? void __iomem *regs = thrd->dmac->pinfo->base;
> >> + ? ? u32 val;
> >> +
> >> + ? ? if (is_manager(thrd))
> >> + ? ? ? ? ? ? val = readl(regs + DS) & 0xf;
> >> + ? ? else
> >> + ? ? ? ? ? ? val = readl(regs + CS(thrd->id)) & 0xf;
> >> +
> >> + ? ? switch (val) {
> >> + ? ? case DS_ST_STOP:
> >> + ? ? ? ? ? ? return PL330_STATE_STOPPED;
> >> + ? ? case DS_ST_EXEC:
> >> + ? ? ? ? ? ? return PL330_STATE_EXECUTING;
> >> + ? ? case DS_ST_CMISS:
> >> + ? ? ? ? ? ? return PL330_STATE_CACHEMISS;
> >> + ? ? case DS_ST_UPDTPC:
> >> + ? ? ? ? ? ? return PL330_STATE_UPDTPC;
> >> + ? ? case DS_ST_WFE:
> >> + ? ? ? ? ? ? return PL330_STATE_WFE;
> >> + ? ? case DS_ST_FAULT:
> >> + ? ? ? ? ? ? return PL330_STATE_FAULTING;
> >> + ? ? case DS_ST_ATBRR:
> >> + ? ? ? ? ? ? if (is_manager(thrd))
> >> + ? ? ? ? ? ? ? ? ? ? return PL330_STATE_INVALID;
> >
> > might be more code efficient to break the case into two
> > and have a is_manager() check between the two switches.
> ok
> 
> ......
> 
> >> +
> >> +/* If the request 'req' of thread 'thrd' is currently active */
> >> +static inline bool _req_active(struct pl330_thread *thrd,
> >> + ? ? ? ? ? ? struct _pl330_req *req)
> >> +{
> >> + ? ? void __iomem *regs = thrd->dmac->pinfo->base;
> >> + ? ? u32 buf = req->mc_bus, pc = readl(regs + CPC(thrd->id));
> >> +
> >> + ? ? if (IS_FREE(req))
> >> + ? ? ? ? ? ? return false;
> >> +
> >> + ? ? return (pc >= buf && pc <= buf + req->mc_len) ? true : false;
> >> +}
> >
> > hmm, doesn't linux bool allow just a
> > ? ? ?return (pc >= buf && pc <= buf + req->mc_len); ?
> remember my itch ? :)

brainscrub, isle 3.
 
> .....
> 
> >> +updt_exit:
> >> + ? ? spin_unlock_irqrestore(&pl330->lock, flags);
> >> +
> >> + ? ? if (pl330->dmac_tbd.reset_dmac
> >> + ? ? ? ? ? ? ? ? ? ? || pl330->dmac_tbd.reset_mngr
> >> + ? ? ? ? ? ? ? ? ? ? || pl330->dmac_tbd.reset_chan) {
> >
> > iirc, style is:
> > ? ? ?if (a ||
> > ? ? ? ? ?b ||
> > ? ? ? ? ?c)
> >
> > could be wrong, definetly prefer the above.
> Ok, though there doesn't seem to be any hard-fast rule.

this is why I wasn't being definite.
 
> .......
> 
> >> + ? ? if (!pl330->mcode_cpu) {
> >> + ? ? ? ? ? ? dev_err(pi->dev, "%s:%d Can't allocate memory!\n",
> >
> > no need to add an ! at the end of the line.
> Ok.

again, not a rule as such, just genrally accepted practice.
 
> ........
> 
> >> +
> >> + ? ? /* Check if we can handle this DMAC */
> >> + ? ? if (get_id(pi, PERIPH_ID) != PERIPH_ID_VAL
> >> + ? ? ? ?|| get_id(pi, PCELL_ID) != PCELL_ID_VAL) {
> >> + ? ? ? ? ? ? dev_err(pi->dev, "PERIPH_ID 0x%x, PCELL_ID 0x%x !\n",
> >> + ? ? ? ? ? ? ? ? ? ? readl(regs + PERIPH_ID), readl(regs + PCELL_ID));
> >
> > get_id and readl() ?
> should be only get_id

did seem wrong.

> > Also, please don;'t keep getting suprised by errors, erro messages don't
> > need a ! in them.
> ok
> 
> ......
> 
> >> +/* Populated by the PL330 core driver for DMA API driver's info */
> >> +struct pl330_config {
> >> + ? ? u32 ? ? periph_id;
> >> + ? ? u32 ? ? pcell_id;
> >> +#define DMAC_MODE_NS (1 << 0)
> >> + ? ? unsigned int ? ?mode;
> >> + ? ? unsigned int ? ?data_bus_width:10; /* In number of bits */
> >> + ? ? unsigned int ? ?data_buf_dep:10;
> >> + ? ? unsigned int ? ?num_chan:4;
> >> + ? ? unsigned int ? ?num_peri:6;
> >> + ? ? u32 ? ? ? ? ? ? peri_ns;
> >> + ? ? unsigned int ? ?num_events:6;
> >> + ? ? u32 ? ? ? ? ? ? irq_ns;
> >> +};
> >
> > If this is matching an in-memory structure, then please don't use :x to
> > define these. Also you'll need to ensure it is packed.
> >
> > If not matching an in memory structure, then unsigned char or u8s would
> > probably generate more efficient code without sacrificing a lot of memory
> > space.
> It is not matching any memory structure. I used fields only to stress the values
> they can take.
> Ok, will convert to u8
> 
> .......
> 
> >> + * The Client may want to provide this info only for the
> >> + * first request and a request with new settings.
> >> + */
> >> +struct pl330_reqcfg {
> >> + ? ? /* Address Incrementing */
> >> + ? ? unsigned dst_inc:1;
> >> + ? ? unsigned src_inc:1;
> >> +
> >> + ? ? /*
> >> + ? ? ?* For now, the SRC & DST protection levels
> >> + ? ? ?* and burst size/length are assumed same.
> >> + ? ? ?*/
> >> + ? ? bool nonsecure;
> >> + ? ? bool privileged;
> >> + ? ? bool insnaccess;
> >> + ? ? unsigned brst_len:5;
> >> + ? ? unsigned brst_size:3; /* in power of 2 */
> >
> > see previous comments.
> ok
> 
> Thanks.

good to see things moving along.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
