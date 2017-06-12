From: tony@atomide.com (Tony Lindgren)
Date: Mon, 12 Jun 2017 03:25:28 -0700
Subject: [PATCH] ARM: OMAP: PM: stop early on systems without twl
In-Reply-To: <20170612073946.GU3730@atomide.com>
References: <20170609223223.19079-1-sre@kernel.org>
 <20170612073946.GU3730@atomide.com>
Message-ID: <20170612102527.GX3730@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [170612 00:43]:
> * Sebastian Reichel <sre@kernel.org> [170609 15:36]:
> > Motorola Droid 4 has an OMAP4, but no TWL6030. It currently
> > complains verbosely about this during boot:
> > 
> > twl: not initialized
> > twl6030_uv_to_vsel:OUT OF RANGE! non mapped vsel for 1375000 Vs max 1316660
> > twl6030_uv_to_vsel:OUT OF RANGE! non mapped vsel for 1375000 Vs max 1316660
> > twl6030_uv_to_vsel:OUT OF RANGE! non mapped vsel for 1375000 Vs max 1316660
> > twl6030_uv_to_vsel:OUT OF RANGE! non mapped vsel for 1375000 Vs max 1316660
> > twl6030_uv_to_vsel:OUT OF RANGE! non mapped vsel for 1375000 Vs max 1316660
> > twl6030_uv_to_vsel:OUT OF RANGE! non mapped vsel for 1375000 Vs max 1316660
> > twl6030_uv_to_vsel:OUT OF RANGE! non mapped vsel for 1410000 Vs max 1316660
> > omap2_set_init_voltage: unable to find boot up OPP for vdd_core
> > omap2_set_init_voltage: unable to set vdd_core
> > omap2_set_init_voltage: unable to find boot up OPP for vdd_iva
> > omap2_set_init_voltage: unable to set vdd_iva
> > 
> > While proper support for CPCAP should be added at some point,
> > let's exit early in omap2_common_pm_late_init() until that
> > has been implemented to avoid the above errors. There is still
> > a reminder about missing PM in dmesg:
> > 
> > Missing OMAP4 PM for this platform!
> 
> Great good to see this dmesg spam go away. Applying into
> omap-for-v4.13/soc-v3 thanks.

After running make randconfig builds over lunch I noticed
we can now get "undefined reference to `twl_rev'" so we
need something more here if CONFIG_TWL4030_CORE or
CONFIG_TWL6040_CORE is not selected or is a loadable module.

Maybe making the whole function depend on the following
might work:

#if IS_BUILTIN(CONFIG_TWL6040_CORE) || \
	IS_BUILTIN(CONFIG_TWL4030_CORE)
...
#endif

Anyways dropping for now.

Regards,

Tony
