From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 1 Apr 2016 10:58:34 -0600
Subject: [PATCH 2/3] ARM: multi_v7_defconfig: Switch BCM2835 to
 sdhci-iproc.c for MMC
In-Reply-To: <56FDD697.2050901@wwwdotorg.org>
References: <1459470504-5007-1-git-send-email-eric@anholt.net>
 <1459470504-5007-2-git-send-email-eric@anholt.net>
 <56FDD697.2050901@wwwdotorg.org>
Message-ID: <56FEA8BA.8020307@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/31/2016 08:01 PM, Stephen Warren wrote:
> On 03/31/2016 06:28 PM, Eric Anholt wrote:
>> This approximately triples write performance for the SD card.  My card
>> is too full of important data to collect very reliable numbers, but I
>> see 271.361% +/- 166.742% improvement (n=3 before, 6 after), for 'dd
>> if=/dev/zero of=/boot/asdf bs=1M count=3 oflag=dsync,direct'.  Read
>> performance appears to be unaffected.
>
> I thought that switching the defconfig wasn't possible, since this HW
> module relies on the SoC core clock, and that can be asynchronously
> changed by the FW running on the VideoCore. Consequently, this change
> isn't safe unless the user puts non-default options in their config.txt.
>
> The same comment applies to "[PATCH 1/4] ARM: bcm2835: Switch BCM2835 to
> sdhci-iproc.c for MMC" in the other series.

Ah, now I realize that sdhci-bcm2835.c and sdhci-iproc.c are two 
alternative drivers for the same HW device. For some reason I got the 
incorrect impression from some past email/patch discussion that 
sdhci-iproc.c was a driver for the alternative SD controller in the chip.

So, there's no problem with this patch.
Acked-by: Stephen Warren <swarren@wwwdotorg.org>

(although /me wonders why sdhci-iproc.c was even added in the first 
place given sdhci-bcm2835.c pre-dates it by over 2 years, and equally 
why the new driver is any faster given it looks almost identical and 
accesses the same HW, but I suppose it doesn't matter).
