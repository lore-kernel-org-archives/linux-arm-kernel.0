From: robh@kernel.org (Rob Herring)
Date: Mon, 18 Jan 2016 09:07:14 -0600
Subject: [PATCH 1/4] arm64: dts: Reserve memory regions for hi6220
In-Reply-To: <20160111154027.GC30974@leoy-linaro>
References: <1444365376-10728-2-git-send-email-leo.yan@linaro.org>
 <CAL_JsqJapPM6CpaG+AYDAUQajZ4V5jREdCwA5F4vkD5jqC3bzg@mail.gmail.com>
 <20151009133028.GB21629@leverpostej>
 <CAL_Jsq+TrsS39L4nsRgqszTxKHyc00fLUf+BmftHnn=EV0PxhA@mail.gmail.com>
 <20151009142034.GB528@leoy-linaro>
 <CAL_JsqLhu03B_ADYvCYdduH2d38kajOyc=9eX_FHy4QYYhZGxQ@mail.gmail.com>
 <20151029083301.GB16063@leoy-linaro> <20151105135449.GD27192@leoy-linaro>
 <20151105161315.GE32247@leverpostej> <20151106011937.GA5960@leoy-linaro>
 <20160111154027.GC30974@leoy-linaro>
Message-ID: <CAL_Jsq+BRua=RetZUH9vxCo4WpY436k1vxpp4jZDv=ZjPK42_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 11, 2016 at 9:40 AM, Leo Yan <leo.yan@linaro.org> wrote:
> On Fri, Nov 06, 2015 at 09:19:37AM +0800, Leo Yan wrote:
>> On Thu, Nov 05, 2015 at 04:13:15PM +0000, Mark Rutland wrote:
>> > On Thu, Nov 05, 2015 at 09:54:50PM +0800, Leo Yan wrote:
>> > > On Thu, Oct 29, 2015 at 04:33:01PM +0800, Leo Yan wrote:
>> > > > On Wed, Oct 28, 2015 at 11:32:29PM -0500, Rob Herring wrote:
>> > > > > On Fri, Oct 9, 2015 at 9:20 AM, Leo Yan <leo.yan@linaro.org> wrote:
>> > > > > > On Fri, Oct 09, 2015 at 08:50:13AM -0500, Rob Herring wrote:
>> > > > > >> On Fri, Oct 9, 2015 at 8:30 AM, Mark Rutland <mark.rutland@arm.com> wrote:
>> > > > > >> > On Fri, Oct 09, 2015 at 08:17:16AM -0500, Rob Herring wrote:
>> > > > > >> >> On Thu, Oct 8, 2015 at 11:36 PM, Leo Yan <leo.yan@linaro.org> wrote:
>> > > > > >> >> > On Hi6220, below memory regions in DDR have specific purpose:
>> > > > > >> >> >
>> > > > > >> >> >   0x05e0,0000 - 0x05ef,ffff: For MCU firmware using at runtime;
>> > > > > >> >> >   0x06df,f000 - 0x06df,ffff: For mailbox message data;
>> > > > > >> >> >   0x0740,f000 - 0x0740,ffff: For MCU firmware's section;
>> > > > > >> >> >   0x3e00,0000 - 0x3fff,ffff: For OP-TEE.
>> > > > > >> >> >
>> > > > > >> >> > This patch reserves these memory regions in DT.
>> > > > > >> >> >
>> > > > > >> >> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
>> > > > > >> >> > ---
>> > > > > >> >> >  arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts | 16 ++++++++++++----
>> > > > > >> >> >  1 file changed, 12 insertions(+), 4 deletions(-)
>> > > > > >> >> >
>> > > > > >> >> > diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
>> > > > > >> >> > index e36a539..e3f4cb3 100644
>> > > > > >> >> > --- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
>> > > > > >> >> > +++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
>> > > > > >> >> > @@ -7,9 +7,6 @@
>> > > > > >> >> >
>> > > > > >> >> >  /dts-v1/;
>> > > > > >> >> >
>> > > > > >> >> > -/*Reserved 1MB memory for MCU*/
>> > > > > >> >> > -/memreserve/ 0x05e00000 0x00100000;
>> > > > > >> >> > -
>> > > > > >> >>
>> > > > > >> >> Why does memreserve not work for you? You can have multiple entries.
>> > > > > >> >>
>> > > > > >> >> >  #include "hi6220.dtsi"
>> > > > > >> >> >
>> > > > > >> >> >  / {
>> > > > > >> >> > @@ -24,8 +21,19 @@
>> > > > > >> >> >                 stdout-path = "serial0:115200n8";
>> > > > > >> >> >         };
>> > > > > >> >> >
>> > > > > >> >> > +       /*
>> > > > > >> >> > +        * Reserve below regions from memory node:
>> > > > > >> >> > +        *
>> > > > > >> >> > +        *  - 0x05e0,0000 - 0x05ef,ffff: MCU firmware runtime using
>> > > > > >> >> > +        *  - 0x06df,f000 - 0x06df,ffff: Mailbox message data
>> > > > > >> >> > +        *  - 0x0740,f000 - 0x0740,ffff: MCU firmware section
>> > > > > >> >> > +        *  - 0x3e00,0000 - 0x3fff,ffff: OP-TEE
>> > > > > >> >> > +        */
>> > > > > >> >> >         memory at 0 {
>> > > > > >> >> >                 device_type = "memory";
>> > > > > >> >> > -               reg = <0x0 0x0 0x0 0x40000000>;
>> > > > > >> >> > +               reg = <0x00000000 0x00000000 0x00000000 0x05e00000>,
>> > > > > >> >> > +                     <0x00000000 0x05f00000 0x00000000 0x00eff000>,
>> > > > > >> >> > +                     <0x00000000 0x06e00000 0x00000000 0x0060f000>,
>> > > > > >> >> > +                     <0x00000000 0x07410000 0x00000000 0x36bf0000>;
>> > > > > >> >>
>
> [...]
>
>> > > > > I've read thru the thread and see 2 main conclusions. Using
>> > > > > reserved-memory is problematic since things like grub don't support
>> > > > > that. That is fine and we should stick with /mem-reserve/ for now.
>> > > > >
>> > > > > The other thing is the desire to have the memory presented to the kernel
>> > > > > be the same whether it comes from UEFI or DT structures. I can see why
>> > > > > there is some desire to have that alignment, but that doesn't really
>> > > > > buy us anything. We can't eliminate some code path in the kernel doing
>> > > > > so. So I still think that the memory node should reflect all of memory
>> > > > > as defined by the h/w and mem-reserve should be used for any software
>> > > > > defined reserved regions.
>
> [...]
>
>> > Sorry for the delay.
>> >
>> > I'm still of the opinion that given the kernel has no business even
>> > reading this memory, it does not make sense to use a memreserve.
>> >
>> > Given that, and the points about other software not knowing aobut
>> > /reserved-memory/, I don't think it makes sense to describe the region
>> > in the memory nodes.
>
> [...]
>
> Hi Rob, Mark,
>
> Sorry its taken me so long to bump this thread.
>
> So I can have more confidence discussing this I have reviewed the
> existing files in arch/arm/boot and arch/arm64/boot and done a bit of
> analysis. My summary is below:
>
> In arch/arm/boot:
>
> - In arch/arm, Using /reserved-memory/ and /memreserve/ are very common
>   case to reserve memory regions;
> - /memreserve/ is mainly used to reserve memory for spin-table which
>   used by SMP booting;
> - /reserved-memory/ are used to reserve memory regions for security
>   (TrustZone, secure RAM, etc), message transferring; So we can say
>   usually use this method to reserve memory for device driver or other
>   modules which maps these memory regions later.
>
> - There also have some DT files using memory node to carve out memory
>   regions, but from roughly analysis we can see the most cases are
>   introduced by memory controller for discontinuous memory space for
>   DDR; or there have some silicon bug so some regions are not stable
>   so need get rid of them (Armada-xp);
>
> In arch/arm64/boot:
>
> - There have no any file using /reserved-memory/;
> - Several files are using /memreserve/ for spin-table boot method;
> - ARM platforms (Juno, FVP) use memory nodes to carve out memory regions
>   for security;
> - DT files in arch/arm64 are quite consistent with Mark's suggestion.
>
> In my review I haven't really found anything that pushes me in one
> direction or the other so, without consensus from the DT maintainers, I
> really don't know how to progress here.

While I still think regions should be marked as reserved rather than
carving up the memory node, it's not really worth holding up this
platform further. The kernel can support either way.

However, Mark's argument AIUI was regions that are never accessed
should be done the way you have done it. I don't think the mailbox
region falls in this category. I'm not sure about OP-TEE, but we
should have consistency for it if the OP-TEE driver needs to find its
memory region. Cc'ing Joakim for comment.

Rob
