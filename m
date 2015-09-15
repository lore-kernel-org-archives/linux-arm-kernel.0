From: will.deacon@arm.com (Will Deacon)
Date: Tue, 15 Sep 2015 15:46:29 +0100
Subject: [RFC PATCH] arm64/efi: isolate EFI stub from the kernel proper
In-Reply-To: <1442311903-19213-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1442311903-19213-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20150915144629.GG31157@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 15, 2015 at 11:11:43AM +0100, Ard Biesheuvel wrote:
> Since arm64 does not use a builtin decompressor, the EFI stub is built
> into the kernel proper. So far, this has been working fine, but actually,
> since the stub is in fact a PE/COFF relocatable binary that is executed
> at an unknown offset in the 1:1 mapping provided by the UEFI firmware, we
> should not be seamlessly sharing code with the kernel proper, which is a
> position dependent executable linked at a high virtual offset.
> 
> So instead, separate the contents of libstub and its dependencies, by
> putting them into their own namespace by prefixing all of its symbols
> with __efistub. This way, we have tight control over what parts of the
> kernel proper are referenced by the stub.

Could we add an __efistub annotation to spit out warnings if the stub
calls into unexpected kernel code, like we do for __init/__ref?

Will
