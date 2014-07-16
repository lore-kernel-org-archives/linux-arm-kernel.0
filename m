From: msalter@redhat.com (Mark Salter)
Date: Wed, 16 Jul 2014 10:51:37 -0400
Subject: [PATCH v2] arm64/efi: efistub: jump to 'stext' directly, not
 through the header
In-Reply-To: <1405421886-11692-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1405421886-11692-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1405522297.25580.72.camel@deneb.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-07-15 at 12:58 +0200, Ard Biesheuvel wrote:
> After the EFI stub has done its business, it jumps into the kernel by branching
> to offset #0 of the loaded Image, which is where it expects to find the header
> containing a 'branch to stext' instruction.
> 
> However, the header is not covered by any PE/COFF section, so the header may
> not actually be loaded at the expected offset. So instead, jump to 'stext'
> directly, which is at the base of the PE/COFF .text section, by supplying a
> symbol 'stext_offset' to efi-entry.o which contains the relative offset of
> stext into the Image. Also replace other open coded calculations of the same
> value with a reference to 'stext_offset'

Have you actually seen a situation where the header isn't there?
Isn't the kernel header actually part of the pe/coff file and
firmware loads the whole file into RAM?
