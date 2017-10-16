From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Mon, 16 Oct 2017 10:09:44 +0100
Subject: [PATCH v3 0/8] ARM: NOMMU: MPU updates
In-Reply-To: <20171014143721.GH20805@n2100.armlinux.org.uk>
References: <1506330344-31556-1-git-send-email-vladimir.murzin@arm.com>
 <68a6eb4d-4d8e-7c6a-0875-3165bde8de89@arm.com>
 <e2e80a26-4a87-6d4c-51ad-11d6ea683c16@arm.com>
 <20171013092418.GF20805@n2100.armlinux.org.uk>
 <0edd802a-d596-5d46-ff53-97b1db1a453e@arm.com>
 <20171014143721.GH20805@n2100.armlinux.org.uk>
Message-ID: <2c12933f-594b-eeae-b113-dea00a6d6a02@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/10/17 15:37, Russell King - ARM Linux wrote:
> On Fri, Oct 13, 2017 at 10:40:39AM +0100, Vladimir Murzin wrote:
>> On 13/10/17 10:24, Russell King - ARM Linux wrote:
>>> Sorry, but I have no working MPS3 platform since it killed its uSD card
>>> with all the FPGA bitstreams on.  I'm waiting (since end of September)
>>> for a replacement from ARM Ltd but there hasn't yet been any progress.
>>>
>>> Sure, I can replace the uSD card myself, but the problem is the contents
>>> of the card.
>>
>> Thanks for prompt reply!
>>
>> I should say that board won't help you with testing this series since it
>> implements different MPU model (I have patches for that too but they are
>> on top of this series).
> 
> It assists as far as making sure the changes don't cause a
> regression for the platform.
> 
>> I've been working closely with Alex and Andr?s (since they needed this for
>> their Cortex-M7 platform) to make sure it works as expected. It was also
>> tested with R-class FastModels.
>>
>> I intentionally kept CONFIG_ARM_MPU disabled by default for M-class
>> (PATCH 6/8), so it won't interfere with existing bootloaders.
> 
> It looks like patch 6 will allow me to select ARM_MPU for the MPS3
> config (by way of CPU_V7M being enabled).  As I'm unable to test
> what effect that has here, and I don't know when I'll be able to do
> so, please check if not already done so.

It was done. To ensure that there is a change in PATCH 3/8

@@ -204,13 +205,13 @@ ENTRY(__setup_mpu)
        mrc     p15, 0, r0, c0, c1, 4           @ Read ID_MMFR0
        and     r0, r0, #(MMFR0_PMSA)           @ PMSA field
        teq     r0, #(MMFR0_PMSAv7)             @ PMSA v7
-       bne     __error_p                       @ Fail: ARM_MPU on NOT v7 PMSA
+       bxne    lr

the C side already had a check in mpu_setup()

 	if (!mpu_present())
 		return;

> 
>> I'd be glad if you can review the series and give it a chance to sit in
>> linux-next (I can provide a branch on top of yours for-next).
> 
> Please never provide a branch on top of my for-next, it's an "unstable"
> commit in that it's regenerated from several sub-branches (fixes, misc,
> devel-stable, and whatever other work I want to include in linux-next.)
> 

Ok, got it! It seems the right branch is devel-stable. Unless you have
comments, I'd like to submit patches in your patch system.

Thanks
Vladimir
