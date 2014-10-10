From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 10 Oct 2014 08:30:01 +0200
Subject: [PATCH v3] arm64/efi: efistub: jump to 'stext' directly, not
 through the header
In-Reply-To: <CAFECyb9Tz2Fo2ix0VYiM7WPeie7C=woiVwyQtR4aH_HPcLwkOg@mail.gmail.com>
References: <1412777487-13636-1-git-send-email-ard.biesheuvel@linaro.org>
 <20141009172354.GA466@leverpostej>
 <CAKv+Gu-D812Rn32rm5wQJfSM+NzPXZWbxDcDkZ8mBzbi5RQJXQ@mail.gmail.com>
 <1412893179.29182.71.camel@deneb.redhat.com>
 <CAFECyb9Tz2Fo2ix0VYiM7WPeie7C=woiVwyQtR4aH_HPcLwkOg@mail.gmail.com>
Message-ID: <CAKv+Gu_6uww=W9M9hDfoSmY+zr2i75Y=JOxTLCya2rr=HiT6Bw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 October 2014 01:20, Roy Franz <roy.franz@linaro.org> wrote:
> On Thu, Oct 9, 2014 at 3:19 PM, Mark Salter <msalter@redhat.com> wrote:
>> On Thu, 2014-10-09 at 21:03 +0200, Ard Biesheuvel wrote:
>>> On 9 October 2014 19:23, Mark Rutland <mark.rutland@arm.com> wrote:
>>> > Hi Ard,
>>> >
>>> > On Wed, Oct 08, 2014 at 03:11:27PM +0100, Ard Biesheuvel wrote:
>>> >> After the EFI stub has done its business, it jumps into the kernel by
>>> >> branching to offset #0 of the loaded Image, which is where it expects
>>> >> to find the header containing a 'branch to stext' instruction.
>>> >>
>>> >> However, the UEFI spec 2.1.1 states the following regarding PE/COFF
>>> >> image loading:
>>> >> "A UEFI image is loaded into memory through the LoadImage() Boot
>>> >> Service. This service loads an image with a PE32+ format into memory.
>>> >> This PE32+ loader is required to load all sections of the PE32+ image
>>> >> into memory."
>>> >>
>>> >> In other words, it is /not/ required to load parts of the image that are
>>> >> not covered by a PE/COFF section, so it may not have loaded the header
>>> >> at the expected offset, as it is not covered by any PE/COFF section.
>>> >
>>> > What does this mean for handle_kernel_image? Given we might not have
>>> > _text through to _stext mapped, do we not need to take that into
>>> > account?
>>> >
>>>
>>> Actually, handle_kernel_image() does not interpret the header, it just
>>> copies it along with the rest of the image if it needs to be
>>> relocated, so I don't see an issue there. However, I do remember Mark
>>> Salter mentioning that there is at least one other location that needs
>>> to be fixed up if this concern is valid. Mark?
>>
>> I think at one time we were using the the EFI_LOADED_IMAGE_PROTOCOL
>> ImageBase field and assuming it pointed to the start of the copied
>> file, but I don't think we do so currently. My thought at the time was
>> that the ImageBase pointer didn't really make sense unless the whole
>> image file was copied by LoadImage(). The description for LoadImage has:
>>
>>   The LoadImage() function loads an EFI image into memory and returns
>>   a handle to the image. The image is loaded in one of two ways.
>>
>>   ? If SourceBuffer is not NULL, the function is a memory-to-memory
>>     load  in which SourceBuffer points to the image to be loaded and
>>     SourceSize indicates the image?s size in bytes. In this case, the
>>     caller has copied the image into SourceBuffer and can free the
>>     buffer once loading is complete.
>>
>>   ? If SourceBuffer is NULL, the function is a file copy operation that
>>     uses the EFI_SIMPLE_FILE_SYSTEM_PROTOCOL.
>>
>> Which makes me think the whole thing gets copied. But in any case, I
>> have no objection to your patch.
>>
> In practice for the edk2, the whole thing does get loaded into memory.
> Whether this
> is mandated by the UEFI specification seems less clear.
>
> I just took a look at handle_kernel_image(), and I don't think it will do
> the right thing if the firmware doesn't load the header.  Looking deeper,
> I think some other stuff will be broken in that case as well.
> handle_kernel_image() takes the image_addr, which the ASM wrapper
> computes using PC relative
> operations and _text:
>
> adrp x8, _text
> add x8, x8, #:lo12:_text
>
> So if the header is actually not loaded, this address will be wrong -
> it will be outside
> the area loaded. While we're not using the EFI_LOADED_IMAGE_PROTOCOL,
> our calculation is only
> correct if it does load the whole file.
>
> I think a similar error would be present in handle_kernel_image() with regard
> to determining how big the kernel is so it can be copied:
> kernel_size = _edata - _text;
> This is not correct amount to copy if the header isn't loaded.
>
> I think we'll also run into some alignment issues if the loader really just
> loads the section ( we just have the one) rather than the whole file.
> From reviewing the PE/COFF spec again we violate the relationship
> between FileAlignment and SectionAlignment.
>
> I think the patch is fine for what it does - avoids executing the
> branch in the PE/COFF header,
> and rather branching directly to the desired code that is in the
> PE/COFF section.
> There are variety of other issues that would need to be addressed if
> the EFI loader
> is just loading the bare section.
>

The issue is *not* that the PE/COFF .text section may get loaded at
ImageBase instead of at ImageBase+sizeof(header), so I don't think
there is reason for any of your concerns.
The issue I try to address here is where the loader allocates some
memory starting at ImageBase, but only populates those regions that
are covered by a section, i.e., only the .text section in our case.
Copying the header from the file to memory at the same relative
(negative) offset from .text as it happens to appear in the file is
behavior that is not covered by the spec at all.

-- 
Ard.


>>>
>>> > Also, have we seen problems on any systems yet?
>>> >
>>>
>>> No, I am not aware of any occurrences of this exact issue, this is
>>> just one of the things I spotted while working on this code.
>>> But I think we mostly agree that branching through the header relies
>>> on behavior of the PE/COFF loader that is not covered by the spec.
>>>
>>
>>
