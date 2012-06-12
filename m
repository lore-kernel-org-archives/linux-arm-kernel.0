From: b-cousson@ti.com (Cousson, Benoit)
Date: Tue, 12 Jun 2012 14:38:31 +0200
Subject: [PATCH 1/2] ARM: OMAP2+: hwmod data: Fix the wrong clkdm assigned
 to PRCM modules
In-Reply-To: <4FD65F12.2050805@ti.com>
References: <1339433225-30042-1-git-send-email-b-cousson@ti.com>
 <1339433225-30042-2-git-send-email-b-cousson@ti.com>
 <alpine.DEB.2.00.1206111100130.5849@utopia.booyaka.com>
 <4FD65F12.2050805@ti.com>
Message-ID: <4FD73847.5050205@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On 6/11/2012 11:11 PM, Cousson, Benoit wrote:
> On 6/11/2012 7:26 PM, Paul Walmsley wrote:
>> On Mon, 11 Jun 2012, Benoit Cousson wrote:
>>
>>> The following commit (794b480a37e3d284d6ee7344d8a737ef60476ed5) was
>>> adding
>>> the PRCM IPs data for PRCM, CM, PRCM_MPU and SCRM.
>>> The clkdm entry are not the correct ones and does not exist in the
>>> system.
>>>
>>> Replace them with the proper wkup, l4_ao and l4_cfg.
>>
>> This does not match either the publicly avaiable documentation and the
>> internal NDA hardware specifications[1].
>
> That's almost true, until I realized that the clock domain modules list
> contain this information (clock.py/clock_domain['l4_wkup']['modules']).
> Now, I'm wondering as well why this is not documented better. I'll check
> that tomorrow.

OK, I've just spent 2 hours with HW folks trying to get the real truth...

In fact, this information is not even accurate :-(

There is no such thing as clock domain for PRCM IPs. These IPs are 
considered as clock generator or reset generator and thus does not 
belong to any clock domain.
This information was used to capture the power domain where they belong 
and thus the closest clock domain was used for that, but this is purely 
artificial.

Their first question was, why do you guys need that at the first place???

I guess this question is valid. Since we do not have any SW control, 
this information is completely useless except to potentially avoid 
de-referencing null clkdm.

So I guess it is much better to just take care of that and avoid 
populating with wrong or fake clock domains.

Going a little bit further, these IPs do not even have modulemode, or 
whatever SW control. Even the hwmod it not applicable for them. It 
should just be a regular platform_device and thus deserve a simple entry 
in DT without any hwmod attribute.

Bottom-line, I think we should simply get rid of these PRCM hwmod 
entries and the corresponding fake clock domains.

Does that make sense to you?

Regards,
Benoit
