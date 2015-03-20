From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Fri, 20 Mar 2015 18:52:48 +0100
Subject: exynos5800-peach-pi: suspend/resume (still) broken
In-Reply-To: <CAM4voanUg87=Ya6azGCRz8r2=WJ0wi4ktqdn6GD6ULJsnLUMmw@mail.gmail.com>
References: <CAMAWPa_r04tAXAXosmLk+DfwvQV0qpD+=8O7T_pwFTAozcjOgQ@mail.gmail.com>	<550953ED.10508@collabora.co.uk>	<CAM4voakvhHuVXLY2DmdGexfrqSYUqhXhg1krLwO4CCxjHQ1NCw@mail.gmail.com>	<550C47ED.3010301@collabora.co.uk>	<CAM4voamLt=6dSY-DwDb+c=KRwDWAvjvzUUnno+=+1svDqf41Qg@mail.gmail.com>
 <CAM4voanUg87=Ya6azGCRz8r2=WJ0wi4ktqdn6GD6ULJsnLUMmw@mail.gmail.com>
Message-ID: <550C5E70.30009@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Abhilash,

On 03/20/2015 06:40 PM, Abhilash Kesavan wrote:
>>
>> I have made some progress on this. This is the current state:
>>
>> If I use next-20141114 (which was when the S2R code first appeared in
>> linux-next), then all is good. next-20141117 is fine too but things
>> are broken in next-20141118.
>> I have narrowed it down to the commit: "ae43b32 ARM: 8202/1:
>> dmaengine: pl330: Add runtime Power Management support v12". The only
>> way I see this impacting s2r is because it disables the dma pclk while
>> suspending or before.
>>
>> Checking further, will update in a bit.
> 
> OK, so disabling the mdma0 node in "arch/arm/boot/dts/exynos5420.dtsi"
> gets things working. Like Kevin mentioned in the initial report, I
> need to disable DRM else there is a crash while suspending. With these
> two changes, on linus' tree and kgene's for-next s2r works fine.
>

Awesome, thanks a lot for digging this out!
 
> On linux-next, I need to disable CONFIG_MWIFIEX too.
> 

Yes, I also saw that issue with mwfiex when suspend-to-idle (which works
in -next) due the MMC_PM_KEEP_POWER flag being set in the host pm caps.
But I don't see that being set in the host driver.

> Also, I observe cros-ec-spi transfer failures during resume and
> sometimes it is unable to re-enable the tps fets causing a crash.
> However, that would be a driver specific issue.
> 

Indeed, I can take a look to that issue as well.

> Regarding the mdma0 disablement, it looks like for the system to
> suspend properly the mdma0 pclk needs to stay on.
>

It seems so, I remember we had other issues with the mentioned commit
due clocks being gated. For example the mau_epll clock that was needed
to access the audss block registers and caused a boot hang on Exyos5420.

That specific issue was fixed by f1e9203e2366 ("clk: samsung: Fix Exynos
5420 pinctrl setup and clock disable failure due to domain being gated")
which solves it by enabling the mau_epll on probe.
 
> Regards,
> Abhilash
>>>

Best regards,
Javier
