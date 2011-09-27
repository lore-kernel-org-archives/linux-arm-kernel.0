From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 27 Sep 2011 09:51:17 +0200
Subject: [PATCH 1/2] drivers: create a pin control subsystem v7
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF1738180167@HQMAIL01.nvidia.com>
References: <1316175203-10736-1-git-send-email-linus.walleij@stericsson.com>
	<74CDBE0F657A3D45AFBB94109FB122FF04B7321751@HQMAIL01.nvidia.com>
	<CACRpkdZyhkydTutHXfry_dUPK_Ts_jq+5VHcr8XdgrHSExTyww@mail.gmail.com>
	<74CDBE0F657A3D45AFBB94109FB122FF1738180167@HQMAIL01.nvidia.com>
Message-ID: <CACRpkdZiQX0whbC85dN0JmNB=sgWiZ=WiUwkBdrHzFC4awH8YA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 21, 2011 at 9:45 PM, Stephen Warren <swarren@nvidia.com> wrote:
> Linus Walleij wrote at Wednesday, September 21, 2011 3:17 AM:
>> To abstract things the stuff we can do with the group should be
>> something enumerated too. So:
>>
>> pinctrl_config_group(const char *pinctrl_device, const char *group,
>> const char *mode);
>> pinctrl_config_pin(const char *pinctrl_device, int pin, const char *mode);
>>
>> So the driver need an API to enumerate pin and group modes.
>>
>> I might want to save this thing for post-merge of the basic API and
>> pinmux stuff though so we don't try to push too much upfront
>> design at once.
>
> Yes, adding in a replacement _config API can certainly be a later patch.

If I'm efficient enough we might get that add-on before the v3.2
merge window, I'll iterate that patch separately though.

> One comment on the API above: I think you want "mode" (or "setting"?)
> /and/ a value parameter; Tegra's pull strength definition for example
> is:
>
> enum tegra_pull_strength {
> ? ? ? ?TEGRA_PULL_0 = 0,
> ? ? ? ?TEGRA_PULL_1,
> // ... (every value in between)
> ? ? ? ?TEGRA_PULL_30,
> ? ? ? ?TEGRA_PULL_31,
> ? ? ? ?TEGRA_MAX_PULL,
> };
>
> And it seems better to represent that as ("pull", 0) ... ("pull", 31) than
> "pull0" .. "pull31" such that the value needs to be parsed out of the "mode"
> string somehow by the driver.

OK so we might want some public defintion of "things you can do"
with pins, then an opaque parameter.

like:

#define PINCTRL_PULL "pull"
#define PINCTRL_BIAS "bias"
#define PINCTRL_LOADCAP "load-capacitance"
#define PINCTRL_DRIVE "drive"

...but then it's just simple enumerators, and we might be better off
with a simple enum after all:

enum pinctrl_pin_ops {
    PINCTRL_PULL,
    PINCTRL_BIAS,
    PINCTRL_LOADCAP,
    PINCTRL_DRIVE,
}

Surely the device tree will have to translate that enum into strings
(I guess? Sorry for my low DT competence) but that is more of a
DT pecularity and can be kept in the DT pin control parser?

Yours,
Linus Walleij
