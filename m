From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 16 Mar 2016 15:36:54 +0300
Subject: [PATCH 0/5] da8xx USB clocks
In-Reply-To: <1458081344-2449-1-git-send-email-david@lechnology.com>
References: <1458081344-2449-1-git-send-email-david@lechnology.com>
Message-ID: <56E95366.8040306@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/16/2016 1:35 AM, David Lechner wrote:

> I've implemented some proper clocks for the USB PHY clocks on da8xx. For those
> not familiar with the architecture, the SoC has one USB 1.1 OHCI port and one
> USB 2.O OTG port. The USB 1.1 PHY clock can optionally be supplied by the PLL
> in the USB 2.0 PHY.
>
> I have seen some comments in the past that these clock details don't belong in
> the USB drivers and I agree with that. So, I have moved the handling of the
> clocks out of the USB drivers to the mach code with the rest of the SoC clocks.
>
> This code has been tested on LEGO MINDSTORMS EV3 (AM1808/da850 family). Here is
> an output of the davinci clock debug to give you a better idea of how clocks
> are related.
>
>      root at ev3dev:~# cat /sys/kernel/debug/davinci_clocks
>      ref_clk           users=23      24000000 Hz
>        pll0            users=20 pll 300000000 Hz
>          pll0_aux_clk  users= 4 pll  24000000 Hz
>            ...
>            usb20_phy   users= 2      24000000 Hz
>              usb11_phy users= 1      24000000 Hz
>        ...
>      usb_ref_clk       users= 0      48000000 Hz
>
> usb20_phy and usb11_phy can optionally be children of usb_ref_clk instead.
>
>
> I'm planning on adding device tree bindings for the ohci driver, but I need to
> get some things sorted out with the regulator subsystem first. I see that Petr
> has been working on device tree support for the musb driver. This should take
> care of some of the concerns related to his changes too, for example, the
> ti,usb2-phy-refclock-hz device tree property is no longer needed because it
> is now taken care of in the clock code. I've actually included one of Petr's
> patchs here since one of my patches depends on it.
>
> I'm also working on device tree bindings for davinci clocks, but it will take
> me a while to get there. But that should not hold up the device tree bindings
> for da8xx ohci and musb.

    Nice to see that someone still cares about this code. With the ending of 
the MontaVista's efforts, it largely seemed like abandonware...

MBR, Sergei
