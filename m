From: computersforpeace@gmail.com (Brian Norris)
Date: Sun, 21 Oct 2012 00:21:18 -0700
Subject: [PATCH 07/11] fsmc/nand: Provide contiguous buffers to dma
In-Reply-To: <1350371511.5769.43.camel@sauron.fi.intel.com>
References: <cover.1349778820.git.vipin.kumar@st.com>
 <2b88c853b3691338fae037f569917fc300cd6032.1349778821.git.vipin.kumar@st.com>
 <CACRpkdb6ArMUQ6MAsue+Gh15UfOUrWNAc9wrxd6awc0BTwOGiw@mail.gmail.com>
 <CAOh2x=ksMr7VRCnpF-rK+Mesg1p4Td++SQ-t=ShrguRRVWSSSQ@mail.gmail.com>
 <CACRpkdYjA8QUh4HqvE1rsnXcGA4WafTkMq_wLNJ__gXEnEYrow@mail.gmail.com>
 <507794B6.2000107@st.com>
 <1350307104.4115.23.camel@sauron.fi.intel.com>
 <CAN8TOE-7d=YUSYsHFw9X5vnz8cpSJYv5uZfvBpDyhg+-F_LDiQ@mail.gmail.com>
 <1350371511.5769.43.camel@sauron.fi.intel.com>
Message-ID: <CAN8TOE9tDbW5QoRnY0wAOPJZqXEO=kdtVkS=BHYAUjebrPq=GA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 16, 2012 at 12:11 AM, Artem Bityutskiy <dedekind1@gmail.com> wrote:
> On Mon, 2012-10-15 at 09:27 -0700, Brian Norris wrote:
>> See the commit description for the following commit in mtd-utils.git:
>>
>>     commit 71c76e74661492b4f68f670514866cfc85f47089
>>     libmtd: fix mtd_write() issues for large data-only writes
>
> Well, this is another work-around.

Yeah, I know it was a workaround. It's another issue of balancing time
and the "best" solution. Of course, the solutions actually don't seem
that difficult now, so I probably should have just fixed the ioctl()
in the first place... But I was simply pointing this out as evidence
of a real memory-fragmentation issue.

> The better way to fix this would be
> to change kernel's 'mtdchar_write_ioctl()' to be iterative and avoid
> calling 'memdup_user(len)' for arbitrary 'len' passed from user-space.

That's one way, but it would require specifying some arbitrary
iteration length, right? Like some multiple of writesize?

Instead, how about modelling it more closely after mtdchar_write(),
using mtd_kmalloc_up_to(), then iteratively call copy_from_user()?

> So I thought about something like introducing an mtd_alloc() which
> would:
>    a. Try doing CMA allocation: dma_alloc_from_contiguous()
>    b. If it fails, use kmalloc().
...
> If both fail - bad luck. Go look at the code and switch to S-G lists
> instead of allocating contiguous regions. As I said, in many places it
> is easy to do, and there are few places when you would need to spend a
> bit more time.
>
> How does this sound to you?

It sounds OK, but that depends on the success rate of
dma_alloc_from_contiguous(). I'm not familiar with it.

Brian
