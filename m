From: dianders@chromium.org (Doug Anderson)
Date: Thu, 5 May 2016 15:56:45 -0700
Subject: [PATCH v7 4/9] i2c: rk3x: Move setting STATE_START and add
 STATE_SETUP
In-Reply-To: <1462371194-5809-5-git-send-email-david.wu@rock-chips.com>
References: <1462371194-5809-1-git-send-email-david.wu@rock-chips.com>
 <1462371194-5809-5-git-send-email-david.wu@rock-chips.com>
Message-ID: <CAD=FV=WVKpJJbqc=UYbeObDurjte0iQOzvLL++i=wM9=TBeCDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

David,

On Wed, May 4, 2016 at 7:13 AM, David Wu <david.wu@rock-chips.com> wrote:
> Signed-off-by: David Wu <david.wu@rock-chips.com>
> ---
> Change in v7:
> - none
>
>  drivers/i2c/busses/i2c-rk3x.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Probably this change could be dropped now.  Switching the location of
setting START_START was much more important when you were supporting
HIGH SPEED mode.  I don't think we need it anymore, right?

...if we want to keep this change, I'd say:

1. Add a description, like maybe:

To help with debugging add a STATE_SETUP between STATE_IDLE and
STATE_START to make it more obvious that we're not actually idle but we
also haven't initiated the start bit.  This change is not expected to
have any impact but it does delay the changing of state to STATE_START.
If previously we were getting an erroneous interrupt before we actually
sent the start bit we'll now be treating that differently.  The new
behavior (catching the erroneous interrupt) should be better.

2. Change "i2c->state = STATE_SETUP" to the _start_ of
rk3x_i2c_setup().  That would have a better chance of catching a
spurious interrupt.

3. Add an error check at the start of rk3x_i2c_irq() similar to the
check for STATE_IDLE (or use the same check and modify the printk).
Specifically the justification for adding STATE_SETUP is to help with
debugging (catch interrupts that were unexpected and print more info
about our state), so we should make it useful for this.


-Doug
