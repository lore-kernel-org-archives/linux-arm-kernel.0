From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 7 May 2012 14:38:23 +0200
Subject: [RFC 4/5] pinctrl: SPEAr: Add gpio ranges support
In-Reply-To: <4f7690c68b1fa5ef14b29b88fed50237e068fe4d.1335526926.git.viresh.kumar@st.com>
References: <cover.1335526926.git.viresh.kumar@st.com>
 <4f7690c68b1fa5ef14b29b88fed50237e068fe4d.1335526926.git.viresh.kumar@st.com>
Message-ID: <CACRpkdbhbESbQWX=5RC86X9Z+R767oijDB4myw=bSRay9ud-qQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 27, 2012 at 1:43 PM, Viresh Kumar <viresh.kumar@st.com> wrote:

> Most of SPEAr SoCs, which support pinctrl, can configure & use pads as gpio.
> This patch gpio enable support for SPEAr pinctrl drivers.

OK...

> +static struct spear_gpio_pingroup spear1310_gpio_pingroup[] = {
> + ? ? ? {
> + ? ? ? ? ? ? ? .pins = i2c0_pins,
> + ? ? ? ? ? ? ? .npins = ARRAY_SIZE(i2c0_pins),
> + ? ? ? ? ? ? ? .muxreg = {
> + ? ? ? ? ? ? ? ? ? ? ? .reg = PAD_FUNCTION_EN_0,
> + ? ? ? ? ? ? ? ? ? ? ? .mask = PMX_I2C0_MASK,
> + ? ? ? ? ? ? ? ? ? ? ? .val = 0,
> + ? ? ? ? ? ? ? },
> + ? ? ? }, {
> + ? ? ? ? ? ? ? .pins = ssp0_pins,
> + ? ? ? ? ? ? ? .npins = ARRAY_SIZE(ssp0_pins),
> + ? ? ? ? ? ? ? .muxreg = {
> + ? ? ? ? ? ? ? ? ? ? ? .reg = PAD_FUNCTION_EN_0,
> + ? ? ? ? ? ? ? ? ? ? ? .mask = PMX_SSP0_MASK,
> + ? ? ? ? ? ? ? ? ? ? ? .val = 0,
> + ? ? ? ? ? ? ? },
> + ? ? ? }, {

(...)

Hm first I wonder what i2c0 and ssp0 have to do with GPIO...
Well whatever, maybe split out a special patch just adding the
groups?

Please cut down this code by using a clever macro:

#define SPEAR_PCTL_GRP(a,b) \
{ \
    .pins =  a##_pins, \
    .npins = ARRAY_SIZE(a##_pins), \
    .muxreg = { \
        .reg = PAD_FUNCTION_EN_2, \
        .mask PMX_##b##_MASK, \
        .val = 0, \
    }, \
}

Then:

static struct spear_gpio_pingroup spear1310_gpio_pingroup[] = {
    SPEAR_PCTL_GRP(i2c0, I2C0),
    SPEAR_PCTL_GRP(ssp0, SSP0),
    SPEAR_PCTL_GRP(ssp0_cs0, SSP0_CS0),
    (...)
};

(You get the picture.)

> +static struct spear_gpio_pingroup spear3xx_gpio_pingroup[] = {
> + ? ? ? {
> + ? ? ? ? ? ? ? .pins = firda_pins,
> + ? ? ? ? ? ? ? .npins = ARRAY_SIZE(firda_pins),
> + ? ? ? ? ? ? ? .muxreg = {
> + ? ? ? ? ? ? ? ? ? ? ? .mask = PMX_FIRDA_MASK,
> + ? ? ? ? ? ? ? ? ? ? ? .val = PMX_FIRDA_MASK,
> + ? ? ? ? ? ? ? },
> + ? ? ? }, {
> + ? ? ? ? ? ? ? .pins = i2c_pins,
> + ? ? ? ? ? ? ? .npins = ARRAY_SIZE(i2c_pins),
> + ? ? ? ? ? ? ? .muxreg = {
> + ? ? ? ? ? ? ? ? ? ? ? .mask = PMX_I2C_MASK,
> + ? ? ? ? ? ? ? ? ? ? ? .val = PMX_I2C_MASK,
> + ? ? ? ? ? ? ? },
> + ? ? ? }, {

And do the same thing here.

Yours,
Linus Walleij
