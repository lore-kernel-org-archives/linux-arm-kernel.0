From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 13 Sep 2016 21:24:10 +0100
Subject: [PATCH v3] arm64: mm: move zero page from .bss to right before
 swapper_pg_dir
In-Reply-To: <CAKv+Gu90AokunA3zOcNhwXsFpCpoY_juipnr3y68nefZk9Ff0w@mail.gmail.com>
References: <1473696925-26156-1-git-send-email-ard.biesheuvel@linaro.org>
 <20160913173507.GA29678@leverpostej>
 <CAKv+Gu90AokunA3zOcNhwXsFpCpoY_juipnr3y68nefZk9Ff0w@mail.gmail.com>
Message-ID: <20160913202410.GA2947@remoulade>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 13, 2016 at 08:18:52PM +0100, Ard Biesheuvel wrote:
> On 13 September 2016 at 18:35, Mark Rutland <mark.rutland@arm.com> wrote:
> Thanks. But actually, I think it makes sense to make the first
> swapper_pg_dir page read-only as well, given that it is only modified
> via the fixmap, and we can trivially extend the r/o bss region to end
> at 'swapper_pg_dir + PAGE_SIZE'
> 
> Thoughts?

I thought that we lazy-allocated the vmalloc region at runtime, and initialised
pgd level entries.

>From a quick dig it looks like a vmalloc() could eventually call
pgd_populate(), which seems to set a pgd entry without using a fixmap slot.

Is there some reason that won't happen at runtime?

Thanks,
Mark.
