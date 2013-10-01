From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 01 Oct 2013 16:43:54 +0200
Subject: [PATCH 3/4] clk: kirkwood: Add CLK_IGNORE_UNUSED to ethernet
 ge0 and ge1 clocks
In-Reply-To: <20131001142205.GF2448@localhost>
References: <1380575010-8573-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1380575010-8573-4-git-send-email-ezequiel.garcia@free-electrons.com>
 <20131001004009.GK31178@titan.lakedaemon.net>
 <20131001134213.GC2448@localhost> <524AD2F7.4090803@gmail.com>
 <20131001142205.GF2448@localhost>
Message-ID: <524ADFAA.40805@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/01/2013 04:22 PM, Ezequiel Garcia wrote:
> On Tue, Oct 01, 2013 at 03:49:43PM +0200, Sebastian Hesselbarth wrote:
>> On 10/01/2013 03:42 PM, Ezequiel Garcia wrote:
>>> On Mon, Sep 30, 2013 at 08:40:09PM -0400, Jason Cooper wrote:
>>>> On Mon, Sep 30, 2013 at 06:03:29PM -0300, Ezequiel Garcia wrote:
>>>>> These clocks should never be gated, since the ethernet interfaces forget
>>>>> the assigned MAC address assigned if their clock source is turned off.
>>>>>
>>>>> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
>>>>> ---
>>>>> Cc: Mike Turquette <mturquette@linaro.org>
>>>>>
>>>>>    drivers/clk/mvebu/kirkwood.c | 9 +++++++--
>>>>>    1 file changed, 7 insertions(+), 2 deletions(-)
> [..]
>>> The motivation for these 4 patches, came from an attempt of booting a
>>> multiplatform kernel Kirkwood, which _almost_ booted fine :P
>>
>> But the workaround doesn't affect "_almost_", does it?
>>
>
> No. I have no idea why the multiplatfrom didn't work: it booted
> just fine and then just before entering userland, it freezed :P
>
> Although I had to do some weird stuff to get it working, so it
> doesn't really matter right now. It was a fun experiment though :)
>
>>> So, I see this as preparation work for the move to mach-mvebu.
>>>
>>> Does anybody have any insights on how a proper fix would be done
>>> in the net driver?
>>
>> The proper fix would be anything that is related with providing
>> proper 'local-mac-address' property to the corresponding nodes *and*
>> properly setup some registers in eth ip, e.g. (R)GMII, basically
>> all that is usually done by u-boot.
>>
>
> The kirwood.dtsi file already contains 'local-mac-address' property,
> but the driver is not doing anything with it.

The local-mac-address property is a placeholder for the real mac
address. Also, mv643xx_eth calls of_get_mac_address which fails for
the invalid local-mac-address value of [00 00 00 00 00 00].

If you manage to setup local-mac-address in your bootloader, everything
should be fine. If we have a DT fixup that takes care of the above for
non-DT bootloaders, everything should be fine.

> I guess the only meaningful case we want to support is a nicely
> defined MAC passed in that property, and not retaining any other
> MAC set by some other way, uh?

For DT, you rely on valid addresses returned by of_get_mac_address() or
fall back to non-DT register readback, if none was passed. As most of
our kirkwood boards don't have DT support in u-boot at all, that is
what we do right now.

Drawback of the register readback is that contents get lost as soon as
you gate the clock. So the idea is to backup the contents early in the
DT to allow the clocks to be gated.

CLK_IGNORE_UNUSED is _not_ the right fix, because actually we *want*
those clocks to be gated. Either for those who not use ETH at all or
especially those boards providing only one ETH jack.

> But I haven't really looked at any of this until just now,
> so I might be completely off.

I still prefer Jason's approach and would give it a try on LAKML and
devtree ML: Backup register contents if of_get_mac_address does not
contain a valid address, and gate clocks.

Sebastian
