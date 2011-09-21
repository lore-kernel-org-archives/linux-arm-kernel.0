From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 21 Sep 2011 12:45:52 -0700
Subject: [PATCH 1/2] drivers: create a pin control subsystem v7
In-Reply-To: <CACRpkdZyhkydTutHXfry_dUPK_Ts_jq+5VHcr8XdgrHSExTyww@mail.gmail.com>
References: <1316175203-10736-1-git-send-email-linus.walleij@stericsson.com>
	<74CDBE0F657A3D45AFBB94109FB122FF04B7321751@HQMAIL01.nvidia.com>
	<CACRpkdZyhkydTutHXfry_dUPK_Ts_jq+5VHcr8XdgrHSExTyww@mail.gmail.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF1738180167@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij wrote at Wednesday, September 21, 2011 3:17 AM:
> On Tue, Sep 20, 2011 at 11:58 PM, Stephen Warren <swarren@nvidia.com> wrote:
> > Linus Walleij wrote at Friday, September 16, 2011 6:13 AM:
> >> This creates a subsystem for handling of pin control devices.
> >> These are devices that control different aspects of package
> >> pins.
> >
> > I've read through the documentation and header files, but not the .c files,
> > and this looks almost perfect as far as I can tell right now. I'll try to
> > review the .c files sometime too.
> 
> Great, I'm hunting your Acked-by/Reviewed-by ...

Very close; I was just holding off until we resolved the discussion on
hog'd non-system mapping table entries, and I figured I'd wait until v8
which presumably would delete the pinmux_config function from the header?

> I will likely request inclusion into linux-next soon-ish.
> 
> > I just have one comment:
> >
> >> diff --git a/include/linux/pinctrl/pinmux.h b/include/linux/pinctrl/pinmux.h
> > ...
> >> +/* External interface to pinmux */
> >> +extern int pinmux_request_gpio(unsigned gpio);
> >> +extern void pinmux_free_gpio(unsigned gpio);
> >> +extern struct pinmux * __must_check pinmux_get(struct device *dev, const char *name);
> >> +extern void pinmux_put(struct pinmux *pmx);
> >> +extern int pinmux_enable(struct pinmux *pmx);
> >> +extern void pinmux_disable(struct pinmux *pmx);
> >> +extern int pinmux_config(struct pinmux *pmx, u16 param, unsigned long *data);
> >
> > That definition of pinmux_config doesn't seem as useful as it could be;
> 
> It should be removed. It's just there in the header file, I killed off
> the implementation because specific control of a mux doesn't make
> sense. We want to do stuff to pin groups directly, not related to
> muxing, so that kind of thing needs to be in the generic pinctrl
> interface.

OK.

> > I'd like the ability to execute pinmux_config on a /named/ group, and I
> > can certainly see a use-case for applying it to /named/ pins too.
> 
> That sounds correct to me.
> 
> To abstract things the stuff we can do with the group should be
> something enumerated too. So:
> 
> pinctrl_config_group(const char *pinctrl_device, const char *group,
> const char *mode);
> pinctrl_config_pin(const char *pinctrl_device, int pin, const char *mode);
> 
> So the driver need an API to enumerate pin and group modes.
> 
> I might want to save this thing for post-merge of the basic API and
> pinmux stuff though so we don't try to push too much upfront
> design at once.

Yes, adding in a replacement _config API can certainly be a later patch.

One comment on the API above: I think you want "mode" (or "setting"?)
/and/ a value parameter; Tegra's pull strength definition for example
is:

enum tegra_pull_strength {
        TEGRA_PULL_0 = 0,
        TEGRA_PULL_1,
// ... (every value in between)
        TEGRA_PULL_30,
        TEGRA_PULL_31,
        TEGRA_MAX_PULL,
};

And it seems better to represent that as ("pull", 0) ... ("pull", 31) than
"pull0" .. "pull31" such that the value needs to be parsed out of the "mode"
string somehow by the driver.

-- 
nvpublic
