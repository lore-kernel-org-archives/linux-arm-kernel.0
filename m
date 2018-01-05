From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 05 Jan 2018 09:55:19 +0100
Subject: [PATCH] ARM: dts: kirkwood: fix pin-muxing of MPP7
In-Reply-To: <20180105093634.6736747c@windsurf.lan> (Thomas Petazzoni's
 message of "Fri, 5 Jan 2018 09:36:34 +0100")
References: <20180104165312.14052-1-thomas.petazzoni@free-electrons.com>
 <20180105093634.6736747c@windsurf.lan>
Message-ID: <874lo0bs7c.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,
 
 On ven., janv. 05 2018, Thomas Petazzoni <thomas.petazzoni@free-electrons.com> wrote:

> Hello,
>
> On Thu,  4 Jan 2018 17:53:12 +0100, Thomas Petazzoni wrote:
>> MPP7 is currently muxed as "gpio", but this function doesn't exist for
>> MPP7, only "gpo" is available. This causes the following error:
>> 
>> kirkwood-pinctrl f1010000.pin-controller: unsupported function gpio on pin mpp7
>> pinctrl core: failed to register map default (6): invalid type given
>> kirkwood-pinctrl f1010000.pin-controller: error claiming hogs: -22
>> kirkwood-pinctrl f1010000.pin-controller: could not claim hogs: -22
>> kirkwood-pinctrl f1010000.pin-controller: unable to register pinctrl driver
>> kirkwood-pinctrl: probe of f1010000.pin-controller failed with error -22
>> 
>> So the pinctrl driver is not probed, all device drivers (including the
>> UART driver) do a -EPROBE_DEFER, and therefore the system doesn't
>> really boot (well, it boots, but with no UART, and no devices that
>> require pin-muxing).
>> 
>> Back when the Device Tree file for this board was introduced, the
>> definition was already wrong. The pinctrl driver also always described
>> as "gpo" this function for MPP7. However, between Linux 4.10 and 4.11,
>> a hog pin failing to be muxed was turned from a simple warning to a
>> hard error that caused the entire pinctrl driver probe to bail
>> out. This is probably the result of commit 6118714275f0a ("pinctrl:
>> core: Fix pinctrl_register_and_init() with pinctrl_enable()").
>> 
>> This commit fixes the Device Tree to use the proper "gpo" function for
>> MPP7, which fixes the boot of OpenBlocks A7, which was broken since
>> Linux 4.11.
>> 
>> Fixes: f24b56cbcd9d ("ARM: kirkwood: add support for OpenBlocks A7 platform")
>> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>
> I just realized that my commit title isn't that great, as it doesn't
> mention the board. Something like:
>
> 	ARM: dts: kirkwood: fix pin-muxing of MPP7 on OpenBlocks A7
>
> would have been better.
>
> Gr?gory: let me know if you want me to send a v2, or if you can fix up
> this while applying.
>

I applied it on mvebu/fixes with this new title, as well as the reviewed-by
flag form Andrew, ands I also added the "Cc: <stable@vger.kernel.org>"
line.

Thanks,

Gregory


> Thanks!
>
> Thomas
> -- 
> Thomas Petazzoni, CTO, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
