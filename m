From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 18 Feb 2011 17:32:32 +0530
Subject: [PATCH 3/5] ARM: l2x0: Errata fix for flush by Way operation can
	cause data corruption
In-Reply-To: <AANLkTikEjTgisftQV46djrOP8iWMFV267v-efHsVf_Nd@mail.gmail.com>
References: <1297510187-31547-1-git-send-email-santosh.shilimkar@ti.com><1297510187-31547-4-git-send-email-santosh.shilimkar@ti.com><AANLkTimkqZ5datA+7shggbWz3+j=TDg5beUkQK=b1AmK@mail.gmail.com><13596bec9184b117d6a1d02da8e017bf@mail.gmail.com><AANLkTimjXG5-kEW=1vodnGo3Ct_xOS_HihdqN0TeL9ba@mail.gmail.com><33573d5cfc91cf45dc58ee861cccc2ae@mail.gmail.com><4dfaffa99292bf8e36791ea9a68de75e@mail.gmail.com>
	<AANLkTikEjTgisftQV46djrOP8iWMFV267v-efHsVf_Nd@mail.gmail.com>
Message-ID: <a52fd2d3aaca5ad999974fe3f886d90d@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: catalin.marinas at gmail.com [mailto:catalin.marinas at gmail.com]
> On Behalf Of Catalin Marinas
> Sent: Wednesday, February 16, 2011 9:24 PM
> To: Santosh Shilimkar
> Cc: linux-arm-kernel at lists.infradead.org; Andrei Warkentin; Kevin
> Hilman; tony at atomide.com; linux-omap at vger.kernel.org
> Subject: Re: [PATCH 3/5] ARM: l2x0: Errata fix for flush by Way
> operation can cause data corruption
>
> On 15 February 2011 07:14, Santosh Shilimkar
> <santosh.shilimkar@ti.com> wrote:
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -1140,7 +1140,7 @@ config ARM_ERRATA_742231
> >
> > ?config PL310_ERRATA_588369
> > ? ? ? ?bool "Clean & Invalidate maintenance operations do not
> invalidate
> > clean lines"
> > - ? ? ? depends on CACHE_L2X0 && ARCH_OMAP4
> > + ? ? ? depends on CACHE_L2X0 && CACHE_PL310
>
> It can just depend on CACHE_PL310 as this depends on CACHE_L2X0.
>
With CACHE_PL310 alone, I get below warning.

warning: (ARCH_OMAP4) selects PL310_ERRATA_588369 which has unmet direct
dependencies (CACHE_PL310)

This is coming because Pl310 can't be selected on V6 and OMAP
common build has V6 and V7 both enabled.

So to avoid the warning and also able to select the errata in
OMAP build, I am making the errata's depends on CACHE_L2X0
with comment.

Regards,
Santosh
