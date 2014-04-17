From: daniel@zonque.org (Daniel Mack)
Date: Thu, 17 Apr 2014 12:38:40 +0200
Subject: [PATCH v4 00/21] ARM: support for ICP DAS LP-8x4x (with dts)
In-Reply-To: <610ed273-1e54-4d44-b523-cbe0d042cf48@email.android.com>
References: <1387309071-22382-1-git-send-email-ynvich@gmail.com>
 <1397668411-27162-1-git-send-email-ynvich@gmail.com>
 <534EC04F.9010408@gmail.com>
 <610ed273-1e54-4d44-b523-cbe0d042cf48@email.android.com>
Message-ID: <534FAF30.1000101@zonque.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/16/2014 10:59 PM, Sergei Ianovich wrote:
>> Well, IIRC, I asked you to look into the MMC performance
>> regressions that you reported and see what we can do about them. I
>> currently don't have hardware to reproduce this, so I can't do it
>> myself.
> 
> I hate to point fingers, but you promissed to refresh the code on
> several occasions. It is from 3.8 tree at the moment. The regression
> may be introduced by an error in my merging of your patches. I
> published the one I tested in one piece with the results.

Ok, well. I didn't see this as a potential reason, sorry. Point taken.

I spent some hours on this topic again now, and rebased and tested my
tree to 3.15-rc1. Pushed it here:

  https://github.com/zonque/linux/tree/pxa-dma-3.15

There's some overlap to the patches you sent, which I'll comment on
directly soon.

I'm booting my board with pxa[23]xx.dtsi taken from my tree.

Please, if you find some time, test this tree and see if you still see
the performance regression.

>> My impression is that the transisiton will only be painless if the 
>> mmp_pdma driver provides comparable performance to the existing 
>> implementation. I also still think that adding hacks to the drivers
>> to manually parse the dma properties (as in #8) brings us further
>> away from a proper solution, not closer
> 
> No doubt about that. But the regression is not the only problem.
> Driver for video capture requires an extensive rewrite as well.

Jup, I totally see your point. I was hoping for more support from
someone with access to hardware to work on this, and possibly add the
missing bits to the DMA framework to make the hot-linking possible. This
didn't happen, which is unfortunate, so we in fact might need to
recondider on how to move forward here.

> The
> result is that a working pxa DT device is kept out of the tree and
> there is no supported DT devices in tree. So no proper examples for
> new devices and no drive-by improvements. All of this prevents rather
> than facilitates eventual DT migration of tha PXA platform.

Ok, so how about this:

1. We keep the old API around, along with compat wrappers for existing
drivers until someone finally finds time to at least test the patches
that I can only compile-test myself.

2. For platforms that don't need those exotic drivers for devices that
nobody seems to be interested in, use DT and the pxa-mmp-dma driver, and
make sure it performs as well as the old implementation.

3. Do not add hacks for DT-compatability of existing drivers to make
them work with the old DMA implementation (like your patch #7).

4. For new drivers, don't add any compat code for the old DMA
implementation but soley rely on the new DMA framework.



Does this sound suitable for you?


Thanks,
Daniel
