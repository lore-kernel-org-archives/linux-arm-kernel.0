From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Tue, 28 Oct 2014 09:03:06 -0700
Subject: [PATCH RFC v2 8/8] ARM: zynq: DT: Add pinctrl information
In-Reply-To: <CACRpkda9v=H9rQBq484c+UCwEKeca9qOE_78Wf+STB4rDwhuyA@mail.gmail.com>
References: <1413479495-14206-1-git-send-email-soren.brinkmann@xilinx.com>
 <1413479495-14206-9-git-send-email-soren.brinkmann@xilinx.com>
 <CACRpkda9v=H9rQBq484c+UCwEKeca9qOE_78Wf+STB4rDwhuyA@mail.gmail.com>
Message-ID: <5cf5e2e5cd154992b2896b98988a409a@BN1BFFO11FD007.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-10-28 at 04:05PM +0100, Linus Walleij wrote:
> On Thu, Oct 16, 2014 at 7:11 PM, Soren Brinkmann
> <soren.brinkmann@xilinx.com> wrote:
> 
> > Add pinctrl descriptions to the zc702 and zc706 device trees.
> >
> > Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> 
> (...)
> > +&pinctrl0 {
> > +       pinctrl_can0_default: pinctrl-can0-default {
> > +               common {
> > +                       function = "can0";
> > +                       groups = "can0_9_grp";
> > +                       bias-pull-up = <0>;
> 
> No. If you want pull-up, just use
> bias-pull-up;
> 
> If you want to disable pull-up, use
> bias-disable;

But bias-disable also disables high-impedance. That doesn't work for me,
I think.

> 
> > +                       slew-rate = <0>;
> 
> If this measure is any kind of time unit, this is against the laws of nature.

It's not. As the bindings say, the argument is driver specific. In the
Zynq case you can simply choose fast or slow - whatever that means -
which maps to 0 or 1 in the DT. This though raises the question where
that documentation lives. Since this is a driver specific
interpretation, it should not be in the binding docs, IMHO. So, some
other place might need to be found to document the implementation
specifics.

> 
> > +                       io-standard = <1>;
> > +               };
> > +
> > +               rx {
> > +                       pins = "MIO46";
> > +                       bias-high-impedance = <1>;
> 
> Just
> bias-high-impedance;

Same problem as I have above. To allow all permutations of pull-up and
tri-state I can't just have a single disable-bias property.

> 
> > +               };
> > +
> > +               tx {
> > +                       pins = "MIO47";
> > +                       bias-high-impedance = <0>;
> 
> Just
> bias-disable;

That would also disable the pull-up.

	S?ren
