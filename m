From: msalter@redhat.com (Mark Salter)
Date: Wed, 16 Jul 2014 17:03:56 -0400
Subject: [PATCH v2] arm64/efi: efistub: jump to 'stext' directly, not
 through the header
In-Reply-To: <CAKv+Gu-bqXKoy-G00cWPJES=6A_ofu=cfBOsD0ZriHa4AGxG0A@mail.gmail.com>
References: <1405421886-11692-1-git-send-email-ard.biesheuvel@linaro.org>
 <1405522297.25580.72.camel@deneb.redhat.com>
 <20140716155345.GB30313@leverpostej>
 <1405539927.25580.74.camel@deneb.redhat.com>
 <CAKv+Gu-bqXKoy-G00cWPJES=6A_ofu=cfBOsD0ZriHa4AGxG0A@mail.gmail.com>
Message-ID: <1405544636.25580.83.camel@deneb.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-07-16 at 22:38 +0200, Ard Biesheuvel wrote:
> On 16 July 2014 21:45, Mark Salter <msalter@redhat.com> wrote:
> > On Wed, 2014-07-16 at 16:53 +0100, Mark Rutland wrote:
> >> On Wed, Jul 16, 2014 at 03:51:37PM +0100, Mark Salter wrote:
> >> > On Tue, 2014-07-15 at 12:58 +0200, Ard Biesheuvel wrote:
> >> > > After the EFI stub has done its business, it jumps into the kernel by branching
> >> > > to offset #0 of the loaded Image, which is where it expects to find the header
> >> > > containing a 'branch to stext' instruction.
> >> > >
> >> > > However, the header is not covered by any PE/COFF section, so the header may
> >> > > not actually be loaded at the expected offset. So instead, jump to 'stext'
> >> > > directly, which is at the base of the PE/COFF .text section, by supplying a
> >> > > symbol 'stext_offset' to efi-entry.o which contains the relative offset of
> >> > > stext into the Image. Also replace other open coded calculations of the same
> >> > > value with a reference to 'stext_offset'
> >> >
> >> > Have you actually seen a situation where the header isn't there?
> >> > Isn't the kernel header actually part of the pe/coff file and
> >> > firmware loads the whole file into RAM?
> >>
> >> From my understanding of Ard's earlier comments, this part isn't
> >> guaranteed per the UEFI spec.
> >>
> >> I would rather we weren't relying on implementation details.
> >>
> >
> > Could be. I didn't see anything about it in the UEFI spec, but I
> > probably wasn't exhaustive in my search. In any case, there's at
> > least one other place broken if the kernel header isn't included
> > in the loaded image.
> >
> 
> I have not been able to find anything in the PE/COFF documents that
> tells you what to put in memory areas that are not covered by a
> section. Expecting the header to be there is indeed relying on an
> implementation detail, which seems risky.
> And indeed, if there are any other (non EFI related) uses of header
> fields in the kernel, it would be good to have a look at those well,

I think we need to come up with a loader which does load an image
without kernel header so that we can test. Otherwise, we'll probably
end up with buggy code anyway. The stub code assumes the the loaded
image pointed to by the system table is the whole image. Seems like
we'd need to add code to determine if it is whole kernel image or
image without initial header. Stub would have to handle both cases.
For instance, one case would want image placed at 2MiB+TEXT_OFFSET,
other case would want 2MiB+TEXT_OFFSET+sizeof(kernel header).

Am I just missing something here? Your "arm64/efi: efistub: get text
offset and image size from the Image header" patch makes no sense if we
can't rely on header being there.
