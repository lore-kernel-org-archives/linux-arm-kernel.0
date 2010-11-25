From: marcus.xm.lorentzon@stericsson.com (Marcus LORENTZON)
Date: Thu, 25 Nov 2010 13:25:24 +0100
Subject: [PATCH 09/10] MCDE: Add build files and bus
In-Reply-To: <F45880696056844FA6A73F415B568C6953604E802E@EXDCVYMBSTM006.EQ1STM.local>
References: <F45880696056844FA6A73F415B568C6953604E802E@EXDCVYMBSTM006.EQ1STM.local>
Message-ID: <C832F8F5D375BD43BFA11E82E0FE9FE0082586F12D@EXDCVYMBSTM005.EQ1STM.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,
Comments inline.

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd at arndb.de]
> Sent: den 12 november 2010 17:23
> To: linux-arm-kernel at lists.infradead.org
> Cc: Jimmy RUBIN; linux-fbdev at vger.kernel.org; linux-
> media at vger.kernel.org; Dan JOHANSSON; Linus WALLEIJ
> Subject: Re: [PATCH 09/10] MCDE: Add build files and bus
> 
> On Wednesday 10 November 2010, Jimmy Rubin wrote:
> > This patch adds support for the MCDE, Memory-to-display controller,
> > found in the ST-Ericsson ux500 products.
> >
> > This patch adds the necessary build files for MCDE and the bus that
> > all displays are connected to.
> >
> 
> Can you explain why you need a bus for this?

The idea of the bus is to make it easier to add new panel/display support using the normal device/driver model. Boards add devices at init, and drivers are selected in config. If we were to model the "real physical" bus structure it would be very complex, hard to use. We use our own bus, but it's really a virtual bus for adding display devices and drivers to MCDE host. Is there any "generic virtual bus type" we should use instead of our own type? If you have another idea of how to add display devices and drivers without MCDE code modifications, please let us know. A virtual bus just give us a nice framework to do this.

> With the code you currently have, there is only a single driver
> associated
> with this bus type, and also just a single device that gets registered
> here!

And yes, currently there's only one single driver. But there's a lot more coming in the pipe. Like some LCD, DPI, DBI, DSI display drivers. And once all different u8500 boards are pushed, there will be multiple boards registering devices with different setups. But one thing at a time.

> >+static int __init mcde_subsystem_init(void)
> >+{
> >+       int ret;
> >+       pr_info("MCDE subsystem init begin\n");
> >+
> >+       /* MCDE module init sequence */
> >+       ret = mcde_init();
> >+       if (ret)
> >+               return ret;
> >+       ret = mcde_display_init();
> >+       if (ret)
> >+               goto mcde_display_failed;
> >+       ret = mcde_dss_init();
> >+       if (ret)
> >+               goto mcde_dss_failed;
> >+       ret = mcde_fb_init();
> >+       if (ret)
> >+               goto mcde_fb_failed;
> >+       pr_info("MCDE subsystem init done\n");
> >+
> >+       return 0;
> >+mcde_fb_failed:
> >+       mcde_dss_exit();
> >+mcde_dss_failed:
> >+       mcde_display_exit();
> >+mcde_display_failed:
> >+       mcde_exit();
> >+       return ret;
> >+}
> 
> Splitting up the module into four sub-modules and then initializing
> everything from one place indicates that something is done wrong
> on a global scale.
> 
> If you indeed need a bus, that should be a separate module that gets
> loaded first and then has the other modules build on top of.

Yes, that's the general idea. We don't completely understand the correct way of making sure how one module gets loaded before another, without selecting init level, like the fs_initcall below you commented on. I guess most of our submodules should be initialized during subsys_init. But we have not found how to specify the module init order inside subsys init level. Maybe you can shed some light on this? Makefile order seems like a fragile way of defining init order dependencies.
Do you think static init calls from machine subsys init are a better solution?

> I'm not sure how the other parts layer on top of one another, can you
> provide some more insight?

+----------------------------+
| mcde_fb/mcde_kms/mcde_v4l2 |
+---------------+------------+
|    mcde_dss   |
+   +-----------+
|   | disp drvs |
+---+-----------+
|    mcde hw    |
+---------------+
|      HW       |
+---------------+

> From what I understood so far, you have a single multi-channel display
> controller (mcde_hw.c) that drives the hardware.
> Each controller can have multiple frame buffers attached to it, which
> in turn can have multiple displays attached to each of them, but your
> current configuration only has one of each, right?

Correct, channels A/B (crtcs) can have two blended "framebuffers" plus background color, channels C0/C1 can have one framebuffer.

> Right now you have a single top-level bus device for the displays,
> maybe that can be integrated into the controller so the displays are
> properly rooted below the hardware that drives them.

Not sure I understand 100%. Routing is independent of bus structure. Routing could change dynamically during runtime reconfiguration using future KMS for example. Bus is only for connecting display devices with drivers. Of course we could have one bus per port/connector. But then the code would be more complex and we would end up with one bus/device/driver per connector (or in some rare cases 2-4 on DBI/DSI connectors).

> The frame buffer device also looks weird. Right now you only seem
> to have a single frame buffer registered to a driver in the same
> module. Is that frame buffer not dependent on a controller?

MCDE framebuffers are only depending on MCDE DSS. DSS is the API that will be used by all user space APIs so that we don't have to duplicate the common code. We are planning mcde_kms and mcde_v4l2 drivers on top of MCDE DSS(=Display Sub System).

> >+#ifdef MODULE
> >+module_init(mcde_subsystem_init);
> >+#else
> >+fs_initcall(mcde_subsystem_init);
> >+#endif
> 
> This is not a file system ;-)

Yes, we know :)

Any comments on how to control the init order of multiple modules with init order dependencies are very welcome.

/BR
/Marcus
