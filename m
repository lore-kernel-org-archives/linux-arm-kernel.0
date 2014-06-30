From: will.deacon@arm.com (Will Deacon)
Date: Mon, 30 Jun 2014 10:03:18 +0100
Subject: [PATCH v2] arm64: fpsimd: avoid restoring fpcr if the contents
 haven't changed
In-Reply-To: <CAKv+Gu_-nPg5eGj1MHXui=2QkDPGFgjh=4dZhODj984KCGqGEA@mail.gmail.com>
References: <1403884399-16359-1-git-send-email-will.deacon@arm.com>
 <CAKv+Gu_-nPg5eGj1MHXui=2QkDPGFgjh=4dZhODj984KCGqGEA@mail.gmail.com>
Message-ID: <20140630090318.GB24879@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 27, 2014 at 06:33:58PM +0100, Ard Biesheuvel wrote:
> On 27 June 2014 17:53, Will Deacon <will.deacon@arm.com> wrote:
> > Writing to the FPCR is commonly implemented as a self-synchronising
> > operation in the CPU, so avoid writing to the register when the saved
> > value matches that in the hardware already.

[...]

> >  .macro fpsimd_restore_partial state, tmpnr1, tmpnr2
> >         ldp     w\tmpnr1, w\tmpnr2, [\state]
> >         msr     fpsr, x\tmpnr1
> > -       msr     fpcr, x\tmpnr2
> > +       fpsimd_restore_fpcr x\tmpnr1, x\tmpnr2
> 
> Ehm, isn't this the wrong way around?

Yup, well spotted. I'll give the crypto selftests a run to test this path
with the fix (I was just running paranoia in userspace before).

Will
