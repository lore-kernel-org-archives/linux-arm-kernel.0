From: timur@codeaurora.org (Timur Tabi)
Date: Fri, 16 Mar 2018 23:30:59 -0500
Subject: [PATCH v3 18/18] infiniband: cxgb4: Eliminate duplicate barriers
 on weakly-ordered archs
In-Reply-To: <1f5e3b14-05a1-08d0-c0cb-00805526448d@codeaurora.org>
References: <1521216991-28706-1-git-send-email-okaya@codeaurora.org>
 <1521216991-28706-19-git-send-email-okaya@codeaurora.org>
 <003601d3bd6a$783d6970$68b83c50$@opengridcomputing.com>
 <83387f6e-adcb-14e9-2c22-96abf9493cc6@codeaurora.org>
 <004501d3bd7b$505e70f0$f11b52d0$@opengridcomputing.com>
 <740c7d45-450e-c9b3-ceed-7bc7fcefbc5a@codeaurora.org>
 <71e37a55-537b-d75a-cfde-f188b7cfce8e@codeaurora.org>
 <1f5e3b14-05a1-08d0-c0cb-00805526448d@codeaurora.org>
Message-ID: <CAOZdJXWMmsSUXpT_XVboXM5DRHzt0=EXL9mFNPm0bWtTxhU_QA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 16, 2018 at 11:25 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
> @@ -477,15 +477,16 @@ static inline void t4_ring_sq_db(struct t4_wq *wq, u16 inc, union t4_wr *wqe)
>                                  (u64 *)wqe);
>                 } else {
>                         pr_debug("DB wq->sq.pidx = %d\n", wq->sq.pidx);
> -                       writel(PIDX_T5_V(inc) | QID_V(wq->sq.bar2_qid),
> -                              wq->sq.bar2_va + SGE_UDB_KDOORBELL);
> +                       __raw_writel(PIDX_T5_V(inc) | QID_V(wq->sq.bar2_qid),

I think Jason might be right that drivers shouldn't be calling the
__raw_write functions.  You definitely need to run this by the PPC
developers, specifically Ben Herrenschmidt.


-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
