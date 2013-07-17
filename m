From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 17 Jul 2013 16:24:38 -0600
Subject: [PATCH v8] reset: Add driver for gpio-controlled reset pins
In-Reply-To: <20130717213836.GA13324@amd.pavel.ucw.cz>
References: <1369904940-716-1-git-send-email-p.zabel@pengutronix.de>
 <20130716015038.GD28375@S2101-09.ap.freescale.net>
 <51E4BF98.8030604@wwwdotorg.org>
 <20130716041056.GA30067@S2101-09.ap.freescale.net>
 <51E56AA7.7020103@wwwdotorg.org>
 <20130717030246.GA4541@S2101-09.ap.freescale.net>
 <51E6CCE4.20705@wwwdotorg.org> <20130717213836.GA13324@amd.pavel.ucw.cz>
Message-ID: <51E719A6.6070105@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/17/2013 03:38 PM, Pavel Machek wrote:
> On Wed 2013-07-17 10:57:08, Stephen Warren wrote:
>> On 07/16/2013 09:02 PM, Shawn Guo wrote:
>>> On Tue, Jul 16, 2013 at 09:45:43AM -0600, Stephen Warren wrote:
>>>> Registering the driver earlier won't cause any bugs. However, it's not
>>>> the correct approach.
>>>>
>>>> Deferred probe /is/ the approach for assuring correct dependencies
>>>> between drivers. It works and should be used. There are not enough
>>>> initcall levels to play games using initcalls and solve all the issues,
>>>> and the ordering requirements vary board-to-board. Deferred probe at
>>>> runtime handles this without having to manually place all the drivers
>>>> into specific initcall levels, and dynamically adjusts to board
>>>> differences, since it all happens automatically at run-time.
>>>
>>> I do not quite follow the argument here.  I agree with you that
>>> deferred probe is the approach to solve dependencies.  But it does not
>>> necessarily mean that initcall can not be used to help it save some
>>> nasty or nested deferring.  Deferred probe and initcalls are not two
>>> mutually exclusive mechanisms but two which can help each other.
>>
>> My understanding is that deferred probe was implemented specifically to
>> avoid having to, or allowing, the use of initcall levels to determine
>> probe order.
>>
>> However, if someone closely associated with the implementation of
>> deferred probe (e.g. Grant, or a device core maintainer) is willing to
>> step up and say I'm wrong, I'll drop my objection.
> 
> AFAIR, defered probing is known to be a "hack" by its authors. We
> should still try to get initcall levels right...

I don't /think/ it was the concept of deferred probe that was considered
hacky, but perhaps just the first proof-of-concept implementation, and
any hackiness was presumably solved before the feature was merged.
