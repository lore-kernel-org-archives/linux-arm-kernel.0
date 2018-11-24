From: duwe@lst.de (Torsten Duwe)
Date: Sat, 24 Nov 2018 13:20:42 +0100
Subject: [PATCH 2/2] arm64/module: switch to ADRP/ADD sequences for PLT
 entries
In-Reply-To: <CAKv+Gu93dgDSapVva0HxTssSf+zT22VmiJhby25sHMz4fZpdpw@mail.gmail.com>
References: <20181122084646.3247-1-ard.biesheuvel@linaro.org>
 <20181122084646.3247-3-ard.biesheuvel@linaro.org>
 <20181123161135.GA370@lst.de>
 <CAKv+Gu93dgDSapVva0HxTssSf+zT22VmiJhby25sHMz4fZpdpw@mail.gmail.com>
Message-ID: <20181124122042.GA4362@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 23, 2018 at 05:24:13PM +0100, Ard Biesheuvel wrote:
> On Fri, 23 Nov 2018 at 17:12, Torsten Duwe <duwe@lst.de> wrote:
> > On Thu, Nov 22, 2018 at 09:46:46AM +0100, Ard Biesheuvel wrote:
> >
> > But I'm really lost with this one:
> >
> > > +bool plt_entries_equal(const struct plt_entry *a, const struct plt_entry *b)
> > > +{
> > > +     u64 p, q;
> > > +
> > > +     /*
> > > +      * Check whether both entries refer to the same target:
> > > +      * do the cheapest checks first.
> > > +      */
> > > +     if (a->add != b->add || a->br != b->br)
> > > +             return false;
> > > +
> > > +     p = ALIGN_DOWN((u64)a, SZ_4K);
> > > +     q = ALIGN_DOWN((u64)b, SZ_4K);
> > > +
> > > +     if (a->adrp == b->adrp && p == q)
> > > +             return true;
> > > +
> > > +     return (p + aarch64_insn_adrp_get_offset(le32_to_cpu(a->adrp))) ==
> > > +            (q + aarch64_insn_adrp_get_offset(le32_to_cpu(b->adrp)));
> > > +}
> >
> > IIUC addr/addrp are PC-relative? So in order to tell whether they lead to
> > the same destination, their location (a and b) must _fully_ been taken
> > into account, not just some bits?

Ok, only the % 4k part of the PC is taken into account for adrp, I learned;
well then.

> 
> The criterion is whether they point to the same target.
> 
> So the reasoning is as follows:
> - if the 'add' or 'br' opcodes are different, they are definitely not equal
> - if the 'add' and 'br' opcodes are the same, the 'adrp' opcodes are
> the same, and the adrp instructions reside in the same 4 KB sized/4 KB
> aligned window, they must point to the same symbol
> - otherwise, decode the instructions to see if they point to the same
> symbol. Note that we already checked the 'add's so no need to check
> them again.
> 
> > Also, plt entries residing at different locations might address the same
> > target, but (a->add != b->add || a->br != b->br) would yield true
> > despite that. Is this intended?
> >
> 
> If they address the same target, the add will be the same. The br also
> has to be the same because we cannot reuse an ordinary PLT as and ADRP
> veneer or vice versa.

Ah, _that's_ the purpose! Could you please clarify it like

/* make sure we're comparing equally typed veneers (or quote the above) */
if (a->br != b->br)
	return false;
/* different offsets into the page can never lead to equal dest */
if (a->add != b->add)
	return false;
/* it remains to compare the destination pages */ ...

Seems like this is per se difficult territory, see erratum#843419 ;-)

Reviewed-by: Torsten Duwe <duwe@lst.de>

	Torsten
