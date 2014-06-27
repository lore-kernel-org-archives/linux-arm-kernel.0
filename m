From: dalias@libc.org (Rich Felker)
Date: Fri, 27 Jun 2014 18:26:26 -0400
Subject: [musl] Re: Thread pointer changes
In-Reply-To: <20140627220400.GT32514@n2100.arm.linux.org.uk>
References: <20140610072835.GA8466@brightrain.aerifal.cx>
 <20140611145533.GT179@brightrain.aerifal.cx>
 <53ADC5B1.6080905@amacapital.net>
 <20140627213743.GB16724@brightrain.aerifal.cx>
 <20140627220400.GT32514@n2100.arm.linux.org.uk>
Message-ID: <20140627222626.GA17988@brightrain.aerifal.cx>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 27, 2014 at 11:04:00PM +0100, Russell King - ARM Linux wrote:
> On Fri, Jun 27, 2014 at 05:37:43PM -0400, Rich Felker wrote:
> > On Fri, Jun 27, 2014 at 12:27:45PM -0700, Andy Lutomirski wrote:
> > > Hi ARM people and Kees-
> > > 
> > > The "vectors" page appears to be an abomination that's a lot like the
> > > x86_64 vsyscall page.  IMO it should be phased out.
> > 
> > I'm not a fan of this extreme approach, but if it's taken, there needs
> > to be some way to continue to make universal binaries which work
> > safely on:
> > 
> > - Pre-v6, v6, and v7+ hardware.
> 
> And that is to make use of the kuser page.
> 
> > - Pre-removal and post-removal kernels.
> 
> Please, don't get stuff confused.
> 
> The kuser page isn't going anywhere _except_ for one situation: where
> the system integrator has determined that they have built their
> userspace not to require the kuser helpers, and wish to have greater
> security and performance through doing so.
> 
> What we *aren't* doing with the kernel is removing the page entirely
> for ARMv7+ CPUs.  We are merely giving system integrators the option
> to increase security /provided/ their userspace is built appropriately.
> 
> If the userspace requires the kuser helpers, then the page *must* be
> provided by the kernel.
> 
> It is a system integrator/distro bug to provide a kernel with the kuser
> helpers disabled, but then to provide a libc which requires the page.

>From our standpoint it is not necessarily the system integrator/distro
who provides the libc, but rather the distributor of the (possibly
static-linked, or possibly dynamic-linked but with its own full set of
libs) application binary. As a provider of tools used to produce such
binaries, we want these binaries to work regardless of how the kernel
was configured.

Thus, my interest is in ensuring that, whenever the kuser helper page
is disabled (or, as proposed, moved to a dynamic address), there's a
safe and efficient way to detect this condition and know what to do to
work around it.

Rich
