From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Sat, 12 Jan 2013 16:04:28 +0530
Subject: [PATCH RFT 3/3] ARM: tegra: dts: seaboard: enable keyboard
In-Reply-To: <50F0A2A8.3080401@wwwdotorg.org>
References: <1357911185-11048-1-git-send-email-ldewangan@nvidia.com>
 <1357911185-11048-3-git-send-email-ldewangan@nvidia.com>
 <50F09BC7.90607@wwwdotorg.org>
 <20130111232438.GN23505@n2100.arm.linux.org.uk>
 <50F09FCB.70809@wwwdotorg.org>
 <20130111233615.GO23505@n2100.arm.linux.org.uk>
 <50F0A2A8.3080401@wwwdotorg.org>
Message-ID: <50F13C34.3020808@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 12 January 2013 05:09 AM, Stephen Warren wrote:
> On 01/11/2013 04:36 PM, Russell King - ARM Linux wrote:
>> On Fri, Jan 11, 2013 at 04:27:07PM -0700, Stephen Warren wrote:
>>> On 01/11/2013 04:24 PM, Russell King - ARM Linux wrote:
>>>> On Fri, Jan 11, 2013 at 04:09:59PM -0700, Stephen Warren wrote:
>>>>> On 01/11/2013 06:33 AM, Laxman Dewangan wrote:
>>>>>> 	kbc->clk = clk_get(&pdev->dev, NULL);
>>>>>> 	if (IS_ERR(kbc->clk)) {
>>>>>> 		dev_err(&pdev->dev, "failed to get keyboard clock\n");
>>>>>> 		err = PTR_ERR(kbc->clk);
>>>>>> 		goto err_iounmap;
>>>>>> 	}
>>>>> Should that check be if (!kbc-clk) instead? Or does the common clock
>>>>> framework require if (IS_ERR_OR_NULL(kbc->clk)); hopefully not since
>>>>> IS_ERR_OR_NULL shouldn't be used any more.
>>>> /**
>>>>   * clk_get - lookup and obtain a reference to a clock producer.
>>>>   * @dev: device for clock "consumer"
>>>>   * @id: clock consumer ID
>>>>   *
>>>>   * Returns a struct clk corresponding to the clock producer, or
>>>>     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>>   * valid IS_ERR() condition containing errno.  ...
>>>>     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>>
>>>> Or, put another way:
>>>>
>>>> 	If (!IS_ERR(clk))
>>>> 		The_Clock_Is_Valid();
>>>> 	Else
>>>> 		The_Clock_Is_Invalid();
>>>> 		The_Error = PTR_ERR(clk);
>>> OK, but that doesn't appear to be what happened in practice.
>> It's what I've been saying each time I see an abuse, the problem is
>> people don't care to read the documentation provided let alone
>> understand the interfaces.
>>
>> That's precisely why IS_ERR_OR_NULL() is to be removed.  One less
>> thing for someone to throw a dart at as a selection method to use.
>> Or maybe roll a dice.  Or whatever way they do seem to choose.
>> (Whatever that is, it's not based on any sound engineering practice
>> I can make out.)
> For the record, I did mention that IS_ERR_OR_NULL() should not be the
> solution here. And the point of my email to Laxman was that he should go
> figure out the answer to my question, which would entail reading the
> documentation/code/...

Going through clock driver, the clk_get() should return error pointer or 
valid pointer, atleast not NULL.

Probably our clock driver is returning to NULL and hence issue is 
becasue whole world, it  check for IS_ERR or !IS_ERR() and null clk 
pointer treated as !IS_ERR().

Stephen,
Which is the tree on which Prashant changes are applied. I can debug 
from that tree.
