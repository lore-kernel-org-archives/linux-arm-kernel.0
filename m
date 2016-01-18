From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 18 Jan 2016 15:42:59 +0000
Subject: [PATCH 1/4] arm64: dts: Reserve memory regions for hi6220
In-Reply-To: <CAL_Jsq+BRua=RetZUH9vxCo4WpY436k1vxpp4jZDv=ZjPK42_w@mail.gmail.com>
References: <20151009133028.GB21629@leverpostej>
 <CAL_Jsq+TrsS39L4nsRgqszTxKHyc00fLUf+BmftHnn=EV0PxhA@mail.gmail.com>
 <20151009142034.GB528@leoy-linaro>
 <CAL_JsqLhu03B_ADYvCYdduH2d38kajOyc=9eX_FHy4QYYhZGxQ@mail.gmail.com>
 <20151029083301.GB16063@leoy-linaro>
 <20151105135449.GD27192@leoy-linaro>
 <20151105161315.GE32247@leverpostej>
 <20151106011937.GA5960@leoy-linaro>
 <20160111154027.GC30974@leoy-linaro>
 <CAL_Jsq+BRua=RetZUH9vxCo4WpY436k1vxpp4jZDv=ZjPK42_w@mail.gmail.com>
Message-ID: <20160118154258.GP21067@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 18, 2016 at 09:07:14AM -0600, Rob Herring wrote:
> On Mon, Jan 11, 2016 at 9:40 AM, Leo Yan <leo.yan@linaro.org> wrote:
> > On Fri, Nov 06, 2015 at 09:19:37AM +0800, Leo Yan wrote:
> >> On Thu, Nov 05, 2015 at 04:13:15PM +0000, Mark Rutland wrote:
> >> > On Thu, Nov 05, 2015 at 09:54:50PM +0800, Leo Yan wrote:
> >> > > On Thu, Oct 29, 2015 at 04:33:01PM +0800, Leo Yan wrote:
> >> > > > On Wed, Oct 28, 2015 at 11:32:29PM -0500, Rob Herring wrote:
> >> > > > > On Fri, Oct 9, 2015 at 9:20 AM, Leo Yan <leo.yan@linaro.org> wrote:
> >> > > > > > On Fri, Oct 09, 2015 at 08:50:13AM -0500, Rob Herring wrote:
> >> > > > > >> On Fri, Oct 9, 2015 at 8:30 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> >> > > > > >> > On Fri, Oct 09, 2015 at 08:17:16AM -0500, Rob Herring wrote:
> >> > > > > >> >> On Thu, Oct 8, 2015 at 11:36 PM, Leo Yan <leo.yan@linaro.org> wrote:
> >> > > > > >> >> > On Hi6220, below memory regions in DDR have specific purpose:
> >> > > > > >> >> >
> >> > > > > >> >> >   0x05e0,0000 - 0x05ef,ffff: For MCU firmware using at runtime;
> >> > > > > >> >> >   0x06df,f000 - 0x06df,ffff: For mailbox message data;
> >> > > > > >> >> >   0x0740,f000 - 0x0740,ffff: For MCU firmware's section;
> >> > > > > >> >> >   0x3e00,0000 - 0x3fff,ffff: For OP-TEE.
> >> > > > > >> >> >
> >> > > > > >> >> > This patch reserves these memory regions in DT.
> >> > > > > >> >> >
> >> > > > > >> >> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> >> > > > > >> >> > ---
> >> > > > > >> >> >  arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts | 16 ++++++++++++----
> >> > > > > >> >> >  1 file changed, 12 insertions(+), 4 deletions(-)
> >> > > > > >> >> >
> >> > > > > >> >> > diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> >> > > > > >> >> > index e36a539..e3f4cb3 100644
> >> > > > > >> >> > --- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> >> > > > > >> >> > +++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> >> > > > > >> >> > @@ -7,9 +7,6 @@
> >> > > > > >> >> >
> >> > > > > >> >> >  /dts-v1/;
> >> > > > > >> >> >
> >> > > > > >> >> > -/*Reserved 1MB memory for MCU*/
> >> > > > > >> >> > -/memreserve/ 0x05e00000 0x00100000;
> >> > > > > >> >> > -
> >> > > > > >> >>
> >> > > > > >> >> Why does memreserve not work for you? You can have multiple entries.
> >> > > > > >> >>
> >> > > > > >> >> >  #include "hi6220.dtsi"
> >> > > > > >> >> >
> >> > > > > >> >> >  / {
> >> > > > > >> >> > @@ -24,8 +21,19 @@
> >> > > > > >> >> >                 stdout-path = "serial0:115200n8";
> >> > > > > >> >> >         };
> >> > > > > >> >> >
> >> > > > > >> >> > +       /*
> >> > > > > >> >> > +        * Reserve below regions from memory node:
> >> > > > > >> >> > +        *
> >> > > > > >> >> > +        *  - 0x05e0,0000 - 0x05ef,ffff: MCU firmware runtime using
> >> > > > > >> >> > +        *  - 0x06df,f000 - 0x06df,ffff: Mailbox message data
> >> > > > > >> >> > +        *  - 0x0740,f000 - 0x0740,ffff: MCU firmware section
> >> > > > > >> >> > +        *  - 0x3e00,0000 - 0x3fff,ffff: OP-TEE
> >> > > > > >> >> > +        */
> >> > > > > >> >> >         memory at 0 {
> >> > > > > >> >> >                 device_type = "memory";
> >> > > > > >> >> > -               reg = <0x0 0x0 0x0 0x40000000>;
> >> > > > > >> >> > +               reg = <0x00000000 0x00000000 0x00000000 0x05e00000>,
> >> > > > > >> >> > +                     <0x00000000 0x05f00000 0x00000000 0x00eff000>,
> >> > > > > >> >> > +                     <0x00000000 0x06e00000 0x00000000 0x0060f000>,
> >> > > > > >> >> > +                     <0x00000000 0x07410000 0x00000000 0x36bf0000>;
> >> > > > > >> >>
> >
> > [...]
> >
> >> > > > > I've read thru the thread and see 2 main conclusions. Using
> >> > > > > reserved-memory is problematic since things like grub don't support
> >> > > > > that. That is fine and we should stick with /mem-reserve/ for now.
> >> > > > >
> >> > > > > The other thing is the desire to have the memory presented to the kernel
> >> > > > > be the same whether it comes from UEFI or DT structures. I can see why
> >> > > > > there is some desire to have that alignment, but that doesn't really
> >> > > > > buy us anything. We can't eliminate some code path in the kernel doing
> >> > > > > so. So I still think that the memory node should reflect all of memory
> >> > > > > as defined by the h/w and mem-reserve should be used for any software
> >> > > > > defined reserved regions.
> >
> > [...]
> >
> >> > Sorry for the delay.
> >> >
> >> > I'm still of the opinion that given the kernel has no business even
> >> > reading this memory, it does not make sense to use a memreserve.
> >> >
> >> > Given that, and the points about other software not knowing aobut
> >> > /reserved-memory/, I don't think it makes sense to describe the region
> >> > in the memory nodes.
> >
> > [...]
> >
> > Hi Rob, Mark,
> >
> > Sorry its taken me so long to bump this thread.
> >
> > So I can have more confidence discussing this I have reviewed the
> > existing files in arch/arm/boot and arch/arm64/boot and done a bit of
> > analysis. My summary is below:
> >
> > In arch/arm/boot:
> >
> > - In arch/arm, Using /reserved-memory/ and /memreserve/ are very common
> >   case to reserve memory regions;
> > - /memreserve/ is mainly used to reserve memory for spin-table which
> >   used by SMP booting;
> > - /reserved-memory/ are used to reserve memory regions for security
> >   (TrustZone, secure RAM, etc), message transferring; So we can say
> >   usually use this method to reserve memory for device driver or other
> >   modules which maps these memory regions later.
> >
> > - There also have some DT files using memory node to carve out memory
> >   regions, but from roughly analysis we can see the most cases are
> >   introduced by memory controller for discontinuous memory space for
> >   DDR; or there have some silicon bug so some regions are not stable
> >   so need get rid of them (Armada-xp);
> >
> > In arch/arm64/boot:
> >
> > - There have no any file using /reserved-memory/;
> > - Several files are using /memreserve/ for spin-table boot method;
> > - ARM platforms (Juno, FVP) use memory nodes to carve out memory regions
> >   for security;
> > - DT files in arch/arm64 are quite consistent with Mark's suggestion.
> >
> > In my review I haven't really found anything that pushes me in one
> > direction or the other so, without consensus from the DT maintainers, I
> > really don't know how to progress here.
> 
> While I still think regions should be marked as reserved rather than
> carving up the memory node, it's not really worth holding up this
> platform further. The kernel can support either way.
> 
> However, Mark's argument AIUI was regions that are never accessed
> should be done the way you have done it. I don't think the mailbox
> region falls in this category. I'm not sure about OP-TEE, but we
> should have consistency for it if the OP-TEE driver needs to find its
> memory region. Cc'ing Joakim for comment.

My understanding was that the OP-TEE memory was that reserved for use by
the secure side (rather than a shared region). To avoid (non-secure)
speculative accesses triggering aborts from some trustzone controller,
and other issues, no memory reserved for secure side use should be
mapped by the non-secure side, and hence a memreserve is insufficient.
Hopefully Joakim can shed light on that.

There is a general problem with memreserve in that it is currently
ill-defined for arm and arm64, and its implications are not well
understood (by the nature of the ARM cache architecture, and problems
like mismatched aliases being not well understood). Due to this, I think
that its use should be avoided unless strictly necessary.

Having an alias as part of the linear mapping creates a number of
problems which are avoided most simply by never having that alias (i.e.
not describing the region as memory at all). Establishing that pattern
now saves us pain in future.

One major reason for memreserve being used was to allow the linear
mapping to be used to access objects. Practically every case has moved
over to using a dynamic mapping (fixmap, or {io,mem}remap), as that's
required to handle a number of edge cases.

For data structures (e.g. the DTB) that are only expected to be accessed
by the kernel, a memreserve is fine provided sufficient cache
maintenance has been performed already. For everything else (e.g.
anything shared with or owned by another agent), its use is questionable
at best (and I think the spin-table story is an unfortunate mistake that
we have to live with).

Thanks,
Mark.
