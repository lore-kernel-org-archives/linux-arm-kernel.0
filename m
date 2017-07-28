From: slash.tmp@free.fr (Mason)
Date: Fri, 28 Jul 2017 23:53:49 +0200
Subject: [RFC PATCH v1] net: ethernet: nb8800: Reset HW block in ndo_open
In-Reply-To: <yw1xfudgl7am.fsf@mansr.com>
References: <823b1540-b528-bbd7-7f99-5dc39a08868a@sigmadesigns.com>
 <yw1xk22slemx.fsf@mansr.com>
 <c1bf54ee-8634-23a1-abda-55bc3fafe2a8@sigmadesigns.com>
 <yw1xfudgl7am.fsf@mansr.com>
Message-ID: <446e3a95-80c3-0742-9cb1-69a8dfc9b1ae@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/07/2017 20:56, M?ns Rullg?rd wrote:

> Marc Gonzalez writes:
> 
>> On 28/07/2017 18:17, M?ns Rullg?rd wrote:
>>
>>> Marc Gonzalez wrote:
>>>
>>>> ndo_stop breaks RX in a way that ndo_open is unable to undo.
>>>
>>> Please elaborate.  Why can't it be fixed in a less heavy-handed way?
>>
>> I'm not sure what "elaborate" means. After we've been through
>> ndo_stop once, the board can send packets, but it doesn't see
>> any replies from remote systems. RX is wedged.
> 
> So you say, but you have not explained why this happens.  Until we know
> why, we can't decide on the proper fix.

I'll try adding delays in strategic places, and see if
I can trigger the same bug on tango4. If I can't, then
this work around is all we've got.

And I need nb8800_init for resume anyway, so I might
as well use it in ndo_open.

TODO: test power savings from holding HW in reset.

>> I think ndo_stop is rare enough an event that doing a full
>> reset is not an issue, in terms of performance.
> 
> Performance isn't the issue.  Doing the right thing is.

I don't have always have time to figure out exactly how
broken HW is broken. It's already bad enough that disabling
DMA requires sending a fake packet through the loop back...


>>> I'm pretty sure this doesn't preserve everything it should.
>>
>> Hmmm, we're supposed to start fresh ("full reset").
>> What could there be to preserve?
>> You mentioned flow control and multicast elsewhere.
>> I will take a closer look. Thanks for the heads up.
> 
> Yes, those settings are definitely lost with your patch.  Now I'm not
> sure whether the networking core expects these to survive a stop/start
> cycle, so please check that.  There might also be other less obvious
> things that need to be preserved.

The original code calls nb8800_pause_config() every
time the link comes up. The proposed patch doesn't
change that.

Regards.
