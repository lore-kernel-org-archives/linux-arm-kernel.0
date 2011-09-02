From: b-cousson@ti.com (Cousson, Benoit)
Date: Fri, 2 Sep 2011 14:35:04 +0200
Subject: [PATCH 7/7] OMAP3: beagleboard: Remove DT support from regular
	board
In-Reply-To: <20110902104850.GS3548@atomide.com>
References: <1314897912-18178-1-git-send-email-b-cousson@ti.com>
	<1314897912-18178-8-git-send-email-b-cousson@ti.com>
	<20110902081246.GQ3548@atomide.com> <4E609B0A.1020804@ti.com>
	<20110902104850.GS3548@atomide.com>
Message-ID: <4E60CD78.9030602@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/2/2011 12:48 PM, Tony Lindgren wrote:
> * Cousson, Benoit<b-cousson@ti.com>  [110902 11:26]:
>> On 9/2/2011 10:12 AM, Tony Lindgren wrote:
>>> * Benoit Cousson<b-cousson@ti.com>   [110901 19:52]:
>>>> In order to avoid conflict with the new board-omap3-dt.c file,
>>>> remove the .dt_compat entry from the beagle regular board
>>>> file.
>>>>
>>>> Any DT work for OMAP3 will have to be done on the generic DT
>>>> board file to avoid breaking the legacy board support until
>>>> DT migration is done.
>>>
>>> In general we should not keep duplicate old non-DT data around
>>> now that we have the DT append support. Instead we should just
>>> require the .dts file appended to zImage for all mach-omap2
>>> machines. Otherwise we'll end up with double bloat :)
>>
>> Mmm, I'm not sure to get your point. We are not duplicating, since a
>> pure DT generic board will not have anything except a
>> of_platform_populate(NULL, omap_dt_match_table, NULL, NULL);
>> And the regular board files will keep initializing devices statically.
>> The drivers will then for the moment support both pdata and DT
>> method to get board parameters.
>
> Well when converting a driver to DT, we should just drop pdata
> support. No need to keep it around as it will just make it harder
> for us to clean up afterwards.

I'm not sure it is that simple. We have 20+ OMAP3+ boards supported so 
far. Dropping pdata when a driver is adapted means that all these boards 
should be properly adapted to DT and tested... (board-XXX.dts + 
board-XXX.c).
That's a huge effort for my point of view. Whereas keeping the legacy 
pdata method will allow progressing on the boart-dt only without 
breaking any legacy boards. It will allow the board manufacturers to 
potentially do the DTS file for their own system using then the generic 
board-dt.c file.

That being said, keeping the legacy pdata code in some driver along with 
the DT is a big pain as well:-(
In some cases, DT can even provide some good way to encode HW 
information that we do not have today with hwmod/omap_device. So in that 
case we do not even have any alternative method yet.

>>> So it's OK to have the DT entries in board files so drivers
>>> that get converted will work with them.
>>
>> Well, it will be a little bit more tricky, because having DT in
>> current board files will be a mess with a bunch of #ifdef CONFIG_OF,
>> and adding DT compatible inside each boards will prevent the pure
>> generic DT one to work. In that case we will duplicate the DT
>> migration in every legacy boards files...
>
> We should just select CONFIG_OF deal with it that way.
>
>> That's why the current strategy is to keep the current board files
>> non-DT aware and add the DT support only to the generic DT board
>> file.
>
> Well I don't like that, it will be a big mess. We'll end up with
> twice the amount of platform_data and init code. It's OK to
> require CONFIG_OF as it's known to work with the append support
> for older boards.
>
> It's easier just to require DT append for all the boards. In most
> cases it's just a trivial include of the common dts file for now.

That part is easy indeed, this is hacking every board-XXX.c and testing 
them that will be tricky. This is as well the board specifics settings 
that are tricky not the generic OMAP stuff. We do have to set GPIOs, pin 
mux, regulator bindings, audio codec stuff...

> When we convert something to DT, there's no point going back.

Agree on that, in theory, I'm just wondering how practical it will be to 
progress on every board at the same time.

I guess we do need some advice from the DT gurus on that as well.

It looks to me that both approaches are painful and will require some 
efforts.
It is too bad that nobody did a 
devicetree-migration-o-matic-for-lazy-developer.py script to handle that...

Regards,
Benoit
