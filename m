From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 05 Jul 2013 12:36:11 -0600
Subject: Appended DTB files for multi-machine kernels
In-Reply-To: <51D5A938.30607@gmail.com>
References: <51D5A938.30607@gmail.com>
Message-ID: <51D7121B.50704@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/04/2013 10:56 AM, Daniel Mack wrote:
...
> The built-in support for attaching a DTB to the zImage does not suffice
> here, because we have one image for all models, and also, we couldn't do
> a 'per-board-revision' selection that way either.
...
> As a solution, I'm thinking of a small framework that could for example
> work as follows.
> 
> a) A small mechanism allows storing multiple DTB binary files inside the
> kernel binary at compile time...
...
> c) Allow users to open-code the DTB lookup depending on whatever kind of
> runtime information (be it the board_revision or anything else).

The problem with (c) is that in general it probably requires a lot of
infra-structure to be working to implement it. On Tegra, the board
revision is in an EEPROM attached to an I2C bus. You'd need to have
parsed DT and started instantiating devices already before you could
access the ID EEPROM to know which board revision you're running on.
That's a bit of a chicked-and-egg problem. Even with a much simpler
scheme such as board ID encoded into GPIOs, you'll still likely run into
similar problems; pinmux and GPIO controller drivers are needed just to
read the GPIOs, which then requires DT to instantiate those drivers.

So, the suggestion of Nicolas's that you mentioned does solve that
rather neatly.
