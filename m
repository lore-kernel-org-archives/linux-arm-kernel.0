From: eric@anholt.net (Eric Anholt)
Date: Mon, 17 Aug 2015 10:56:23 -0700
Subject: [PATCH 3/7] drm/vc4: Add KMS support for Raspberry Pi.
In-Reply-To: <55CEC3D8.7060103@wwwdotorg.org>
References: <1439427380-2436-1-git-send-email-eric@anholt.net>
 <1439427380-2436-4-git-send-email-eric@anholt.net>
 <55CEC3D8.7060103@wwwdotorg.org>
Message-ID: <877fotx0hk.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

r<#secure method=pgpmime mode=sign>
Stephen Warren <swarren@wwwdotorg.org> writes:

> On 08/12/2015 06:56 PM, Eric Anholt wrote:
>> This is the start of a full VC4 driver.  Right now this just supports
>> configuring the display using a pre-existing video mode (because
>> changing the pixel clock isn't available yet, and doesn't work when it
>> is).  However, this is enough for fbcon and bringing up X using
>> xf86-video-modesetting.
>
>> diff --git a/drivers/gpu/drm/vc4/Kconfig b/drivers/gpu/drm/vc4/Kconfig
>
>> +config DRM_VC4
>> +	tristate "Broadcom VC4 Graphics"
>
>> +	help
>> +	  Choose this option if you have a system that has a Broadcom
>> +	  VC4 GPU, such as the Raspberry Pi or other BCM2708/BCM2835.
>> +
>> +	  This driver requires that "avoid_warnings=2" be present in
>> +	  the config.txt for the firmware, to keep it from smashing
>> +	  our display setup.
>
> The need for "avoid_warnings=2" seems like it will trip people up. I
> don't think it's in any config.txt I've seen. Can you expand more on that?

The warnings thing is the firmware watching for undervoltage and then it
calls into dispmanx to overlay a little rainbow box on the screen.  This
of course interferes with our display setup.

I think we'll be able to wire up notifications to Linux for
undervoltage, at which point we can do something useful with that
information, ourselves.
