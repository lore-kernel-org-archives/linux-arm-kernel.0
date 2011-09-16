From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Fri, 16 Sep 2011 17:31:53 +0530
Subject: [PATCH 02/25] OMAP4: Redefine mandatory barriers for OMAP to
	include interconnect barriers.
In-Reply-To: <CAMQu2gwv5y6PY_ooBjYuM497D=QuU54yWB+i6DRdn1YuuocY6Q@mail.gmail.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
	<1315144466-9395-3-git-send-email-santosh.shilimkar@ti.com>
	<20110913202701.GF24252@atomide.com> <4E7080F8.9020302@ti.com>
	<87obyl7mj8.fsf@ti.com>
	<CAMQu2gy6yVA7zWAPUsnzCtixHkjzkn6UnbapR0mpoJ+AwNMAcQ@mail.gmail.com>
	<20110915175354.GW24252@atomide.com>
	<CAMQu2gzfU0K0Q1Pta4vX=dNBBYQ6wNg_Kf5EeMTCV_WHTs3Y=w@mail.gmail.com>
	<20110915194330.GC2284@atomide.com>
	<CAMQu2gwv5y6PY_ooBjYuM497D=QuU54yWB+i6DRdn1YuuocY6Q@mail.gmail.com>
Message-ID: <CAMQu2gxhDyQqLqt3C+97s0vy_r0P2umcrygN5ZaN=A8p0TV3xQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 16, 2011 at 1:30 AM, Shilimkar, Santosh
<santosh.shilimkar@ti.com> wrote:
> On Fri, Sep 16, 2011 at 1:13 AM, Tony Lindgren <tony@atomide.com> wrote:
>> * Shilimkar, Santosh <santosh.shilimkar@ti.com> [110915 10:49]:
>>> On Thu, Sep 15, 2011 at 11:23 PM, Tony Lindgren <tony@atomide.com> wrote:
>>> >
>>> > Please also include the errata in the description and set it up with
>>> > a Kconfig entry with something like ARM_ERRATA_XXXXXX or TI_ERRATA_XXXXXX.
>>> >
>>> Sure.
>>> It's a ?TI ERRATA.
>>
>> OK
>>
>>> > Also it would be best to apply this fix at the end of the PM series so
>>> > it is easier to verify the bug and potentially remove the hack if
>>> > a better fix is ever available.
>>> >
>>> As such order doesn't matter much because it can be removed either way
>>> even if it is in the beginning of the series with KCONFIG entry.
>>>
>>> But I can change the order if you prefer that way.
>>
>> Well it seems that it's the omap4_finish_suspend in this series that
>> can be used to trigger the bug, although the bug has been around for
>> few years. So then instead of mentioning random hangups you can have
>> a better description with something like "Patch xyz added PM idle
>> support for omap4, however bug 123 causes so and so. Fix the issue
>> with blah blah".
>>
> Sounds good .
>
>> Also, if you have some easy way to reproduce the bug maybe mention
>> that too? That would make it easy to verify if issue has been fixed.
>>

Just for record, Below are the errata details.

ERRATA: i688: Async Bridge Corruption

If a data is stalled inside asynchronous bridge because
of backpressure, it may be accepted multiple times, creating pointer
misalignment that will corrupt next transfers on that data path until next
reset of the system (No recovery procedure once the issue is hit, the
path remains consistently broken). Async bridge can be found on path between
MPU to EMIF, MPU to L3 interconnect and Cortex M3 to Emif .

This situation can happen only when the idle is initiated by a Master
Request Disconnection (which is trigged by software whenexecuting WFI)

WORKAROUND
All the initiators connected through Async Bridge must ensure that
data path is properly drained before issuing WFI. This condition will be
met if one Strongly ordered access is performed to the target right
before executing the WFI.

> There are some multimedia usecases where the bug was discovered
> but on mainline obviously we don't have that support.
>
> I will check with IP folks if any other simple test-case is possible
> to reproduce the issue and If I find one, will mention that.
>
We have a GFX usecase which demonstrate this issue but can't
be tested on mainline sicne no GFX support.

But the same patch is already in the product line which
has fixed the GFX usecase issue.

Regards
Santosh
