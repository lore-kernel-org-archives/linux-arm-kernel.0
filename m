From: govindraj.raja@ti.com (Raja, Govindraj)
Date: Mon, 12 Mar 2012 17:19:07 +0530
Subject: [PATCH] omap_hwmod: Allow io_ring wakeup configuration for all
 modules.
In-Reply-To: <CAMrsUdJq8J8dTnKcZmXgMucDX=dNXgR+9xFhYOdHvNDuw_=4Mw@mail.gmail.com>
References: <1331122775-761-1-git-send-email-govindraj.raja@ti.com>
 <CAMrsUdJq8J8dTnKcZmXgMucDX=dNXgR+9xFhYOdHvNDuw_=4Mw@mail.gmail.com>
Message-ID: <CAMrsUdLe1gq-tWeg_GgEp_HHUVXCGMgegCtfEzEp9zzMpbDfHA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 7, 2012 at 7:40 PM, Raja, Govindraj <govindraj.raja@ti.com> wrote:
> On Wed, Mar 7, 2012 at 5:49 PM, Govindraj.R <govindraj.raja@ti.com> wrote:
>>

[...]

>
> From b3aa1dac5909cad1b959f5b97bbf408b2f974060 Mon Sep 17 00:00:00 2001
> From: "Govindraj.R" <govindraj.raja@ti.com>
> Date: Wed, 7 Mar 2012 17:14:02 +0530
> Subject: [PATCH] omap_hwmod: Allow io_ring wakeup configuration for all
> ?modules.
>
> Some modules doesn't have SYSC_HAS_ENAWAKEUP bit available
> (ex: usb host uhh module) in absence of this flag
> omap_hwmod_enable/disable_wakeup avoids configuring
> pad mux wakeup capability.
>
> Configure sysc if SYSC_HAS_ENAWAKEUP is available and for other cases
> try enabling/disabling wakeup from mux_pad pins.
>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
> ---

Gentle Ping.

--
Thanks,
Govindraj.R



> ?arch/arm/mach-omap2/omap_hwmod.c | ? 30 ++++++++++++++++--------------
> ?1 files changed, 16 insertions(+), 14 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index eba6cd3..9605fad 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -2475,14 +2475,15 @@ int omap_hwmod_enable_wakeup(struct omap_hwmod *oh)
> ? ? ? ?unsigned long flags;
> ? ? ? ?u32 v;
>
> - ? ? ? if (!oh->class->sysc ||
> - ? ? ? ? ? !(oh->class->sysc->sysc_flags & SYSC_HAS_ENAWAKEUP))
> - ? ? ? ? ? ? ? return -EINVAL;
> -
> ? ? ? ?spin_lock_irqsave(&oh->_lock, flags);
> - ? ? ? v = oh->_sysc_cache;
> - ? ? ? _enable_wakeup(oh, &v);
> - ? ? ? _write_sysconfig(v, oh);
> +
> + ? ? ? if (oh->class->sysc &&
> + ? ? ? ? ? (oh->class->sysc->sysc_flags & SYSC_HAS_ENAWAKEUP)) {
> + ? ? ? ? ? ? ? v = oh->_sysc_cache;
> + ? ? ? ? ? ? ? _enable_wakeup(oh, &v);
> + ? ? ? ? ? ? ? _write_sysconfig(v, oh);
> + ? ? ? }
> +
> ? ? ? ?_set_idle_ioring_wakeup(oh, true);
> ? ? ? ?spin_unlock_irqrestore(&oh->_lock, flags);
>
> @@ -2506,14 +2507,15 @@ int omap_hwmod_disable_wakeup(struct omap_hwmod *oh)
> ? ? ? ?unsigned long flags;
> ? ? ? ?u32 v;
>
> - ? ? ? if (!oh->class->sysc ||
> - ? ? ? ? ? !(oh->class->sysc->sysc_flags & SYSC_HAS_ENAWAKEUP))
> - ? ? ? ? ? ? ? return -EINVAL;
> -
> ? ? ? ?spin_lock_irqsave(&oh->_lock, flags);
> - ? ? ? v = oh->_sysc_cache;
> - ? ? ? _disable_wakeup(oh, &v);
> - ? ? ? _write_sysconfig(v, oh);
> +
> + ? ? ? if (oh->class->sysc &&
> + ? ? ? ? ? (oh->class->sysc->sysc_flags & SYSC_HAS_ENAWAKEUP)) {
> + ? ? ? ? ? ? ? v = oh->_sysc_cache;
> + ? ? ? ? ? ? ? _disable_wakeup(oh, &v);
> + ? ? ? ? ? ? ? _write_sysconfig(v, oh);
> + ? ? ? }
> +
> ? ? ? ?_set_idle_ioring_wakeup(oh, false);
> ? ? ? ?spin_unlock_irqrestore(&oh->_lock, flags);
>
> --
> 1.7.5.4
