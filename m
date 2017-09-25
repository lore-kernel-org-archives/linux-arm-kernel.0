From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 25 Sep 2017 11:48:49 -0700
Subject: [PATCH] [v2] soc: bcm: brcmstb: fix ARM build errors
In-Reply-To: <95917630-de47-cb0c-f7bf-5742927e11f1@gmail.com>
References: <20170911201324.3423067-1-arnd@arndb.de>
 <95917630-de47-cb0c-f7bf-5742927e11f1@gmail.com>
Message-ID: <e8010d8d-6703-348a-aca1-4a981be7e0e8@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/12/2017 10:56 AM, Florian Fainelli wrote:
> On 09/11/2017 01:13 PM, Arnd Bergmann wrote:
>> When building the new PM driver on older ARM architectures, we can
>> run into one of two build errors:
>>
>> drivers/soc/bcm/brcmstb/pm/pm-arm.c: In function 'brcmstb_do_pmsm_power_down':
>> drivers/soc/bcm/brcmstb/pm/pm-arm.c:334:2: error: implicit declaration of function 'wfi' [-Werror=implicit-function-declaration]
>>
>> drivers/soc/bcm/brcmstb/pm/pm-arm.o: In function `brcmstb_pm_s3_finish':
>> pm-arm.c:(.text+0x860): undefined reference to `cpu_resume'
>>
>> The first one requires at least ARMv6K, the second one requires the CPU
>> suspend/resume logic which is not available on some of the older CPUs,
>> and needs to be selected explicitly.
>>
>> This adds the extra Kconfig statements to enforce this, limiting
>> compilation on ARM to the STB platform that is guaranteed to be
>> ARMv7. We could enable compile-testing for other ARMv7 platforms,
>> but there seems to be little value as an allmodconfig kernel
>> already includes it.
> 
> Thanks, can you pick that change directly and/or fold it in:
> 
> 6274ca43eba1b2ebcac96f3c9b41fbc4945c0af0 ("soc: bcm: brcmstb: Add
> support for S2/S3/S5 suspend states (ARM)")?

Picked this up in drivers/next, and squashed this change into the
original commit, this is what it looks like now:

https://github.com/Broadcom/stblinux/commit/6274ca43eba1b2ebcac96f3c9b41fbc4945c0af0

Thanks Arnd!
-- 
-- 
Florian
