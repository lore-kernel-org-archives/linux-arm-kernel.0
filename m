From: vincent.siles@provenrun.com (Vincent Siles)
Date: Thu, 8 Sep 2016 11:50:05 +0200
Subject: lsl / lsr possible confusion in v7_flush_dcache_all
In-Reply-To: <20160908093801.GB1493@arm.com>
References: <20160908091520.GE14909@vsiles-Desktop>
 <20160908093801.GB1493@arm.com>
Message-ID: <20160908095004.GF14909@vsiles-Desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Oh, right. I missed that !

Thank you for the help.
Best,
Vincent

On 08-09-16 10:38:01, Will Deacon wrote:
> On Thu, Sep 08, 2016 at 11:15:20AM +0200, Vincent Siles wrote:
> > While reading the v7_flush_dcache_all (arch/arm/mm/cache-v7.S), I
> > stumbled upon this line:
> > 
> > # r10 is the current cache level
> > 127: add    r2, r10, r10, lsr #1	    @ work out 3x current cache level
> > 
> > If we want r2 to be 3 * r10, we should compute r10 + (r10 << 1), which
> > is lsl, not lsr.
> > 
> > I check for a recent kernel, the issue seems to still be here:
> > repo:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > revision:   d71f058617564750261b673ea9b3352382b9cde4
> 
> This code is take pretty much verbatim from the ARM ARM and, despite
> being fairly obfuscated, does what it says on the tin. r10 is incremented
> by 2 each time round the loop, so this is basically doing 2i + (2i / 2).
> 
> Will
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160908/0b5292a4/attachment.sig>
