From: csd@broadcom.com (Christian Daudt)
Date: Wed, 6 Mar 2013 07:05:16 -0800
Subject: [PATCH] ARM: bcm281xx: Add L2 cache enable code
In-Reply-To: <201303061128.57127.arnd@arndb.de>
References: <1362451632-18806-1-git-send-email-csd@broadcom.com>
 <201303060631.03782.arnd@arndb.de> <5136F816.2070909@broadcom.com>
 <201303061128.57127.arnd@arndb.de>
Message-ID: <51375B2C.2000005@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13-03-06 03:28 AM, Arnd Bergmann wrote:
>>>> It was originally in init_machine section but I was told that that was
>>>> too late and init_irq would be better, and I saw that highbank also has
>>>> it in init_irq. I agree that it is unrelated to irq - is there a better
>>>> place to put this in ?
>>> IMHO the later the better. Do you know what issues were caused  by having it
>>> in init_machine?
>> This is some feedback I got a while back:
>> "From kernel 3.4 on-wards i think ( if i remember correctly) cache sync
>> might be called before your board_init function and you might have to do
>> this in init_irq. "
>>
>> I just looked through where l2x0_of_init is currently called and here's
>> the list:
>> early_initcall (exynos4, omap2, sirf, ux500)
>> init_irq (highbank, imx6q)
>> init_machine (socfpga, v2m_dt_init)
>>
>> so seems to be everywhere :) So I can move it back to init_machineif
>> that's where itshould be.
> Hmm, let's try to solve this another time, I don't think there is an easy
> answer. Maybe we really need a common entry point for the cache
> controller setup, or move it completely out of platform specific code
> for the case where it can be probed from DT.
>
> Thanks for doing the research!
>
So for the time being should it stay in init_irq or init_machine ?

   Thanks,
    csd
