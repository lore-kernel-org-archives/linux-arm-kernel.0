From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 11 Nov 2011 11:36:01 +0000
Subject: [PATCH v8 13/16] ARM: LPAE: Add identity mapping support for
 the 3-level page table format
In-Reply-To: <20111110225517.GW12913@n2100.arm.linux.org.uk>
References: <1320682618-1182-1-git-send-email-catalin.marinas@arm.com>
 <1320682618-1182-14-git-send-email-catalin.marinas@arm.com>
 <20111110225517.GW12913@n2100.arm.linux.org.uk>
Message-ID: <20111111113601.GE23243@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 10, 2011 at 10:55:17PM +0000, Russell King - ARM Linux wrote:
> On Mon, Nov 07, 2011 at 04:16:55PM +0000, Catalin Marinas wrote:
> > +		pmd += pmd_index(addr);
> > +	} else
> > +		pmd = pmd_offset(pud, addr);
> > +
> > +	do {
> > +		next = pmd_addr_end(addr, end);
> > +		*pmd = __pmd((addr & PMD_MASK) | prot);
> > +		flush_pmd_entry(pmd);
> > +	} while (pmd++, addr = next, addr != end);
> > +}
> > +#else	/* !CONFIG_ARM_LPAE */
> 
> I'm not convinced about the wiseness of this.  One of the places where
> this code is called is from the reboot paths, which can happen in atomic
> context.  Trying to allocate memory in such a context is going to lead
> to problems, especially if support for panic'ing on OOM, and rebooting
> on panic'ing are both enabled.

A solution would be to have pre-set page table for identity mappings
(which may even come in handy for power management) and avoid the
allocation in idmap.c.

Yet another alternative for reset would be to allocate all the pmds for
each task during pgd_alloc() and setup_mm_for_reboot() wouldn't need to
allocate a new pmd.

> Therefore, I think this patch depends on the work Will has been doing to
> re-structure the kexec and restart support.

I think Will can rebase his patches on top of mine (I touched this file
first :)).

-- 
Catalin
