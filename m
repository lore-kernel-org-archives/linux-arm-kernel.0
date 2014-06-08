From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 08 Jun 2014 11:55:19 +0200
Subject: MMC is *still* broken...
In-Reply-To: <CAOesGMgp+r3TTuhctqxVxW8abj467UpPwch3iN=e8rsXeF1p-A@mail.gmail.com>
References: <20140605183615.GG23430@n2100.arm.linux.org.uk>	<86oay7noer.fsf@void.printf.net>
 <CAOesGMgp+r3TTuhctqxVxW8abj467UpPwch3iN=e8rsXeF1p-A@mail.gmail.com>
Message-ID: <53943307.5070202@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 06/06/2014 12:21 AM, Olof Johansson wrote:
> [Adding Hans]
> 
> On Thu, Jun 5, 2014 at 12:31 PM, Chris Ball <chris@printf.net> wrote:
>> Hi Russell, adding Ulf and Olof,
>>
>> On Thu, Jun 05 2014, Russell King - ARM Linux wrote:
>>> drivers/mmc/core/core.c: In function 'mmc_card_power_up':
>>> drivers/mmc/core/core.c:1517:4: error: implicit declaration of
>>> function 'gpiod_set_value'
>>>
>>> I reported this back in April, and it's still present.  This makes me
>>> wonder if MMC is maintained.... and makes me wonder what the point
>>> of reporting bugs is if they just get ignored.
>>
>> I don't recall your report.  I might have just failed to read it, but
>> doing a quick mail search only finds "Subject: randconfig failures -
>> MMC + trusted foundations" -- which was sent to linux-arm-kernel@, but
>> not CC'd to linux-mmc@ or to me.
>>
>> Furthermore, this error does not exist in mmc-next or linux-next,
>> so it's unclear why or how the MMC maintainers would fix it.
>> drivers/mmc/core/core.c does not use gpiod_set_value() in these trees.
>>
>> Presumably you're testing Olof's unmerged patch "mmc: add support for
>> power-on sequencing through DT".  If it needs to include more gpio
>> headers, that should be reported to Olof for a respin.
>>
>> The patch has not been merged because we're still discussing the best
>> way forward on linux-mmc@, in the thread "RFC: representing sdio
>> devices oob interrupt, clks, etc. in device tree".  The most recent
>> message in the thread is from yesterday.
> 
> Right, Hans has taken over the patch set and he should revise it as
> needed. Hans?

Erm, that was not really my intent. My interest in mmc powerup
sequencing is only peripheral. As a hobby project I work on support for
Allwinner ARM SoCs, some of their boards use Broadcom sdio wifi IC-s,
and as such I've been testing (and fixing) a patch-set from
Arend van Spriel to add oob irq support to the brcmfmac driver.

In its original incarnation this set also added some mmc powerup sequencing
stuff. Since this was broken I decided to start a discussion on how to deal
with this, hoping that we could reach a consensus on this quickly...

Besides me being only peripheral interested, and this only being
a hobby project, there also is the problem that people who are interested
in this seem to stop responding to any proposals about 3 mails in to
the thread. So just when it seems we are getting somewhere everyone
involved seems to go quiet, which I find very frustrating.

Combining all of the above with the fact that I'm currently really
trying to keep to much balls up in the air at once, means that I've
decided to throw in the towel wrt mmc powerup sequencing.

I've just dropped powerup sequencing from the brcmfmac patch-set, only
adding oob irq support for now, which is all I need for the Allwinner
boards.

I'm sorry if I gave the impression that I was going to fix this all,
but I simply don't have the time nor energy to work at this atm.

For whomever does pick this up, let me try to summarize the direction
the discussion seems to be heading in (but I still have not yet heard
any maintainer clearly state yes this is how we're going to do this) :

1) The necessary resources for powerup should live in a subnode of
the mmc-host.

2) As described in this patch: http://patchwork.ozlabs.org/patch/355235/
mmc-host subnodes will be addressed by sdio-function number with number
0 addressing the card itself. Since the sdio-function subnodes will have
things like oob-irq info and compatible strings to indicate how this info
should be interpreted, I believe that the info from 1). would best be
stored in the subnode with reg = <0>, so the node describing the card
itself, this also makes sense since some of the resources used for powerup
may well be shared between sdio functions.

3) Storing all the resources needed for powerup in a subnode with reg = <0>,
means that we can also out a compatible string there to indicate how these
resources should be used. I can see your (Olof's) original powerup patch
be turned into a generic powerup-driver using a compatible e.g. "generic-powerup".

4) Implementation wise I think we all agree that we want to use a platform
device + driver. So the mmc-core would check for a subnode with reg == 0 and if
there is one instantiate a platform device from this, using the subnode as the
platform devices of_node, and the platform driver for the powerup will be bound
using the compatible string of the subnode.

5) mmc_add_host will do a platform_device_register() for this platform device,
and afterwards check if a driver was bound, if no driver was bound,
the platform device will be unregistered and mmc_add_host will return -EPROBE_DEFER,
so that the whole probe can be tried again later. This is necessary since some
of the resources needed to powerup may not be available yet (or the powerup driver
may be a module which is not available yet).

6) power-management will use runtime-pm. If more fine grained power-management is
added later, then device specific callbacks can be added.

Regards,

Hans
