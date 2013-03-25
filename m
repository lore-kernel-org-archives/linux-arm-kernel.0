From: mgr@pengutronix.de (Michael Grzeschik)
Date: Mon, 25 Mar 2013 17:29:31 +0100
Subject: [PATCH v4 0/6] support other fsl SoCs with usbmisc + small fixes
In-Reply-To: <CAOMZO5ArDLKDLEzhYc7EP2CNQGcT=vO7ctbiEsjzsGs+EaT7Dw@mail.gmail.com>
References: <1354033021-10585-1-git-send-email-m.grzeschik@pengutronix.de>
 <20121128025217.GC18593@nchen-desktop>
 <87ip6mor1e.fsf@ashishki-desk.ger.corp.intel.com>
 <CAOMZO5ArDLKDLEzhYc7EP2CNQGcT=vO7ctbiEsjzsGs+EaT7Dw@mail.gmail.com>
Message-ID: <20130325162931.GB22810@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexander, Fabio, Greg,

On Mon, Mar 25, 2013 at 10:11:15AM -0300, Fabio Estevam wrote:
> Hi Alexander,
> 
> On Thu, Jan 24, 2013 at 7:42 AM, Alexander Shishkin
> <alexander.shishkin@linux.intel.com> wrote:
> > Peter Chen <peter.chen@freescale.com> writes:
> >
> >> On Tue, Nov 27, 2012 at 05:16:55PM +0100, Michael Grzeschik wrote:
> >>> Nearly every SoC from Freescale has this non-core usb registers. This series
> >>> adds support for more users of this driver.
> >>>
> >>> This series is based on Peter Chen's work. Its needed to merge his master branch
> >>> before applying this series:
> >>>
> >>> https://github.com/hzpeterchen/linux-usb.git
> >>
> >> I have tested it at i.mx6q sabrelite board, it works good.
> >>
> >> I have pushed your commit to my git, please cc me
> >> your coming chipidea patches, thanks.
> >>
> >> Alex, please add:
> >>
> >> Reviewed-by: Peter Chen <peter.chen@freescale.com>
> >> Tested-by: Peter Chen <peter.chen@freescale.com>
> >
> > Looks good, queueing this one for submission.
> 
> Could you please let us know what is preventing this series to be applied?

That's what our chipidea usb disaster currently looks like in detail:

http://git.pengutronix.de/git/mgr/linux.git v3.9/topic/usb-phy
4414a59 Merge 'v3.9/topic/usb-phy' into usb-3.9
a806027 usb: otg: mxs-phy: remove clkgate/sftrst clearing
026881b usb: otg: mxs-phy: Improve mxs phy initialization
ed42fa9 usb: mxs-phy: register phy at usb phy library
d2783aa usb: phy: remove NULL pointer check in usb_add_phy()

/*
 * The series usb-ci-udc has already been posted some times
 * but it currently got no replies by Alexander.
 */
http://git.pengutronix.de/git/mgr/linux.git v3.9/topic/usb-ci-udc
e548c9d Merge 'v3.9/topic/usb-ci-udc' into usb-3.9
80538f3 usb: chipidea: udc: add multiple td support to hardware_{en,de}queue
02e1c7b usb: chipidea: udc: manage dynamic amount of tds with an linked list
0ebb8f4 usb: chipidea: udc: prepare qhead with dma_alloc_coherent
39be042 usb: chipidea: udc: add the define TD_PAGE_COUNT and fix all users
c2f0562 usb: chipidea: udc: use gfp_flags in _hardware_enqueue
f818222 usb: chipidea: udc: move _ep_queue into an unlocked function
8aea3b0 usb: chipidea: udc: configure iso endpoints
8e61a12 usb: chipidea: udc: rework ep_enable cap setting
e5ceed7 usb: chipidea: udc: move ZLT flag change to ep_enable
2e33742 usb: chipidea: udc: read status of td only once in hardware_dequeue
516803b usb: chipidea: udc: only clear active and halted bits in qhead
ee95a49 usb: chipidea: udc: use {read,write}l to handle mapped data

http://git.pengutronix.de/git/mgr/linux.git v3.9/topic/imx-usbmisc
1174002 Merge 'v3.9/topic/imx-usbmisc' into usb-3.9
f406383 usb: chipidea: usbmisc: skip clocks on i.MX6
d5c8d53 usb: chipidea: usbmisc: use module_platform_driver
105d5d0 usb: chipidea: usbmisc: add support for ahb, ipg and per clock

http://git.pengutronix.de/git/mgr/linux.git v3.9/topic/imx-usb
df11f8b Merge 'v3.9/topic/imx-usb' into usb-3.9
9a967c4 usb: chipidea: udc: add force-full-speed option
a02af86 USB: chipidea: set STS bit in serial mode
af34326 usb: chipidea: ci13xxx_imx: add 2nd and 3rd clock to support imx5x and newer
5b7f6d8 usb: chipidea: pci: mark platformdata as static

/*
 * All above branches depent on the lower branches of Alexander and Peter
 * which we currently have rebased on v3.9-rc3 and on top of each other.
 * It is named alex-and-peter-for-3.9.
 */
http://git.pengutronix.de/git/mgr/linux.git alex-and-peter-for-3.9

/*
 * Peters branch already contain the usbmisc series,
 * but they never made it to ci-for-greg, although
 * Alexander already mentioned (24 Jan 2013) to queue them.
 */
https://github.com/hzpeterchen/linux-usb.git master^^
4d36511 Merge 'v3.9/topic/usb-peterchen'
90314f3 usb: chipidea: usbmisc: add post handling and errata fix for mx25
edde2ad usb: chipidea: usbmisc: add mx53 support
6150722 usb: chipidea: usbmisc: prepare driver to handle more than one soc
542384e usb: chipidea: usbmisc: fix a potential race condition
cdffb44 usb: chipidea: usbmisc: unset global varibale usbmisc on driver remove
b8e47e3 usb: chipidea: usbmisc: rename file, struct and functions to usbmisc_imx
c5863f9 usb: chipidea: imx: select usb id pin using syscon interface
8c8a1f5 usb: chipidea: udc: fix the oops when plugs in usb cable after rmmod gadget
c703723 usb: chipidea: imx: add getting vbus regulator code
e897d66 usb: chipidea: delete the delayed work
4c0be3e usb: chipidea: add vbus regulator control
f1e52f8 usb: chipidea: udc: retire the flag CI13_PULLUP_ON_VBUS
af4e743 usb: chipidea: udc: add pullup/pulldown dp at hw_device_state
1be0011 usb: chipidea: add otg id switch and vbus connect/disconnect detect
7c3c62d usb: chipidea: add otg file
618bfec Revert "USB: chipidea: add vbus detect for udc"
bfe5248 USB chipidea i.MX: use devm_usb_get_phy_by_phandle to get phy
705620f USB mxs-phy: Register phy with framework
f5e9796 USB chipidea i.MX: introduce dr_mode property
dc622c4 USB chipidea: introduce dual role mode pdata flags
b1d4a9e USB: chipidea: add PTW and PTS handling
747eee3 USB: chipidea: ci13xxx-imx: create dynamic platformdata
2f2bb89 USB: add devicetree helpers for determining dr_mode and phy_type
4f30039 USB: move bulk of otg/otg.c to phy/phy.c
760d9a8 nop-xceiv: make nop to use usb_add_phy_dev

/*
 * This branch is already one month old and stays untouched
 * /
https://github.com/hzpeterchen/linux-ci.git ci-for-greg
e0fe4d5 Merge 'ci-for-greg'
e160513 usb: chipidea: don't redefine __ffs()
93b27aa usb: chipidea: fix precedence bug in ci_requests_show()
67d0531 usb: chipidea: move debug files creation/removal to the core
5a958dd usb: chipidea: move role to debugfs
038429c usb: chipidea: convert debug entries in sysfs to debugfs
25dc0fb usb: chipidea: replace interrupt accounting with tracepoints
dc43e8c usb: chipidea: convert events to tracepoints
a84a5bf usb: chipidea: trim include list in the core
f2bf55e usb: chipidea: trim include list in udc code
adf1889 usb: chipidea: drop redundant includes

Thanks,
Michael

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
