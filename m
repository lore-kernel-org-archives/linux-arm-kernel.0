From: omar.ramirez@ti.com (Ramirez Luna, Omar)
Date: Wed, 14 Mar 2012 19:31:19 -0500
Subject: [PATCH v2 5/8] ARM: OMAP2+: hwmod: ensure that SYSCONFIG bits are
 reprogrammed after a reset
In-Reply-To: <20120228053657.16278.76132.stgit@dusk>
References: <20120228053524.16278.59430.stgit@dusk>
 <20120228053657.16278.76132.stgit@dusk>
Message-ID: <CAB-zwWhAa3PprwDLzWLkBFUHPeJO3HN3M9mAZF=ohGTvP43jYA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

2012/2/27 Paul Walmsley <paul@pwsan.com>:
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index db4ad41..aeb6f4c 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -1490,13 +1490,22 @@ static int _reset(struct omap_hwmod *oh)
> ? ? ? ?pr_debug("omap_hwmod: %s: resetting\n", oh->name);
>
> ? ? ? ?if (oh->class->reset)
> - ? ? ? ? ? ? ? return oh->class->reset(oh);
> -
> - ? ? ? if (!oh->rst_lines_cnt)
> - ? ? ? ? ? ? ? return _ocp_softreset(oh);
> + ? ? ? ? ? ? ? oh->class->reset(oh);
> + ? ? ? else if (!oh->rst_lines_cnt)
> + ? ? ? ? ? ? ? _ocp_softreset(oh);
> + ? ? ? else
> + ? ? ? ? ? ? ? for (i = 0; i < oh->rst_lines_cnt; i++)
> + ? ? ? ? ? ? ? ? ? ? ? _assert_hardreset(oh, oh->rst_lines[i].name);

If we reached here the reset lines will be asserted, and then the code
below touches sysc registers on a module under reset.

This would crash on _setup->_setup_reset->_reset.

Adding a 'return 0' I believe fixes the behavior, boots the board and
leaves the hwmod under reset.

-	else
+	} else {
 		for (i = 0; i < oh->rst_lines_cnt; i++)
 			_assert_hardreset(oh, oh->rst_lines[i].name);
+		return 0;
+	}

>
> - ? ? ? for (i = 0; i < oh->rst_lines_cnt; i++)
> - ? ? ? ? ? ? ? _assert_hardreset(oh, oh->rst_lines[i].name);
> + ? ? ? /*
> + ? ? ? ?* OCP_SYSCONFIG bits need to be reprogrammed after a
> + ? ? ? ?* softreset. ?The _enable() function should be split to avoid
> + ? ? ? ?* the rewrite of the OCP_SYSCONFIG register.
> + ? ? ? ?*/
> + ? ? ? if (oh->class->sysc) {
> + ? ? ? ? ? ? ? _update_sysc_cache(oh);
> + ? ? ? ? ? ? ? _enable_sysc(oh);
> + ? ? ? }

Best Regards,

Omar
