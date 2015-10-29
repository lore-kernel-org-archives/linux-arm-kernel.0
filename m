From: leo.yan@linaro.org (Leo Yan)
Date: Thu, 29 Oct 2015 16:33:01 +0800
Subject: [PATCH 1/4] arm64: dts: Reserve memory regions for hi6220
In-Reply-To: <CAL_JsqLhu03B_ADYvCYdduH2d38kajOyc=9eX_FHy4QYYhZGxQ@mail.gmail.com>
References: <1444365376-10728-1-git-send-email-leo.yan@linaro.org>
 <1444365376-10728-2-git-send-email-leo.yan@linaro.org>
 <CAL_JsqJapPM6CpaG+AYDAUQajZ4V5jREdCwA5F4vkD5jqC3bzg@mail.gmail.com>
 <20151009133028.GB21629@leverpostej>
 <CAL_Jsq+TrsS39L4nsRgqszTxKHyc00fLUf+BmftHnn=EV0PxhA@mail.gmail.com>
 <20151009142034.GB528@leoy-linaro>
 <CAL_JsqLhu03B_ADYvCYdduH2d38kajOyc=9eX_FHy4QYYhZGxQ@mail.gmail.com>
Message-ID: <20151029083301.GB16063@leoy-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 28, 2015 at 11:32:29PM -0500, Rob Herring wrote:
> On Fri, Oct 9, 2015 at 9:20 AM, Leo Yan <leo.yan@linaro.org> wrote:
> > On Fri, Oct 09, 2015 at 08:50:13AM -0500, Rob Herring wrote:
> >> On Fri, Oct 9, 2015 at 8:30 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> >> > On Fri, Oct 09, 2015 at 08:17:16AM -0500, Rob Herring wrote:
> >> >> On Thu, Oct 8, 2015 at 11:36 PM, Leo Yan <leo.yan@linaro.org> wrote:
> >> >> > On Hi6220, below memory regions in DDR have specific purpose:
> >> >> >
> >> >> >   0x05e0,0000 - 0x05ef,ffff: For MCU firmware using at runtime;
> >> >> >   0x06df,f000 - 0x06df,ffff: For mailbox message data;
> >> >> >   0x0740,f000 - 0x0740,ffff: For MCU firmware's section;
> >> >> >   0x3e00,0000 - 0x3fff,ffff: For OP-TEE.
> >> >> >
> >> >> > This patch reserves these memory regions in DT.
> >> >> >
> >> >> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> >> >> > ---
> >> >> >  arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts | 16 ++++++++++++----
> >> >> >  1 file changed, 12 insertions(+), 4 deletions(-)
> >> >> >
> >> >> > diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> >> >> > index e36a539..e3f4cb3 100644
> >> >> > --- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> >> >> > +++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> >> >> > @@ -7,9 +7,6 @@
> >> >> >
> >> >> >  /dts-v1/;
> >> >> >
> >> >> > -/*Reserved 1MB memory for MCU*/
> >> >> > -/memreserve/ 0x05e00000 0x00100000;
> >> >> > -
> >> >>
> >> >> Why does memreserve not work for you? You can have multiple entries.
> >> >>
> >> >> >  #include "hi6220.dtsi"
> >> >> >
> >> >> >  / {
> >> >> > @@ -24,8 +21,19 @@
> >> >> >                 stdout-path = "serial0:115200n8";
> >> >> >         };
> >> >> >
> >> >> > +       /*
> >> >> > +        * Reserve below regions from memory node:
> >> >> > +        *
> >> >> > +        *  - 0x05e0,0000 - 0x05ef,ffff: MCU firmware runtime using
> >> >> > +        *  - 0x06df,f000 - 0x06df,ffff: Mailbox message data
> >> >> > +        *  - 0x0740,f000 - 0x0740,ffff: MCU firmware section
> >> >> > +        *  - 0x3e00,0000 - 0x3fff,ffff: OP-TEE
> >> >> > +        */
> >> >> >         memory at 0 {
> >> >> >                 device_type = "memory";
> >> >> > -               reg = <0x0 0x0 0x0 0x40000000>;
> >> >> > +               reg = <0x00000000 0x00000000 0x00000000 0x05e00000>,
> >> >> > +                     <0x00000000 0x05f00000 0x00000000 0x00eff000>,
> >> >> > +                     <0x00000000 0x06e00000 0x00000000 0x0060f000>,
> >> >> > +                     <0x00000000 0x07410000 0x00000000 0x36bf0000>;
> >> >>
> >> >> No, don't do this. Please use memreserve or reserved-memory binding[1]
> >> >> or combination of both. Probably reserved-memory if you need the
> >> >> kernel to access some of these regions.
> >> >
> >> > I disagree at least for those portions owned by the secure world. The
> >> > kernel shouldn't map those at all, so memreserve isn't appropriate. That
> >> > covers OP-TEE and the MCU firmware regions, and I'd expec the EFI memory
> >> > map to not list those as available to the kernel.
> >>
> >> I'm fine carving out the beginning or end, but otherwise think memory
> >> should correspond to the physical memory. We have a way to describe
> >> holes to keep out, so we should use them. If secure world uses the DT,
> >> then it would either want to know its region in memory or add the DT
> >> data to say what it is using. We need that to be easy to find or easy
> >> to set, respectively. The size secure world needs could vary as well.
> >>
> >> The fact that the kernel maps the memory is the kernel's problem, not
> >> a DT problem.
> >>
> >
> > Just give more input here. In previous time, we have long discussion [1];
> > So actually your suggestion is exactly same what my old patch.
> >
> > From previous discussion, i think here have an assumtion: Use UEFI as
> > bootloader, the kernel will ignore (or remove) memreserve and reserved-memory
> > nodes, so just like Mark said "the EFI memory map to not list those
> > as available to the kernel". My new patch is just to follow this and
> > also make sure they have same behavior for different bootloader
> > (between UEFI and uboot).
> 
> I've read thru the thread and see 2 main conclusions. Using
> reserved-memory is problematic since things like grub don't support
> that. That is fine and we should stick with /mem-reserve/ for now.

Thanks for reviewing, Rob.

One thing should note: after booting with UEFI, /memreserve/ nodes
will be deleted by UEFI stub; and _ONLY_ can use /reserved-memory/
node to reserve memory regions.

Ard have another patch [1], after applied this patch, then all
/memreserve/ nodes and /reserved-memory/ nodes nodes will be ignored
to scan after booting with UEFI stub.

This is make sense, that means UEFI need provide exactly correct memory
map info by self and totally not depend on DT structures.

Another minor difference between /memreserve/ node and /reserved-memory/
node is: we can add property "no-map" for /reserved-memory/; so that
means it will totally remove region from memory block. it's more safe
for the memory region will NOT be mapped twice with different mapping
attribution.

[1] http://archive.arm.linux.org.uk/lurker/message/20150922.002128.46757034.en.html

> The other thing is the desire to have the memory presented to the kernel
> be the same whether it comes from UEFI or DT structures. I can see why
> there is some desire to have that alignment, but that doesn't really
> buy us anything. We can't eliminate some code path in the kernel doing
> so. So I still think that the memory node should reflect all of memory
> as defined by the h/w and mem-reserve should be used for any software
> defined reserved regions.

i think before we engaged much thinking for UEFI, that's meaningful for
we found what's correct implementation for UEFI. We need make sure UEFI
will do correct thing for itself.

If only consider purly from DT's usage, i have no strong opinion to
stick to use memory node to carve memory regions out. It's okay for me to
go back to use /reserved-memory/ to reserved regions.

Mark, do you agree with this?

Thanks,
Leo Yan
