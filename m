From: will.deacon@arm.com (Will Deacon)
Date: Mon, 5 Sep 2016 15:42:26 +0100
Subject: [PATCH] arm64: mm: phys_mem_access_prot() reports non-kernel
 memory as device memory
In-Reply-To: <CAKv+Gu9+r1wwcmd60nZ+tuLgj=MzDdyzs9+pCjZr+6N_S+00xQ@mail.gmail.com>
References: <1473064984-9494-1-git-send-email-james.morse@arm.com>
 <20160905103526.GD2649@arm.com> <57CD6D2E.70208@arm.com>
 <CAKv+Gu-eEodAFnXhAygzEFU34vZitzhH2yfU71=3gyVFBsdQYA@mail.gmail.com>
 <20160905132411.GC10221@arm.com>
 <CAKv+Gu9+r1wwcmd60nZ+tuLgj=MzDdyzs9+pCjZr+6N_S+00xQ@mail.gmail.com>
Message-ID: <20160905144225.GD10221@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 05, 2016 at 02:41:16PM +0100, Ard Biesheuvel wrote:
> On 5 September 2016 at 14:24, Will Deacon <will.deacon@arm.com> wrote:
> > On Mon, Sep 05, 2016 at 02:10:54PM +0100, Ard Biesheuvel wrote:
> >> On 5 September 2016 at 14:03, James Morse <james.morse@arm.com> wrote:
> >> > On 05/09/16 11:35, Will Deacon wrote:
> >> >> So our abstractions don't seem to align with reality. Why are the ACPI
> >> >> tables getting marked as NOMAP to being with?
> >> >
> >> > EFI adds any region we can map as normal memory to memblock.memory, it also adds
> >> > anything it considers reserved to the memblock.nomap, e.g. the ACPI tables. This
> >> > causes these regions be left out of the linear map.
> >> > (I don't know why exactly, but assume its so that the attributes and permissions
> >> > can be tweaked easily)
> >> >
> >>
> >> To prevent mismatched attributes between the linear mapping and
> >> whatever mapping the firmware and/or ACPI are using. Also, going
> >> through the trouble of mapping runtime services executable code with
> >> R-X permissions and then having a writable alias is not great in terms
> >> of security.
> >
> > Ok, but with this patch we potentially have both of those problems
> > (mismatched attributes and RWX permission) with the userspace mapping :/
> >
> > Is it worth trying to avoid any of this, or do we just throw our hands
> > in the air and give up when /dev/mem is being used?
> >
> 
> Well, I do think /dev/mem is a ridiculous hack, but it is arguably an
> improvement to not map a region as device if we know it is backed by
> memory.
> 
> Leif already did a lot of work on dmidecode and related tools to get
> rid of /dev/mem dependencies, especially because of the fact that it
> used 'known' physical addresses to look for magic numbers identifying
> SMBIOS tables etc. I am not sure if acpidump was on our radar yet, but
> in the long term, we should be able to reduce the dependency on
> /dev/mem for anything other than development use.

Judging by Leif's reply, acpidump has already been fixed too.

> Would it help at all if we restricted these uses to read only? I am
> not aware of any tools that require read/write access to memory in
> this way.

I'd certainly be happier if we dropped the write permission and derived
the memory type from EFI for the NOMAP regions (it looks like ia64 tries
to do something like this, whereas we currently return non-cacheable if
O_SYNC is set on the fd).

Will
