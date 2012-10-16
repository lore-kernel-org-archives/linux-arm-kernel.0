From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Tue, 16 Oct 2012 10:11:51 +0300
Subject: [PATCH 07/11] fsmc/nand: Provide contiguous buffers to dma
In-Reply-To: <CAN8TOE-7d=YUSYsHFw9X5vnz8cpSJYv5uZfvBpDyhg+-F_LDiQ@mail.gmail.com>
References: <cover.1349778820.git.vipin.kumar@st.com>
 <2b88c853b3691338fae037f569917fc300cd6032.1349778821.git.vipin.kumar@st.com>
 <CACRpkdb6ArMUQ6MAsue+Gh15UfOUrWNAc9wrxd6awc0BTwOGiw@mail.gmail.com>
 <CAOh2x=ksMr7VRCnpF-rK+Mesg1p4Td++SQ-t=ShrguRRVWSSSQ@mail.gmail.com>
 <CACRpkdYjA8QUh4HqvE1rsnXcGA4WafTkMq_wLNJ__gXEnEYrow@mail.gmail.com>
 <507794B6.2000107@st.com> <1350307104.4115.23.camel@sauron.fi.intel.com>
 <CAN8TOE-7d=YUSYsHFw9X5vnz8cpSJYv5uZfvBpDyhg+-F_LDiQ@mail.gmail.com>
Message-ID: <1350371511.5769.43.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-10-15 at 09:27 -0700, Brian Norris wrote:
> > I'd really prefer to just switch to kmalloc() everywhere instead of
> > adding hacks like this to the drivers. Then if this is a problem for
> > someone, he can fix it by either switching to smaller buffers (possible
> > in many places), or by improving memory fragmentation issues on his
> > system, or by just using CMA.
> 
> I think I can suggest that this is already a problem on real systems.
> In bringing up a board on v3.3 kernel, I experienced a kernel memory
> allocation error when trying to memdup_user() in eraseblock-size
> regions. I believe I would experience more of these if all
> eraseblock-sized buffers were kmalloc()'d.
> 
> See the commit description for the following commit in mtd-utils.git:
> 
>     commit 71c76e74661492b4f68f670514866cfc85f47089
>     libmtd: fix mtd_write() issues for large data-only writes

Well, this is another work-around. The better way to fix this would be
to change kernel's 'mtdchar_write_ioctl()' to be iterative and avoid
calling 'memdup_user(len)' for arbitrary 'len' passed from user-space.

> I would prefer not building a solution that hopes kmalloc() can get a
> large contiguous buffer (remember, eraseblock sizes come as large as
> 2MB these days). A real solution like CMA or scatter-gather seems like
> a better idea.

Me too. But this does not happen. People bring this up for years. Of
course it is easier to hack drivers, and very understandable. So what
I would like to do is somehow force people to fix this issue.

So I thought about something like introducing an mtd_alloc() which
would:
   a. Try doing CMA allocation: dma_alloc_from_contiguous()
   b. If it fails, use kmalloc().

This function would probably need a cookie which it returns and which
the mtd_free() function would use to call either kfree() or
dma_release_from_contiguous()...

If both fail - bad luck. Go look at the code and switch to S-G lists
instead of allocating contiguous regions. As I said, in many places it
is easy to do, and there are few places when you would need to spend a
bit more time.

How does this sound to you?

-- 
Best Regards,
Artem Bityutskiy


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121016/04d3c8f5/attachment.sig>
