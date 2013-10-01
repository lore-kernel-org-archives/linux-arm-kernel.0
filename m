From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 01 Oct 2013 15:49:43 +0200
Subject: [PATCH 3/4] clk: kirkwood: Add CLK_IGNORE_UNUSED to ethernet
 ge0 and ge1 clocks
In-Reply-To: <20131001134213.GC2448@localhost>
References: <1380575010-8573-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1380575010-8573-4-git-send-email-ezequiel.garcia@free-electrons.com>
 <20131001004009.GK31178@titan.lakedaemon.net>
 <20131001134213.GC2448@localhost>
Message-ID: <524AD2F7.4090803@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/01/2013 03:42 PM, Ezequiel Garcia wrote:
> On Mon, Sep 30, 2013 at 08:40:09PM -0400, Jason Cooper wrote:
>> On Mon, Sep 30, 2013 at 06:03:29PM -0300, Ezequiel Garcia wrote:
>>> These clocks should never be gated, since the ethernet interfaces forget
>>> the assigned MAC address assigned if their clock source is turned off.
>>>
>>> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
>>> ---
>>> Cc: Mike Turquette <mturquette@linaro.org>
>>>
>>>   drivers/clk/mvebu/kirkwood.c | 9 +++++++--
>>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> I'm inclined to leave this as a hack in board-dt.c...  At some point we
>> are going to move kirkwood over to mach-mvebu/, and there will be eyes
>> on the code.  There's less chance of 're-discovering' this for cleanup
>> if it's in the clock driver, looking all proper and such.  Even with the
>> clear comment.
>>
>
> Hm.. Really? I honestly think this change is a far cleaner way of
> dealing with the problem.

Actually I prefer to leave the workaround there, too.

> The motivation for these 4 patches, came from an attempt of booting a
> multiplatform kernel Kirkwood, which _almost_ booted fine :P

But the workaround doesn't affect "_almost_", does it?

> So, I see this as preparation work for the move to mach-mvebu.
>
> Does anybody have any insights on how a proper fix would be done
> in the net driver?

The proper fix would be anything that is related with providing
proper 'local-mac-address' property to the corresponding nodes *and*
properly setup some registers in eth ip, e.g. (R)GMII, basically
all that is usually done by u-boot.

Currently, there is no support for PHY configuration at all but
if your board uses reset defaults, IIRC it should work except for
the missing MAC address. There is one fix for kirkwood already
that enables proper clock.

Again, IIRC, I tried to push a fix similar to Jason's but used
of_set_property. Jason's looks way more sane and we should give
it a try.

Sebastian
