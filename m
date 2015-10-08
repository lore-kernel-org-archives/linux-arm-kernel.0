From: psidhu@gateworks.com (Pushpal Sidhu)
Date: Thu, 8 Oct 2015 12:31:05 -0700
Subject: i.mx6 video out in mainline
In-Reply-To: <1444200359.7656.4.camel@pengutronix.de>
References: <CAD1M060ucNEjPceeK9R2s4drkZE1EWEadB1JtcUmnfuNx24zkA@mail.gmail.com>
 <CAOMZO5CwjC2dq3fWugAJsqThxAZ6o4wv0gV7ues28a51z0fXLg@mail.gmail.com>
 <CAD1M061RTNOCuE5vwrTsR3mgOaWcuwt5mc-L+K3kdLCDQ=JfLQ@mail.gmail.com>
 <1444200359.7656.4.camel@pengutronix.de>
Message-ID: <CAD1M062hdjvqFvS=RbFabofb8O70C0Js-TCbUOMy_0KXnQ7sJQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 6, 2015 at 11:45 PM, Lucas Stach <l.stach@pengutronix.de> wrote:
> Am Dienstag, den 06.10.2015, 16:02 -0700 schrieb Pushpal Sidhu:
>> On Tue, Oct 6, 2015 at 3:16 PM, Fabio Estevam <festevam@gmail.com>
>> wrote:
>> > On Tue, Oct 6, 2015 at 6:52 PM, Pushpal Sidhu <psidhu@gateworks.com
>> > > wrote:
>> > > Hi All,
>> > >
>> > > I'm attempting to use a standard fb console (using the
>> > > imx6qdl-gw54xx.dtsi), but I find that it only draws to the
>> > > 1024x768p
>> > > portion of the screen. This is also true when running the
>> > > userspace
>> > > tool fb-test.
>> >
>> > Looking at imx6qdl-gw54xx.dtsi I see you have a LVDS panel with
>> > 1024x768 resolution.
>> >
>> > I sent a patch that allows LDB and HDMI to work simultaneously:
>> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/com
>> > mit/arch/arm/boot/dts/imx6qdl
>> > -sabresd.dtsi?id=d28be499c45e6e16d7a042ce280eb872dc06952b
>> >
>> > Can you try to adapt it for imx6qdl-gw54xx.dtsi?
>> >
>> > If this still does not help your HDMI output, please try disabling
>> > the LVDS.
>>
>> When I took your patch and adapted it for imx6qdl-gw54xx.dtsi, I
>> found
>> that HDMI video out was slightly shifted to the left and resolution
>> remained at 1024x768p.
>>
>> I also found that when I disabled DRM_IMX_LDB, HDMI out stopped
>> working altogether, though if I stripped out the ldb section in
>> device
>> tree, the resolution comes back at 1080p (regardless of setting
>> DRM_IMX_LDB or not). There is definitely some strange interdependency
>> between lvds and hdmi here. Do you have an idea of where I should
>> start looking for this problem?
>>
> This isn't strange, but actually really simple to explain:
>
> 1. The DRM driver is a componentized driver that needs all of its
> components to come up before it registers the DRM device. So if you
> have the LDB enabled in your DT you also need the LDB driver, otherwise
> you won't get any video out. If you don't want to have LDB, don't
> disable the driver alone, but also add a status = "disabled" in the DT
> LDB node.
>
> 2. The kernels framebuffer emulation layer will try to put the
> framebuffer on both displays. So if you have a smaller LVDS display
> connected the framebuffer will only have the size of the smaller
> display. Solution is to not depend on the kernels frambuffer emulation,
> but actually set a mode from userspace and work with the KMS interface
> directly.

Ah, that makes total sense then. Do you know of any userspace
application that works using the KMS interface, other than using
x11/wayland (in other words, something extremely simple like fbset)?
I've gotten too used to using the downstream vendor kernel way of
using sysfs to set the modes per display so I'm trying to learn the
"right" way of doing things.

About sysfs, why is it that the seemingly obsolete
/sys/class/graphics/fbX/{mode,modes} still exist in the kernel when
they seem to serve no function? Is that just some cleanup that hasn't
occurred yet?

- Pushpal
