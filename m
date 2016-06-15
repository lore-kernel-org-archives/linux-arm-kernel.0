From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Wed, 15 Jun 2016 18:21:04 +0100
Subject: [PATCH v5 2/3] drm/arm: Add support for Mali Display Processors
In-Reply-To: <CAKMK7uENW3cU8LccHcqffX3cbzax2-5mzY0101yLfR7vtD4CoA@mail.gmail.com>
References: <1466002295-24813-1-git-send-email-Liviu.Dudau@arm.com>
 <1466002295-24813-3-git-send-email-Liviu.Dudau@arm.com>
 <20160615152309.GI1338@phenom.ffwll.local>
 <20160615161758.GF9711@e106497-lin.cambridge.arm.com>
 <CAKMK7uENW3cU8LccHcqffX3cbzax2-5mzY0101yLfR7vtD4CoA@mail.gmail.com>
Message-ID: <20160615172104.GI9711@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 15, 2016 at 07:13:15PM +0200, Daniel Vetter wrote:
> On Wed, Jun 15, 2016 at 6:17 PM, Liviu Dudau <Liviu.Dudau@arm.com> wrote:
> > On Wed, Jun 15, 2016 at 05:23:10PM +0200, Daniel Vetter wrote:
> >> On Wed, Jun 15, 2016 at 03:51:34PM +0100, Liviu Dudau wrote:
> >> > Add support for the new family of Display Processors from ARM Ltd.
> >> > This commit adds basic support for Mali DP500, DP550 and DP650
> >> > parts, with only the display engine being supported at the moment.
> >> >
> >> > Cc: David Brown <David.Brown@arm.com>
> >> > Cc: Brian Starkey <Brian.Starkey@arm.com>
> >> >
> >> > Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> >>
> >> Small thing I noticed: drm_dev_register/connector_register_all should be
> >> the last step in your init code, and unregister the first. Atm it's
> >> somewhere in the middle. But perfectly fine to do that as a follow-up.
> >
> > I've tried that, but the connector and encoder that gets registered as part
> > of the component_bind_all() fails if there is no drm dev registered. You did
> > comment on the v4 version about that and I did test your idea, sorry for
> > forgeting to update you on that.
> 
> Why does it fail? That shouldn't happen ... we need to be able to set
> up everything first, before we register.

Could be the tda998x_drv fault, but I'm getting this splat:

[    1.347687] kobject_add_internal failed for card0-HDMI-A-1 (error: -2 parent: card0)
[    1.355420] ------------[ cut here ]------------
[    1.360015] WARNING: CPU: 3 PID: 1 at /work/repositories/kernel/lib/kobject.c:244 kobject_add_internal+0xd8/0x290
[    1.370202] Modules linked in:
[    1.373238]
[    1.374724] CPU: 3 PID: 1 Comm: swapper/0 Not tainted 4.7.0-rc2+ #2
[    1.380941] Hardware name: ARM Juno development board (r0) (DT)
[    1.386816] task: ffffffc976ca0000 ti: ffffffc976ca8000 task.ti: ffffffc976ca8000
[    1.394251] PC is at kobject_add_internal+0xd8/0x290
[    1.399179] LR is at kobject_add_internal+0xd8/0x290
[    1.404107] pc : [<ffffff8008344730>] lr : [<ffffff8008344730>] pstate: 60000045
[    1.411452] sp : ffffffc976cab7f0
[    1.414742] x29: ffffffc976cab7f0 x28: ffffff8008c5bbb8
[    1.420022] x27: ffffffc0799c3810 x26: ffffff80089f8a10
[    1.425302] x25: 0000000000000000 x24: ffffffc0799c2000
[    1.430582] x23: ffffff8008bddc78 x22: ffffffc0799c2000
[    1.435861] x21: ffffffc0799c2010 x20: 00000000fffffffe
[    1.441139] x19: ffffffc0799c3810 x18: 0000000000000010
[    1.446418] x17: 0000000000000000 x16: 0000000000000000
[    1.451697] x15: ffffff8088c35c87 x14: 6163203a746e6572
[    1.456976] x13: 617020322d203a72 x12: 6f7272652820312d
[    1.462255] x11: 412d494d44482d30 x10: 6472616320726f66
[    1.467533] x9 : 2064656c69616620 x8 : 00000000000000a1
[    1.472812] x7 : 5f6464615f746365 x6 : 000000000000000a
[    1.478091] x5 : ffffffc976453c18 x4 : 0000000000000000
[    1.483370] x3 : 0000000000000000 x2 : ffffff8008baa7b8
[    1.488649] x1 : ffffffc976ca8000 x0 : 0000000000000048
[    1.493927]
[    1.495421] ---[ end trace b193c9c9e93296f4 ]---
[    1.500002] Call trace:
[    1.502434] Exception stack(0xffffffc976cab630 to 0xffffffc976cab750)
[    1.508827] b620:                                   ffffffc0799c3810 00000000fffffffe
[    1.516608] b640: ffffffc976cab7f0 ffffff8008344730 ffffffc976cab670 ffffff80080f81dc
[    1.524389] b660: ffffff80089b7570 0000000108c35000 ffffffc976cab710 ffffff80080f8500
[    1.532170] b680: ffffffc0799c3810 00000000fffffffe ffffffc0799c2010 ffffffc0799c2000
[    1.539951] b6a0: ffffff8008bddc78 ffffffc0799c2000 0000000000000000 ffffff80089f8a10
[    1.547731] b6c0: ffffffc0799c3810 ffffff8008c5bbb8 0000000000000048 ffffffc976ca8000
[    1.555511] b6e0: ffffff8008baa7b8 0000000000000000 0000000000000000 ffffffc976453c18
[    1.563292] b700: 000000000000000a 5f6464615f746365 00000000000000a1 2064656c69616620
[    1.571073] b720: 6472616320726f66 412d494d44482d30 6f7272652820312d 617020322d203a72
[    1.578851] b740: 6163203a746e6572 ffffff8088c35c87
[    1.583695] [<ffffff8008344730>] kobject_add_internal+0xd8/0x290
[    1.589658] [<ffffff800834496c>] kobject_add+0x84/0xd0
[    1.594763] [<ffffff8008484e94>] device_add+0xc4/0x548
[    1.599867] [<ffffff8008485568>] device_create_groups_vargs+0x108/0x118
[    1.606432] [<ffffff8008485644>] device_create_with_groups+0x3c/0x48
[    1.612742] [<ffffff80084630cc>] drm_sysfs_connector_add+0x5c/0xd0
[    1.618880] [<ffffff80084671f0>] drm_connector_register+0x18/0xa0
[    1.624930] [<ffffff80084809b8>] tda998x_bind+0x5f8/0x6c0
[    1.630292] [<ffffff8008482f94>] component_bind_all+0xfc/0x258
[    1.636083] [<ffffff800847d1a4>] malidp_bind+0x3b4/0x528
[    1.641357] [<ffffff8008482be8>] try_to_bring_up_master+0x140/0x1a0
[    1.647579] [<ffffff8008482ce0>] component_add+0x98/0x170
[    1.652940] [<ffffff800847fc18>] tda998x_probe+0x18/0x20
[    1.658216] [<ffffff80085f087c>] i2c_device_probe+0x164/0x228
[    1.663921] [<ffffff8008488124>] driver_probe_device+0x204/0x2b0
[    1.669884] [<ffffff800848827c>] __driver_attach+0xac/0xb0
[    1.675330] [<ffffff80084860d8>] bus_for_each_dev+0x60/0xa0
[    1.680862] [<ffffff80084878b0>] driver_attach+0x20/0x28
[    1.686135] [<ffffff80084874a8>] bus_add_driver+0x1d0/0x238
[    1.691668] [<ffffff8008488a40>] driver_register+0x60/0xf8
[    1.697116] [<ffffff80085f19e0>] i2c_register_driver+0x38/0x88
[    1.702909] [<ffffff8008ad6a4c>] tda998x_driver_init+0x18/0x20
[    1.708701] [<ffffff8008081a10>] do_one_initcall+0x38/0x128
[    1.714234] [<ffffff8008ab0cc0>] kernel_init_freeable+0x14c/0x1f0
[    1.720286] [<ffffff8008782b08>] kernel_init+0x10/0x100
[    1.725475] [<ffffff8008084e10>] ret_from_fork+0x10/0x40
[    1.730771] [drm:drm_sysfs_connector_add] *ERROR* failed to register connector device: -2
[    1.745136] mali-dp 6f200000.malidp: failed to bind 1-0070 (ops tda998x_ops): -2
[    1.752506] [drm:malidp_bind] *ERROR* Failed to bind all components

Best regards,
Liviu


> -Daniel
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> +41 (0) 79 365 57 48 - http://blog.ffwll.ch
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
