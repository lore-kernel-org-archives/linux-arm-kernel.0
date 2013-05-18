From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sat, 18 May 2013 20:33:50 +0200
Subject: [RFC 2/4] ARM: dove: add video card node for SolidRun CuBox
In-Reply-To: <20130518193354.1be73084@armhf>
References: <20130516192510.GV18614@n2100.arm.linux.org.uk>
 <1368897139-25485-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1368897139-25485-3-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130518193354.1be73084@armhf>
Message-ID: <5197C98E.1060104@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/18/2013 07:33 PM, Jean-Francois Moine wrote:
> On Sat, 18 May 2013 19:12:17 +0200
> Sebastian Hesselbarth<sebastian.hesselbarth@gmail.com>  wrote:
>> This adds a video card node required for rmk's dove_drm driver. Reg
>> property matches reserved memory region (currently 16M at top of memory),
>> clocks property should carry extclk0 for now.
>>
>> Signed-off-by: Sebastian Hesselbarth<sebastian.hesselbarth@gmail.com>
>> ---
...
>> +		vcard: video-card {
>> +			compatible = "marvell,dove-video-card";
>> +			reg =<0x3f000000 0x1000000>;
>> +			clocks =<&si5351 0>,<&si5351 0>;
>> +		};
>> +	};
...
>> +&lcd0 { status = "okay"; };
>
> May you explain a bit more this strange hack?

This "hack" adds the video-card device node that describes the board
dependent part of Dove SoC video. Remember, it is a device tree node
to match Russel's driver!

You have the video memory passed, the clocks property will vanish
later. And you enable lcd0 as you may have noticed that there is
nothing connected on lcd1 on the _CuBox_.

But there is on the D2Plug, and that DT description _will_ enable
lcd0, lcd1 and dcon.

Maybe, there is a misunderstanding in in the concept of DT here.
DT does _not_ describe the driver layout but the HW. And for Linux
this basically means, you replace board/SoC dependent init code
that register some platform_device with a description in DT.

The actual driver does _not_ need to know about non-DT or DT except
that somebody has to parse it and create a platform_device for it.
If you only have standard properties like reg and irq, it all gets
parsed automagically by DT bus probing. But as you already pointed
out, a video card on Dove is a little bit more complex as reg and
irq - so I provided a DT parser for rmk's *RFC* driver as *RFC*!

Sebastian
