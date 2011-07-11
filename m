From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Mon, 11 Jul 2011 13:21:09 +0800
Subject: [PATCH] ARM: mmp: add DTS file
In-Reply-To: <20110710073510.GG10912@ponder.secretlab.ca>
References: <1310120428-22700-3-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-4-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-5-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-6-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-7-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-8-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-9-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-10-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-11-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-12-git-send-email-haojian.zhuang@marvell.com>
	<20110710073510.GG10912@ponder.secretlab.ca>
Message-ID: <1310361669.4621.16.camel@Lily>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2011-07-10 at 00:35 -0700, Grant Likely wrote:
> On Fri, Jul 08, 2011 at 06:20:28PM +0800, Haojian Zhuang wrote:
> > Add DTS file to support brownstone & ttc-dkb.
> > 
> > Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> 
> Hi Haojian.
> 
> Overall, the patch series is moving in the right direction.  I've made
> a lot of comments, but they shouldn't be difficult to resolve.  I look
> forward to seeing the next version of the series.  Comments below...
> 
> > ---
> >  arch/arm/boot/dts/mmp2-brownstone.dts |  319 +++++++++++++++++++++++++++++++++
> >  arch/arm/boot/dts/ttc-dkb.dts         |  176 ++++++++++++++++++
> >  arch/arm/mach-mmp/brownstone.c        |   66 ++-----
> >  arch/arm/mach-mmp/ttc_dkb.c           |   21 ++-
> >  4 files changed, 530 insertions(+), 52 deletions(-)
> >  create mode 100644 arch/arm/boot/dts/mmp2-brownstone.dts
> >  create mode 100644 arch/arm/boot/dts/ttc-dkb.dts
> > 
> > diff --git a/arch/arm/boot/dts/mmp2-brownstone.dts b/arch/arm/boot/dts/mmp2-brownstone.dts
> > new file mode 100644
> > index 0000000..5fdabc3
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/mmp2-brownstone.dts
> > @@ -0,0 +1,319 @@
> > +/dts-v1/;
> > +
> > +/include/ "skeleton.dtsi"
> > +

> > +			interrupt-controller;
> > +			#interrupt-cells = <1>;

> > +			sub-interrupts = <64>;
> 
> What is this for?
> 
Because I need to know how much interrupts could be supported in this
domain? For example, mux4, mux5, ... and supported in mmp2 silicon.
Although they have similar interface, the interrupt numbers are
different in different mux. So I need a property to tell parser that how
much interrupts should be allocated for this interrupt domain.


> > +			gpio-controller;
> > +			reg = <
> > +				0xd4019000 0xb0
> > +				0xd4019004 0xb0
> > +				0xd4019008 0xb0
> > +				0xd4019100 0xb0
> > +				0xd4019104 0xb0
> > +				0xd4019108 0xb0>;
> 
> This looks wrong.  The address ranges overlap.  Why not simply:
> <0xd4019000 0x200>;
> 
These six registers means the start address of six gpio banks. The
registers are overlapped. And internal register of gpio bank are same in
both ARCH-PXA and ARCH-MMP. The only difference is the start register of
each gpio bank.
And there're different gpio numbers in different silicons. If I can
transfer the start gpio address from DTS file, I needn't to hard code
them in gpio driver. If I only write it as <0xd4019000 0x200>, it can't
help driver to understand how much gpio banks existed. Unless I provide
a new property on gpio bank. What's your opinion on this?
