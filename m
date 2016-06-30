From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu, 30 Jun 2016 09:44:54 +0900
Subject: [PATCH v19 10/13] arm64: kdump: add VMCOREINFO's for user-space
 coredump tools
In-Reply-To: <20160623154624.GC16398@dhcppc9>
References: <cover.1466120418.git.geoff@infradead.org>
 <6e96110e85e7b1167043d789e85f9c916fdf281a.1466120418.git.geoff@infradead.org>
 <20160620053222.GB14309@dhcppc9>
 <20160622055940.GY20774@linaro.org>
 <20160623071412.GA16398@dhcppc9>
 <20160623081545.GA20774@linaro.org>
 <20160623154624.GC16398@dhcppc9>
Message-ID: <20160630004453.GH20774@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pratyush,

On Thu, Jun 23, 2016 at 09:16:24PM +0530, Pratyush Anand wrote:
> On 23/06/2016:05:42:28 PM, AKASHI Takahiro wrote:
> > On Thu, Jun 23, 2016 at 12:44:12PM +0530, Pratyush Anand wrote:
> > > Hi Takahiro,
> > > 
> > > Thanks for your reply.
> > > 
> > > On 22/06/2016:02:59:41 PM, AKASHI Takahiro wrote:
> > > > On Mon, Jun 20, 2016 at 11:02:22AM +0530, Pratyush Anand wrote:
> > > > > +Atsushi
> > > > > 
> > > > > Hi Takahiro,
> > > > > 
> > > > > On 16/06/2016:11:48:28 PM, Geoff Levand wrote:
> > > > > > From: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > > > > > 
> > > > > > For the current crash utility, we need to know, at least,
> > > > > >   - kimage_voffset
> > > > > >   - PHYS_OFFSET
> > > > > > to handle the contents of core dump file (/proc/vmcore) correctly due to
> > > > > > the introduction of KASLR (CONFIG_RANDOMIZE_BASE) in v4.6.
> > > > > > This patch puts them as VMCOREINFO's into the file.
> > > > > > 
> > > > > >   - VA_BITS
> > > > > > is also added for makedumpfile command.
> > > > > 
> > > > > Thanks for adding them. They are quite helpful for makedumpfile as well.
> > > > > 
> > > > > > More VMCOREINFO's may be added later.
> > > > > 
> > > > > Yes, we will need to pass VMCOREINFO_SYMBOL(_text) and VMCOREINFO_SYMBOL(_end)
> > > > > in order to work with makedumpfile.
> > > > 
> > > > I know that adding those symbols is the easiest way, but
> > > > theoretically, if we know the physical address of "swapper_pg_dir",
> > > 
> > > But, we know only it's virtual address. 
> > 
> > What I meant here is that, if we know the physical address of "swapper_pg_dir",
> > we don't have to know neither of "_text", "_end", "kimage_voffset" nor
> > "PHYS_OFFSET".
> > I just wanted to ask you whether you thought of this possibility.
> 
> OK, Let me clarify the needs from makedumpfile perspective. Atsushi can correct
> me if I am wrong:
> 
> - As a minimal we need some way of reading page table entries. Currently vmcore
>   has only virtual address of swapper_pg_dir, but if you can provide
>   __pa(swapper_pg_dir) in vmcore, then we do not need either "_text", "_end" or
>   "kimage_voffset". 
> - However, "PHYS_OFFSET" might still be needed. makedumpfile core code needs to
>   know phys_base. Currently we find it from the PT_LOAD segments. We treat the
>   lowest start of segment's LMAs as the physical base. I am not sure, if that is
>   still true with latest KASAN changes.

PHYS_OFFSET is now there in patch 10/13.

> - Further, if you do not provide "_text" and "_end", then we will have to translate
>   each address with complex page table read process, which would slow
>   makedumpfile execution significantly.

I believe that this is the only reason that you want both symbols
though I don't know how much performance penalty it may cause.

> Now, please let us know that what will be the kernel strategy, so that I can
> re-organise makedumpfile accordingly.

Given that I'm not a user nor author of makedumpfile command for arm64,
as we discussed locally before, I'm now convinced that you'd better post
your own kernel patch based on your requirements as you like.

Thanks,
-Takahiro AKASHI

> > > 
> > > > instead of its virtual address, we can access all the memory pointed to
> > > > by any kernel virtual address.
> > > > How do you rationalize that we need to know "_text" and "_end"?
> > > 
> > > Well, we need some mechanism so that we can decide if an address can be
> > > translated using linear mapping of virt_to_phys(). 
> > 
> > All the entries in MMU tables are based on "physical" addresses,
> > and so we don't care whether a given address is in linear mapping or not
> > in walking through MMU.
> > See what I mean?
> 
> Yes, yes, I thought, we have only virtual swapper_pg_dir, so I was looking for a
> way to translate *atleast* that into physical.
> 
> Thanks for your input. Those are helpful.
> 
> ~Pratyush
> 
> > 
> > Thanks,
> > -Takahiro AKASHI
> > 
> > > Alternatively, probably we can do like this:
> > > -- Translate all address between "SYMBOL(swapper_pg_dir)"  and "SYMBOL(swapper_pg_dir)
> > >  + SWAPPER_DIR_SIZE" using virt_to_phys() and now we can read values from
> > >  dumpfile using that physical address. This way we can get PGD/PMD/PUD values.
> > > -- PTE values may lie out side this range, however that address should still be
> > > linearly translatable. We can use virt_to_phys() macro from them as well.
> > > 
> > > In summary, we can translate address of PGD/PMD/PUD/PTE using virt_to_phys()
> > > and rest all can be translated using page table entries.
> > > 
> > > ~Pratyush
