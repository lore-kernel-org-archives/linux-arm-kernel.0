From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 3 Apr 2014 09:58:35 +0100
Subject: [PATCH 1/1] AArch64: TCR_TG1_64K incorrectly sets TCR_EL1 bits
 [31:30]
In-Reply-To: <CAHWCVWJKiQxBBR43A3beG9f7dEw4JpkFGZ6V-Es8EAn0uW3WJw@mail.gmail.com>
References: <CAHWCVW+cH6MwhQj-JGWN63AqseFYuDPoftv+zGJU8UDfAgueEQ@mail.gmail.com>
 <20140402123844.GE31892@arm.com> <20140402170747.GC24018@arm.com>
 <CAHWCVWJKiQxBBR43A3beG9f7dEw4JpkFGZ6V-Es8EAn0uW3WJw@mail.gmail.com>
Message-ID: <20140403085835.GC17022@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 02, 2014 at 06:21:29PM +0100, Joe Sylve wrote:
> That makes sense and I agree, it's better to fix it now so that it
> will be easier to add 16K paging later (on a side note is there any
> reason not to add it now if someone was willing to do the work?).

See another thread with the Samsung folks about the adding 4-levels of
page tables. We need a bit of refactoring first to decouple the page
size from the number of levels, after that 16K would be relatively easy
(it's easy now as well but I don't see the point on doing it before the
refactoring).

> There was talk in another thread about the possibility of adding a
> pagetable-4K-hwdef.h and pagetable-64K-hwdef.h.  I think this is
> another example of why that might be a good idea as this stuff could
> be moved out of proc.S as to be bit more clean:
> 
> +#ifdef CONFIG_ARM64_64K_PAGES
> +#define TCR_TG_FLAGS   TCR_TG0_64K | TCR_TG1_64K
> +#else
> +#define TCR_TG_FLAGS   TCR_TG0_4K | TCR_TG1_4K
> +#endif

Yes, we could do this when we create the pgtable-*k-hwdef.h files.

-- 
Catalin
