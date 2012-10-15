From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Mon, 15 Oct 2012 16:18:24 +0300
Subject: [PATCH 07/11] fsmc/nand: Provide contiguous buffers to dma
In-Reply-To: <507794B6.2000107@st.com>
References: <cover.1349778820.git.vipin.kumar@st.com>
 <2b88c853b3691338fae037f569917fc300cd6032.1349778821.git.vipin.kumar@st.com>
 <CACRpkdb6ArMUQ6MAsue+Gh15UfOUrWNAc9wrxd6awc0BTwOGiw@mail.gmail.com>
 <CAOh2x=ksMr7VRCnpF-rK+Mesg1p4Td++SQ-t=ShrguRRVWSSSQ@mail.gmail.com>
 <CACRpkdYjA8QUh4HqvE1rsnXcGA4WafTkMq_wLNJ__gXEnEYrow@mail.gmail.com>
 <507794B6.2000107@st.com>
Message-ID: <1350307104.4115.23.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-10-12 at 09:25 +0530, Vipin Kumar wrote:
> The buffers provided to the driver are actually user buffers. The reason 
> I say that is because the generic nand test modules eg 
> drivers/mtd/nand/mtd_stresstest.c calls mtd->_read with a user buffer as 
> an argument

I am not sure what does "user" buffers mean, but they are vmalloced()
buffer, not kmalloc()'ed, so they are not physically contiguous.

> This same buffer directly trickles down to the driver
> 
> Artem, should we clearly cast this buffer as a user pointer instead of 
> just a 'uint8_t *'.

They are not "_user", they are really kernel buffers. Or what do you
mean, which exactly type do you suggest?

This stuff is something many people are bringing up for many years
already. Drivers that do DMA do not cope with vmalloc()ed memory well,
and we grew a number of hacks in several drives. I mean, hacks like the
one you are introducing to your driver.

I'd solve the problem by changing the in-kernel mtd users to use
physically-contiguous memory instead. The following are the users I can
think of:

UBI, UBIFS, JFFS2, mtdtests and probably mtdswap.

They use vmalloc() when they need to read/write entire eraseblock, which
is usually 128KiB or 256KiB, and kmalloc() that much may fail if the
memory is fragmented. 

In many cases, it is easy to read/write in smaller chunk, but several
times. E.g., mtdtests could be changed.

In some cases, it is not easy, though.

First thing which comes to mind is that in modern kernels memory
fragmentation is not that big issue as it used to be. So may be
kmalloc() the memory is not that bad nowadays? We have page migration,
memory compaction, etc?

I'd really prefer to just switch to kmalloc() everywhere instead of
adding hacks like this to the drivers. Then if this is a problem for
someone, he can fix it by either switching to smaller buffers (possible
in many places), or by improving memory fragmentation issues on his
system, or by just using CMA.

We can even have an mtd-wide funcion which will try kmalloc(), and if
that fails, fall-back to CMA.


Then we can add a guard check to all mtd function which accept a buffer
and WARN() if it not physically contiguous.

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121015/738aa0ca/attachment-0001.sig>
