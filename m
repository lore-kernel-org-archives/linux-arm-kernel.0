From: jeremy.linton@arm.com (Jeremy Linton)
Date: Fri, 23 Oct 2015 11:32:15 -0500
Subject: [PATCH] arm64: Align .text section to PAGE_SIZE
In-Reply-To: <CAKv+Gu_5YPiQOejsAUdVs7YbNJD4tFwuATYq6VNxuXbeRsoYkw@mail.gmail.com>
References: <1445610134-20528-1-git-send-email-jeremy.linton@arm.com>
 <CAKv+Gu_5YPiQOejsAUdVs7YbNJD4tFwuATYq6VNxuXbeRsoYkw@mail.gmail.com>
Message-ID: <562A610F.4090101@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/23/2015 10:34 AM, Ard Biesheuvel wrote:
> It looks like fixup_executable() [with DEBUG_RODATA enabled] is the
> culprit here: it calls create mapping() with a size that gets rounded
> up to a multiple of PAGE_SIZE, which means the region that ends up
> getting its exec bits cleared is larger than it should. Perhaps it is
> better to fix that instead?

Ard,
	Thanks for taking a look at this!

	Your probably right.

	But AFAIK, with just that fix text/ro sections can be partially mapped 
without ro. It seems to me that putting a little padding in so that they 
are on separate pages is a good idea, especially since it seems the 
remaining sections of interest are page aligned, either explicitly in 
the linker script or via assembly directives in assorted places.

	Maybe a clearer fix is an additional ifdef in the DEBUG_ALIGN_RODATA 
stanza which sets ALIGN_DEBUG_RO to align to pagesize if DEBUG_RODATA is 
set, that way it only takes affect for RODATA.

Thanks,
	Jeremy
