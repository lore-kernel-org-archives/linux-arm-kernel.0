From: charu@ti.com (Varadarajan, Charulatha)
Date: Tue, 8 Mar 2011 14:46:04 +0530
Subject: [PATCH 3/3] OMAP2+: powerdomain: add pwrdm_can_ever_lose_context()
In-Reply-To: <20110308021551.31946.19903.stgit@twilight.localdomain>
References: <20110308021018.31946.29962.stgit@twilight.localdomain>
	<20110308021551.31946.19903.stgit@twilight.localdomain>
Message-ID: <AANLkTimuYVuxiqifxPEqfxyVuSYcKL563TZCP5uNM8Ss@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 8, 2011 at 07:45, Paul Walmsley <paul@pwsan.com> wrote:
> Some drivers wish to know whether the device that they control can
> ever lose context, for example, when the device's enclosing
> powerdomain loses power. ?They can use this information to determine
> whether it is necessary to save and restore device context, or whether
> it can be skipped. ?Implement the powerdomain portion of this by
> adding the function pwrdm_can_ever_lose_context(). ?This is not for
> use directly from driver code, but instead is intended to be called
> from driver-subarch integration code (i.e., arch/arm/*omap* code).
>
> Currently, the result from this function should be passed into the
> driver code via struct platform_data, but at some point this should
> be part of some common or OMAP-specific device code.
>
> While here, update file copyrights.
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> ---
> ?arch/arm/mach-omap2/powerdomain.c | ? 43 ++++++++++++++++++++++++++++++++++++-
> ?arch/arm/mach-omap2/powerdomain.h | ? 18 +++++++--------
> ?2 files changed, 50 insertions(+), 11 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
> index eaed0df..a11be81 100644
> --- a/arch/arm/mach-omap2/powerdomain.c
> +++ b/arch/arm/mach-omap2/powerdomain.c
> @@ -2,7 +2,7 @@
> ?* OMAP powerdomain control
> ?*
> ?* Copyright (C) 2007-2008 Texas Instruments, Inc.
> - * Copyright (C) 2007-2009 Nokia Corporation
> + * Copyright (C) 2007-2011 Nokia Corporation
> ?*
> ?* Written by Paul Walmsley
> ?* Added OMAP4 specific support by Abhijit Pagare <abhijitpagare@ti.com>
> @@ -938,3 +938,44 @@ u32 pwrdm_get_context_loss_count(struct powerdomain *pwrdm)
>
> ? ? ? ?return count;
> ?}
> +
> +/**
> + * pwrdm_can_ever_lose_context - can this powerdomain ever lose context?
> + * @pwrdm: struct powerdomain *
> + *
> + * Given a struct powerdomain * @pwrdm, returns 1 if the powerdomain
> + * can lose either memory or logic context or if @pwrdm is invalid, or
> + * returns 0 otherwise. ?This function is not concerned with how the
> + * powerdomain registers are programmed (i.e., to go off or not); it's
> + * concerned with whether it's ever possible for this powerdomain to
> + * go off while some other part of the chip is active. ?This function
> + * assumes that every powerdomain can go to either ON or INACTIVE.
> + */
> +bool pwrdm_can_ever_lose_context(struct powerdomain *pwrdm)
> +{
> + ? ? ? int i;
> +
> + ? ? ? if (IS_ERR_OR_NULL(pwrdm)) {
> + ? ? ? ? ? ? ? pr_debug("powerdomain: %s: invalid powerdomain pointer\n",
> + ? ? ? ? ? ? ? ? ? ? ? ?__func__);
> + ? ? ? ? ? ? ? return 1;

Do you really want to return 1 in case of invalid powerdomain pointer?

-V Charulatha

> + ? ? ? }
> +
> + ? ? ? if (pwrdm->pwrsts & PWRSTS_OFF)
> + ? ? ? ? ? ? ? return 1;
> +
> + ? ? ? if (pwrdm->pwrsts & PWRSTS_RET) {
> + ? ? ? ? ? ? ? if (pwrdm->pwrsts_logic_ret & PWRSTS_OFF)
> + ? ? ? ? ? ? ? ? ? ? ? return 1;
> +
> + ? ? ? ? ? ? ? for (i = 0; i < pwrdm->banks; i++)
> + ? ? ? ? ? ? ? ? ? ? ? if (pwrdm->pwrsts_mem_ret[i] & PWRSTS_OFF)
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? return 1;
> + ? ? ? }
> +
> + ? ? ? for (i = 0; i < pwrdm->banks; i++)
> + ? ? ? ? ? ? ? if (pwrdm->pwrsts_mem_on[i] & PWRSTS_OFF)
> + ? ? ? ? ? ? ? ? ? ? ? return 1;
> +
> + ? ? ? return 0;
> +}

<<snip>>
