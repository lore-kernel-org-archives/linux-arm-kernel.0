From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Thu, 27 Nov 2014 00:01:44 +0100
Subject: [PATCH] ARM: OMAP2+: Warn about deprecated legacy booting mode
In-Reply-To: <20141126200806.GO2817@atomide.com>
References: <20141027200008.GR2560@atomide.com> <201411262022.03338@pali>
 <20141126200806.GO2817@atomide.com>
Message-ID: <201411270001.44871@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 26 November 2014 21:08:06 Tony Lindgren wrote:
> * Pali Roh?r <pali.rohar@gmail.com> [141126 11:24]:
> > On Wednesday 26 November 2014 20:10:28 Tony Lindgren wrote:
> > > * Pali Roh?r <pali.rohar@gmail.com> [141126 10:59]:
> > > > On Wednesday 26 November 2014 19:19:35 Tony Lindgren 
wrote:
> > > > > Maybe Pali can try to restart that discussion? To me
> > > > > it seems the /proc/cpuinfo should be the same as it's
> > > > > a user interface. Sorry forgot the details of the
> > > > > previous discussion..
> > > > 
> > > > Yes, two days ago I again wrote emails about this
> > > > problem...
> > > > 
> > > > E.g. one of them, see:
> > > > https://lkml.org/lkml/2014/11/24/774
> > > > 
> > > > > And with which app was that? Sorry I forgot..
> > > > 
> > > > More applications/libraries for N900 which running on
> > > > Maemo 5 system. Some of them are Nokia proprietary,
> > > > some of them are open source and some are mine.
> > > > 
> > > > Basically problem is that non DT boot provides this info
> > > > in /proc/cpuinfo:
> > > > 
> > > > Hardware        : Nokia RX-51 board
> > > > Revision        : 0012
> > > > 
> > > > New DT boot provides this:
> > > > 
> > > > Hardware        : Generic OMAP3 (Flattened Device Tree)
> > > > Revision        : 0000
> > > 
> > > Oh you can easily fix that by adding a n900 specific
> > > DT_MACHINE_START entry to mach-omap2/board-generic.c.
> > 
> > I would like to see some solution which does not depend on
> > distributing addition patch which will not be in mainline
> > kernel...
> 
> Yes mainline of course. Maybe you misunderstood what I was
> suggesting, maybe try the attached patch to fix the "Hardware"
> line problem in /proc/cpuinfo?
> 

With your patch I'm getting:

Hardware        : Nokia RX-51 board

So patch is good.

> > For this problem I proposed patch (which was rejected):
> > https://lkml.org/lkml/2014/6/18/853
> 
> Yes I think that should continue as a separate discussion
> too if there are other differences in /proc/cpuinfo.
> 
> > Basically Hardware is used to check if application is
> > running on Nokia N900 or not. Also entry from Hardware is
> > appended to Web browser user agent and some internet
> > services using it as identifier (N900 device).
> > 
> > > The revision entry you can populate too in pdata-quirks.c,
> > > or maybe add something generic to populate it based on the
> > > cmdline or a dts entry as I believe that comes from the
> > > legacy ATAGs. I think that's just the system_rev or some
> > > other *_rev global in the kernel.
> > 
> > Revision comes from bootloader (via ATAG) and it is HW
> > revision of N900 device. It cannot be hardcoded into kernel
> > or DTS as it it depends on HW.
> 
> Well for the "Revision" line problem, we could pass the
> revision in cmdline or .dts if not passed in the legacy
> ATAGs. It sounds like were just not copying it to system_rev
> for DT based booting? Maybe it's just some missing
> CONFIG_ATAG option that needs to be enabled?
> 
> Regards,
> 
> Tony
> 

Yes it looks like DT code does not read Revision ATAG... I tried 
to enable everything but always same problem...

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141127/a7a93e38/attachment.sig>
