From: msalter@redhat.com (Mark Salter)
Date: Thu, 09 Oct 2014 18:19:39 -0400
Subject: [PATCH v3] arm64/efi: efistub: jump to 'stext' directly, not
 through the header
In-Reply-To: <CAKv+Gu-D812Rn32rm5wQJfSM+NzPXZWbxDcDkZ8mBzbi5RQJXQ@mail.gmail.com>
References: <1412777487-13636-1-git-send-email-ard.biesheuvel@linaro.org>
 <20141009172354.GA466@leverpostej>
 <CAKv+Gu-D812Rn32rm5wQJfSM+NzPXZWbxDcDkZ8mBzbi5RQJXQ@mail.gmail.com>
Message-ID: <1412893179.29182.71.camel@deneb.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2014-10-09 at 21:03 +0200, Ard Biesheuvel wrote:
> On 9 October 2014 19:23, Mark Rutland <mark.rutland@arm.com> wrote:
> > Hi Ard,
> >
> > On Wed, Oct 08, 2014 at 03:11:27PM +0100, Ard Biesheuvel wrote:
> >> After the EFI stub has done its business, it jumps into the kernel by
> >> branching to offset #0 of the loaded Image, which is where it expects
> >> to find the header containing a 'branch to stext' instruction.
> >>
> >> However, the UEFI spec 2.1.1 states the following regarding PE/COFF
> >> image loading:
> >> "A UEFI image is loaded into memory through the LoadImage() Boot
> >> Service. This service loads an image with a PE32+ format into memory.
> >> This PE32+ loader is required to load all sections of the PE32+ image
> >> into memory."
> >>
> >> In other words, it is /not/ required to load parts of the image that are
> >> not covered by a PE/COFF section, so it may not have loaded the header
> >> at the expected offset, as it is not covered by any PE/COFF section.
> >
> > What does this mean for handle_kernel_image? Given we might not have
> > _text through to _stext mapped, do we not need to take that into
> > account?
> >
> 
> Actually, handle_kernel_image() does not interpret the header, it just
> copies it along with the rest of the image if it needs to be
> relocated, so I don't see an issue there. However, I do remember Mark
> Salter mentioning that there is at least one other location that needs
> to be fixed up if this concern is valid. Mark?

I think at one time we were using the the EFI_LOADED_IMAGE_PROTOCOL
ImageBase field and assuming it pointed to the start of the copied
file, but I don't think we do so currently. My thought at the time was
that the ImageBase pointer didn't really make sense unless the whole
image file was copied by LoadImage(). The description for LoadImage has:

  The LoadImage() function loads an EFI image into memory and returns
  a handle to the image. The image is loaded in one of two ways.

  ? If SourceBuffer is not NULL, the function is a memory-to-memory
    load  in which SourceBuffer points to the image to be loaded and
    SourceSize indicates the image?s size in bytes. In this case, the
    caller has copied the image into SourceBuffer and can free the
    buffer once loading is complete.

  ? If SourceBuffer is NULL, the function is a file copy operation that
    uses the EFI_SIMPLE_FILE_SYSTEM_PROTOCOL.

Which makes me think the whole thing gets copied. But in any case, I
have no objection to your patch.

> 
> > Also, have we seen problems on any systems yet?
> >
> 
> No, I am not aware of any occurrences of this exact issue, this is
> just one of the things I spotted while working on this code.
> But I think we mostly agree that branching through the header relies
> on behavior of the PE/COFF loader that is not covered by the spec.
> 
