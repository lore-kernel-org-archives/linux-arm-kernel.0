From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Fri, 31 Oct 2014 09:57:43 -0700
Subject: [PATCH RFC v2 8/8] ARM: zynq: DT: Add pinctrl information
In-Reply-To: <CACRpkdZjJQTxVhvq5BT3mHBDHge_wHBNi9N_6u0WVbPB3wBDKw@mail.gmail.com>
References: <1413479495-14206-1-git-send-email-soren.brinkmann@xilinx.com>
 <1413479495-14206-9-git-send-email-soren.brinkmann@xilinx.com>
 <CACRpkda9v=H9rQBq484c+UCwEKeca9qOE_78Wf+STB4rDwhuyA@mail.gmail.com>
 <5cf5e2e5cd154992b2896b98988a409a@BN1BFFO11FD007.protection.gbl>
 <CACRpkdZjJQTxVhvq5BT3mHBDHge_wHBNi9N_6u0WVbPB3wBDKw@mail.gmail.com>
Message-ID: <030ed753d9764825b1bd5c845b360c7d@BN1AFFO11FD036.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-10-31 at 09:17AM +0100, Linus Walleij wrote:
> On Tue, Oct 28, 2014 at 5:03 PM, S?ren Brinkmann
> <soren.brinkmann@xilinx.com> wrote:
> > On Tue, 2014-10-28 at 04:05PM +0100, Linus Walleij wrote:
> >> On Thu, Oct 16, 2014 at 7:11 PM, Soren Brinkmann
> >> <soren.brinkmann@xilinx.com> wrote:
> >>
> >> > Add pinctrl descriptions to the zc702 and zc706 device trees.
> >> >
> >> > Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> >>
> >> (...)
> >> > +&pinctrl0 {
> >> > +       pinctrl_can0_default: pinctrl-can0-default {
> >> > +               common {
> >> > +                       function = "can0";
> >> > +                       groups = "can0_9_grp";
> >> > +                       bias-pull-up = <0>;
> >>
> >> No. If you want pull-up, just use
> >> bias-pull-up;
> >>
> >> If you want to disable pull-up, use
> >> bias-disable;
> >
> > But bias-disable also disables high-impedance. That doesn't work for me,
> > I think.
> 
> Hm. Some sequencing problem right? Like you count on
> bias-high-impdedance being set in some other state?
> 
> I think each state should be self-contained, so you set
> all the stuff you need in a state, do not rely on things coming
> in pre-set from another state.
> 
> So in this case just set bias-high-impedance; then and
> if the state does not have bias-pull-up, *always* disable it
> in the driver.
> 
> >>
> >> > +                       slew-rate = <0>;
> >>
> >> If this measure is any kind of time unit, this is against the laws of nature.
> >
> > It's not. As the bindings say, the argument is driver specific.
> 
> Okay then.
> 
> >> > +               rx {
> >> > +                       pins = "MIO46";
> >> > +                       bias-high-impedance = <1>;
> >>
> >> Just
> >> bias-high-impedance;
> >
> > Same problem as I have above. To allow all permutations of pull-up and
> > tri-state I can't just have a single disable-bias property.
> 
> Again it seems to be a sequencing problem. And device tree is
> not good at sequences, therefore all states should be self-contained.

I agree, but how would I define a pin with pull-up enabled and
tri-state disabled - assume the pin is currently in a random state that
can have those things set/not set arbitrarily.

I don't see how that can be handled without using arguments the way I
proposed.

I can't put bias-disable in DT since it would potentially disable both
and the pull-up enable would have only a transient effect.
I can't do the sequencing in the driver either. If I see pull-up enable,
I can't imply an effect on tri-state since I can't know whether there
was/will be a tri-state property that sets it as well.

	S?ren
