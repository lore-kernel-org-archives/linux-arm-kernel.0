From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 9 Oct 2010 01:10:52 +0100
Subject: [PATCH] ARM: allow, but warn, when issuing ioremap() on RAM
In-Reply-To: <20101008234448.GD10975@n2100.arm.linux.org.uk>
References: <1286444662-16843-1-git-send-email-felipe.contreras@gmail.com>
	<20101007192245.GC26435@n2100.arm.linux.org.uk>
	<AANLkTikQKY7pOobD+==uT5Cy0poT=O5wDMKtbVyJVNbO@mail.gmail.com>
	<20101008175308.GA10975@n2100.arm.linux.org.uk>
	<AANLkTi=ERZjVDS=Q7aw1zA23KF68irUP3vvKLZw5meBU@mail.gmail.com>
	<20101008230451.GB10975@n2100.arm.linux.org.uk>
	<20101008232539.GA28697@kroah.com>
	<20101008234448.GD10975@n2100.arm.linux.org.uk>
Message-ID: <20101009001052.GA14675@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 09, 2010 at 12:44:48AM +0100, Russell King - ARM Linux wrote:
> So, as I say, there's been six months.  It was discussed.  But still
> we find that the drivers haven't been touched and now we're complaining
> that drivers are breaking.
> 
> If it hadn't been discussed, if solutions hadn't been proposed, then
> yes, it would be right to revert it out-right.  But that's not what
> happened.
> 
> If we have to have another three months (or so), this time with a warning,
> then so be it, but let's make it plainly clear that it _will_ _definitely_
> be changing, and that drivers _will_ break unless they are fixed.
> 
> Unfortunately, what I fear is that nothing will happen because people
> want the ioremap-on-system-RAM to just work, and then we'll hit this
> exact same issue again in three months time.

There is another solution to this which will be architecturally compliant
- as we can detect system ram ioremaps, we can force them to have the
same memory type, sharability and cache attributes as the existing
mappings rather than merely failing them.  But this is not what drivers
want.

The reason they play the ioremap-system-RAM game is to get around the
DMA coherence issues - rather than using the DMA API, because that
suffers from being incapable of dealing with large contiguous chunks
of memory.

Anyway, to fill other observers in, the issue here is:
- ARMv6 and above have weak memory ordering models.

- ARMv6 and above can speculatively prefetch from any region which has
  a 'normal memory' type.  As further hardware revisions are released,
  the speculative prefetch becomes progressively more aggressive.

- multiple mappings of the same physical address region with differing
  memory type (strongly ordered, device, normal memory) becomes
  unpredictable.  The memory type partly defines which reads/writes are
  allowed to bypass other reads/writes.  Unpredictable here means that
  there is no guarantee whether the access performed via the mapping
  you've created will be done as per the memory type specified in that
  mapping.

- multiple mappings of the same physical address region with differing
  sharability attributes have been observed to cause systems to crash/hang,
  but fall under the 'unpredictable' behaviour - which basically means
  you don't know if the coherence hardware will be involved in the
  access.

- multiple mappings of the same physical address region with differing
  cache attributes is also unpredictable - you can't guarantee whether
  the access will be performed using the cache attributes through the
  mapping you're performing the access through.

In the case of system memory, this is normally mapped as 'normal memory'
with write-back cache.  On uniprocessor systems, this is mapped as
non-shared memory.

ioremap() creates 'device' type mappings, which are marked as shared
(some devices, the shared-ness is used as another address bit!)

So, permitting ioremap of system RAM violates all three - which means
there is no guarantee of ordering, sharedness or cache behaviour via
mappings which alias with differing attributes.
