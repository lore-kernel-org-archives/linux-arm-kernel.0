From: linux@prisktech.co.nz (Tony Prisk)
Date: Sat, 30 Mar 2013 22:25:35 +1300
Subject: [PATCH] video: fb: vt8500: Convert framebuffer drivers to
 standardized binding
In-Reply-To: <20130329184310.GI20693@game.jcrosoft.org>
References: <1364100587-9320-1-git-send-email-linux@prisktech.co.nz>
 <20130329184310.GI20693@game.jcrosoft.org>
Message-ID: <5156AF8F.2040306@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/03/13 07:43, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 17:49 Sun 24 Mar     , Tony Prisk wrote:
>> Now that a display timing binding is available, convert our almost identical
>> binding to use the standard binding.
>>
>> This patch converts the vt8500 and wm8505 framebuffer drivers and
>> associated dts/dtsi files to use the standard binding as defined in
>> bindings/video/display-timing.txt.
>>
>> There are two side-effects of making this conversion:
>>
>> 1) The fb node should now be in the board file, rather than the soc file as
>> the display-timing node is a child of the fb node.
>>
>> 2) We still require a bits per pixel property to initialize the framebuffer
>> for the different lcd panels. Rather than including this as part of the
>> display timing, it is moved into the framebuffer node.
>>
>> I have also taken the opportunity to alphabetise the includes of each
>> driver to avoid double-ups.
>>
>> Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
>> ---
>> Hi Florian,
>>
>> This patch is based on top of the previous patchset (0/5 video: vt8500 patches
>> for 3.10). It could be considered patch 6 of the same set.
>>
>> Regards
>> Tony P
>>
>>   .../devicetree/bindings/video/via,vt8500-fb.txt    |   48 ++++----------
>>   .../devicetree/bindings/video/wm,wm8505-fb.txt     |   32 +++++----
>>   arch/arm/boot/dts/vt8500-bv07.dts                  |   24 +++----
>>   arch/arm/boot/dts/vt8500.dtsi                      |    8 ---
>>   arch/arm/boot/dts/wm8505-ref.dts                   |   21 +++---
>>   arch/arm/boot/dts/wm8505.dtsi                      |    7 --
>>   arch/arm/boot/dts/wm8650-mid.dts                   |   21 +++---
>>   arch/arm/boot/dts/wm8650.dtsi                      |    7 --
>>   arch/arm/boot/dts/wm8850-w70v2.dts                 |   21 +++---
>>   arch/arm/boot/dts/wm8850.dtsi                      |    7 --
>>   drivers/video/Kconfig                              |    6 ++
>>   drivers/video/vt8500lcdfb.c                        |   53 ++++++---------
>>   drivers/video/wm8505fb.c                           |   68 ++++++++------------
>>   13 files changed, 130 insertions(+), 193 deletions(-)
>>
>> ...
>>
>> diff --git a/arch/arm/boot/dts/vt8500.dtsi b/arch/arm/boot/dts/vt8500.dtsi
>> index cf31ced..fc25d9f 100644
>> --- a/arch/arm/boot/dts/vt8500.dtsi
>> +++ b/arch/arm/boot/dts/vt8500.dtsi
>> @@ -98,14 +98,6 @@
>>   			interrupts = <43>;
>>   		};
>>   
>> -		fb at d800e400 {
>> -			compatible = "via,vt8500-fb";
>> -			reg = <0xd800e400 0x400>;
>> -			interrupts = <12>;
>> -			display = <&display>;
>> -			default-mode = <&mode0>;
>> -		};
> no this belong here at Soc level not board
> 		fb at d800e400 {
> 			compatible = "via,vt8500-fb";
> 			reg = <0xd800e400 0x400>;
> 			interrupts = <12>;
> 		};
I have made this change as suggested by Tomi. I had a feeling it was 
wrong, but didn't know the correct way of doing it. Will be in v2.
>> ...
>>
>> +	ret = of_get_fb_videomode(pdev->dev.of_node, &mode, OF_USE_NATIVE_MODE);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = of_property_read_u32(pdev->dev.of_node, "bits-per-pixel", &bpp);
>> +	if (ret)
>> +		return ret;
>>   
>> -	of_mode.vmode = FB_VMODE_NONINTERLACED;
>> -	fb_videomode_to_var(&fbi->fb.var, &of_mode);
>> +	mode.vmode = FB_VMODE_NONINTERLACED;
> why this hanble by of_get_fb_videomode
>
> Best Regards,
> J.
>
Hmm.. I didn't notice the optional interlaced property. Will remove this 
for v2 - All boards so far have been non-interlaced so it doesn't 
require a change to the dts.

Thanks for the feedback

Regards
Tony P
