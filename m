From: nsekhar@ti.com (Sekhar Nori)
Date: Sun, 18 Dec 2016 21:21:25 +0530
Subject: [PATCH v7 1/2] provide lock-less versions of clk_{enable|disable}
In-Reply-To: <e004a3f8-2dde-b21c-b09e-da5a65d768f6@lechnology.com>
References: <1481302773-14181-1-git-send-email-abailon@baylibre.com>
 <20161209185421.fybpk4bdq6b7yglf@pengutronix.de>
 <e548f7cf-a1d5-0bc2-1095-db8464a1bcc4@ti.com>
 <35adff3d-c6a6-7b65-fb61-6da447dd6c3f@baylibre.com>
 <e004a3f8-2dde-b21c-b09e-da5a65d768f6@lechnology.com>
Message-ID: <5112fcf8-8a10-bfd3-3c37-c3a956eacd15@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 17 December 2016 02:11 AM, David Lechner wrote:
> On 12/12/2016 04:27 AM, Alexandre Bailon wrote:
>> On 12/12/2016 10:02 AM, Sekhar Nori wrote:
>>> Hi Uwe,
>>>
>>> On Saturday 10 December 2016 12:24 AM, Uwe Kleine-K?nig wrote:
>>>> Hello,
>>>>
>>>> On Fri, Dec 09, 2016 at 05:59:32PM +0100, Alexandre Bailon wrote:
>>>>> Rename __clk_{enable|disble} in davinci_clk_{enable|disable}.
>>>>> davinci_clk_{enable|disable} is a lock-less version of
>>>>> clk_{enable|disable}.
>>>>> This is useful to recursively enable clock without doing recursive
>>>>> call
>>>>> to clk_enable(), which would cause a recursive locking issue.
>>>>> The lock-less version could be used by example by the usb20 phy clock,
>>>>> that need to enable the usb20 clock before to start.
>>>>
>>>> I wouldn't call that lock-less. The difference is that the newly
>>>> exposed
>>>> funcion requires the caller to already hold the lock. So maybe a better
>>>
>>> Right.
>> Is it enough to update the commit message or should I also update the
>> patch title?
>> If so, could you suggest one because I don't know how to describe it
>> shortly.
> 
> How about... "ARM: davinci: Make __clk_{enable,disable} functions public"

Looks fine to me, here is the updated subject line and commit text. No
need to resend just for this, I can adjust when applying.

"
ARM: davinci: Make __clk_{enable,disable} functions public

In some cases, there is a need to enable a clock as part of clock
enable callback of a different clock. For example, USB 2.0 PHY clock
enable requires USB 2.0 clock to be enabled. In this case, it is safe to
instead call  __clk_enable() since the clock framework lock is already
taken. calling clk_enable() causes recursive locking error.

A similar case arises in the clock disable path.

To enable such usage, make __clk_{enable,disable} functions publicly
available outside of clock.c. Also, call them
davinci_clk_{enable|disable} now to be consistent with how other
davinci-specific clock functions are named.

Note that these functions are not exported to drivers. They are meant
for usage in platform specific clock management code.
"

Thanks,
Sekhar
