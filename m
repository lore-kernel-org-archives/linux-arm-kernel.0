From: eric@eukrea.com (Eric =?ISO-8859-1?B?QuluYXJk?=)
Date: Tue, 27 Mar 2012 11:40:48 +0200
Subject: [MX25][MMC] mmc esdhc failure in 3.3
In-Reply-To: <7f2ae9e3800848e140461a0506808fb4@mail.fqingenieria.es>
References: <5e57eb999780335721212bb8d411406f@mail.fqingenieria.es>
 <20120312132423.GC2459@pengutronix.de>
 <9018463dfcd3c9e9a311aeed42b758bf@mail.fqingenieria.es>
 <0E83723C55F66F43A6041464FE31119D099A34@039-SN2MPN1-011.039d.mgd.msft.net>
 <a06e68c3687c7390e15950bc20831fd4@mail.fqingenieria.es>
 <85b807b77d73328485781d6fa1568e46@mail.fqingenieria.es>
 <20120327101259.73525f9d@eb-e6520>
 <ac05d6e5c1ce4bf9cfc5c28d235f866f@mail.fqingenieria.es>
 <20120327090148.GB6790@pengutronix.de>
 <20120327110615.3bfaf969@eb-e6520>
 <7f2ae9e3800848e140461a0506808fb4@mail.fqingenieria.es>
Message-ID: <20120327114048.6af2e178@eb-e6520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Le Tue, 27 Mar 2012 11:33:57 +0200,
joancarles <joancarles@fqingenieria.es> a ?crit :
> >> Interesting question is now why it worked on your older kernel? The 
> >> code
> >> around BROKEN_TIMEOUT is there for much longer, I'd think.
> >>
> > not in fact it seems to have been broken from a long time and I think
> > I'm responsible of that in 37865fe91582582a6f6c00652f6a2b1ff71f8a78
> > "mmc: sdhci-esdhc-imx: fix timeout on i.MX's sdhc"
> > because unlike the i.MX35 it seems that the i.MX25 manages to read
> > properly the partition table even without the timeout quirk and it
> > seems that I didn't do more extensive tests for this patch.
> 
> Might be unrelated, however I have been keeping my eyes on the fix of 
> ENGcm07207 quirk introduced with 16a790bcc. According to the 
> IMX25CE.pdf, to abort data transfers on the AHB, software can reset the 
> eSDHC by writing 1 to SYSCTL[24] (RSTA), which currently is not done 
> with SDHCI_QUIRK_NO_MULTIBLOCK. It sets the max_blk_count to 1 instead 
> of 65535. Not sure if this is also limiting the speed.
> 
I tried to increase max_blk_count and it breaks after a few tests.
Using an oscilloscope it seems we have a big latency between each
transfer which could explain the low throughput, I didn't have the
time to look deeper at this problem.

> I have tried putting the SD card into an ALL-in-One reader via USB and 
> I get 6MB/s read and 15MB/s write performance. Since I didn't know the 
> exact class of the card, this reassures me that there is nothing 
> substantially wrong with the card per se.
> 
> So, how can we find a solution to this speed issue? Also, do you plan 
> on submitting your patch to revert the timeout quirk for MX25?
> 
yes, I'm writing a proper commit message and will send it in a few
minutes.

Eric
