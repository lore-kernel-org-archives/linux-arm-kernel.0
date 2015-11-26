From: horms@verge.net.au (Simon Horman)
Date: Thu, 26 Nov 2015 13:09:06 +0900
Subject: [PATCH] ARM: shmobile: r8a7779: Add L2 cache-controller node
In-Reply-To: <CAMuHMdVTdPocWCnzE8v-O_rpNJR=0mO23jeG8ejYzL0REtQb+g@mail.gmail.com>
References: <1448416683-1411-1-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdVTdPocWCnzE8v-O_rpNJR=0mO23jeG8ejYzL0REtQb+g@mail.gmail.com>
Message-ID: <20151126040905.GB1198@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 25, 2015 at 09:41:42AM +0100, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Wed, Nov 25, 2015 at 2:58 AM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > Add the missing L2 cache-controller node, and link the CPU nodes to it.
> >
> > The L2 cache is an ARM L2C-310 (r3p2), of size 1 MB (64 KiB x 16 ways).
> >
> > Based on work for the r8a7740 by Geert Uytterhoeven.
> >
> > Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> Thanks for your patch!
> 
> > ---
> >  arch/arm/boot/dts/r8a7779.dtsi | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
> > index 6afa909865b5..f27fa2db16ee 100644
> > --- a/arch/arm/boot/dts/r8a7779.dtsi
> > +++ b/arch/arm/boot/dts/r8a7779.dtsi
> 
> > @@ -63,6 +67,17 @@
> >                       <0xf0000100 0x100>;
> >         };
> >
> > +       L2: cache-controller {
> > +               compatible = "arm,pl310-cache";
> > +               reg = <0xf0100000 0x1000>;
> > +               interrupts = <0 122 IRQ_TYPE_LEVEL_HIGH>;
> 
> 40?
> 
> Comparing to other devices, you have to subtract 32 from 0x5a, not
> add 32?

Thanks for pointing that out. I will update this to 0x5a - 32 = 58

> > +               arm,data-latency = <3 3 3>;
> > +               arm,tag-latency = <2 2 2>;
> 
> Table 9.5 says 2 resp. 1 instead of 3 resp. 2?

Thanks.

> However:
> 
> "The TAG and data RAM latency can be set in the reg1_tag_ram_control and
>  reg1_data_ram_control registers. However, since values to be set are
>  hardware-dependent, the default values should not be modified."
> 
> Perhaps we should just omit these values?

I see also see remarks regarding the values not being configurable
for the r8a7740 (section 2.7.1) and sh73a0 (section 6.10.1) so perhaps we
should remove the values from the dts files of those SoCs too?
