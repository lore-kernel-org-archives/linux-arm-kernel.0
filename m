From: pageexec@freemail.hu (PaX Team)
Date: Mon, 10 Apr 2017 12:42:35 +0200
Subject: [kernel-hardening] Re: [RFC v2][PATCH 04/11] x86: Implement
 __arch_rare_write_begin/unmap()
In-Reply-To: <CALCETrWvGLtObdk3V0k_Esa_L=EOf+Whe=6DpcJ7H_W8Z-5Btw@mail.gmail.com>
References: <1490811363-93944-1-git-send-email-keescook@chromium.org>,
 <58EA2D58.17782.6ADE22BD@pageexec.freemail.hu>,
 <CALCETrWvGLtObdk3V0k_Esa_L=EOf+Whe=6DpcJ7H_W8Z-5Btw@mail.gmail.com>
Message-ID: <58EB619B.8144.6F924846@pageexec.freemail.hu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 Apr 2017 at 17:10, Andy Lutomirski wrote:

> On Sun, Apr 9, 2017 at 5:47 AM, PaX Team <pageexec@freemail.hu> wrote:
> > on x86 the cost of the pax_open/close_kernel primitives comes from the cr0
> > writes and nothing else, use_mm suffers not only from the cr3 writes but
> > also locking/atomic ops and cr4 writes on its path and the inevitable TLB
> > entry costs. and if cpu vendors cared enough, they could make toggling cr0.wp
> > a fast path in the microcode and reduce its overhead by an order of magnitude.
> >
> 
> If the CR4 writes happen in for this use case, that's a bug.

that depends on how you plan to handle perf/rdpmc users and how many
alternative mm structs you plan to manage (one global, one per cpu,
one per mm struct, etc).

> > you'll be duplicating TLB entries in the alternative PCID for both code
> > and data, where they will accumulate (=take room away from the normal PCID
> > and expose unwanted memory for access) unless you also flush them when
> > switching back (which then will cost even more cycles). also i'm not sure
> > that processors implement all the 12 PCID bits so depending on how many PCIDs
> > you plan to use, you could be causing even more unnecessary TLB replacements.
> >
> 
> Unless the CPU is rather dumber than I expect, the only duplicated
> entries should be for the writable aliases of pages that are written.
> The rest of the pages are global and should be shared for all PCIDs.

well, 4.10.2.4 has language like this (4.10.3.2 implies similar):

   A logical processor may use a global TLB entry to translate a linear
   address, even if the TLB entry is associated with a PCID different
   from the current PCID.

that to me says that global page entries are associated with a PCID and
may (not) be used while in another PCID. in Intel-speak that's not 'dumb'
but "tricks up our sleeve that we don't really want to tell you about in
detail, except perhaps under a NDA".
