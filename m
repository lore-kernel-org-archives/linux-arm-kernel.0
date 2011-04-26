From: jamie@shareable.org (Jamie Lokier)
Date: Tue, 26 Apr 2011 23:45:47 +0100
Subject: MMC and reliable write - was: since when does ARM map the kernel
	memory in sections?
In-Reply-To: <201104262238.02979.pwaechtler@mac.com>
References: <201104122052.17453.pwaechtler@mac.com>
	<201104262100.42670.pwaechtler@mac.com>
	<20110426190719.GA5832@shareable.org>
	<201104262238.02979.pwaechtler@mac.com>
Message-ID: <20110426224546.GC5832@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter Waechtler wrote:
> JEDEC Standard No. 84-A441
> Page 56
> 
> 
> Reliable Write: Multiple block write with pre-defined block count and 
> Reliable Write parameters. This transaction is similar to the basic pre-
> defined multiple-block write (defined in previous bullet) with the
> following exceptions. The old data pointed to by a logical address must remain 
> unchanged until the new data written to same logical address has been 
> successfully programmed. This is to ensure that the target address 
> updated by the reliable write transaction never contains undefined data. 
> 
> Data must remain valid even if a sudden power loss occurs during the 
> programming.
> 
> There are two versions of reliable write: legacy implementation and the 
> enhance implementation. The type of reliable write supported by the device is 
> indicated by the EN_REL_WR bit in the
> WR_REL_PARAM extended CSD register.
>  For the case of EN_REL_WR = 0 :
> 
> 
> More fun on page 147ff:
> 
> ? WR_REL_SET [167]
> The write reliability settings register indicates the reliability setting for 
> each of the user and general
> area partitions in the device. The contents of this register are read only if 
> the HS_CTRL_REL is 0 in
> the WR_REL_PARAM extended CSD register. The default value of these bits is not 
> specified and is
> determined by the device.
> 
> 
> it goes on with:
> 
> Bit[4]: WR_DATA_REL_4
> 0x0: In general purpose partition 4, the write operation has been optimized 
> for performance and existing data in the partition could be at risk if a power
> failure occurs.
>
> 0x1: In general purpose partition 4, the device protects previously written 
> data if power failure occurs during a write operation.

Hmm...  It all hinges on whether "previously written data" refers just
to the region being overwritten, or to all the other data in the
partition?

If MMC writes are specified to only affect the data being written with
a Write command, and to have stably committed the data when Write
returns, then "Reliable Write" just means "atomic", and filesystems
and databases don't actually need that.

Hard disks don't guarantee that, and it's not a problem.  Filesystems
and databases need barriers and/or durable (stable) commits, and for
writes in one area not to corrupt data in a different area.

*That's* a problem with other flash devices (and possibly some RAIDs):
Writes to one area can corrupt data in sectors that aren't being
written to, over quite a large distance.

I can't tell from the above specification excerpt (by itself) what is
being guaranteed; it seems ambiguous, but maybe there's a clearer
definition elsewhere.

It is conceivable that checksums and metadata could be stored into a
"reliable" partition and some kinds of file data into an "unreliable"
partition, where filesystem integrity is important and nobody cares
about the actual data! :-)

-- Jamie
