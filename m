From: dan.j.williams@gmail.com (Dan Williams)
Date: Wed, 27 Apr 2011 16:12:49 -0700
Subject: RAID/dmaengine violates the dma-streaming API
In-Reply-To: <20110427202016.GX17290@n2100.arm.linux.org.uk>
References: <BANLkTinMA_U1r6K4t8UZKUr4nZBsWPSv9w@mail.gmail.com>
	<BANLkTi=30Q5=TAaPcE8SXt417S6e=RaY3Q@mail.gmail.com>
	<20110427202016.GX17290@n2100.arm.linux.org.uk>
Message-ID: <BANLkTikBoek0-138wdeqJxF+A3UiN7h-zQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 27, 2011 at 1:20 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Apr 27, 2011 at 02:42:57PM +0300, saeed bishara wrote:
>> On Sun, Apr 17, 2011 at 7:00 PM, saeed bishara <saeed.bishara@gmail.com> wrote:
>> > Hi,
>> > ? ? when md uses the dma for offloading xor and memcpy operations, it
>> > violates the dma-mapping API. ?here is the scenario I'm taking about
>> > (under write to degraded raid5):
>> > 1. ops_run_prexor sends xor operation from buffers A and B, and the
>> > destination is A.
>> > 2. ops_run_biodrain: sends mempcy operation from C to B.
>> > 3. ops_run_reconstruct5: sends xor operation from A and B, and the
>> > destination is A again.
>> >
>> > in step 1, the async tx maps A using dma_map_page, and in step 3, it
>> > maps again the same buffer. but, if the request from step 1 still
>> > being handled the dma engine, then we end with a case where the buffer
>> > mapped while it still belongs to the dma hw.
>> > when the arch is ARMv6/SMP mode (without io coherency), the cache
>> > maintenance involves read/write access to the buffers, that means, the
>> > second mapping above may access the buffer(with read/write) while the
>> > dma is writing to it!!.
>> >
>> Russell/Dan,
>> ? ? ?can you have a look into this issue? what I see here is that the
>> raid stack issues dma_map_page to a buffer that still owned by DMA.
>
> I already mentioned this issue to Dan, and pointed out that it's
> a violation of the buffer ownership rules. ?I don't remember clearly
> what the outcome of it is, but there's not a lot which can be done at
> architecture level about it.
>
> I think the buffer mapping was going to be moved upwards, to prevent
> the multiple buffer mapping issue. ?I don't know if patches were
> produced though (and I don't have hardware to be able to produce and
> test such patches against.)
>

This is still on my plate and is waiting for me to get out from
underneath the isci driver effort.  I was thinking to push it all to
md and kill the api, but then had an idea of an async_session data
structure that could automatically marshal a chain of transfers
between mapping domains.  The fast path would be a chain that stays
within one mapping domain, but the infrastructure would be able to
devolve to support pathological cases like
dma_domain1->cpu->dma_domain2 chains.  So md would need to manipulate
async_sessions, but it could rely on the async_tx api to handle dma
mapping details.

That's my 10,000 foot view at least.

--
Dan
