From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Thu, 14 Oct 2010 17:47:09 +0300
Subject: [PATCH] ARM: allow, but warn, when issuing ioremap() on RAM
In-Reply-To: <20101011152516.GF27153@n2100.arm.linux.org.uk>
References: <20101007192245.GC26435@n2100.arm.linux.org.uk>
	<AANLkTikQKY7pOobD+==uT5Cy0poT=O5wDMKtbVyJVNbO@mail.gmail.com>
	<20101008175308.GA10975@n2100.arm.linux.org.uk>
	<AANLkTi=ERZjVDS=Q7aw1zA23KF68irUP3vvKLZw5meBU@mail.gmail.com>
	<20101008230451.GB10975@n2100.arm.linux.org.uk>
	<20101008232539.GA28697@kroah.com>
	<20101008234448.GD10975@n2100.arm.linux.org.uk>
	<AANLkTinhwORqdWU43yr1AXJGZm2zPKGG+Q9twruNs2aH@mail.gmail.com>
	<20101009092127.GB20975@n2100.arm.linux.org.uk>
	<AANLkTimQJLmDZPHtVJLCv9ZQgx_Yjh9=MOwOxMSAz4QX@mail.gmail.com>
	<20101011152516.GF27153@n2100.arm.linux.org.uk>
Message-ID: <AANLkTime=tKu_F=8fvUUWkRt2xp+S5yMY8Sv0Gs4TCQ5@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 11, 2010 at 6:25 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sun, Oct 10, 2010 at 04:52:36AM +0300, Felipe Contreras wrote:
>> At the time 'fixup' is called, 'meminfo' is empty; the tags haven't
>> been parsed. So my solution is to move the memblock_add() after
>> 'reserve', and pass 'meminfo' as an argument:
>
> Here's a different approach which will work. ?This pushes ARM further
> towards using memblock for everything relating to memory init (although
> we still have the old membank stuff around.)
>
> The advantage with this is that memblock is now used as the basis for
> determining where memory is, setting up the maps, freeing memory into
> the pools, etc.
>
> What this also means is that this code in the ->reserve callback:
>
> ? ? ? ?size = min(size, SZ_2M);
> ? ? ? ?base = memblock_alloc(size, min(align, SZ_2M));
> ? ? ? ?memblock_free(base, size);
> ? ? ? ?memblock_remove(base, size);

Why align to SZ_2M both the start and end?

> will result in [base+size] being removed from the available memory,
> using highmem if available, if not from lowmem and removing it from
> the lowmem memory map - which is exactly the behaviour we want.

Makes sense to me.

> ?arch/arm/mm/init.c | ?160 +++++++++++++++++++++++++++++++++++-----------------
> ?arch/arm/mm/mmu.c ?| ? 43 ++++++++------
> ?mm/memblock.c ? ? ?| ? ?4 +
> ?3 files changed, 138 insertions(+), 69 deletions(-)

This works fine:
Tested-by: Felipe Contreras <felipe.contreras@gmail.com>

-- 
Felipe Contreras
