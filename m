From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 7 Sep 2010 15:29:59 +0800
Subject: colibri-pxa300: LCD_LDD / LCD_CS gpio conflict
In-Reply-To: <201009070920.34414.pieterg@gmx.com>
References: <201009061512.23705.pieterg@gmx.com>
	<AANLkTim+h8Wu40LoWue2=TeKykAJmr8=rT48gF5eCX6j@mail.gmail.com>
	<201009070920.34414.pieterg@gmx.com>
Message-ID: <AANLkTi=vTp0+x=zzM6j+stWENvZCnOLOpd4LXvaiMh6Z@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 7, 2010 at 3:20 PM, pieterg <pieterg@gmx.com> wrote:
> On Tuesday 07 September 2010 04:43:31 Eric Miao wrote:
>> On Mon, Sep 6, 2010 at 9:12 PM, pieterg <pieterg@gmx.com> wrote:
>> > In colibri-pxa300.c, line 132, gpio config GPIO62_LCD_CS_N is
>> > overriding the GPIO62_LCD_LDD_8 configuration, earlier in the pin
>> > config table.
>> >
>> > As a result, one pixel data line is missing, obviously causing wrong
>> > pixel data on passive lcd panels.
>> >
>> > Not sure what the best workaround should be.
>> > LDD_CS is not available on the colibri evalboard as far as I can see,
>> > so we might just define GPIO127_LCD_CS_N instead? (till the soc/carrier
>> > board configs have been split)
>> >
>> > Or for now just put GPIO62_LCD_CS_N between
>> > #ifdef ?
>>
>> Possibly define two groups of LCD pin configurations and select them
>> when the appropriate LCD expansion card is plugged. If it can be
>> detected at run-time, that will be perfect, otherwise have to come
>> up with ugly #ifdef .. #else then.
>
> I don't think you can detect whether an active or passive lcd panel is used.
> And since the LCD_CS_N is only used for active panels, we can be sure that
> we only need it when CONFIG_FB_PXA_SMARTPANEL is defined.
> So though it's ugly, it is already there, and we can use it.
>

CONFIG_FB_PXA_SMARTPANEL is an inclusive config option not
a mutual exclusive, so it's enabling a capability. Even if it's selected
the board code can still select parallel/smartpanel protocol in the
pxafb_mach_info.lcd_conn field. It just cannot be used safely here.

If it's not run-time detectable, the ugliest way is to add a board
specific kernel command line option, though I'd shrug.

> Rgds, Pieter
>
