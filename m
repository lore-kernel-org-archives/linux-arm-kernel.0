From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 30 Dec 2014 23:34:32 +0100
Subject: [PATCH 2/4] ARM: sirf: add atlas7 machine support
In-Reply-To: <1419496460-4929-3-git-send-email-21cnbao@gmail.com>
References: <1419496460-4929-1-git-send-email-21cnbao@gmail.com>
 <1419496460-4929-3-git-send-email-21cnbao@gmail.com>
Message-ID: <4739415.xM06V8YCmL@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 25 December 2014 16:34:18 Barry Song wrote:
> +DT_MACHINE_START(ATLAS7_DT, "Generic ATLAS7 (Flattened Device Tree)")
> +       /* Maintainer: Barry Song <baohua.song@csr.com> */
> +       .smp            = smp_ops(sirfsoc_smp_ops),
> +       .map_io         = sirfsoc_map_io,
> +       .init_late      = sirfsoc_init_late,
> +       .dt_compat      = atlas7_dt_match,
> +MACHINE_END

Can you check if the sirfsoc_map_io function is still required?
My guess is that you can just replace sirfsoc_map_scu() with a
call of ioremap in sirfsoc_smp_prepare_cpus, and drop sirfsoc_map_lluart()
entirely in favor of the default debug_ll_io_init() function that
is called when map_io is NULL.

Also, how about merging the entries for atlas6 and atlas7, and just
having multiple compatible strings in atlas_dt_match?

	Arnd
