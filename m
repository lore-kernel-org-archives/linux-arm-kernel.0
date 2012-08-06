From: matt@genesi-usa.com (Matt Sealey)
Date: Mon, 6 Aug 2012 13:09:26 -0500
Subject: [PATCH 4/9] ASoC: imx: Don't use {en,dis}able_fiq() calls
In-Reply-To: <20120806154951.GQ16861@opensource.wolfsonmicro.com>
References: <20120805230238.GA1663@lizard>
 <1344207819-3415-4-git-send-email-anton.vorontsov@linaro.org>
 <CAKGA1bkiHj=zMJXSzoGp3fpLS3POnFXSV5y7sYYFAikqoUT9tQ@mail.gmail.com>
 <20120806154951.GQ16861@opensource.wolfsonmicro.com>
Message-ID: <CAKGA1b=_AOub_pEJJGBTb6Y7wLZaSYKQjFTyMVFSr_=9VX4wpg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 6, 2012 at 10:49 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Mon, Aug 06, 2012 at 10:19:50AM -0500, Matt Sealey wrote:
>
>> it's not compiled in unless absolutely necessary. However, there was a
>> rumble that this code may disappear or be reworked in the future
>> making this also quite redundant. Since it's not in the
>
> There's no point in the FIQ driver if the DMA drivers are supported.

http://patchwork.ozlabs.org/patch/128853/

Russell's sage advise; "It's worth pointing out that people end up
using FIQs for certain things
because the hardware requires you to do it.  So if a platform is using
them, they're probably not
doing it out of choice, but are doing it because it's a baseline
requirement to get something working."

I don't recall Sascha's response to this, I thought it was on the ML
but it may have been in private,
but something is broken on the MX27/28 SSI FIFO which means FIQ is the
only way to get reliable
audio since the DMA unit cannot get accurate alarms (this seems a
common bug in Freescale
processors :) - I'll let him elaborate since I've never even seen an
MX28 let alone booted one, and
our MX27 board never got tested without the FIQ code if I recall correctly.

So that needs to stay, the issue here is why did nobody catch
ssi-fiq.S breaking in testing MX51
Babbage and building a Thumb2 kernel, for example? Why did nobody
notice it was building when
configuring for MX3/5/6 boards (which do actually have working SSI and
DMA, as you assume, and
do not need this code, nor build the imx-pcm-dma-fiq part of the
driver anyway)? I'm willing to fix all
of the above, but if there's an obvious deficiency in testing at some
point we need to fix that too..

Of course if Sascha says the fiq dma hack can disappear forever that's
absolutely fine, I'm also
willing to be the one to delete it... :)

-- 
Matt Sealey <matt@genesi-usa.com>
Product Development Analyst, Genesi USA, Inc.
