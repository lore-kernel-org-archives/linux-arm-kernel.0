From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 01 Jun 2015 21:27:42 +0200
Subject: [Y2038] [PATCH] drm/exynos: g2d: Replace struct timeval usage
In-Reply-To: <20150601030618.GA2754@tinar>
References: <20150601030618.GA2754@tinar>
Message-ID: <11771769.CzI59d4H3P@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 01 June 2015 08:36:18 Tina Ruchandani wrote:
> -       do_gettimeofday(&now);
> +       getnstimeofday64(&now);
>         e->event.tv_sec = now.tv_sec;
> -       e->event.tv_usec = now.tv_usec;
> +       e->event.tv_usec = (now.tv_nsec / NSEC_PER_USEC);
>         e->event.cmdlist_no = cmdlist_no;
> 

This has the same problem as the ipp patch: e->event.tv_sec is
a 32-bit variable, so this will still overflow, and the patch
has no effect.

	Arnd
