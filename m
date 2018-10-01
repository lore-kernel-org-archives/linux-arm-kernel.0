From: leoyang.li@nxp.com (Li Yang)
Date: Mon, 1 Oct 2018 16:50:22 -0500
Subject: [PATCH v2 5/5] soc/fsl_qbman: export coalesce change API
In-Reply-To: <1538124204-31406-6-git-send-email-madalin.bucur@nxp.com>
References: <1538124204-31406-1-git-send-email-madalin.bucur@nxp.com>
 <1538124204-31406-6-git-send-email-madalin.bucur@nxp.com>
Message-ID: <CADRPPNQgGAYTCmppyxPwQnnC433QLm21D5iq_4EvSj0LrsAxGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 28, 2018 at 3:45 AM Madalin Bucur <madalin.bucur@nxp.com> wrote:
>
> Export the API required to control the QMan portal interrupt coalescing
> settings.

These are new APIs not just old APIs being exported.  What is the user
of these APIs?  Is the user being submitted?  We cannot have APIs in
kernel that has no users.

>
> Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
> ---
>  drivers/soc/fsl/qbman/qman.c | 31 +++++++++++++++++++++++++++++++
>  include/soc/fsl/qman.h       | 27 +++++++++++++++++++++++++++
>  2 files changed, 58 insertions(+)
>
> diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
> index 99d0f87889b8..8ab75bb44c4d 100644
> --- a/drivers/soc/fsl/qbman/qman.c
> +++ b/drivers/soc/fsl/qbman/qman.c
> @@ -1012,6 +1012,37 @@ static inline void put_affine_portal(void)
>
>  static struct workqueue_struct *qm_portal_wq;
>
> +void qman_dqrr_set_ithresh(struct qman_portal *portal, u8 ithresh)
> +{
> +       if (!portal)
> +               return;
> +
> +       qm_dqrr_set_ithresh(&portal->p, ithresh);
> +       portal->p.dqrr.ithresh = ithresh;
> +}
> +EXPORT_SYMBOL(qman_dqrr_set_ithresh);
> +
> +void qman_dqrr_get_ithresh(struct qman_portal *portal, u8 *ithresh)
> +{
> +       if (portal && ithresh)
> +               *ithresh = portal->p.dqrr.ithresh;
> +}
> +EXPORT_SYMBOL(qman_dqrr_get_ithresh);
> +
> +void qman_portal_get_iperiod(struct qman_portal *portal, u32 *iperiod)
> +{
> +       if (portal && iperiod)
> +               *iperiod = qm_in(&portal->p, QM_REG_ITPR);
> +}
> +EXPORT_SYMBOL(qman_portal_get_iperiod);
> +
> +void qman_portal_set_iperiod(struct qman_portal *portal, u32 iperiod)
> +{
> +       if (portal)
> +               qm_out(&portal->p, QM_REG_ITPR, iperiod);
> +}
> +EXPORT_SYMBOL(qman_portal_set_iperiod);
> +
>  int qman_wq_alloc(void)
>  {
>         qm_portal_wq = alloc_workqueue("qman_portal_wq", 0, 1);
> diff --git a/include/soc/fsl/qman.h b/include/soc/fsl/qman.h
> index d4dfefdee6c1..42f50eb51529 100644
> --- a/include/soc/fsl/qman.h
> +++ b/include/soc/fsl/qman.h
> @@ -1186,4 +1186,31 @@ int qman_alloc_cgrid_range(u32 *result, u32 count);
>   */
>  int qman_release_cgrid(u32 id);
>
> +/**
> + * qman_dqrr_get_ithresh - Get coalesce interrupt threshold
> + * @portal: portal to get the value for
> + * @ithresh: threshold pointer
> + */
> +void qman_dqrr_get_ithresh(struct qman_portal *portal, u8 *ithresh);
> +
> +/**
> + * qman_dqrr_set_ithresh - Set coalesce interrupt threshold
> + * @portal: portal to set the new value on
> + * @ithresh: new threshold value
> + */
> +void qman_dqrr_set_ithresh(struct qman_portal *portal, u8 ithresh);
> +
> +/**
> + * qman_dqrr_get_iperiod - Get coalesce interrupt period
> + * @portal: portal to get the value for
> + * @iperiod: period pointer
> + */
> +void qman_portal_get_iperiod(struct qman_portal *portal, u32 *iperiod);
> +/*
> + * qman_dqrr_set_iperiod - Set coalesce interrupt period
> + * @portal: portal to set the new value on
> + * @ithresh: new period value
> + */
> +void qman_portal_set_iperiod(struct qman_portal *portal, u32 iperiod);
> +
>  #endif /* __FSL_QMAN_H */
> --
> 2.1.0
>
