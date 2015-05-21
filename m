From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 21 May 2015 09:19:00 +0200
Subject: [PATCH v8 4/9] mfd: Add binding document for NVIDIA Tegra XUSB
In-Reply-To: <20150520145227.GA3787@ulmo.nvidia.com>
References: <1430761002-9327-1-git-send-email-abrestic@chromium.org>
 <1430761002-9327-5-git-send-email-abrestic@chromium.org>
 <20150513143954.GA3394@x1> <55544CC5.9050001@nvidia.com>
 <20150514074058.GA22418@x1>
 <CAL1qeaEqNejuGkN-ke11mtWnaaRo+XieCBkQ6+NQ-Afym6uxVA@mail.gmail.com>
 <CAL1qeaHy0h7bXhuLHh4AG2Zfu48JYeawgVo4dp_k4oX8YFw6tA@mail.gmail.com>
 <20150520063551.GD3627@x1> <20150520145227.GA3787@ulmo.nvidia.com>
Message-ID: <CACRpkdbK4BBhs==yFWW91M_4x5f3RGDiXBV+yBYYQ78JG0mMLg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 20, 2015 at 4:52 PM, Thierry Reding
<thierry.reding@gmail.com> wrote:

> I'm a little confused by the simple-mfd approach. The only code I see in
> linux-next for this is a single line that adds the "simple-mfd" string
> to the OF device ID table in drivers/of/platform.c. As far as I can tell
> this will merely cause child devices to be created. There won't be a
> shared regmap and resources won't be set up properly either.

That is correct. The simple-mfd is a two-component approach.

Ideally, in the simplest case, you combine simple-mfd with syscon.

foo at 0 {
    compatible = "foo", "syscon", "simple-mfd";
    reg = <0x10000000 0x1000>;

    bar at 1 {
        compatible = "bar";
    };

    baz at 2 {
        compatible = "baz";
    };
};

This will instantiate bar and baz.

These subdrivers then probe and:

probe() {
   struct regmap *map;

   map = syscon_node_to_regmap(parent->of_node);
   (...)
}

Simple, syscon is the MFD hub.

Yours,
Linus Walleij
