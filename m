From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 10 Nov 2015 13:32:10 +0100
Subject: [PATCH v2 4/7] xen: introduce XENPF_settime64
In-Reply-To: <1447156675-7418-4-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1511101131350.5676@kaball.uk.xensource.com>
 <1447156675-7418-4-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <3704230.3XlU4asf6t@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 10 November 2015 11:57:52 Stefano Stabellini wrote:
> Rename the current XENPF_settime hypercall and related struct to
> XENPF_settime32.
> 
> Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> CC: konrad.wilk at oracle.com
> CC: david.vrabel at citrix.com
> CC: boris.ostrovsky at oracle.com

Looks good.

> ---
>  arch/x86/xen/time.c              |    8 ++++----
>  include/xen/interface/platform.h |   18 ++++++++++++++----
>  2 files changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
> index 663c2ea..3bbd377 100644
> --- a/arch/x86/xen/time.c
> +++ b/arch/x86/xen/time.c
> @@ -134,10 +134,10 @@ static int xen_pvclock_gtod_notify(struct notifier_block *nb,
>         if (!was_set && timespec_compare(&now, &next_sync) < 0)
>                 return NOTIFY_OK;
>  
> -       op.cmd = XENPF_settime;
> -       op.u.settime.secs = now.tv_sec;
> -       op.u.settime.nsecs = now.tv_nsec;
> -       op.u.settime.system_time = xen_clocksource_read();
> +       op.cmd = XENPF_settime32;
> +       op.u.settime32.secs = now.tv_sec;
> +       op.u.settime32.nsecs = now.tv_nsec;
> +       op.u.settime32.system_time = xen_clocksource_read();
>  
>         (void)HYPERVISOR_platform_op(&op);

I suppose someone will have to get back to this eventually and
change the code to try XENPF_settime64 first.

	Arnd
