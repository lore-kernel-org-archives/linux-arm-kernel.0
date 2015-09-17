From: jh80.chung@samsung.com (Jaehoon Chung)
Date: Thu, 17 Sep 2015 11:03:52 +0900
Subject: [PATCH 6/8] mmc: dw_mmc: Generic MMC tuning with the clock phase
 framework
In-Reply-To: <2272810.k4vHSW5D0y@diego>
References: <1441045446-30858-1-git-send-email-heiko@sntech.de>
 <8878355.D5Q8mk4qcM@diego> <55F8D442.5020004@samsung.com>
 <2272810.k4vHSW5D0y@diego>
Message-ID: <55FA1F88.3090108@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 09/16/2015 11:52 PM, Heiko St?bner wrote:
> Hi,
> 
> Am Mittwoch, 16. September 2015, 11:30:26 schrieb Jaehoon Chung:
>> On 09/16/2015 07:09 AM, Heiko St?bner wrote:
>>> Am Dienstag, 15. September 2015, 17:25:38 schrieb Jaehoon Chung:
>>>> On 09/01/2015 03:24 AM, Heiko Stuebner wrote:
>>>>> From: Alexandru M Stan <amstan@chromium.org>
>>>>>
>>>>> This algorithm will try 1 degree increments, since there's no way to
>>>>> tell
>>>>> what resolution the underlying phase code uses. As an added bonus, doing
>>>>> many tunings yields better results since some tests are run more than
>>>>> once
>>>>> (ex: if the underlying driver uses 45 degree increments, the tuning code
>>>>> will try the same angle more than once).
>>>>>
>>>>> It will then construct a list of good phase ranges (even ranges that
>>>>> cross
>>>>> 360/0), will pick the biggest range then it will set the sample_clk to
>>>>> the
>>>>> middle of that range.
>>>>>
>>>>> We do not touch ciu_drive (and by extension define default-drive-phase).
>>>>> Drive phase is mostly used to define minimum hold times, while one could
>>>>> write some code to determine what phase meets the minimum hold time (ex
>>>>> 10
>>>>> degrees) this will not work with the current clock phase framework
>>>>> (which
>>>>> floors angles, so we'll get 0 deg, and there's no way to know what
>>>>> resolution the floors happen at). We assume that the default drive
>>>>> angles
>>>>> set by the hardware are good enough.
>>>>>
>>>>> If a device has device specific code (like exynos) then that will still
>>>>> take precedence, otherwise this new code will execute. If the device
>>>>> wants
>>>>> to tune, but has no sample_clk defined we'll return EIO with an error
>>>>> message.
>>>>
>>>> Which point is "_generic_"? I don't find the code that control the
>>>> register
>>>> relevant to CLK_DRV/SMPL PHASE. It seems that posted the similar patches
>>>> at
>>>> u-boot mailing list..
>>>
>>> The "generic" part is that it uses the clk phase API for dw_mmc
>>> implementations where the clkgen controlling interface is outside the
>>> dw_mmc IP itself. So it's open for other implementations as well.
>>
>> Designware IP also has the CLK phase register(UHS_REG_EXT register)...
>> if this code is related with it, it should be located into dw-mmc.c.
> 
> UHS_REG_EXT is acutally "reserved" on both the rk3288 as well as the rk3368. 
> rk3036/rk3128 (Cortex-A7) provide a bit description, but the tuning 
> documentation still uses the controls located in the clock controller.
> 
> So I guess UHS_REG_EXT is the real "generic" solution.
> 
>>> But if you are more comfortable with it, I can also move it into the
>>> dw_mmc- rockchip variant for the time being, until another user comes
>>> along.
>> I think more better that this code is located into dw_mmc-rockchip. how
>> about?
> 
> As described above, moving that to the rockchip part sounds sensible. And I 
> guess we can think more about it, once a second user appears.

Sure, we can think more about this.
As you knew, clock phase is closely related to the timing issue.
So clock phase scheme needs to control however.
In future, if somebody introduce the similar control as rockchip, we can discuss about it.

Best Regards,
Jaehoon Chung

> 
> 
> Heiko
> 
