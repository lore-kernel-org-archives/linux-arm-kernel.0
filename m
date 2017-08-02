From: slash.tmp@free.fr (Mason)
Date: Wed, 2 Aug 2017 13:54:29 +0200
Subject: [RFC PATCH v2 1/2] net: ethernet: nb8800: Reset HW block in
 ndo_open
In-Reply-To: <yw1xbmnyi660.fsf@mansr.com>
References: <33d1ab47-6098-5e3f-8a3c-f72626d07113@free.fr>
 <d817da35-f977-5985-4aae-73617004fac3@free.fr> <yw1xbmnyi660.fsf@mansr.com>
Message-ID: <ef36cd4a-b1b5-7505-34d1-250c736d6731@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/08/2017 13:02, M?ns Rullg?rd wrote:

> Mason wrote:
> 
>> Move all HW initializations to nb8800_init.
>> This provides the basis for suspend/resume support.
>> ---
>>  drivers/net/ethernet/aurora/nb8800.c | 50 +++++++++++++++++-------------------
>>  drivers/net/ethernet/aurora/nb8800.h |  1 +
>>  2 files changed, 25 insertions(+), 26 deletions(-)
> 
> You're still not doing anything to preserve flow control and multicast
> configuration, and those are probably not the only ones.

I did handle flow control (as far as I can tell).
The current settings are stored in:
priv->pause_aneg, priv->pause_rx, priv->pause_tx
and nb8800_pause_config() is called from nb8800_link_reconfigure()

I'll take a closer look at multicast settings.

> Worse, you're now never tearing down dma properly, which means the
> hardware can be left with active pointers to memory no longer allocated
> to it.

You're making it sound like there is a risk those pointers
might be used somehow. There is no such risk AFAICT.
The PHY is disconnected, NAPI is stopped, RX and TX have
been disabled, and the ISR has been removed.

I have considered putting the HW block in reset (clock gated)
at the end of nb8800_stop() to save power, which would make
the issue you point out moot.

The reason I removed nb8800_dma_stop() in nb8800_stop()
is because it hangs when called from nb8800_suspend().
(It requires interrupts to make progress, and interrupts
seem to be disabled when nb8800_suspend() is called.)


Broader question for netdev:

I've been wondering about costly close operations.
If closing a device is complex (in terms of code), at which
point does it become simpler to just reset the block, and
avoid writing/maintaining/debugging the code performing
said close operation?

> Finally, you still haven't explained why the hw needs to be reset in
> ndo_open().  Whatever is causing your lockup can almost certainly be
> triggered in some other way too.  I will not accept this side-stepping
> of the issue.

(I was not aware that you were the final authority on which
patches are accepted upstream.)

FWIW, I have placed a formal request for the HW dev to
investigate, as I could not reproduce on tango4, despite
several days wasted on this issue.

In the mean time, the driver in its current form does not
support suspend/resume. How would *you* implement it?
(IMO, my way is great in its simplicity and code reuse.)

Regards.
