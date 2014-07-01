From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 01 Jul 2014 18:43:18 +0200
Subject: Some Large Address Space Ponders on A9
In-Reply-To: <CAJgR-BhNHYVYJo+jXAOCy+xzXP-AMjJ7LhuzssrQSEPQN4W=2A@mail.gmail.com>
References: <CAJgR-BhNHYVYJo+jXAOCy+xzXP-AMjJ7LhuzssrQSEPQN4W=2A@mail.gmail.com>
Message-ID: <14859259.LsA3SotVTm@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 01 July 2014 10:59:45 Jon Loeliger wrote:
> Folks,
> 
> I have a classic Cortex A9 based SoC in which I will need to
> do some device driver development that will be capable of
> addressing a physical address space larger than 32-bits.
> I understand that the A9 doesn't support LPAE and that
> pretending that it does and config'ing LPAE "on" will just
> break six-ways-to-hell.
> 
> But I need to be able to specify some 64-bit addresses in
> the Device Tree, and allow my device driver to manipulate
> 64-bit resource_size_t ranges.
> 
> Here's the problem.  Over in include/linux/types.h we find:
> 
>     #ifdef CONFIG_PHYS_ADDR_T_64BIT
>     typedef u64 phys_addr_t;
>     #else
>     typedef u32 phys_addr_t;
>     #endif
> 
>     typedef phys_addr_t resource_size_t;
> 
> So that means on my A9 system, phys_addr_t and resource_size_t
> are either both 32-bit or both 64-bit.  I can't get just resource_size_t
> to be 64-bit without some surgery here.

Hmm, we sometimes confuse phys_addr_t and dma_addr_t, because for
all practical purposes they tend to be the same. However, I think
what you need here is dma_addr_t, which is defined independently.

You will probably run into bugs if you have dma_addr_t >
phys_addr_t, but you could try fixing those.

> I've tried the obvious experiment of just config'ing up a
> selection defining CONFIG_PHYS_ADDR_T_64BIT and seeing
> if things work.  They don't; details below.
> 
> So, a few questions...
> 
> Should using a 64-bit phys_addr_t on an A9 "just work"?  Or is
> this a new scenario never considered before?  Maybe a bug
> due to this odd configuration that might need to be fixed?
> Maybe some assumption of alignment, packed-ness
> or sizes in some structure relating to context switching?

It should mostly just work, since a lot of the same code gets
used by A7 and A15 when LPAE is enabled.

> I think the device-tree handling code is able to grok and process
> 64-bit addresses.  Does it make sense to allow the phys_addr_t and
> the resource_size_t to take on different sizes?  That is, to break the
> above definition of resource_size_t from types.h and allow its size
> to be determined independently of phys_addr_t?

resource_size_t and phys_addr_t should really be the same all the
time.

> Is there some easier (obvious even?) way to allow some DT devices to
> use 64-bit resources and I've just missed it?

You can try 64-bit dma_addr_t with 32-bit resource_size_t/phys_addr_t,
but it's more likely to work if you make them all 64-bit.

	Arnd
