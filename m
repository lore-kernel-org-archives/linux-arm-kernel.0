From: grinberg@compulab.co.il (Igor Grinberg)
Date: Tue, 06 Jul 2010 13:31:34 +0300
Subject: [PATCH v2] otg/ulpi.c : fix register write
In-Reply-To: <4C27597F.3010902@eukrea.com>
References: <1277311435-12027-1-git-send-email-eric@eukrea.com>
	<4C236600.2030605@compulab.co.il> <4C236D9A.4030707@eukrea.com>
	<4C2700C9.2090602@compulab.co.il> <4C27597F.3010902@eukrea.com>
Message-ID: <4C330606.90207@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06/27/10 17:00, Eric B?nard wrote:
> Le 27/06/2010 09:42, Igor Grinberg a ?crit :
>>
>> On 06/24/10 17:37, Eric B?nard wrote:
>>> Le 24/06/2010 16:04, Igor Grinberg a ?crit :
>>>> ulpi_set_flags is used to set the OTG flags and not to clear them,
>>>> also it is a static function and is not a part of struct
>>>> otg_transceiver,
>>>> so it cannot be called from outside the ulpi.c, thus after the
>>>> ulpi_create,
>>>> it is never called.
>>>> I think, currently, this should stay as it is.
>>>>
>>> OK, the problem that when one flag is set, you can't clear it without
>>> resetting the PHY.
>>
>> This is correct, but current ulpi driver is not designed for writing
>> multiple times
>> into the ULPI_OTG_CTRL register, only once when ulpi_init function is
>> called.
>> Do you call the ulpi_init function for a couple of times? Looks like
>> a hack.
>>
> no hack, as I was fixing the other function, I though this one could
> also be fixed :)
> I'll send a patch with only the other fix.
>
> Eric
>

I've found in the ulpi specification that there are some bits in the
OTG Control Register that are set by default after power-on.
Current ulpi driver can only set those bits and not clear them,
making it impossible for the platform to clear them even at
initialization time.
So, after all v2 of your patch is correct.
Sorry, for not seeing this at first time :( , so

Acked-by: Igor Grinberg <grinberg@compulab.co.il>

-- 
Regards,
Igor.
