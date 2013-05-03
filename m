From: s-anna@ti.com (Suman Anna)
Date: Fri, 3 May 2013 11:29:32 -0500
Subject: [GIT PULL] mailbox driver framework for v3.10 merge window
In-Reply-To: <CAJe_ZhfA=eqihefgtYGmLt03sNV6arme9t1YgzTFoC8nB6SNkQ@mail.gmail.com>
References: <37C860A02101E749A747FA2D3C1E3C504A1971@DLEE11.ent.ti.com>
 <201304091255.03020.arnd@arndb.de>
 <CAJe_Zhf5QwQQU5aVtNhbDT3EK9Dof-ZK_boP9WaNghqO8xY7iA@mail.gmail.com>
 <5182E403.1030808@ti.com>
 <CAJe_ZhfA=eqihefgtYGmLt03sNV6arme9t1YgzTFoC8nB6SNkQ@mail.gmail.com>
Message-ID: <5183E5EC.9040702@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/02/2013 09:37 PM, Jassi Brar wrote:
> On 3 May 2013 03:39, Suman Anna <s-anna@ti.com> wrote:
>> Hi Arnd,
>>
>> On 04/28/2013 11:07 PM, Jassi Brar wrote:
>>>
>>> Not to mean only talk and no do, I prepared another proposal that
>>> addressed all the concerns shared so far in the RFC
>>> http://www.spinics.net/lists/kernel/msg1523873.html (its not ready for
>>> primetime yet)  And also converted the PL320 driver to the new API,
>>> unlike the pulled patchset which leaves that out in the cold.
>>> http://www.spinics.net/lists/kernel/msg1523874.html
>>
>> Yes, the current code is mainly interrupt-driven and supports only
>> non-atomic context. We have a need to support atomic contexts and ipc
>> controllers that do not have interrupt-based triggering.
>>
> Supporting poll and client driven TX and atomic context is going to
> need big chunks of changes which we can avoid by doing them already.
> Plus a bottleneck with PL320, as Mark pointed out they can't afford
> any bigger latency, which will come from RX via notifier path.
> 
>> As Jassi
>> pointed out, the RFC is not ready yet and there are still some
>> contention points that needs to be sorted out (especially to maintain
>> OMAP mailbox functionality).
>>
> Apart from a few checkpatch fixes, a missing timer delete call and
> some testing with dummy client and controller drivers for various
> usecases, it's ready from my side. It worked at least as good as your
> API in our internal testing.
> 
> Please do let me know which OMAP functionality are you worried about,
> I believe it could all still be done above this api.

Mainly the splitting of bottom-half responsibility of the controller
driver between mailbox and the client (or another in-between layer
between my existing client (remoteproc driver), because of the support
for only atomic context.

> 
>>>
>>> Now, we could either call it (effectively the TI's framework with
>>> quirks for STE) as the "Common API" and then dismantle and convert it
>>> patch by patch (authors and I seem to agree many things need to be
>>> changed and implemented).
>>>   OR we do it reasonably right the first time even if that means yet
>>> another release. IMHO we should go for slow but steady thing.
>>
>> I think it is your call here, either of the above approaches would
>> definitely involve some rework on the framework as well as both the OMAP
>> & ST mailboxes.
> 
> I am interested to know what changes do you anticipate in my proposed
> API. Not to mean it's perfect, but I thought I provided for all
> practical use-cases.

I will provide feedback on the RFC thread, and we can continue the
discussion on that thread. I will also share the link to my current
work-in-progress branch so that you can see the design approach that I
have taken.

> 
> Yes, TI and STE would need re-work, but then as of now they are their
> own APIs upstream. And even with your proposal they would still need
> to be changed if we are to implement the desired features. What about
> PL320?

The pl320_transmit function is identical to the present
mailbox_msg_send_receive_no_irq, but that is a non-factor anyway since
we would have changed the API.

regards
Suman
