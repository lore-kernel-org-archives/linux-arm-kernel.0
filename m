From: josh.wu@atmel.com (Josh Wu)
Date: Tue, 3 Feb 2015 16:46:15 +0800
Subject: [PATCH 2/4] mtd: nand: atmel: Update DT documentation after
 splitting NFC and NAND
In-Reply-To: <20150202104236.649f99ad@bbrezillon>
References: <1417732214-3292-1-git-send-email-boris.brezillon@free-electrons.com>	<1417732214-3292-3-git-send-email-boris.brezillon@free-electrons.com>	<20150202075737.GC3523@norris-Latitude-E6410>
 <20150202104236.649f99ad@bbrezillon>
Message-ID: <54D08AD7.3050209@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Boris, Brian

On 2/2/2015 5:42 PM, Boris Brezillon wrote:
> Hi Brian,
>
> On Sun, 1 Feb 2015 23:57:37 -0800
> Brian Norris <computersforpeace@gmail.com> wrote:
>
>> Hi Boris,
>>
>> BTW, this series has a few conflicts with other things I have queued, so
>> you'll need to refresh.
> Yes, that's not a problem, but I'd like to be sure this is the way we
> want to go before rebasing this series.
>
>> On Thu, Dec 04, 2014 at 11:30:12PM +0100, Boris Brezillon wrote:
>>> The NAND and NFC (NAND Flash Controller) were linked together with a
>>> parent <-> child relationship.
>>>
>>> This model has several drawbacks:
>>> - it does not allow for multiple NAND chip handling while the controller
>>>    support multi-chip (even though the driver is not ready yet)
>>> - it mixes NAND partitions and NFC nodes at the same level (which is a bit
>>>    disturbing)
>> I agree that this is disturbing. (FWIW, it also seems a bit disturbing
>> that atmel_nand.c actually registers two different drivers and the tries
>> to synchronize them; this seems like it could be handled better, but I'm
>> not sure how at the moment.)
> Yep, that's my feeling too, but I'm not sure how this could/should be
> done.
> My problem here is that the pinmux should be requested by the EBI
> device because the EBI manages several type of devices and the data and
> address signals are shared by all the devices, hence the idea of
> defining the nand chip node under the EBI node.
> In the other hand, the NFC is not part of the EBI bus, and thus should
> not be defined under the EBI node.
>
> This might lead to the NFC device being probed before the NAND chip,
> hence the need for this synchronization.

OMHO, there is another way, which is change the NFC node to many NFC 
properties, just like PMECC.
As NFC, PMECC or hamming ecc HW could be part of current NAND node (in 
sama5, HSMC maybe a better name for this node. )

And this change can avoid the sync problem and avoid two drivers in 
atmel_nand.c.

>
>>> - the introduction of the EBI bus implies defining NAND chips under the
>>>    EBI node, and the ranges available under the EBI node should be
>>>    restricted to EBI address space, while the NFC references several
>>>    registers outside of these EBI ranges.
>> That's an interesting bit. I've actually run across this sort of problem
>> on other SoCs, where we have a relationship between two pieces of
>> hardware--the NAND chip and the NAND controller--where the former might
>> be on one bus (like your EBI bus, with chip selects), and the latter is
>> part of the top-level MMIO register space.
>>
>> But can you elaborate here a bit more? Does the NAND chip actually need
>> to be represented under your EBI bus?
> Yes, as said above this is all about pinmux conflicts, the NAND
> controller has to request the appropriate pinmux for its NAND chips but
> it will conflict with the pinmux requested by the EBI bus (data and
> address signals are shared by all the devices connected on the EBI).
>
>>> Move the NFC node outside of the NAND node, to get a more future-proof
>>> model.
>> I'm curious if an alternative solution might work, maybe one like the
>> Allwiner NAND (sunxi-nand) DT, which just reverses the roles; the 'NFC'
>> is the parent of the NAND chip(s). We've seen this pattern in other
>> contexts too.

I also prefer this. Then the dt node should looks like finally:

nand (SMC may be more correct) node {
     PMECC properties
     NFC properties --> we can make the NFC not a node, just many NFC 
properties.

     pinctrl-nand0
     nand chip 0: {
         partitions...
     }

     pinctrl-nand1
     nand chip 1: {
         partitions...
     }
}

> I would have preferred this solution too, but the EBI/pinmux constraint
> explained above prevents this approach.
I am not very clear about the pinmux constraint.
Maybe we just leave one DT node (either EBI or current nand node) to 
take care the pins.

> What I can do though, is reverse the referencing: reference nand chips
> from the nand controller node.

I guess the dt looks like: (correct me if I am wrong)

EBI node {
     pinctrl-nand0
     nand chip 0: {
         partitions...
     }

     pinctrl-nand1
     nand chip 1: {
         partitions...
     }
}

nand (SMC/HSMC may be more correct) node {
     PMECC properties
     NFC properties --> we can make the NFC not a node, just many NFC 
properties.

     &nand chip0
     &nand chip1
}

This is still looks nice to me.

>
> Josh, Brian, any idea to solve this EBI/nand-chip/nand-controller
> dependency problem is welcome.
>
> Best Regards,
>
> Boris
>
Best Regards,
Josh Wu
