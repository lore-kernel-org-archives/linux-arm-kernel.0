From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sat, 08 Aug 2015 00:50:15 +0200
Subject: [PATCH v2 2/2] ARM: dts: rockchip: add veyron-minnie board
In-Reply-To: <CAKdAkRTVbGeDY2J_T1N1x1yQaq7vCnO71TVmQGAZAkMaQsz2qw@mail.gmail.com>
References: <1763907.pckMEaRNPs@diego>
 <CAD=FV=XVxxDzXkz7DuX47d=3MENzGkHrBYYDzH_KCKDpyORYYA@mail.gmail.com>
 <CAKdAkRTVbGeDY2J_T1N1x1yQaq7vCnO71TVmQGAZAkMaQsz2qw@mail.gmail.com>
Message-ID: <4355831.vggPnSTQsd@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 7. August 2015, 15:13:13 schrieb Dmitry Torokhov:
> On Fri, Aug 7, 2015 at 3:06 PM, Doug Anderson <dianders@chromium.org> wrote:
> > Heiko,
> > 
> > On Thu, Aug 6, 2015 at 10:37 AM, Heiko St?bner <heiko@sntech.de> wrote:
> >> +&i2c3 {
> >> +       status = "okay";
> >> +
> >> +       /*
> >> +        * Touchscreen pin control is shared between Atmel and Elan
> >> devices, +        * so we have to pull it up to the bus level.
> >> +        */
> >> +       pinctrl-names = "default";
> >> +       pinctrl-0 = <&i2c3_xfer &touch_int &touch_rst>;
> >> +
> >> +       clock-frequency = <400000>;
> >> +       i2c-scl-falling-time-ns = <50>;
> >> +       i2c-scl-rising-time-ns = <300>;
> >> +
> >> +       touchscreen at 10 {
> >> +               compatible = "elan,ekth3500";
> >> +               reg = <0x10>;
> >> +               interrupt-parent = <&gpio2>;
> >> +               interrupts = <14 IRQ_TYPE_EDGE_FALLING>;
> >> +               reset-gpios = <&gpio2 15 GPIO_ACTIVE_LOW>;
> >> +               vcc33-supply = <&vcc33_touch>;
> >> +               vccio-supply = <&vcc33_touch>;
> >> +       };
> >> +
> >> +       touchscreen at 4a {
> >> +               compatible = "atmel,atmel_mxt_ts";
> >> +               reg = <0x4a>;
> >> +               atmel,reset-gpios = <&gpio2 15 GPIO_ACTIVE_LOW>;
> >> +               avdd-supply = <&vcc5v_touch>;
> >> +               interrupt-parent = <&gpio2>;
> >> +               interrupts = <14 IRQ_TYPE_EDGE_FALLING>;
> >> +               vdd-supply = <&vcc33_touch>;
> > 
> > Technically I don't think most of these properties exist upstream, but
> > Dmitry (now CCed) might know more.
> > 
> > ...actually similar for elan.  At least I don't see 'reset-gpios', nor
> > 'vcc33-supply' and 'vccio-supply' in the bindings when I checkout
> > linuxnext...
> 
> I just merged the Elan regulator/gpio support, it will show up in the next
> next.
> > Oh, and also locally our tree has hacks in it to handle the fact that
> > both atmel and elan will try to grab the same reset GPIO.  I'm nearly
> > certain that Dmitry said that the current hacks we have wouldn't be
> > appropriate for upstream.  I had some proposals for better solutions,
> > but they were slightly more controversial.  In any case, I think all
> > shipping devices ended up using one or the other of these two
> > touchscreens (I forget which), so you could probably simplify and just
> > pick one of them.  If old prototype devices don't work upstream it
> > wouldn't be the end of the world.
> 
> I think if you pick Elan for this board it will cover majority (all?)
> devices that actually shipped.

I guess I'll simply drop the touchscreens for for this initial submission - at 
this point in time we don't have support for the internal display anyway, so I 
can sort out the touchscreens a bit later.

armsoc has a slightly early cutoff most of the time, so I'll try to land the 
initial support and worry about the smaller tidbits later :-)


Heiko
