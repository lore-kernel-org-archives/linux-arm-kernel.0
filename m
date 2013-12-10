From: zonque@gmail.com (Daniel Mack)
Date: Tue, 10 Dec 2013 11:48:29 +0100
Subject: [PATCH 08/20] mmc: host: pxamci: switch over to dmaengine use
In-Reply-To: <1386671112.7152.219.camel@host5.omatika.ru>
References: <1375889649-14638-9-git-send-email-zonque>	
 <1386667657-26355-1-git-send-email-ynvich@gmail.com>
 <1386671112.7152.219.camel@host5.omatika.ru>
Message-ID: <52A6F17D.4090902@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/10/2013 11:25 AM, Sergei Ianovich wrote:
> On Tue, 2013-12-10 at 13:27 +0400, Sergei Ianovich wrote:
>> The device works in general, but it is slower than with the old DMA
>> and it reports sporadic failures like that
> 
> This took 40 minutes on my ARM device:

[...]

> The same card immediately after on my x86_64 PC, in 2 minutes:

[...]

> The same command with old DMA driver took 23 minutes. There was no DMA
> errors.

I'd say something like bonnie++ is a more deterministic test for such
things, considering that the first fsck might have fixed things that the
2nd didn't have to touch.

Apart from that, your findings are interesting. I only tested pxamci
with a Wifi card connected via SDIO, and didn't see such a big
difference in performance.

> Conclusions:
> 1. The card itself is fine.
> 
> 2. There are issues with new DMA driver. I am ready to test patches,
> without questions.
> 
> 3. There are issues with the MMC stack in my ARM device. Please drop a
> pointer where to start digging.

Alright, thanks a lot for offering help! You could start having a look
at the DMA descriptors and see whether they differ in size, compared to
the old implementation. Taking time stamps to measure the turnaround
cycle of the transfers would be another thing that you can try.

I'm not aware of any code in the mmp_pdma driver that would burn lots of
CPU cycles, but that doesn't mean there aren't any.


Daniel
