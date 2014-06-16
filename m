From: dianders@google.com (Doug Anderson)
Date: Mon, 16 Jun 2014 10:02:58 -0700
Subject: [PATCH 3/3] ARM: dts: Enable audio support for Peach-pi board
In-Reply-To: <20140616165123.GA21661@sirena.org.uk>
References: <1402464739-19044-1-git-send-email-tushar.b@samsung.com>
 <1402464739-19044-4-git-send-email-tushar.b@samsung.com>
 <CAD=FV=XqqP7+xDOAKCixivzgaO0xvJX7L+CCN+unAEuf-6aUbQ@mail.gmail.com>
 <539ED2C0.8030405@gmail.com>
 <CAD=FV=UaaRQVq3TmXMTv9OkER+zORC89YfPNjwZwfCQKmuavrw@mail.gmail.com>
 <20140616165123.GA21661@sirena.org.uk>
Message-ID: <CAD=FV=VaK3PR4exCsYbaYwEK=_cuK+=PK9QqK_uD-cT_Y7m7UQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark,

On Mon, Jun 16, 2014 at 9:51 AM, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Jun 16, 2014 at 09:49:26AM -0700, Doug Anderson wrote:
>
>> Yes please.  I think there's supposed to be some official ordering of
>> things.  If anyone reading this has a pointer to the official sort
>> order of things in the device tree I'd love to see it!  ;)
>
> Most exact first I believe?

More specifically I'm looking for the ordering between nodes and
between properties in a node.  For instance:

1. It appears to be convention to sort children of the "pinctrl" nodes
by the first pin number in that group.  That is:

ec_spi_cs: ec-spi-cs {
  samsung,pins = "gpb1-2";
  ...
};

...comes before:
usb300_vbus_en: usb300-vbus-en {
  samsung,pins = "gph0-0";
  ...
};

...that's one really good and well-defined ordering.


2. I have no idea how general properties should be sorted.  I tend to
see "compatible" first but that's above the only rule I've seen.
Sometimes I've seen "status" first, sometimes last, sometimes
alphabetically sorted, and sometimes in a random place.  Examples:

usb301_vbus_reg: regulator-usb301 {
  compatible = "regulator-fixed";
  regulator-name = "P5.0V_USB3CON1";
  regulator-min-microvolt = <5000000>;
  regulator-max-microvolt = <5000000>;
  gpio = <&gph0 1 0>;
  pinctrl-names = "default";
  pinctrl-0 = <&usb301_vbus_en>;
  enable-active-high;
};

&hdmi {
  status = "okay";
  hpd-gpio = <&gpx3 7 GPIO_ACTIVE_HIGH>;
  pinctrl-names = "default";
  pinctrl-0 = <&hdmi_hpd_irq>;
  ddc = <&i2c_2>;
};


3. I have no idea how to sort nodes.  In theory you could say that
they should be sorted by base address:

i2s0: i2s at 03830000 {
  ...
};

hsi2c_7: i2c at 12CD0000 {
  ...
};

i2s1: i2s at 12D60000 {
  ...
};

...that works until someone argues that all of the "i2s" nodes should
be together.  It also doesn't work so well with the board convention
of using aliases to refer to things in the SoC, like:

&i2s0 {
  status = "okay";
};

&hsi2c_7 {
  status = "okay";
};

...it's not at all obvious in the board file what the base address in
the SoC was.

---

Anyway, none of this is earth shattering and it doesn't matter all
that much.  It's just nice to have an official order to make diffing
easier and also to avoid merge conflicts (unlikely someone changing
different properties will both add them in the same place in the
ordering).


-Doug
