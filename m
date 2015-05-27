From: l.stach@pengutronix.de (Lucas Stach)
Date: Wed, 27 May 2015 11:05:38 +0200
Subject: [PATCH] ARM: imx6: allow booting with old DT
In-Reply-To: <5565815E.2040400@arm.com>
References: <1432658616-13733-1-git-send-email-l.stach@pengutronix.de>
 <20150527073408.GD16165@dragon> <1432713148.3011.6.camel@pengutronix.de>
 <55657B50.7000006@arm.com> <1432714807.3011.15.camel@pengutronix.de>
 <5565815E.2040400@arm.com>
Message-ID: <1432717538.3011.28.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, den 27.05.2015, 09:33 +0100 schrieb Marc Zyngier:
> On 27/05/15 09:20, Lucas Stach wrote:
> > Am Mittwoch, den 27.05.2015, 09:07 +0100 schrieb Marc Zyngier:
> >> On 27/05/15 08:52, Lucas Stach wrote:
> >>> Am Mittwoch, den 27.05.2015, 15:34 +0800 schrieb Shawn Guo:
> >>>> On Tue, May 26, 2015 at 06:43:36PM +0200, Lucas Stach wrote:
> >>>>> The GPC rewrite to IRQ domains has been on the premise that it may break
> >>>>> suspend/resume for new kernels on old DT, but otherwise keep things working
> >>>>> from a user perspective. This was an accepted compromise to be able to move
> >>>>> the GIC cleanup forward.
> >>>>>
> >>>>> What actually happened was that booting a new kernel on an old DT crashes
> >>>>> before even the console is up, so the user does not even see the warning
> >>>>> that the DT is too old. The warning message suggests that this has been
> >>>>> known before, which is clearly unacceptable.
> >>>>
> >>>> To see any early message like this one, low-level debug support is
> >>>> expected to be turned on.
> >>>>
> >>> Using low-level debug might be acceptable for a developer.
> >>>
> >>> From a user perspective a kernel update without a corresponding DT
> >>> update should never render the machine completely broken. Keep in mind
> >>> that i.MX6 isn't only used in deeply embedded system, but is already in
> >>> devices where non-developer users might update the kernel. They might
> >>> even use prebuilt kernels where enabling low-level debug is not an
> >>> option.
> >>
> >> I'd imagine that whoever provides this pre-build kernel would also
> >> deliver some form of release notes indicating the procedure. Even
> >> better, an installation script.
> >>
> >>> We are not free to break the existing DT stability rules in such a
> >>> drastic way, especially if keeping things working to some extent is
> >>> easily done.
> >>
> >> That would be on the condition that the DT was correct the first place,
> >> and accurately described the hardware. It didn't, breaking the contract
> >> we have the first place.
> >>
> >> We can argue for years about DT stability, history proves that it
> >> doesn't lead anywhere.
> >>
> > The fact that we are still in a learning phase with regard to DT and
> > have made mistakes in the past (and I'm sure we will still do some in
> > the future) isn't an excuse for not even trying to keep the stability.
> > 
> > In this case there was a clear consent that we break DT stability by
> > rendering suspend/resume broken. This was the accepted compromise
> > between DT stability and the highly needed GIC cleanup.
> > Completely breaking an entire SoC family in early boot was not part of
> > the the compromise! Especially as it isn't really hard to keep things
> > working to the specified extent, as this patch proves.
> 
> This patch series has been on the list for months, in -next for several
> weeks, and now in mainline for about a month. I would have appreciated
> your input and your patch during that time so that your pet platform
> would have been kept in an acceptable shape. Others have done so, you
> didn't.
> 
We are still in the RC phase of 4.1, so no harm has been done other than
upsetting some developers and potential adventurous users. So we are
still right in time to fix this.

I don't have the bandwidth to test every patchset flying by and while I
didn't provide an explicit ack, I was okay with it by looking at it.
Honestly I trusted you that the patchset does what was stated in the
commit message, which is break suspend/resume but otherwise keep things
working. 

> If you have such a vested interest in keeping this SoC on a smooth
> upgrade path, then I suggest you at least follow the various patch
> series potentially touching it, and contribute in a timely manner.
> Understand that people don't necessarily have access to your favourite
> piece of HW, and may overlook that kind of detail. I rely on others to
> let me know about it, and I encourage you to do so.
> 
I'm fine with fixing things at the RC stages and I did not blame anyone
personally. What is not okay is that the commit messages of the series
didn't provide a hint for this kind of breakage.
Until v6 of this series the warning message read "Outdated DT detected,
suspend/resume will NOT work", only later it was changed to "Outdated DT
detected, system is about to crash!!!", which seems to indicate that you
were aware of the breakage, but neglected to explicitly state this in a
commit message where it is easily accessible for other developers
looking at the patches or resolve the problem.

Also the attitude of saying "DT stability has been broken in the past so
why bother with it in the future" is troubling IMHO.

Regards,
Lucas
-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
