From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 29 Mar 2013 13:22:38 +0000
Subject: [PATCH v3] [RFC] arm: use PSCI if available
In-Reply-To: <51548E1C.4070508@gmail.com>
References: <1364388639-11210-1-git-send-email-stefano.stabellini@eu.citrix.com>
 <20130327133811.GE18429@mudshark.cambridge.arm.com>
 <alpine.DEB.2.02.1303271610430.4430@kaball.uk.xensource.com>
 <20130327172306.GB20990@mudshark.cambridge.arm.com>
 <alpine.DEB.2.02.1303281225050.4430@kaball.uk.xensource.com>
 <alpine.LFD.2.03.1303281048060.1372@syhkavp.arg> <51545BE4.9050206@gmail.com>
 <alpine.LFD.2.03.1303281135320.1372@syhkavp.arg> <51548E1C.4070508@gmail.com>
Message-ID: <alpine.DEB.2.02.1303291257060.4430@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 28 Mar 2013, Rob Herring wrote:
> On 03/28/2013 10:39 AM, Nicolas Pitre wrote:
> > On Thu, 28 Mar 2013, Rob Herring wrote:
> > 
> >> On 03/28/2013 09:51 AM, Nicolas Pitre wrote:
> >>> On Thu, 28 Mar 2013, Stefano Stabellini wrote:
> >>>
> >>>> - the interface to bring up secondary cpus is different and based on
> >>>> PSCI, in fact Xen is going to add a PSCI node to the device tree so that
> >>>> Dom0 can use it.
> >>>>
> >>>> Oh wait, Dom0 is not going to use the PSCI interface even if the node is
> >>>> present on device tree because it's going to prefer the platform smp_ops
> >>>> instead.
> >>>
> >>> Waitaminute...  I must have missed this part.
> >>>
> >>> Who said platform specific methods must be used in preference to PSCI?
> >>
> >> I did. Specifically, I said the platform should be allowed to provide
> >> its own smp_ops. A platform may need to do addtional things on top of
> >> PSCI for example.
> > 
> > Then the platform should have its special hook that would override the 
> > default PSCI methods.  But, by *default* the PSCI methods should be used 
> > if the related DT information is present.
> 
> Agreed. The special hook to override is setting mach desc smp_ops, right?

If you consider the mach smp_ops a platform specific override, then
again PSCI and providing a PSCI node on DT doesn't solve the Xen problem
at all.

See above: Xen adds a PSCI node to DT, and Linux still does not use it.


> >>> If DT does provide PSCI description, then PSCI should be used.  Doing 
> >>> otherwise is senseless.  If PSCI is not to be used, then it should not 
> >>> be present in DT.
> >>
> >> You can't assume the DT and kernel are in-sync. For example, I've added
> >> PSCI in the firmware and DTB (part of the firmware), but the highbank
> >> kernel may or may not use it depending if I convert it.
> > 
> > If the kernel does not understand PSCI bindings in the DT, it naturally 
> > won't use PSCI, right?  Conversely, if the firmware and therefore 
> > provided DT don't have PSCI, then the PSCI enabled kernel won't use PSCI 
> > either. So what is the problem?
> 
> I'm distinguishing the kernel in general is enabled for PSCI and a
> platform is enabled. The kernel may have PSCI smp_ops and the DTB may
> have PSCI data, but that alone should not make a platform use the
> default PSCI smp_ops. The platform has to make the decision and it
> cannot be just based on the platform's dtb having PSCI data.

I can see how this would give greater flexibility to firmware
developers, but on the other hand it would limit the flexibility of the
kernel.

In fact, unfortunately, it is diametrically the opposite of what Xen
needs.

I would kindly ask the maintainers to let me know what direction I
should take to move forward.
