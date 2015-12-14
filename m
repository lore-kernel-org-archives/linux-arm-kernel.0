From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 14 Dec 2015 14:30:53 +0100
Subject: [PATCH 1/2] ARM: l2x0: make it possible to disable outer sync
 from DT
In-Reply-To: <20151210142942.GB495@leverpostej>
References: <1449756855-19473-1-git-send-email-linus.walleij@linaro.org>
 <20151210142942.GB495@leverpostej>
Message-ID: <CACRpkdayPdJDKPh=6vH5p5gWCu1uetBVdbEJz8Pvw79bujmQrg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 10, 2015 at 3:32 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Thu, Dec 10, 2015 at 03:14:15PM +0100, Linus Walleij wrote:
>> Some RealView platforms have broken outer_sync, see:
>> http://marc.info/?l=linux-kernel&m=144846940516899&w=2
>>
>> We got rid of the custom barriers from the machine by disabling
>> outer sync, but that was just for the boardfile case. We have
>> to be able to do the same in the device tree case.
>>
>> Since __l2c_init() is cloning and copying the L2C vtable,
>> we pass an argument to this function to optionally numb
>> the outer sync operation if desired, before initializing
>> the cache.
>>
>> After this we can set up the cache correctly on the RealView
>> PB11MPCore, and it boots rock solid with the cache enabled.
>> Before this, spurious crashes would occur if we try to set
>> up the cache properly.
>>
>> Cc: Russell King <linux@arm.linux.org.uk>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: devicetree at vger.kernel.org
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>>  Documentation/devicetree/bindings/arm/l2cc.txt |  1 +
>>  arch/arm/mm/cache-l2x0.c                       | 13 ++++++++++---
>>  2 files changed, 11 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/l2cc.txt b/Documentation/devicetree/bindings/arm/l2cc.txt
>> index d181b7c4c522..aae7387acbdb 100644
>> --- a/Documentation/devicetree/bindings/arm/l2cc.txt
>> +++ b/Documentation/devicetree/bindings/arm/l2cc.txt
>> @@ -75,6 +75,7 @@ Optional properties:
>>    specified to indicate that such transforms are precluded.
>>  - arm,parity-enable : enable parity checking on the L2 cache (L220 or PL310).
>>  - arm,parity-disable : disable parity checking on the L2 cache (L220 or PL310).
>> +- arm,outer-sync-disable : disable the outer sync operation on the L2 cache.
>
> I'm not sure what this means from a HW perspective. The "outer sync"
> operation is Linux terminology and doesn't show up in the TRM for L220.
>
> What is the (integration? HW?) bug that we're trying to avoid the effect
> of? It sounds like we should be describing that.
>
> We should at least have a better definition of what this means we must
> avoid.

So this code is a bit ancient, and we're trying to migrate it to device tree.

It was inspired by this board file patch from Arnd:
http://marc.info/?l=linux-arm-kernel&m=144846938616893&w=2

Then I go back and dig in the code and I find this:

commit 2503a5ecd86c002506001eba432c524ea009fe7f
Author: Catalin Marinas <catalin.marinas@arm.com>
Date:   Thu Jul 1 13:21:47 2010 +0100

    ARM: 6201/1: RealView: Do not use outer_sync() on ARM11MPCore
boards with L220

    RealView boards with certain revisions of the L220 cache controller (ARM11*
    processors only) may have issues (hardware deadlock) with the
recent changes to
    the mb() barrier implementation (DSB followed by an L2 cache
sync). The patch
    redefines the RealView ARM11MPCore mandatory barriers without the
outer_sync()
    call.

    Cc: <stable@kernel.org>
    Tested-by: Linus Walleij <linus.walleij@stericsson.com>
    Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
    Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

And that is as much as it says.

It is working around a hardware lockup in some core tiles. Is it
enough if I add this
to the explanation or do we need to send Catalin or Will down in the archives
to read netlists? ;)

Yours,
Linus Walleij
