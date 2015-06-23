From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Tue, 23 Jun 2015 14:37:45 +0100
Subject: [Xen-devel] [RFC 00/23] arm64: Add support for 64KB page
 granularity in Xen guest
In-Reply-To: <5559D9C6.5010807@citrix.com>
References: <1431622863-28575-1-git-send-email-julien.grall@citrix.com>
 <555614AB.9000006@citrix.com> <5559D9C6.5010807@citrix.com>
Message-ID: <alpine.DEB.2.02.1506231436250.16917@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 18 May 2015, Julien Grall wrote:
> Hi David,
> 
> On 15/05/15 16:45, David Vrabel wrote:
> > On 14/05/15 18:00, Julien Grall wrote:
> >> Hi all,
> >>
> >> ARM64 Linux is supporting both 4KB and 64KB page granularity. Although, Xen
> >> hypercall interface and PV protocol are always based on 4KB page granularity.
> >>
> >> Any attempt to boot a Linux guest with 64KB pages enabled will result to a
> >> guest crash.
> >>
> >> This series is a first attempt to allow those Linux running with the current
> >> hypercall interface and PV protocol.
> >>
> >> This solution has been chosen because we want to run Linux 64KB in released
> >> Xen ARM version or/and platform using an old version of Linux DOM0.
> > 
> > The key problem I see with this approach is the confusion between guest
> > page size and Xen page size.  This is going to be particularly
> > problematic since the majority of development/usage will remain on x86
> > where PAGE_SIZE == XEN_PAGE_SIZE.
> > 
> > I think it would be nice to keep XEN_PAGE_SIZE etc out of front and
> > backend drivers.  Perhaps with a suitable set of helper functions?
> 
> Even with the helpers, we are not protected from any change in the
> frontend/backend that will impact 64K. It won't be possible to remove
> all the XEN_PAGE_* usage (there is a lots of places where adding helpers
> would not be possible) and we would still have to carefully review any
> changes.

We could at least introduce a few asserts, so that an ARM64 kernel
build, that any x86 maintainers can easily and quickly do on their x86
machines, would spot these errors.
