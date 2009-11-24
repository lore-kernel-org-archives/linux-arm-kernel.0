From: daniel@caiaq.de (Daniel Mack)
Date: Tue, 24 Nov 2009 14:07:17 +0100
Subject: USB support on i.MX27
In-Reply-To: <37367b3a0911240431m3bbf9520of88152c299f80ceb@mail.gmail.com>
References: <37367b3a0911240343u58e3b3d2le5d48e638348a3ad@mail.gmail.com>
	<20091124115737.GR14091@buzzloop.caiaq.de>
	<37367b3a0911240431m3bbf9520of88152c299f80ceb@mail.gmail.com>
Message-ID: <20091124130717.GS14091@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 24, 2009 at 10:31:12AM -0200, Alan Carvalho de Assis wrote:
> On 11/24/09, Daniel Mack <daniel@caiaq.de> wrote:
> > On Tue, Nov 24, 2009 at 09:43:41AM -0200, Alan Carvalho de Assis wrote:
> >> I am trying to add USB support to i.MX27 on mainline linux kernel, I
> >> am following your modifications as in this post:
> >>
> >> "Re: Comment to "[PATCH 7/8] Add EHCI support for MX27 and MX31 based
> >> boards"
> >>
> >> I can't find xcvr.h and isp1504_xcvr.h then I copied fsl_xcvr.h from
> >> FSL kernel to mainline:
> >>
> >> alan at metropolis:~/ltib-patches/ltib/rpm/BUILD/linux$ cp
> >> include/linux/usb/fsl_xcvr.h
> >> ~/linux/pengutronix/linux-2.6/include/linux/usb/xcvr.h
> >>
> >> But I can't to figure out where to find isp1504_xcvr.h.
> >
> > There is nothing special about the ISP1504. On the register level, it is
> > compliant to generic ULPI transceivers, and hence the driver in mainline
> > was named accordingly. There is nothing you need to add from the BSPs
> > anymore, everything is on its way to mainline already.
> >
> 
> Hmm, then don't need I to add ISP1504 driver from FSL kernel? Great!

Correct.

> > There are a number of boards that implement USB support already for MX3,
> > and they're all in Sascha's tree. Most of them have been added just
> > recently, so make sure you're looking at the newest source. As mentioned
> > above, for ISP1504, you just need create a generic ULPI transceiver.
> >
> 
> I am using mxc-master updated but there is nothing related to usb or
> otg on mx31lilly.c. Fortunately I figure out mx31moboard.c has it. I
> will base on it for now.

The support is in mx31lilly-db.c which is the _board_ specific code.
People might decide to not have USB on their custom boards, and so this
functions are not enabled from the module code (mx31lilly.c).

> > The only thing that is missing is code that maps the .flags and maybe
> > .portsc settings from the mxc_usbh_platform_data struct to the
> > appropriate registers on MX27. And of course, your board support will
> > need some IOMUX settings.
> >
> 
> Yes, to configure external pins, but I will base on old FSL kernel to
> get it working.

Mixing those versions is not recommended. Try using a kernel based on
mxc-master, apply the pending USB patches manually and modify the EHCI
driver so it works for MX27. A patch that diffs between your version and
the latest USB patches would be appreciated.

If that works, a second patch to add USB to MX27ADS would be the next
step.

Daniel
