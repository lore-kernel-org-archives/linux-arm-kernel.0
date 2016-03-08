From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 8 Mar 2016 11:12:13 -0700
Subject: [PATCH 3/3] ARM: bcm2835: Add VC4 to the device tree.
In-Reply-To: <87bn6ozw0c.fsf@eliezer.anholt.net>
References: <1457123528-13482-1-git-send-email-eric@anholt.net>
 <1457123528-13482-4-git-send-email-eric@anholt.net>
 <56DE6A80.1060707@wwwdotorg.org> <87bn6ozw0c.fsf@eliezer.anholt.net>
Message-ID: <56DF15FD.3090807@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/08/2016 11:04 AM, Eric Anholt wrote:
> Stephen Warren <swarren@wwwdotorg.org> writes:
>
>> On 03/04/2016 01:32 PM, Eric Anholt wrote:
>>> VC4 is the GPU (display and 3D) present on the 283x.
>>
>>> diff --git a/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts b/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts
>>
>>> +&hdmi {
>>> +	hpd-gpios = <&gpio 46 GPIO_ACTIVE_LOW>;
>>> +};
>>
>> Isn't that the same everywhere? If so, adding it to bcm2835-rpi.dtsi
>> seems like a better idea; it'd avoid duplicating it everywhere.
>
> It's not the same everywhere (_HIGH vs _LOW), which is why it's in the
> individual files.

Oh right, it looks OK then. The series,
Acked-by: Stephen Warren <swarren@wwwdotorg.org>

One could reduce the duplication by moving the common block into the 
common .dtsi file, but using a board-defined #define for the polarity:

bcm2835-rpi-a-plus.dts:

#define RPI_HDMI_HPD_POLARITY
#include "bcm2835-rpi.dtsi"

bcm2835-rpi.dtsi:

&hdmi {
	hpd-gpios = <&gpio 46 RPI_HDMI_HPD_POLARITY>;
};

... although this case is so tiny I'm not sure there's any benefit 
trying to unify it like that right now.
