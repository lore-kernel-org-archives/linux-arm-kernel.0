From: dianders@chromium.org (Doug Anderson)
Date: Wed, 16 Sep 2015 14:56:57 -0700
Subject: [PATCH v3 2/2] drm: bridge/dw_hdmi: add dw hdmi i2c bus adapter
 support
In-Reply-To: <55F9D7F0.4070402@mentor.com>
References: <1440970470-7155-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <CAD=FV=XZ4cY4o-=vL79GDE4m57B+Rw_Yr_QwtB6T7DbQNzmU0Q@mail.gmail.com>
 <55F9D7F0.4070402@mentor.com>
Message-ID: <CAD=FV=Vk+qziHohVL_Zaag0qqh_R6DnA1s-ppVFC=cBccAn4EA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vladimir,

On Wed, Sep 16, 2015 at 1:58 PM, Vladimir Zapolskiy
<vladimir_zapolskiy@mentor.com> wrote:
>>> +static void dw_hdmi_i2c_init(struct dw_hdmi *hdmi)
>>> +{
>>> +       /* Set Fast Mode speed */
>>> +       hdmi_writeb(hdmi, 0x0b, HDMI_I2CM_DIV);
>>
>> If you're going to hardcode to something, it seems like hardcoding to
>> standard mode might be better?  It's likely that users will plug into
>> all kinds of broken / crappy HDMI devices out there.  I think you'll
>> get better compatibility by using the slower mode, and EDID transfers
>> really aren't too performance critical are they?
>>
>
> Accepted. I don't know what are the exact divisors of master clock for
> fast and standard modes, for reference I'll make a simple performance
> test and publish its results. I expect that in standard mode SCL is
> about 100KHz and in fast mode SCL is about 400KHz, and, if in standard
> mode SCL is less than 100KHz, it will take more than 50ms to read out
> 512 bytes of data, which might be not acceptable from performance
> perspective.

Yes, I'd expect 100kHz and 400kHz.

I agree that 50ms is non-trivial, but it's also not something you're
doing lots of.  I'd expect that the EDID is read over this channel at
cable plugin time and then not used much after that.  Adding an extra
40ms (10ms vs 50ms) before we can access the TV doesn't seem terrible
for compatibility.

Doing a quick scan for what others in mainline do:

A few can be found with:

$ git grep -A3 hdmiddc | grep clock-freq
arch/arm/boot/dts/stihxxx-b2120.dtsi-
clock-frequency = <100000>;
arch/arm/boot/dts/tegra30-apalis.dtsi-          clock-frequency = <100000>;
arch/arm/boot/dts/tegra30-beaver.dts-           clock-frequency = <100000>;
arch/arm/boot/dts/tegra30-colibri.dtsi-         clock-frequency = <100000>;

A few more done by hand (picked arbitrarily; note that unspecified
clock freq means 100000 on rk3288):

arch/arm/boot/dts/omap3-beagle.dts:             ddc-i2c-bus = <&i2c3>;
arch/arm/boot/dts/omap3-beagle.dts:&i2c3 {
arch/arm/boot/dts/omap3-beagle.dts-     clock-frequency = <100000>;
arch/arm/boot/dts/omap3-beagle.dts-};

arch/arm/boot/dts/omap3-beagle-xm.dts:          ddc-i2c-bus = <&i2c3>;
arch/arm/boot/dts/omap3-beagle-xm.dts:&i2c3 {
arch/arm/boot/dts/omap3-beagle-xm.dts-  clock-frequency = <100000>;
arch/arm/boot/dts/omap3-beagle-xm.dts-};

arch/arm/boot/dts/rk3288-evb.dtsi:      ddc-i2c-bus = <&i2c5>;
arch/arm/boot/dts/rk3288-evb.dtsi:&i2c5 {
arch/arm/boot/dts/rk3288-evb.dtsi-      status = "okay";
arch/arm/boot/dts/rk3288-evb.dtsi-};

arch/arm/boot/dts/rk3288-firefly.dtsi:  ddc-i2c-bus = <&i2c5>;
arch/arm/boot/dts/rk3288-firefly.dtsi:&i2c5 {
arch/arm/boot/dts/rk3288-firefly.dtsi-  status = "okay";
arch/arm/boot/dts/rk3288-firefly.dtsi-};

arch/arm/boot/dts/rk3288-popmetal.dts:  ddc-i2c-bus = <&i2c5>;
arch/arm/boot/dts/rk3288-popmetal.dts:&i2c5 {
arch/arm/boot/dts/rk3288-popmetal.dts-  status = "okay";
arch/arm/boot/dts/rk3288-popmetal.dts-};

arch/arm/boot/dts/imx6q-gk802.dts:      ddc-i2c-bus = <&i2c3>;
arch/arm/boot/dts/imx6q-gk802.dts:&i2c3 {
arch/arm/boot/dts/imx6q-gk802.dts-      pinctrl-names = "default";
arch/arm/boot/dts/imx6q-gk802.dts:      pinctrl-0 = <&pinctrl_i2c3>;
arch/arm/boot/dts/imx6q-gk802.dts-      clock-frequency = <100000>;

arch/arm/boot/dts/imx6q-gw5400-a.dts:   ddc-i2c-bus = <&i2c3>;
arch/arm/boot/dts/imx6q-gw5400-a.dts:&i2c3 {
arch/arm/boot/dts/imx6q-gw5400-a.dts-   clock-frequency = <100000>;

arch/arm/boot/dts/imx6qdl-apf6dev.dtsi: ddc-i2c-bus = <&i2c3>;
arch/arm/boot/dts/imx6qdl-apf6dev.dtsi:&i2c3 {
arch/arm/boot/dts/imx6qdl-apf6dev.dtsi- clock-frequency = <400000>;

...ah ha!  Found one at 400kHz.  ...but it sure looks like most people
have decided that 100kHz is wiser...

>>> +static int dw_hdmi_i2c_xfer(struct i2c_adapter *adap,
>>> +                           struct i2c_msg *msgs, int num)
>>> +{
>>> +       struct dw_hdmi *hdmi = i2c_get_adapdata(adap);
>>> +       struct dw_hdmi_i2c *i2c = hdmi->i2c;
>>> +       u8 addr = msgs[0].addr;
>>> +       int i, ret = 0;
>>> +
>>> +       dev_dbg(hdmi->dev, "xfer: num: %d, addr: %#x\n", num, addr);
>>> +
>>> +       for (i = 0; i < num; i++) {
>>> +               if (msgs[i].addr != addr) {
>>> +                       dev_warn(hdmi->dev,
>>> +                                "unsupported transfer, changed slave address\n");
>>> +                       return -EOPNOTSUPP;
>>> +               }
>>> +
>>> +               if (msgs[i].len == 0) {
>>> +                       dev_dbg(hdmi->dev,
>>> +                               "unsupported transfer %d/%d, no data\n",
>>> +                               i + 1, num);
>>> +                       return -EOPNOTSUPP;
>>> +               }
>>> +       }
>>> +
>>> +       mutex_lock(&i2c->lock);
>>> +
>>
>> If I may make a suggestion, it's worth considering putting
>> dw_hdmi_i2c_init() here and removing it from the dw_hdmi_bind()
>> function.  There isn't any state kept between i2c transfers (each one
>> is independent), so re-initting each time won't hurt.  ...and doing so
>> has the potential to fix some things.
>
> I think it is resourse wasteful, especially since it does not solve any
> actual problem, if I understand your arguments correctly.
>
> I'd like to see the I2C bus registered even if there is no ongoing
> transfer, for instance running "modprobe i2c-dev; i2cdetect -l".
>
> For information I notice that there is a movement of I2C bus
> configuration/capture from bind() to probe() in DRM drivers, e.g. see
> commit 53bdcf5f026c .

Skipping dw_hdmi_i2c_init() won't prevent the bus from showing up.  We
should still call i2c_add_adapter() at init time.  I'm only suggesting
calling dw_hdmi_i2c_init() at each transfer, and that does a tiny
amount of work (set soft reset, init 4 extra registers).

Note that in my tree moving it here actually does solve a real
problem, but that's not a great argument for upstream.  In my tree we
have suspend/resume support, and the resume code wasn't calling
dw_hdmi_i2c_init() (though it was needed).  Thus putting the init() at
the start of the transfer function does solve a real problem for me.
In my case I could also have solved the problem by calling
dw_hdmi_i2c_init() in the resume code, but (to me) adding 4 extra
register writes for each i2c transfer seemed like a cleaner fix since
I like the idea defensively programming and making sure we can't get
stuck in a bad state.


>> On rk3288 there's at least one case where the i2c controller can get
>> wedged and just totally stops working.  Although this particular wedge
>> isn't fixed by calling dw_hdmi_i2c_init() (it needs a full controller
>> reset to fix), it's possible that there may be other cases where the
>> HDMI_I2CM_SOFTRSTZ fixes some bad state.
>
> I don't know, may be the shared part of the driver should export a
> reset() function for RK3288, if it (or its next version) helps?

Locally we've got the reset master wired up now in
<https://chromium-review.googlesource.com/#/c/299601/>.  ...but it
appears that our tree is pretty far away from upstream in many ways at
the moment, so this isn't trivial to just post upstream.  :(  Where I
can I've still been trying to post upstream / give feedback upstream,
but where there are too many differences it's a bit hard.  Hopefully
Rockchip will be able to get everything resolved, since I know several
of their engineers participate upstream.


> Unlickily I don't possess an RK3288 power board, but in any case I would
> appreciate, if you share your test, I'll try to reproduce the same
> problem on iMX6.

It's possible it's a shared problem with all dw_hdmi users, but hard
to know.  I've got a pretty good description of it at
<https://chromium-review.googlesource.com/#/c/299493/1/drivers/gpu/drm/bridge/dw_hdmi.c>.
I probably won't land that change locally (nor submit it upstream)
since IMHO doing the full reset of the HDMI part at HPD time is a
better solution.

-Doug
