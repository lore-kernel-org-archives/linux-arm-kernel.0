From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 21 Aug 2014 09:40:02 -0600
Subject: [PATCH v2 5/5] ARM: tegra: Add thermal reset (thermtrip) support
 to PMC
In-Reply-To: <53F5F019.10308@nvidia.com>
References: <1407933685-12404-1-git-send-email-mperttunen@nvidia.com>
 <1407933685-12404-6-git-send-email-mperttunen@nvidia.com>
 <53F5042A.7020603@wwwdotorg.org> <53F5F019.10308@nvidia.com>
Message-ID: <53F612D2.8020803@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/21/2014 07:11 AM, Mikko Perttunen wrote:
> On 20/08/14 23:25, Stephen Warren wrote:
>> On 08/13/2014 06:41 AM, Mikko Perttunen wrote:
>>> This adds a device tree controlled option to enable PMC-based
>>> thermal reset in overheating situations. Thermtrip is supported on
>>> Tegra30, Tegra114 and Tegra124. The thermal reset only works when
>>> the thermal sensors are calibrated, so a soctherm driver is also
>>> required.
>>
>> If calibration is required, presumably the soctherm must initialize
>> before this thermtrip code can initialize, or this thermtrip logic might
>> be triggered by uncalibrated sensors?
>
> SOCTHERM requires that each sensor be explicitly enabled before it gives
> readings. If a sensor is not enabled, the temperature given by the
> register (and used to trigger thermtrip) will be zero. So in order for a
> thermtrip shutdown to be caused before soctherm is initialized, the
> thermtrip temperature would have to be programmed to below zero (the
> default value is 105C), in which case an immediate shutdown would
> probably be in order anyway (unless the user uses LN2 or something to
> cool the soc below zero).
>
>>
>> If so, then there needs to be some explicit mechanism to force the two
>> drivers into probing in the right order.
>
> Because of the above, I think it isn't necessary to probe these in order.

OK, that makes sense. Briefly mentioning this in the commit description 
could be useful.
