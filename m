From: pwaechtler@mac.com (Peter Waechtler)
Date: Tue, 26 Apr 2011 22:38:02 +0200
Subject: MMC and reliable write - was: since when does ARM map the kernel
	memory in sections?
In-Reply-To: <20110426190719.GA5832@shareable.org>
References: <201104122052.17453.pwaechtler@mac.com>
	<201104262100.42670.pwaechtler@mac.com>
	<20110426190719.GA5832@shareable.org>
Message-ID: <201104262238.02979.pwaechtler@mac.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 26. April 2011, 21:07:19 schrieb Jamie Lokier:
> Peter Waechtler wrote:
> > Am Dienstag, 26. April 2011, 12:33:29 schrieb Per Forlin:
> > > On 23 April 2011 11:23, Linus Walleij <linus.walleij@linaro.org> wrote:
> > > > 2011/4/22 Pavel Machek <pavel@ucw.cz>:
> > > >> Plus, I was told new MMC standard has "write reliable" option...
> > > > 
> > > > I think Per F?rlin looked into reliable write. The latest eMMC cards
> > > > has this, but OTOMH it was too darn slow to be used on current
> > > > chips/"cards".
> > > > 
> > > > Per, Sebastian: any details?
> > > 
> > > I had plans to add reliable writes and do benchmarking but I never got
> > > to it. Right now I have no plans to pick it up.
> > > 
> > > > Yours,
> > > > Linus Walleij
> > > 
> > > Regards,
> > > Per
> > 
> > As far as I understood the spec, reliable write only makes statements
> > like either the old data is still intact - or the new data was written
> > (completely).
> 
> Hmm, if that's a correct understanding, it's not very useful for
> fsync() or journal barriers (unless the spec implies something
> barrier-like), and it would be nice if there were guarantees about the
> _other_ data (that isn't being written at all) not getting corrupted
> as a side effect.
> 
> -- Jamie

well, I cannot interpret this already, but it reads scary ;)

JEDEC Standard No. 84-A441
Page 56


Reliable Write: Multiple block write with pre-defined block count and 
Reliable Write parameters. This transaction is similar to the basic pre-
defined multiple-block write (defined in previous bullet) with the
following exceptions. The old data pointed to by a logical address must remain 
unchanged until the new data written to same logical address has been 
successfully programmed. This is to ensure that the target address 
updated by the reliable write transaction never contains undefined data. 

Data must remain valid even if a sudden power loss occurs during the 
programming.

There are two versions of reliable write: legacy implementation and the 
enhance implementation. The type of reliable write supported by the device is 
indicated by the EN_REL_WR bit in the
WR_REL_PARAM extended CSD register.
 For the case of EN_REL_WR = 0 :


More fun on page 147ff:

? WR_REL_SET [167]
The write reliability settings register indicates the reliability setting for 
each of the user and general
area partitions in the device. The contents of this register are read only if 
the HS_CTRL_REL is 0 in
the WR_REL_PARAM extended CSD register. The default value of these bits is not 
specified and is
determined by the device.


it goes on with:

Bit[4]: WR_DATA_REL_4
0x0: In general purpose partition 4, the write operation has been optimized 
for performance and
existing data in the partition could be at risk if a power failure occurs.
0x1: In general purpose partition 4, the device protects previously written 
data if power failure occurs during a write operation.
