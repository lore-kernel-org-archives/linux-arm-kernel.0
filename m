From: jeroen@myspectrum.nl (Jeroen Hofstee)
Date: Tue, 09 Jun 2015 00:00:20 +0200
Subject: [PATCH] ARM: dts: AM35xx: fix system control module clocks
In-Reply-To: <alpine.DEB.2.02.1506080234271.15153@utopia.booyaka.com>
References: <alpine.DEB.2.02.1506010546510.14902@utopia.booyaka.com>
 <1433172627-28052-1-git-send-email-t-kristo@ti.com>
 <556C8ED5.5050000@myspectrum.nl> <20150601173126.GY30984@atomide.com>
 <alpine.DEB.2.02.1506011733180.14902@utopia.booyaka.com>
 <5571576E.6020207@myspectrum.nl> <557157FA.7080305@myspectrum.nl>
 <557411DC.9020109@myspectrum.nl>
 <alpine.DEB.2.02.1506071952490.15153@utopia.booyaka.com>
 <alpine.DEB.2.02.1506080234271.15153@utopia.booyaka.com>
Message-ID: <55761074.2080109@myspectrum.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Paul, +Menon (since you asked about the USB_OTG trap),

On 08-06-15 04:38, Paul Walmsley wrote:
> Hi Jeroen,
>
> On Sun, 7 Jun 2015, Paul Walmsley wrote:
>
>> On Sun, 7 Jun 2015, Jeroen Hofstee wrote:
>>
>>>
>>> Turns out my suspicion was wrong. This is what I know at the moment,
>>> depending on the bootpins, u-boot will trigger a bad access when loading
>>> a file over ethernet, but only the first time. Clearing the pending interrupt
>>> before booting linux make the "USB_OTG address hole seen" go away.
>> Oh, too bad.  I had been hoping that you were right and that I was wrong
>> ;-)  I'll try this on the CM-T3517 here.
> I used your debugging technique here and was able to reproduce your
> results - with one difference:
>
> http://www.pwsan.com/omap/testlogs/test_v4.1-rc6/20150607194102/boot/cmt3517/cmt3517_log.txt
>
> The interconnect error was logged upon the first interaction with the
> network.  In my case this was with the U-boot 'dhcp' command.  The pending
> interrupt bit was cleared before loading the kernel via tftp, and the
> interrupt bit was not set again, even after a tftp load.
>

I sent a patch to u-boot to disable the offending line, see [1]. It would be
interesting to know if it can also result in valid, accidental memory 
adjustments,
before the invalid one, but I haven't checked that yet.

Regards,
Jeroen

[1] https://patchwork.ozlabs.org/patch/481751/

p.s. the USB_OTG trap is actually a musb / emac / camera trap on an am3517.
