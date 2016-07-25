From: robh@kernel.org (Rob Herring)
Date: Mon, 25 Jul 2016 08:47:23 -0500
Subject: [PATCH 14/18] ARM: mvebu: add support for the Armada 395 SoC
 family
In-Reply-To: <CAH76GKOidxFZ7R1pQZ2W9BRBCxEnLXNHQGrXbAUmouozBUj51Q@mail.gmail.com>
References: <1469105055-25181-1-git-send-email-jaz@semihalf.com>
 <1469105055-25181-16-git-send-email-jaz@semihalf.com>
 <20160721221605.GA21883@rob-hp-laptop>
 <CAH76GKOidxFZ7R1pQZ2W9BRBCxEnLXNHQGrXbAUmouozBUj51Q@mail.gmail.com>
Message-ID: <CAL_JsqJeObuS8OWeErRA5MX-SrMtu_254A-LtP9-A=xdPO7p1Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 22, 2016 at 4:10 AM, Grzegorz Jaszczyk <jaz@semihalf.com> wrote:
> Hi Rob,
>
> 2016-07-22 0:16 GMT+02:00 Rob Herring <robh@kernel.org>:
>> On Thu, Jul 21, 2016 at 02:44:11PM +0200, Grzegorz Jaszczyk wrote:
>>> -compatible = "marvell,a398-db", "marvell,armada398", "marvell,armada390";
>>> +compatible = "marvell,a398-db", "marvell,armada398", "marvell,armada395", "marvell,armada390";
>>
>> If 395 came after 398, then it should come first in the order. This
>> implies that marvell,armada398 is a better match than marvell,armada395.
>> Or perhaps you shouldn't have both?
>>
>> Rob
>
> I am not sure if I get your point. The Armada-398 extends the
> Armada-395 about 2 additional SATA ports (as you can see in commit
> "[PATCH 15/18] ARM: mvebu: a398: update the dtsi about missing
> interfaces"). In this example the a398-db board contains the Armada398
> SoC, so it is a better match and goes first.

But your patch title is adding 395 support, but you are adding the
string to a 398 based board. It would make sense to have 395 here if
the OS already had support for 395 and you want to support the 398
without updating the OS. That doesn't seem to apply here.

> Quite the same is for existing armada-388-db.dts, in which compatible
> looks like this:
> compatible = "marvell,a385-db", "marvell,armada388",
> "marvell,armada385", "marvell,armada380";

Maybe so, but IMO this looks a bit excessive.

The problem is what if you need to apply a fix for only 395 (or 385),
but not 398? If you put both strings in, you can't distinguish you are
running on a 395 or 398 SoC. You would have to check for !398 and any
other SoCs you've claimed are 395 compatible. Maybe you have ID
registers you can read to distinguish SoCs, but then you don't need
the strings in that case either. The flip side is if you need a fix
for both, then the OS can easily check for either string.

Rob
