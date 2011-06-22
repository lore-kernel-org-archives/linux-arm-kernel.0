From: mina86@mina86.com (Michal Nazarewicz)
Date: Wed, 22 Jun 2011 17:54:47 +0200
Subject: [Linaro-mm-sig] [PATCH 08/10] mm: cma: Contiguous Memory
	Allocator added
In-Reply-To: <003701cc30de$7a159710$6e40c530$%szyprowski@samsung.com>
References: <1307699698-29369-1-git-send-email-m.szyprowski@samsung.com>
	<201106150937.18524.arnd@arndb.de>
	<201106220903.31065.hverkuil@xs4all.nl>
	<201106221442.20848.arnd@arndb.de>
	<003701cc30de$7a159710$6e40c530$%szyprowski@samsung.com>
Message-ID: <op.vxhihlc43l0zgt@mnazarewicz-glaptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Wednesday, June 22, 2011 2:42 PM Arnd Bergmann wrote:
>> We could also go further and add a runtime sysctl mechanism like the
>> one for hugepages, where you can grow the pool at run time as long
>> as there is enough free contiguous memory (e.g. from init scripts),
>> or shrink it later if you want to allow larger nonmovable allocations.

On Wed, 22 Jun 2011 15:15:35 +0200, Marek Szyprowski wrote:
> Sounds really good, but it might be really hard to implement, at
> least for CMA, because it needs to tweak parameters of memory
> management internal structures very early, when buddy allocator
> has not been activated yet.

If you are able to allocate a pageblock of free memory from buddy system,
you should be able to convert it to CMA memory with no problems.

Also, if you want to convert CMA memory back to regular memory you
should be able to do that even if some of the memory is used by CMA
(it just won't be available right away but only when CMA frees it).

It is important to note that, because of the use of migration type,
all such conversion have to be performed on pageblock basis.

I don't think this is a feature we should consider for the first patch
though.  We started with an overgrown idea about what CMA might do
and it didn't got us far.  Let's first get the basics right and
then start implementing features as they become needed.

-- 
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=./ `o
..o | Computer Science,  Michal "mina86" Nazarewicz    (o o)
ooo +-----<email/xmpp: mnazarewicz@google.com>-----ooO--(_)--Ooo--
