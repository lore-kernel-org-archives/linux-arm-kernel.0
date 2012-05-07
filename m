From: viresh.linux@gmail.com (viresh kumar)
Date: Mon, 7 May 2012 21:26:03 +0530
Subject: [RFC 4/5] pinctrl: SPEAr: Add gpio ranges support
In-Reply-To: <CACRpkdbhbESbQWX=5RC86X9Z+R767oijDB4myw=bSRay9ud-qQ@mail.gmail.com>
References: <cover.1335526926.git.viresh.kumar@st.com>
 <4f7690c68b1fa5ef14b29b88fed50237e068fe4d.1335526926.git.viresh.kumar@st.com>
 <CACRpkdbhbESbQWX=5RC86X9Z+R767oijDB4myw=bSRay9ud-qQ@mail.gmail.com>
Message-ID: <CAOh2x=kHdAorqnnB8cD76-vSnghbr38KwH6gu3yEv=nj=YALww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 7, 2012 at 6:08 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Fri, Apr 27, 2012 at 1:43 PM, Viresh Kumar <viresh.kumar@st.com> wrote:
>> +static struct spear_gpio_pingroup spear1310_gpio_pingroup[] = {
>> + ? ? ? {
>> + ? ? ? ? ? ? ? .pins = i2c0_pins,
>> + ? ? ? ? ? ? ? .npins = ARRAY_SIZE(i2c0_pins),
>> + ? ? ? ? ? ? ? .muxreg = {
>> + ? ? ? ? ? ? ? ? ? ? ? .reg = PAD_FUNCTION_EN_0,
>> + ? ? ? ? ? ? ? ? ? ? ? .mask = PMX_I2C0_MASK,
>> + ? ? ? ? ? ? ? ? ? ? ? .val = 0,
>> + ? ? ? ? ? ? ? },
>> + ? ? ? }, {
>> + ? ? ? ? ? ? ? .pins = ssp0_pins,
>> + ? ? ? ? ? ? ? .npins = ARRAY_SIZE(ssp0_pins),
>> + ? ? ? ? ? ? ? .muxreg = {
>> + ? ? ? ? ? ? ? ? ? ? ? .reg = PAD_FUNCTION_EN_0,
>> + ? ? ? ? ? ? ? ? ? ? ? .mask = PMX_SSP0_MASK,
>> + ? ? ? ? ? ? ? ? ? ? ? .val = 0,
>> + ? ? ? ? ? ? ? },
>> + ? ? ? }, {
>
> Hm first I wonder what i2c0 and ssp0 have to do with GPIO...

I didn't wanted to create new Arrays for exactly the same pins. so used
earlier ones that belonged to peripherals.

> Well whatever, maybe split out a special patch just adding the
> groups?

If i don't use them in that patch, we will get compilation warnings after it.

> Please cut down this code by using a clever macro:
>
> #define SPEAR_PCTL_GRP(a,b) \
> { \
> ? ?.pins = ?a##_pins, \
> ? ?.npins = ARRAY_SIZE(a##_pins), \
> ? ?.muxreg = { \
> ? ? ? ?.reg = PAD_FUNCTION_EN_2, \
> ? ? ? ?.mask PMX_##b##_MASK, \
> ? ? ? ?.val = 0, \
> ? ?}, \
> }
>
> Then:
>
> static struct spear_gpio_pingroup spear1310_gpio_pingroup[] = {
> ? ?SPEAR_PCTL_GRP(i2c0, I2C0),
> ? ?SPEAR_PCTL_GRP(ssp0, SSP0),
> ? ?SPEAR_PCTL_GRP(ssp0_cs0, SSP0_CS0),
> ? ?(...)
> };
>
> (You get the picture.)

Yes. Will do.
