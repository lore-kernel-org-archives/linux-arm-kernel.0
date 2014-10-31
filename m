From: geoff@infradead.org (Geoff Levand)
Date: Fri, 31 Oct 2014 16:44:52 -0700
Subject: [PATCH 05/10] arm64: Convert dts to use reserved-memory nodes
In-Reply-To: <20141024122738.GH24265@leverpostej>
References: <cover.1414099246.git.geoff@infradead.org>
 <411296ab915959b862923d827e730a1db2ff9b4e.1414099246.git.geoff@infradead.org>
 <20141024105111.GD24265@leverpostej>
 <CACxGe6szzOXHkK9ukpcSBZgeyy5AgX3+7PgQseBnB9XWYLj-PQ@mail.gmail.com>
 <20141024122738.GH24265@leverpostej>
Message-ID: <1414799092.23621.48.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, 2014-10-24 at 13:27 +0100, Mark Rutland wrote:
> On Fri, Oct 24, 2014 at 11:59:38AM +0100, Grant Likely wrote:
> > On Fri, Oct 24, 2014 at 11:51 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> > > On Fri, Oct 24, 2014 at 12:10:58AM +0100, Geoff Levand wrote:
> > >> Device tree regions described by /memreserve/ entries are not available in
> > >> /proc/device-tree, and hence are not available to user space utilities that use
> > >> /proc/device-tree.  In order for these regions to be available, convert any
> > >> arm64 DTS files using /memreserve/ entries to use reserved-memory nodes.
> > >
> > > The limitation here is in the kernel (and a partially in userspace), so
> > > modifying the dts files is a workaround rather than a fix.
> > >
> > > It's perfectly valid for people to remain using /memreserve/, so this
> > > isn't sufficient. There are also existing DTBs using /memreserve/ which
> > > we can't rely on being modified to use reserved-memory.
> > >
> > > I think we need to expose memreserves to userspace somehow, potentially
> > > along with other DTB header fields. Grant, ideas?
> > 
> > Yes, I suggested the same thing to Geoff in a separate thread. Here's
> > what I wrote:
> > 
> > >> Geoff Levand wrote:
> > >>> I did some work on this and I think we just need to convert all the
> > >>> arm64 dts from /memreserve/ to reserved-memory nodes and update the
> > >>> arm64 booting.txt to specify using reserved-memory.  I'll prepare a
> > >>> patch for it.
> > >>
> > >> I don't think that is going to be entirely sufficient. There will be
> > >> platforms that don't get converted over, and this is a generic problem
> > >> that covers all architectures using DT, not just aarch64. The solution
> > >> probably needs to include exposing the /memreserve/ sections to
> > >> userspace. I can see two ways to do this:
> > >>
> > >> 1) Create a new property in /sysfs with all the memreserve sctions
> > >> 2) Live-modify the device tree to put the memreserve data into a node
> > >> at boot time.
> > >>
> > >> Option 2 is probably the most generic solution, but it will require
> > >> some care to make sure there aren't any overlaps if a reserved-memory
> > >> node already exists.
> 
> I would prefer the former currently. While I currently believe that
> modifying the tree is something we're going to have to do for stateful
> properties, it's not someting I want to have to do unless absolutely
> necessary.

Current user space kexec utilities use /proc/device-tree and nothing
else.  The intension of the device tree is to describe the system
sufficiently for a kernel to boot, so I think we should put the
/memreserve/ info into /proc/device-tree.

We could put the /memreserve/ entries in there directly, or convert
to reserved-memory nodes.  At the moment I like the idea to convert to
reserved-memory nodes.

> > > For reference, here is an old conversation about this exact thing.
> > > Reading through it, the opinions I expressed then don't necessarily
> > > match what I think now. I still don't think it is a good idea to
> > > expose the physical address of the old .dtb blob, but I do agree that
> > > the memreserve sections need to be exposed.
> > >
> > > https://lists.ozlabs.org/pipermail/linuxppc-dev/2010-July/083993.html
> 
> Another option would be to expose the original DTB as a (read-only)
> binary file somewhere. That might interact poorly with live tree
> modification in future, however.

I don't like the idea of having two interfaces to get essentially the same
info.  I think it will be a maintenance problem over time.

-Geoff
