From: hverkuil@xs4all.nl (Hans Verkuil)
Date: Mon, 12 Jun 2017 10:42:02 +0200
Subject: [PATCH 4/4] drm/bridge: dw-hdmi: add cec driver
In-Reply-To: <db1f1785-930b-0f32-d71a-79ae8e053b2c@xs4all.nl>
References: <20170530142218.GS22219@n2100.armlinux.org.uk>
 <E1dFi3P-0004lv-2K@rmk-PC.armlinux.org.uk>
 <db1f1785-930b-0f32-d71a-79ae8e053b2c@xs4all.nl>
Message-ID: <c8046a4f-d04e-a2f4-375e-2ff53fabe68e@xs4all.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/01/2017 10:31 AM, Hans Verkuil wrote:
> Hi Russell,
> 
> First a few top-level questions:
> 
> 1) What was the reason for using the cec-notifier here? Isn't this
>     tightly integrated into the main dw-hdmi block? For the tda driver
>     it is clearly required, but for tightly coupled HDMI & CEC HW I
>     just create the adapter from the HDMI driver. As a small bonus it
>     avoids adding the cec-notifier code and the control flow is a bit
>     easier to trace.
> 
> 2) I may have asked this before, apologies if I repeat myself: does
>     this CEC implementation support CEC monitoring (aka snooping)? If
>     it does, then I recommend that it is implemented since it is very
>     useful.
> 
> 3) Is the CEC still active if there is no hotplug signal? Or is it
>     powered off in that case? Ideally it should still be possible to
>     send CEC messages even if there is no hotplug. This is explicitly
>     allowed by the CEC 2.0 spec to wake up displays that turn off the
>     HPD, but that still have a working CEC controller.
> 
>     If this is not possible, then you need to use the CEC_CAP_NEEDS_HPD
>     capability. See: https://patchwork.linuxtv.org/patch/41478/
> 
>     This will almost certainly be merged for 4.13 since other CEC drivers
>     need this as well.

FYI: I tested your patch series with my cubox-i and CEC doesn't work if there
is no HPD. I fiddles around a bit in dw_hdmi.c to prevent it from powering off
the HDMI and PHY, but without any luck. It could be a hardware issue on the
cubox-i (e.g. a level-shifter that powers off when the HPD goes low, although
I don't see anything like that in the schematics), or it can be a driver issue
or a Synopsys IP issue. I really can't tell.

I added text in my status document (https://hverkuil.home.xs4all.nl/cec-status.txt)
at the end on how to test this.

Otherwise the CEC support on the cubox-i was working very well.

Regards,

	Hans
