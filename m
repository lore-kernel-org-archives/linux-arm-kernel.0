From: marcus.xm.lorentzon@stericsson.com (Marcus LORENTZON)
Date: Thu, 25 Nov 2010 19:00:26 +0100
Subject: [PATCH 09/10] MCDE: Add build files and bus
In-Reply-To: <201011251747.48365.arnd@arndb.de>
References: <F45880696056844FA6A73F415B568C6953604E802E@EXDCVYMBSTM006.EQ1STM.local>
	<C832F8F5D375BD43BFA11E82E0FE9FE0082586F12D@EXDCVYMBSTM005.EQ1STM.local>
	<201011251747.48365.arnd@arndb.de>
Message-ID: <C832F8F5D375BD43BFA11E82E0FE9FE0082586F430@EXDCVYMBSTM005.EQ1STM.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd at arndb.de]
> Sent: den 25 november 2010 17:48
> To: Marcus LORENTZON
> Cc: linux-arm-kernel at lists.infradead.org; Jimmy RUBIN; linux-
> media at vger.kernel.org; Dan JOHANSSON; Linus WALLEIJ
> Subject: Re: [PATCH 09/10] MCDE: Add build files and bus
>
> On Thursday 25 November 2010, Marcus LORENTZON wrote:
> > From: Arnd Bergmann [mailto:arnd at arndb.de]
> > > On Wednesday 10 November 2010, Jimmy Rubin wrote:
> > > > This patch adds support for the MCDE, Memory-to-display
> controller,
> > > > found in the ST-Ericsson ux500 products.
> > > >
> > > > This patch adds the necessary build files for MCDE and the bus
> that
> > > > all displays are connected to.
> > > >
> > >
> > > Can you explain why you need a bus for this?
> >
> > The idea of the bus is to make it easier to add new panel/display
> support
> > using the normal device/driver model. Boards add devices at init, and
> > drivers are selected in config. If we were to model the "real
> physical"
> > bus structure it would be very complex, hard to use. We use our own
> bus,
> > but it's really a virtual bus for adding display devices and drivers
> to
> > MCDE host. Is there any "generic virtual bus type" we should use
> instead
> > of our own type? If you have another idea of how to add display
> devices
> > and drivers without MCDE code modifications, please let us know. A
> virtual
> > bus just give us a nice framework to do this.
>
> All devices that you cannot probe by asking hardware or firmware are
> normally
> considered platform devices. Then again, a platform device is usally
> identified by its resources, i.e. MMIO addresses and interrupts, which
> I guess your display does not have.

Then we might be on right track to model them as devices on a platform bus. Since most displays/panels can't be "plug-n-play" probed, instead devices has to be statically declared in board-xx.c files in mach-ux500 folder. Or is platform bus a "singleton"? Or can we define a new platform bus device?
Displays like HDMI TV-sets are not considered for device/driver in mcde. Instead there will be a hdmi-chip-device/driver on the mcde bus. So all devices and drivers on this bus are static.

> > > With the code you currently have, there is only a single driver
> > > associated
> > > with this bus type, and also just a single device that gets
> registered
> > > here!
> >
> > And yes, currently there's only one single driver. But there's a lot
> more
> > coming in the pipe. Like some LCD, DPI, DBI, DSI display drivers. And
> once
> > all different u8500 boards are pushed, there will be multiple boards
> > registering devices with different setups. But one thing at a time.
>
> Your approach is making it hard to review the code in context. Adding a
> device driver that uses existing infrastructure is usually
> straightforward,
> but adding infrastructure is a hard thing and needs to be done with
> great
> care, especially if you add infrastructure before it actually is
> needed.
>
> Staging it in a way that adds all the display drivers later than the
> base driver is a good idea, but it would be helpful to also add the
> infrastructure at the later stage. Maybe you can try to simplify the
> code for now by hardcoding the single display and remove the dynamic
> registration. You still have the the code, so once the base code looks
> good for inclusion, we can talk about it in the context of adding
> dynamic display support back in, possibly in exactly the way you are
> proposing now, but perhaps in an entirely different way if we come up
> with a better solution.

What about starting with MCDE HW, which is the core HW driver doing all real work? And then continue with the infrastructure + some displays + drivers ...
Only problem is that we then have a driver that can't be used from user space, because I don't think I can find anyone with enough time to write a display driver + framebuffer on top of mcde_hw (which is what the existing code does).

> On a more abstract level, when you want to add large chunks of code
> to the kernel, you often cannot find anyone to review and understand
> all of it at once. Splitting a subsystem into ten patches by file
> level rarely helps, so instead you should ideally have a series of
> patches that each add working code that enable more features.
>
> This is of course more work for you, especially if you did not consider
> it while writing the code in the first place. Still, you should
> always try hard to make code easy to review as much as possible,
> because you need to work with reviewers both to get code in and to
> make sure you make the quality ends up as good as possible.
>
> > > >+static int __init mcde_subsystem_init(void)
> > > >+{
> > > >+       int ret;
> > > >+       pr_info("MCDE subsystem init begin\n");
> > > >+
> > > >+       /* MCDE module init sequence */
> > > >+       ret = mcde_init();
> > > >+       if (ret)
> > > >+               return ret;
> > > >+       ret = mcde_display_init();
> > > >+       if (ret)
> > > >+               goto mcde_display_failed;
> > > >+       ret = mcde_dss_init();
> > > >+       if (ret)
> > > >+               goto mcde_dss_failed;
> > > >+       ret = mcde_fb_init();
> > > >+       if (ret)
> > > >+               goto mcde_fb_failed;
> > > >+       pr_info("MCDE subsystem init done\n");
> > > >+
> > > >+       return 0;
> > > >+mcde_fb_failed:
> > > >+       mcde_dss_exit();
> > > >+mcde_dss_failed:
> > > >+       mcde_display_exit();
> > > >+mcde_display_failed:
> > > >+       mcde_exit();
> > > >+       return ret;
> > > >+}
> > >
> > > Splitting up the module into four sub-modules and then initializing
> > > everything from one place indicates that something is done wrong
> > > on a global scale.
> > >
> > > If you indeed need a bus, that should be a separate module that
> gets
> > > loaded first and then has the other modules build on top of.
> >
> > Yes, that's the general idea. We don't completely understand the
> correct
> > way of making sure how one module gets loaded before another, without
> > selecting init level, like the fs_initcall below you commented on. I
> > guess most of our submodules should be initialized during
> subsys_init.
> > But we have not found how to specify the module init order inside
> subsys
> > init level. Maybe you can shed some light on this? Makefile order
> seems
> > like a fragile way of defining init order dependencies.
> > Do you think static init calls from machine subsys init are a better
> solution?
>
> In general, the idea with loadable modules is that you can only load
> them in initialization order because of the symbol dependencies: The
> bus
> gets loaded first and it exports symbols used by the device drivers,
> so a device driver can be sure that the bus is initialized entirely.
>
> For the case where all modules are built-in, you can rely in link-order
> in the Makefile, e.g.
>
> obj-$(CONFIG_FOO_BASE)                += foo_base.o
> obj-$(CONFIG_FOO_SPECIFIC)    += foo_specific.o # this comes after
> foo_base

Ok, we will do this for the mcde stuff. How do we handle stuff that span different kernel folders? Like drivers/misc and drivers/video/mcde etc. We can't just change the order of top level makefiles, that would break other drivers I guess.

> > > I'm not sure how the other parts layer on top of one another, can
> you
> > > provide some more insight?
> >
> > +----------------------------+
> > | mcde_fb/mcde_kms/mcde_v4l2 |
> > +---------------+------------+
> > |    mcde_dss   |
> > +   +-----------+
> > |   | disp drvs |
> > +---+-----------+
> > |    mcde hw    |
> > +---------------+
> > |      HW       |
> > +---------------+
>
> Ok. One problem with this is that once you have a multitude of
> display drivers, you can no longer layer them below mcde_dss.

Not sure what you mean, we have plenty of drivers and devices already. Maybe I should try to clarify picture.

DSS give access to all display devices probed on the virtual mcde dss bus, or platform bus with specific type of devices if you like. All calls to DSS operate on a display device, like create an overlay(=framebuffer), request an update, set power mode, etc. All calls to DSS related to display itself and not only framebuffer scanout, will be passed on to the display driver of the display device in question. All calls DSS only related to overlays, like buffer pointers, position, rotation etc is handled directly by DSS calling mcde_hw.
You could see mcde_hw as a physical level driver and mcde_dss closer to a logical driver, delegating display specific decisions to the display driver. Another analogy is mcde_hw is host driver and display drivers are client device drivers. And DSS is a collection of logic to manage the interaction between host and client devices.

> Having the kms/fb/v4l2 drivers on top definitely makes sense, so
> these should all be able to be standalone loadable modules.
> I do not understand why you have a v4l2 driver at all, or why
> you need both fb and kms drivers, but that is probably because
> of my ignorance of display device drivers.

All APIs have to be provided, these are user space API requirements. KMS has a generic FB implementation. But most of KMS is modeled by desktop/PC graphics cards. And while we might squeeze MCDE in to look like a PC card, it might also just make things more complex and restrict us to do things not possible in PC architecture. Alex Deucher noted in a previous post that we also have the option of implementing the KMS ioctls. We are looking at both options. And having our own framebuffer driver might make sense since it is a very basic driver, and it will allow us to easily extend support for things like partial updates for display panels with on board memory. These panels with memory (like DSI command mode displays) is one of the reasons why KMS is not the perfect match. Since we want to expose features available for these types of displays.

> > > From what I understood so far, you have a single multi-channel
> display
> > > controller (mcde_hw.c) that drives the hardware.
> > > Each controller can have multiple frame buffers attached to it,
> which
> > > in turn can have multiple displays attached to each of them, but
> your
> > > current configuration only has one of each, right?
> >
> > Correct, channels A/B (crtcs) can have two blended "framebuffers"
> plus
> > background color, channels C0/C1 can have one framebuffer.
>
> We might still be talking about different things here, not sure.

In short,
KMS connector = MCDE port
KMS encoder = MCDE channel
KMS crtc = MCDE overlay

> > > Right now you have a single top-level bus device for the displays,
> > > maybe that can be integrated into the controller so the displays
> are
> > > properly rooted below the hardware that drives them.
> >
> > Not sure I understand 100%. Routing is independent of bus structure.
> > Routing could change dynamically during runtime reconfiguration using
> > future KMS for example. Bus is only for connecting display devices
> > with drivers. Of course we could have one bus per port/connector.
> > But then the code would be more complex and we would end up with one
> > bus/device/driver per connector (or in some rare cases 2-4 on DBI/DSI
> > connectors).
>
> I mean 'root' as in the root of your device tree, where the tree
> is modeled after the logical layout of your hardware.
>
> Looking at the representation in sysfs, you should probably aim
> for something like
>
> /sys/devices/axi/axi0/mcde_controller
>                               /chnlA
>                                       /dspl_crtc0
>                                               /fb0
>                                               /fb1
>                                               /v4l_0
>                                       /dspl_dbi0
>                                               /fb2
>                                               /v4l_1
>                               /chnlB
>                                       /dspl_ctrc1
>                                               /fb3
>                               /chnlC
>                                       /dspl_lcd0
>                                               /fb4
>                                               /v4l_2
>
> Not sure if that is close to what your hardware would really
> look like. My point is that all the objects that you are
> dealing with as a device driver should be represented hierarchically
> according to how you probe them.

Yes, mcde_bus should be connected to mcde, this is a bug. The display drivers will placed in this bus, since this is where they are probed like platform devices, by name (unless driver can do MIPI standard probing or something). Framebuffers/V4L2 overlay devices can't be put in same hierarchy, since they have multiple "parents" in case the same framebuffer is cloned to multiple displays for example. But I think I understand your more general point of sysfs representing the "real" probe hierarchy. And this is something we will look at.

> Assuming the structure above is correct and you cannot probe
> any of this by looking at registers, you would put a description
> of it into the a data structure (ideally a flattened device tree
> or a section of one) and let the probing happen:
>
> * The axi core registers an mcde controller as device axi0.
> * udev matches the device and loads the mcde hw driver from
>   user space

We are trying to avoid dynamic driver loading and udev for platform devices to be able to show application graphics within a few seconds after boot.

> * the hw driver creates a device for each channel, and passes
>   the channel specific configuration data to the channel device

We have to migrate displays in runtime between different channels (different use cases and different channel features), we don't want to model displays as probed beneath the channel. Maybe the port/connector could be a device. But that code is so small, so it might just add complexity to visualize sysfs hierarchy. What do you think?

> * the dss driver gets loaded through udev and matches all the
>   channels
> * the dss driver creates the display devices below each channel,
>   according to the configuration data it got passed.

"All" display devices need static platform_data from mach-ux500/board-xx.c. This is why we have the bus, to bind display dev and driver.

> * The various display drivers get loaded through udev as needed
>   and match the display devices
> * Each display device driver initializes the display and creates
>   the high-level devices (fb and v4l) as needed.

This is setup by board/product specific code. Display drivers just enable use of the HW, not defining how the displays are used from user space.

> * Your fb and v4l highlevel drivers get loaded through udev and
>   bind to the devices, creating the user space device nodes
>   through their subsystems.
>
> Now this would be the most complex scenerio that hopefully is
> not really needed, but I guess it illustrates the concept.
> I would guess that you can actually reduce this significantly
> if you do not actually need all the indirections.
>
> Some parts could also get simpler if you change the layering,
> e.g. by making the v4l and fb drivers library code and having
> the display drivers call them, rather than have the display
> drivers create the devices that get passed to upper drivers.

Devices are static from mach-ux500/board-xx. And v4l2/fb setup is board/product specific and could change dynamically.

> > > The frame buffer device also looks weird. Right now you only seem
> > > to have a single frame buffer registered to a driver in the same
> > > module. Is that frame buffer not dependent on a controller?
> >
> > MCDE framebuffers are only depending on MCDE DSS. DSS is the API that
> > will be used by all user space APIs so that we don't have to
> duplicate
> > the common code. We are planning mcde_kms and mcde_v4l2 drivers on
> top
> > of MCDE DSS(=Display Sub System).
>
> My impression was that you don't need a frame buffer driver if you have
> a kms driver, is this wrong?

No, see above. Just that we have mcde dss to support multiple user space apis by customer request. Then doing our own fb on top of that is very simple and adds flexibility.

> What does the v4l2 driver do? In my simple world, displays are for
> output
> and v4l is for input, so I must have missed something here.

Currently nothing, since it is not finished. But the idea (and requirement) is that normal graphics will use framebuffer and video/camera overlays will use v4l2 overlays. Both using same mcde channel and display. Some users might also configure their board to use two framebuffers instead. Or maybe only use KMS etc ...

Thanks for all your experience sharing and feedback!

/BR
/Marcus
