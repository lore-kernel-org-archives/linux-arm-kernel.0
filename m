From: msalter@redhat.com (Mark Salter)
Date: Wed, 16 Jul 2014 15:45:27 -0400
Subject: [PATCH v2] arm64/efi: efistub: jump to 'stext' directly, not
 through the header
In-Reply-To: <20140716155345.GB30313@leverpostej>
References: <1405421886-11692-1-git-send-email-ard.biesheuvel@linaro.org>
 <1405522297.25580.72.camel@deneb.redhat.com>
 <20140716155345.GB30313@leverpostej>
Message-ID: <1405539927.25580.74.camel@deneb.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-07-16 at 16:53 +0100, Mark Rutland wrote:
> On Wed, Jul 16, 2014 at 03:51:37PM +0100, Mark Salter wrote:
> > On Tue, 2014-07-15 at 12:58 +0200, Ard Biesheuvel wrote:
> > > After the EFI stub has done its business, it jumps into the kernel by branching
> > > to offset #0 of the loaded Image, which is where it expects to find the header
> > > containing a 'branch to stext' instruction.
> > > 
> > > However, the header is not covered by any PE/COFF section, so the header may
> > > not actually be loaded at the expected offset. So instead, jump to 'stext'
> > > directly, which is at the base of the PE/COFF .text section, by supplying a
> > > symbol 'stext_offset' to efi-entry.o which contains the relative offset of
> > > stext into the Image. Also replace other open coded calculations of the same
> > > value with a reference to 'stext_offset'
> > 
> > Have you actually seen a situation where the header isn't there?
> > Isn't the kernel header actually part of the pe/coff file and
> > firmware loads the whole file into RAM?
> 
> From my understanding of Ard's earlier comments, this part isn't
> guaranteed per the UEFI spec.
> 
> I would rather we weren't relying on implementation details.
> 

Could be. I didn't see anything about it in the UEFI spec, but I
probably wasn't exhaustive in my search. In any case, there's at
least one other place broken if the kernel header isn't included
in the loaded image.
