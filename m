From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Sun, 11 Dec 2011 16:21:12 +0530
Subject: [PATCH v2] ARM: pl330: Fix a race condition
In-Reply-To: <4EE26670.1060005@arm.com>
References: <4E8C5425.80303@arm.com>
 <1317892206-3600-1-git-send-email-javi.merino@arm.com>
 <CAJuYYwTXf-XU0fdGT0+sggN-MEY3v7UHkfjNkM4+QUW464J9Ew@mail.gmail.com>
 <4EB7B79A.2020004@arm.com>
 <000c01ccada6$f83f5be0$e8be13a0$%kim@samsung.com>
 <4ED3B89E.7070903@arm.com>
 <000e01ccae48$d76a7ba0$863f72e0$%kim@samsung.com>
 <4ED4AB9A.3060807@arm.com>
 <CAJe_Zhem0yTOV4L-kJ91fQN++hFzCUgjOfxSnJR25PuYNTedVQ@mail.gmail.com>
 <03f001ccb4b5$3441f5c0$9cc5e140$%kim@samsung.com>
 <4EDF3989.3060108@arm.com> <4EDFD278.9090101@arm.com>
 <4EE1F7F0.70107@arm.com>
 <CAJe_Zhcj_j+r+T5N_BdS-ENds1SmJs7-Pfyf8vrFkB75BGBaYg@mail.gmail.com>
 <4EE20FF1.5070702@arm.com>
 <CABb+yY0f8xxAj+rFeZ4e61Sfk0+0bMsAiZ-H5AeY4cfCd_VE5g@mail.gmail.com>
 <4EE220A7.5070101@arm.com>
 <CABb+yY2-1B65-UqRofj72zVuZUUk5c6pkqNGs15ZLnkrVheRDQ@mail.gmail.com>
 <4EE26670.1060005@arm.com>
Message-ID: <CABb+yY1rt5RDdb1pfs0v4qfvZ=gsXGYFVwEn6Ns1OA+0TZXSjg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 10, 2011 at 1:20 AM, Javi Merino <javi.merino@arm.com> wrote:
>
> What about properly tracking what we have sent to the DMA? ?Something
> like the following (warning *ugly* and untested code ahead, may eat your
> kitten):
>
> diff --git a/arch/arm/common/pl330.c b/arch/arm/common/pl330.c
> index f407a6b..3652c4b 100644
> --- a/arch/arm/common/pl330.c
> +++ b/arch/arm/common/pl330.c
> @@ -303,6 +303,7 @@ struct pl330_thread {
> ? ? ? ?struct _pl330_req req[2];
> ? ? ? ?/* Index of the last submitted request */
> ? ? ? ?unsigned lstenq;
> + ? ? ? int req_running;
> ?};
>
> ?enum pl330_dmac_state {
> @@ -836,31 +837,6 @@ static inline u32 _state(struct pl330_thread *thrd)
> ? ? ? ?}
> ?}
>
> -/* If the request 'req' of thread 'thrd' is currently active */
> -static inline bool _req_active(struct pl330_thread *thrd,
> - ? ? ? ? ? ? ? struct _pl330_req *req)
> -{
> - ? ? ? void __iomem *regs = thrd->dmac->pinfo->base;
> - ? ? ? u32 buf = req->mc_bus, pc = readl(regs + CPC(thrd->id));
> -
> - ? ? ? if (IS_FREE(req))
> - ? ? ? ? ? ? ? return false;
> -
> - ? ? ? return (pc >= buf && pc <= buf + req->mc_len) ? true : false;
> -}
> -
> -/* Returns 0 if the thread is inactive, ID of active req + 1 otherwise */
> -static inline unsigned _thrd_active(struct pl330_thread *thrd)
> -{
> - ? ? ? if (_req_active(thrd, &thrd->req[0]))
> - ? ? ? ? ? ? ? return 1; /* First req active */
> -
> - ? ? ? if (_req_active(thrd, &thrd->req[1]))
> - ? ? ? ? ? ? ? return 2; /* Second req active */
> -
> - ? ? ? return 0;
> -}
> -
> ?static void _stop(struct pl330_thread *thrd)
> ?{
> ? ? ? ?void __iomem *regs = thrd->dmac->pinfo->base;
> @@ -897,11 +873,13 @@ static bool _trigger(struct pl330_thread *thrd)
> ? ? ? ?if (_state(thrd) != PL330_STATE_STOPPED)
> ? ? ? ? ? ? ? ?return true;
>
> - ? ? ? if (!IS_FREE(&thrd->req[1 - thrd->lstenq]))
> + ? ? ? if (!IS_FREE(&thrd->req[1 - thrd->lstenq])) {
> ? ? ? ? ? ? ? ?req = &thrd->req[1 - thrd->lstenq];
> - ? ? ? else if (!IS_FREE(&thrd->req[thrd->lstenq]))
> + ? ? ? ? ? ? ? thrd->req_running = 2 - thrd->lstenq;
> + ? ? ? } else if (!IS_FREE(&thrd->req[thrd->lstenq])) {
> ? ? ? ? ? ? ? ?req = &thrd->req[thrd->lstenq];
> - ? ? ? else
> + ? ? ? ? ? ? ? thrd->req_running = 1 + thrd->lstenq;
> + ? ? ? } else
> ? ? ? ? ? ? ? ?req = NULL;
>
> ? ? ? ?/* Return if no request */
> @@ -1384,6 +1362,7 @@ static void pl330_dotask(unsigned long data)
> ? ? ? ? ? ? ? ? ? ? ? ?thrd->req[1].r = NULL;
> ? ? ? ? ? ? ? ? ? ? ? ?MARK_FREE(&thrd->req[0]);
> ? ? ? ? ? ? ? ? ? ? ? ?MARK_FREE(&thrd->req[1]);
> + ? ? ? ? ? ? ? ? ? ? ? thrd->req_running = 0;
>
> ? ? ? ? ? ? ? ? ? ? ? ?/* Clear the reset flag */
> ? ? ? ? ? ? ? ? ? ? ? ?pl330->dmac_tbd.reset_chan &= ~(1 << i);
> @@ -1461,7 +1440,7 @@ int pl330_update(const struct pl330_info *pi)
>
> ? ? ? ? ? ? ? ? ? ? ? ?thrd = &pl330->channels[id];
>
> - ? ? ? ? ? ? ? ? ? ? ? active = _thrd_active(thrd);
> + ? ? ? ? ? ? ? ? ? ? ? active = thrd->req_running;
> ? ? ? ? ? ? ? ? ? ? ? ?if (!active) /* Aborted */
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?continue;
>
> @@ -1469,6 +1448,7 @@ int pl330_update(const struct pl330_info *pi)
>
> ? ? ? ? ? ? ? ? ? ? ? ?rqdone = &thrd->req[active];
> ? ? ? ? ? ? ? ? ? ? ? ?MARK_FREE(rqdone);
> + ? ? ? ? ? ? ? ? ? ? ? thrd->req_running = 0;
>
> ? ? ? ? ? ? ? ? ? ? ? ?/* Get going again ASAP */
> ? ? ? ? ? ? ? ? ? ? ? ?_start(thrd);
> @@ -1527,10 +1507,11 @@ int pl330_chan_ctrl(void *ch_id, enum
> pl330_chan_op op)
> ? ? ? ? ? ? ? ?thrd->req[1].r = NULL;
> ? ? ? ? ? ? ? ?MARK_FREE(&thrd->req[0]);
> ? ? ? ? ? ? ? ?MARK_FREE(&thrd->req[1]);
> + ? ? ? ? ? ? ? thrd->req_running = 0;
> ? ? ? ? ? ? ? ?break;
>
> ? ? ? ?case PL330_OP_ABORT:
> - ? ? ? ? ? ? ? active = _thrd_active(thrd);
> + ? ? ? ? ? ? ? active = thrd->req_running;
>
> ? ? ? ? ? ? ? ?/* Make sure the channel is stopped */
> ? ? ? ? ? ? ? ?_stop(thrd);
> @@ -1543,10 +1524,11 @@ int pl330_chan_ctrl(void *ch_id, enum
> pl330_chan_op op)
>
> ? ? ? ? ? ? ? ?thrd->req[active].r = NULL;
> ? ? ? ? ? ? ? ?MARK_FREE(&thrd->req[active]);
> + ? ? ? ? ? ? ? thrd->req_running = 0;
>
> ? ? ? ? ? ? ? ?/* Start the next */
> ? ? ? ?case PL330_OP_START:
> - ? ? ? ? ? ? ? if (!_thrd_active(thrd) && !_start(thrd))
> + ? ? ? ? ? ? ? if (!thrd->req_running && !_start(thrd))
> ? ? ? ? ? ? ? ? ? ? ? ?ret = -EIO;
> ? ? ? ? ? ? ? ?break;
>
> @@ -1587,7 +1569,7 @@ int pl330_chan_status(void *ch_id, struct
> pl330_chanstatus *pstatus)
> ? ? ? ?else
> ? ? ? ? ? ? ? ?pstatus->faulting = false;
>
> - ? ? ? active = _thrd_active(thrd);
> + ? ? ? active = thrd->req_running;
>
> ? ? ? ?if (!active) {
> ? ? ? ? ? ? ? ?/* Indicate that the thread is not running */
> @@ -1662,6 +1644,7 @@ void *pl330_request_channel(const struct
> pl330_info *pi)
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?MARK_FREE(&thrd->req[0]);
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?thrd->req[1].r = NULL;
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?MARK_FREE(&thrd->req[1]);
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? thrd->req_running = 0;
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?break;
> ? ? ? ? ? ? ? ? ? ? ? ?}
> ? ? ? ? ? ? ? ?}
> @@ -1775,6 +1758,8 @@ static inline void _reset_thread(struct
> pl330_thread *thrd)
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?+ pi->mcbufsz / 2;
> ? ? ? ?thrd->req[1].r = NULL;
> ? ? ? ?MARK_FREE(&thrd->req[1]);
> +
> + ? ? ? thrd->req_running = 0;
> ?}
>
> ?static int dmac_alloc_threads(struct pl330_dmac *pl330)
>
Yeah, this is like I said 'marker' method. Though we can clean it up a bit.
1) Pack req_running and lstenq together. Make lsteng return invalid value
should there be no buff programmed, otherwise 0 or 1.
2) Try to merge req_running modification as part of MARK_FREE.

Thanks.
