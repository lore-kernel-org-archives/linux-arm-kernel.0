From: viresh.kumar@st.com (viresh kumar)
Date: Wed, 1 Sep 2010 12:31:24 +0530
Subject: [PATCH 21/74] ST SPEAr : Added keyboard support
In-Reply-To: <20100901063158.GF23585@core.coreip.homeip.net>
References: <cover.1283161023.git.viresh.kumar@st.com>
	<b62c01f06f5090775271a5f779db8508638eff15.1283161023.git.viresh.kumar@st.com>
	<20100830164825.GA28186@core.coreip.homeip.net>
	<4C7DE35F.9080103@st.com>
	<20100901063158.GF23585@core.coreip.homeip.net>
Message-ID: <4C7DFA44.3050204@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/1/2010 12:01 PM, Dmitry Torokhov wrote:
>>>> +#define DECLARE_KEYMAP(name) \
>>>> > >> +int name[] = {\
>>>> > >> +     KEY(0, 0, KEY_ESC), \

[snip...]

>>>> > >> +     KEY(8, 6, KEY_KP2), \
>>>> > >> +     KEY(8, 7, KEY_KP3), \
>>>> > >> +     KEY(8, 8, KEY_KP0), \
>>>> > >> +};
>>> > >
>>> > > Hm, I'd expect this to be in particular board code, not in the header
>>> > > file.
>>> > >
>> >
>> > Currently we have support for evaluation boards only and all of them will have
>> > this structure in their board source files. In order to remove redundant code we
>> > kept it in plat/keyboard.h.
>> >
> So call it "spear_default_keymap" and put it right into the driver? And
> then allow platform code override it.
> 

Renaming is fine but I would still like to keep spear_default_keymap in
platform files instead of driver.

>>>> > >> +struct spear_kbd {
>>>> > >> +     struct input_dev *input;
>>>> > >> +     void __iomem *io_base;          /* Keyboard Base Address */
>>>> > >> +     struct clk *clk;
>>>> > >> +     int *keymap;
>>> > >
>>> > > You need a copy of keymap here so that userspace can modify it safely
>>> > > via EVIOCSKEYCODE.
>>> > >
>> >
>> > We have one copy of struct spear_kbd per device structure. I think it
>> > will be fine if we change this structure only. And so don't need to copy
>> > another structure in driver.
> Normally such platform data should be declared as 'const' and drivers
> should not modify such data. Also unbinding device from driver and
> rebinding later should restore the device into pristine state. Having a
> copy of keymap in spear_kbd allows to achieve such behavior.
> 

OK.

viresh.
