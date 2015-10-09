From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 9 Oct 2015 14:30:29 +0100
Subject: [PATCH 1/4] arm64: dts: Reserve memory regions for hi6220
In-Reply-To: <CAL_JsqJapPM6CpaG+AYDAUQajZ4V5jREdCwA5F4vkD5jqC3bzg@mail.gmail.com>
References: <1444365376-10728-1-git-send-email-leo.yan@linaro.org>
 <1444365376-10728-2-git-send-email-leo.yan@linaro.org>
 <CAL_JsqJapPM6CpaG+AYDAUQajZ4V5jREdCwA5F4vkD5jqC3bzg@mail.gmail.com>
Message-ID: <20151009133028.GB21629@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 09, 2015 at 08:17:16AM -0500, Rob Herring wrote:
> On Thu, Oct 8, 2015 at 11:36 PM, Leo Yan <leo.yan@linaro.org> wrote:
> > On Hi6220, below memory regions in DDR have specific purpose:
> >
> >   0x05e0,0000 - 0x05ef,ffff: For MCU firmware using at runtime;
> >   0x06df,f000 - 0x06df,ffff: For mailbox message data;
> >   0x0740,f000 - 0x0740,ffff: For MCU firmware's section;
> >   0x3e00,0000 - 0x3fff,ffff: For OP-TEE.
> >
> > This patch reserves these memory regions in DT.
> >
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts | 16 ++++++++++++----
> >  1 file changed, 12 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> > index e36a539..e3f4cb3 100644
> > --- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> > +++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> > @@ -7,9 +7,6 @@
> >
> >  /dts-v1/;
> >
> > -/*Reserved 1MB memory for MCU*/
> > -/memreserve/ 0x05e00000 0x00100000;
> > -
> 
> Why does memreserve not work for you? You can have multiple entries.
> 
> >  #include "hi6220.dtsi"
> >
> >  / {
> > @@ -24,8 +21,19 @@
> >                 stdout-path = "serial0:115200n8";
> >         };
> >
> > +       /*
> > +        * Reserve below regions from memory node:
> > +        *
> > +        *  - 0x05e0,0000 - 0x05ef,ffff: MCU firmware runtime using
> > +        *  - 0x06df,f000 - 0x06df,ffff: Mailbox message data
> > +        *  - 0x0740,f000 - 0x0740,ffff: MCU firmware section
> > +        *  - 0x3e00,0000 - 0x3fff,ffff: OP-TEE
> > +        */
> >         memory at 0 {
> >                 device_type = "memory";
> > -               reg = <0x0 0x0 0x0 0x40000000>;
> > +               reg = <0x00000000 0x00000000 0x00000000 0x05e00000>,
> > +                     <0x00000000 0x05f00000 0x00000000 0x00eff000>,
> > +                     <0x00000000 0x06e00000 0x00000000 0x0060f000>,
> > +                     <0x00000000 0x07410000 0x00000000 0x36bf0000>;
> 
> No, don't do this. Please use memreserve or reserved-memory binding[1]
> or combination of both. Probably reserved-memory if you need the
> kernel to access some of these regions.

I disagree at least for those portions owned by the secure world. The
kernel shouldn't map those at all, so memreserve isn't appropriate. That
covers OP-TEE and the MCU firmware regions, and I'd expec the EFI memory
map to not list those as available to the kernel.

For the mailbox memory reserved-memory should be OK.

Thanks,
Mark.
