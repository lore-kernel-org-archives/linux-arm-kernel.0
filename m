From: loeliger@gmail.com (Jon Loeliger)
Date: Tue, 1 Jul 2014 12:51:21 -0500
Subject: Some Large Address Space Ponders on A9
In-Reply-To: <14859259.LsA3SotVTm@wuerfel>
References: <CAJgR-BhNHYVYJo+jXAOCy+xzXP-AMjJ7LhuzssrQSEPQN4W=2A@mail.gmail.com>
 <14859259.LsA3SotVTm@wuerfel>
Message-ID: <CAJgR-Bj-hLW89Us8fq_dWqjMoiBko_DheqLN_Kv3pZYqX+oihw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Tue, Jul 1, 2014 at 11:43 AM, Arnd Bergmann <arnd@arndb.de> wrote:

> Hmm, we sometimes confuse phys_addr_t and dma_addr_t, because for
> all practical purposes they tend to be the same. However, I think
> what you need here is dma_addr_t, which is defined independently.
>
> You will probably run into bugs if you have dma_addr_t >
> phys_addr_t, but you could try fixing those.

Changing even dma_addr_t won't solve the issues that I see.
I need to be able to specify device tree devices that have 64-bit
resources.  All the subsequent math on those resources just falls
out and is written already in terms of resource_size_t data.

>> Should using a 64-bit phys_addr_t on an A9 "just work"?  Or is
>> this a new scenario never considered before?  Maybe a bug
>> due to this odd configuration that might need to be fixed?
>> Maybe some assumption of alignment, packed-ness
>> or sizes in some structure relating to context switching?
>
> It should mostly just work, since a lot of the same code gets
> used by A7 and A15 when LPAE is enabled.

Well, see, that's where I kind of thought we might be.  It seems
like the boot was working reasonably well.  But that maybe there
was some niggling "oh, duh!" bug that needed to be tracked down
in the context switch code or so...  And I just don't even begin to
understand enough of that black magic to start guessing yet. :-)

>> I think the device-tree handling code is able to grok and process
>> 64-bit addresses.  Does it make sense to allow the phys_addr_t and
>> the resource_size_t to take on different sizes?  That is, to break the
>> above definition of resource_size_t from types.h and allow its size
>> to be determined independently of phys_addr_t?
>
> resource_size_t and phys_addr_t should really be the same all the
> time.

Why?  What is the driving force or underlying assumption there?

>> Is there some easier (obvious even?) way to allow some DT devices to
>> use 64-bit resources and I've just missed it?
>
> You can try 64-bit dma_addr_t with 32-bit resource_size_t/phys_addr_t,
> but it's more likely to work if you make them all 64-bit.

Hmm.  So ponder enabling LPAE *except* for changes that it would
induce on page tables, MMU, addressing, illegal instructions, etc.
Just the address size changes, alignment, structure layout, etc.

World of hurt, right?

>         Arnd

Thanks,
jdl
