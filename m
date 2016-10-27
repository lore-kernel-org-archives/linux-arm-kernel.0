From: will.deacon@arm.com (Will Deacon)
Date: Thu, 27 Oct 2016 17:01:36 +0100
Subject: [PATCH] arm64: mm: Fix memmap to be initialized for the entire
 section
In-Reply-To: <20161017185801.GT25086@rric.localdomain>
References: <1475747527-32387-1-git-send-email-rrichter@cavium.com>
 <CAKv+Gu-oYzSn_eeqaX3QVFeQjBGkaX-Wh7+oPcQFcXv7J6GOFQ@mail.gmail.com>
 <20161006161114.GH22012@rric.localdomain>
 <20161017185801.GT25086@rric.localdomain>
Message-ID: <20161027160136.GD24290@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robert,

On Mon, Oct 17, 2016 at 08:58:01PM +0200, Robert Richter wrote:
> Mark, Will, any opinion here?

Having looking at this, I'm inclined to agree with you; pfn_valid() is
all about whether the underlying mem_map (struct page *) entry exists,
not about whether the page is mappable or not.

That said, setting the zone for pages representing NOMAP memory feels
like a slippery slope to losing information about them being NOMAP in
the first place and the whole problem getting out-of-hand. Whilst I'm
happy for pfn_valid() to return true (in the sense that we're within
bounds of mem_map etc), I'm less happy that we're also saying that the
struct page contains useful information, such as the zone and the node
information, which is then subsequently used by the NUMA code.

On top of that, pfn_valid is used in other places as a coarse "is this
memory?" check, and will cause things like ioremap to fail whereas it
wouldn't at the moment. It feels to me like NOMAP memory is a new type
of memory where there *is* a struct page, but it shouldn't be used for
anything. I don't think pfn_valid can describe that, given the way it's
currently used, and flipping the logic is just likely to move the problem
elsewhere.

What options do we have for fixing this in the NUMA code?

Will
