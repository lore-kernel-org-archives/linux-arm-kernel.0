From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 11 Nov 2015 14:31:33 +0100
Subject: [PATCH v2 1/7] timekeeping: introduce __current_kernel_time64
In-Reply-To: <alpine.DEB.2.02.1511101656330.5676@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1511101131350.5676@kaball.uk.xensource.com>
 <alpine.DEB.2.11.1511101046420.3915@nanos>
 <alpine.DEB.2.02.1511101656330.5676@kaball.uk.xensource.com>
Message-ID: <23540141.N5sax8EYBi@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 11 November 2015 11:51:26 Stefano Stabellini wrote:
> On Tue, 10 Nov 2015, Thomas Gleixner wrote:
> > On Tue, 10 Nov 2015, John Stultz wrote:
> > > I'm sort of objecting to a different issue, where the
> > > __current_kernel_time() implementation probably shouldn't be grabbing
> > > the tk_core.timekeeper directly, and instead should take a passed
> > > pointer to a timekeeper. The vdso/pv_clock usage should have a
> > > timekeeper passed to them that they could use.
> > 
> > That usage of __current_kernel_time() in that xen notifier is silly to
> > begin with. The notifier gets already called with a pointer to the
> > time keeper. That xen implementation just does not use it.
> >
> > We extract exactly that information in the vdso updates without
> > calling back into the core code. So for solving that xen thing we do
> > not need a 64 bit variant of __current_kernel_time() at all. The
> > notifier has the pointer to the timekeeper and can just grab data from
> > there.
> 
> Many thanks for the suggestion, I'll do that.
> Should I open code tk_xtime in the xen notifier, or should I export it
> in timekeeper_internal.h?

tk_xtime is a 'static inline' function, I don't see a good way to
make that accessible, and you really want the elements separately,
so I'd open-code it without going through timespec64.

	Arnd
