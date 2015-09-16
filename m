From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 15 Sep 2015 21:04:41 -0700
Subject: [PATCH] ARM: dt: bcm2835: set mmc clock to the correct value of
 250MHz
In-Reply-To: <87k2s0wllm.fsf@eliezer.anholt.net>
References: <1441362818-4323-1-git-send-email-kernel@martin.sperl.org>
 <87k2s0wllm.fsf@eliezer.anholt.net>
Message-ID: <55F8EA59.3070900@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/08/2015 04:13 PM, Eric Anholt wrote:
> kernel at martin.sperl.org writes:
> 
>> From: Martin Sperl <kernel@martin.sperl.org>
>> 
>> This patch sets the clock speed to 250MHz to make the SD card 
>> work at the correct clock speed without overclocking by 2.5.
>> 
>> Signed-off-by: Martin Sperl <kernel@martin.sperl.org> --- 
>> arch/arm/boot/dts/bcm2835.dtsi |    2 +- 1 file changed, 1
>> insertion(+), 1 deletion(-)
>> 
>> Analysis with a logic-analyzer found that the current setting of
>> the mmc clock at 100MHz is wrong and results in overclocking the
>> SD-card and eMMC on the Compute Module.
>> 
>> Exact measurements show that when 25Mhz are selected by the
>> sdhci driver effectively 62.5MHz are used (so 2.5 times faster),
>> which is what is expected when the clock is configured to a fixed
>> 100MHz instead of the 250MHz that the clock is actually running
>> at.
> 
> Looks like this became the default in the firmware in November 2013
> (you can, of course, still do lots of configuration that would
> change it higher or lower).
> 
> I don't know what the downside would be of running MMC with too
> large of a divisor for devices running pre-November firmware.  I
> suspect we should just wait until the new clock driver lands, to
> avoid any backwards-compatibility issues.  Sorry for the trouble
> :(

I imagine we'd just end up with a slower-than-expected clock rate
which should work just fine albeit at lower than expected/possible
performance. Conversely, the effect of not fixing this is errors or
corruption, which seems somewhat worse. Still, if the real clock
driver is showing up very very imminently it just might be worth
waiting for that (although we could set this patch Cc: stable which
might help some people?)
