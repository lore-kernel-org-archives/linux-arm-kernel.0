From: vladimir_zapolskiy@mentor.com (Vladimir Zapolskiy)
Date: Fri, 23 Dec 2016 13:21:20 +0200
Subject: [PATCH v1] watchdog: imx2: fix hang-up on boot for i.MX21, i.MX27
 and i.MX31 SoCs
In-Reply-To: <20161223100113.s57bi7257yero7f7@pengutronix.de>
References: <20161211010648.6591-1-vz@mleia.com>
 <20161211093519.xrxxhrqpc7fmadfr@pengutronix.de>
 <d6d987f1-3461-214a-0ca1-16d310ddd370@mleia.com>
 <20161211102634.jn3awmlzdrm3pqai@pengutronix.de>
 <2fc2558d-fe05-14a7-745e-f71d2178bad6@mleia.com>
 <fe9b03bf-9c37-862f-b3aa-0f9b5a4dfefb@roeck-us.net>
 <bedae3d8-3057-36e4-1d89-ec41f9f1a25b@mleia.com>
 <20161223083256.3wdqou5xmhr7fidn@pengutronix.de>
 <74751709-c32e-b1b3-4fa3-613f7d57d1d8@mleia.com>
 <20161223100113.s57bi7257yero7f7@pengutronix.de>
Message-ID: <7018c466-2467-a9fc-2382-889d3a62741e@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On 12/23/2016 12:01 PM, Uwe Kleine-K?nig wrote:
> On Fri, Dec 23, 2016 at 11:27:24AM +0200, Vladimir Zapolskiy wrote:
>> On 12/23/2016 10:32 AM, Uwe Kleine-K?nig wrote:
>>> Hello,
>>>
>>> On Fri, Dec 23, 2016 at 10:20:20AM +0200, Vladimir Zapolskiy wrote:
>>>> On 12/23/2016 03:55 AM, Guenter Roeck wrote:
>>>>> What is the ultimate conclusion of this exchange ?
>>>>>
>>>>> Are we going to get another version of the patch, or did everyone agree that
>>>>> the patch is good as it is and does not require further changes ?
>>>>>
>>>>
>>>> I can not imagine a different fix.
>>>
>>> my preferred fix would be:
>>>
>>>  - add an imx35 compatible to all newer dtsi
>>>  - update the driver to only write the wmcr on imx35 compatible devices
>>>    adding only imx35.
>>>
>>
>> It breaks old DTS vs. new kernel compatibility, I've already mentioned this.
> 
> Correct, and I didn't deny that. In my mail I pointed out the problem
> this imposes and I think it's small enough to not justify the complexity
> introduced in your proposed change.
> 

I can not statistically estimate well the severity of the problem which was
fixed by commit 5fe65ce7cc (all boards with a similar change not found in
a bootloader will be affected, I believe) multiplied by the rate of users,
who don't update DTB. But statistically the probability is non-zero, and
thus it is better to consider that the new problem which I still resist to
introduce will hit somebody.

> If we cannot agree then at least this needs to be better documented in
> the driver because otherwise someone makes a cleanup later dropping all
> the compatibles that are needed to keep backwards compatibility.
> 

My position is to avoid fixing a bug by introducing another known in
advance bug, IMHO it overrules your statement about data redundancy.

Here I'd like to separate responsibilities. If somebody cleans the list
of compatibles up and it accidentally causes problems, the author of that
commit will be blamed and that commit will be reverted, and the revert
commit won't touch my fix -- make i.MX31 boards boot again.

> But my suggestion is to first do the minimal fix, and if in the next
> merge window people lament about breakages on their machine, we can
> still extend the simple fix to a fully backwards compatible change.

Let's fix one problem stated in the commit subject cleanly and without
any known side effects like I suggest, a questionable and optional purge
of compatibles can be done by somebody else later on.

--
With best wishes,
Vladimir
