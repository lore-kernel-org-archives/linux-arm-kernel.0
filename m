From: viresh.linux@gmail.com (viresh kumar)
Date: Mon, 7 May 2012 21:28:15 +0530
Subject: [RFC 4/5] pinctrl: SPEAr: Add gpio ranges support
In-Reply-To: <201205071528.48460.arnd@arndb.de>
References: <cover.1335526926.git.viresh.kumar@st.com>
 <4f7690c68b1fa5ef14b29b88fed50237e068fe4d.1335526926.git.viresh.kumar@st.com>
 <CACRpkdbhbESbQWX=5RC86X9Z+R767oijDB4myw=bSRay9ud-qQ@mail.gmail.com>
 <201205071528.48460.arnd@arndb.de>
Message-ID: <CAOh2x=mG8nJ8QLOJYniysBw=vkNSaQ=m0XHAh0foU3A7ozpuqg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 7, 2012 at 8:58 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 07 May 2012, Linus Walleij wrote:
>> Hm first I wonder what i2c0 and ssp0 have to do with GPIO...
>> Well whatever, maybe split out a special patch just adding the
>> groups?
>>
>> Please cut down this code by using a clever macro:
>>
>> #define SPEAR_PCTL_GRP(a,b) \
>> { \
>> ? ? .pins = ?a##_pins, \
>> ? ? .npins = ARRAY_SIZE(a##_pins), \
>> ? ? .muxreg = { \
>> ? ? ? ? .reg = PAD_FUNCTION_EN_2, \
>> ? ? ? ? .mask PMX_##b##_MASK, \
>> ? ? ? ? .val = 0, \
>> ? ? }, \
>> }
>>
>> Then:
>>
>> static struct spear_gpio_pingroup spear1310_gpio_pingroup[] = {
>> ? ? SPEAR_PCTL_GRP(i2c0, I2C0),
>> ? ? SPEAR_PCTL_GRP(ssp0, SSP0),
>> ? ? SPEAR_PCTL_GRP(ssp0_cs0, SSP0_CS0),
>> ? ? (...)
>> };
>>
>> (You get the picture.)
>
> If you allow me to give my 2 cents, I would recommend the exact opposite
> in general: resist the urge to use complex macros for everything!
>
> When that gets too hard, please at least use macros that do not concatenate
> C identifies because that makes it really hard to grep for where a constant
> gets used.
>
> A more acceptable macro would be
>
> #define SPEAR_PCTL_GRP(_pins, _mask) \
> { \
> ? ? ? ?.pins = ?_pins, \
> ? ? ? ?.npins = ARRAY_SIZE(_pins), \
> ? ? ? ?.muxreg = { \
> ? ? ? ? ? ? ? ?.reg = PAD_FUNCTION_EN_2, \
> ? ? ? ? ? ? ? ?.mask _val, \
> ? ? ? ? ? ? ? ?.val = 0, \
> ? ? ? ?}, \
> }
>
> but open-coding is generally ok too. Note that you can sometimes save a lot
> of lines if you don't first define all those constants as macros but
> treat a table like this as the place where you put the raw numbers
> from the data sheet, if that the only code location in which they are
> used.

Hmm. Will try to do something better.

--
viresh
