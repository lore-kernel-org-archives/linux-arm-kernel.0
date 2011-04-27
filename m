From: jamie@shareable.org (Jamie Lokier)
Date: Wed, 27 Apr 2011 14:19:05 +0100
Subject: since when does ARM map the kernel memory in sections?
In-Reply-To: <BANLkTikcsJxvJAPMigvXXzbKdXsDEdeTXA@mail.gmail.com>
References: <BANLkTin0NMo7ZDrnTmBghYeRC9wxJu7zrw@mail.gmail.com>
	<20110412203303.GA16019@shareable.org>
	<20110418135243.GB1479@ucw.cz>
	<20110418170752.GQ16019@shareable.org>
	<20110422154344.GA7526@ucw.cz>
	<BANLkTimZZEr8fqXbuBjpYxF1quBFv7Oihg@mail.gmail.com>
	<BANLkTikNqO_xGgsUrZ2fid4ZmA8P6AoHLA@mail.gmail.com>
	<BANLkTi=Zn+kDfErZN6tm6yxHTt4v6o7XNw@mail.gmail.com>
	<20110426225818.GD5832@shareable.org>
	<BANLkTikcsJxvJAPMigvXXzbKdXsDEdeTXA@mail.gmail.com>
Message-ID: <20110427131905.GF5832@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrei Warkentin wrote:
> The connection I made between FUA and reliable writes, is that you
> were guaranteed "physical presence" of the written data on
> storage medium as long as the transaction went through successfully. I
> can see where I assumed more than I should have.... If that's not the
> correct interpretation I will change it.

Well it would seem like a reasonable thing to *want* from the storage
medium. :-) Maybe that's intended but not stated clearly in that
excerpted bit of the MMC spec.

With SATA, you can do FUA, or you can write non-FUA and to a FLUSH
later to get the same level of durability (I presume it's the same
after that) -- or you can turn off the write cache (which is ok with
some disks/interfaces and wrecks the performance of others.)

The fact that ordinary writes can be commited too, and you can wait
for that, is quite important in practice.  It's the basis for all
reliable journalling and efficiently log-structured storage.

> REQ_META doesn't sound like the right candidate, because it's
> enforcing policy. Should there be a REQ_ATOMIC request type?

Imho, only if there's a use for it.  If this is about whole partitions
picking up random data corruption, versus not doing so, then I suggest
the choice of "Reliable Write" vs. "Unreliable Write" be a mount
option or hdparm-style block device option.

If there are tighter guarantees, such as "Unreliable Write" corruption
being limited to the written naturally aligned 1MB blocks (say), and
it was genuinely faster, that would be really valuable information to
pass up to filesystems - and to userspace - as you can structure
reliability around that in lots of ways.

-- Jamie
