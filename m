From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 20 Feb 2013 11:51:17 +0000
Subject: [PATCH 0/8] ARM; OMAP2+: hwmod and SERIAL: Remove sysc
 handling from driver
In-Reply-To: <5124A41A.3010900@ti.com>
References: <1361354272-18089-1-git-send-email-santosh.shilimkar@ti.com>
 <20130220101401.GW17852@n2100.arm.linux.org.uk> <5124A41A.3010900@ti.com>
Message-ID: <20130220115117.GX17852@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 20, 2013 at 03:53:22PM +0530, Santosh Shilimkar wrote:
> Actually the clean-up will remove the serial driver dependency with
> idle handling. Infact DMA support need not care about idle handling
> anymore.

How is that so?  Looking back at the driver source when it did have full
DMA support shows that the handling of force idle state is different
between PIO and DMA modes.

For example, for transmit (which is the only case I had taken the time
to properly understand before the DMA code was unceremoniously ripped
out):

- On DMA transmit, the noidle setting is cleared.  runtime PM status is put.
- If we switch from DMA to PIO transmit, the noidle setting it set.
  runtime PM status is still put.
- When stopping transmit, if we aren't using DMA, idle is forced.
- In the runtime suspend, if we're using DMA and the i291 errata is in effect,
  then idle state is forced
- In the runtime resume, if we're using DMA and the i291 errata is in effect,
  idle state is cleared.

See - that information has been lost through ripping out the DMA code and
then subsequently cleaning up the code to make these things "invisible".
And now that you've lifted the forceidle/noidle functions out of the driver,
there's now even less clue about how to preserve the above behaviour.

>> Therefore, tonight I am dropping and discarding what I have left over
>> from my work on getting DMA support working with the OMAP serial driver
>> again from the nightly test builds and my git tree, and I intend no
>> further involvement with this.
>>
> Please please don't do that. We were at a point where we are unable
> to use UART has just simple console with DT without the $subject
> series. We can help you if some re-basing is needed for your
> patches because of the $subject series.

Actually, I've already dropped the TX DMA stuff out a while back when it
became (a) just too painful to keep porting the thing forward and (b) it
doesn't work properly anyway.  It's last update was back in October, and
was based on v3.6 because it already became impossible to bring it
forward across the utter buggeration of the OMAP serial driver.

(That explains why I only ever pulled forward two patches - those which
add the hooks into the serial core layer and into the OMAP serial driver
to cleanly allocate a DMA-able transmit buffer, leaving the rest of the
transmit DMA code to rot.)
