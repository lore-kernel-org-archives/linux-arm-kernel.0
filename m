From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 14 Oct 2015 15:43:56 -0700
Subject: [PATCH] spmi-pmic-arb: support configurable number of peripherals
In-Reply-To: <20150915182728.GA11715@codeaurora.org>
References: <1442267672-11287-1-git-send-email-sboyd@codeaurora.org>
 <55F77451.9070900@codeaurora.org> <1442316018.15519.4.camel@mm-sol.com>
 <20150915182728.GA11715@codeaurora.org>
Message-ID: <561EDAAC.6060800@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/15/2015 11:27 AM, Stephen Boyd wrote:
> On 09/15, Ivan T. Ivanov wrote:
>> On Mon, 2015-09-14 at 18:28 -0700, Stephen Boyd wrote:
>>> On 09/14/2015 02:54 PM, Stephen Boyd wrote:
>>>> The current driver implementation supports only 128 peripherals.
>>>> Add support for more than 128 peripherals by taking a lazy
>>>> caching approach to the mapping tables. Instead of reading the
>>>> tables at boot given some fixed size, read them on an as needed
>>>> basis and cache the results. We still assume a max number of 512
>>>> peripherals, trading off some space for simplicity.
>>>>
>>>> Based on a patch by Gilad Avidov <gavidov@codeaurora.org> and
>>>> Sagar Dharia <sdharia@codeaurora.org>.
>>>>
>>>> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
>>>> ---
>>> Hi Ivan,
>>>
>>> This patch causes 8916 to crash, because there isn't a mapping for ppid
>>> 257 in the ppid to channel table. It seems that we're reading the revid
>>> from the slave id 1 pmic by going through channel 0, which seems to be
>>> setup for ppid 9 (slave id 0 and the peripheral starting at 0x900). Can
>>> we stop reading the revid registers from non-zero slave id pmic devices?
>>> That would be one solution to fix this problem. Or maybe we need to
>>> special case this in the pmic arbiter code to fold ppid 0xN01 (slave id
>>> N and address 0x100) onto channel 0 all the time?
>>>
>> Yes, we can. We are not using this information at the moment.
>> Right now, revision read is more or less for debug purposes.
>>
>> Would following patch work for you? Of course it will be difficult
> Yes the patch works fine. Feel free to add a
>
> Tested-by: Stephen Boyd <sboyd@codeaurora.org>
>
>

I have to take this back. I missed the part where some pmics are on
slave id 2 or slave id 4, so this check isn't going to work. I've
adjusted it to use sid % 2 instead and I'll resend these two patches,
but I imagine to be more robust we're going to need to add a revid node
to the DT under the SID that actually has it. Then we can search the
child nodes for a revid compatible node and do the rev probing stuff.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
