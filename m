From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 31 May 2013 13:33:45 +0200
Subject: [PATCH 12/39] ARM: u300: set up board power from device tree
In-Reply-To: <6621177.ZgrPQ48FXE@wuerfel>
References: <1369991954-17406-1-git-send-email-linus.walleij@stericsson.com>
 <1369991954-17406-13-git-send-email-linus.walleij@stericsson.com>
 <6621177.ZgrPQ48FXE@wuerfel>
Message-ID: <CACRpkdYXfm4xzqn2Kb0fw2_+BSSXBoNXye2zu3fpv1sPQcHO9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 31, 2013 at 12:37 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 31 May 2013 11:18:47 Linus Walleij wrote:
>> From: Linus Walleij <linus.walleij@linaro.org>
>>
>> This adds support for setting up the board power from the
>> device tree on the U300. We use a board-specific node in the
>> device tree for the S365 board and bind a regulator for the
>> board power to this node.
>>
>> Cc: Mark Brown <broonie@kernel.org>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>
> This is fairly unusual, I think I've never seen a platform driver
> registered for a board.  Is that the intended method for hogging
> a regulator?

There are no precedents AFAICT.

As you can see the previous code uses:
regulator_get(NULL, "vana15");

But that does not match with device tree: it needs some node
to tie the regulator to, i.e. a platform device. Else we leave the
system in some half-transition to DT.

The siutation is similar to our inability to use clk_get_sys()
in pure DT platforms - no node/device there either.

Mark remarked on the first iteration that:

> I would expect this to be bound based on the board name that appears in
> the device tree which (given the way this stuff mostly works) I'd expect
> to have a device node available.

This is what I'm trying to do here.

The root node which actually contains the compatible-string
for the board itself can *not* be used, as the OF platform core
code does not create a platform device for this node, and it
cannot reference anything either.

So a single board node directly in the root was the best
I could come up with, other suggestions welcome...

Yours,
Linus Walleij
