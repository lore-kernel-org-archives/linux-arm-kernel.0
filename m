From: roy.franz@linaro.org (Roy Franz)
Date: Thu, 15 Aug 2013 08:49:57 -0700
Subject: [PATCH] arm64: Expand arm64 image header
In-Reply-To: <1376539080.26173.23.camel@t520.redhat.com>
References: <1376521800-967-1-git-send-email-roy.franz@linaro.org>
 <1376539080.26173.23.camel@t520.redhat.com>
Message-ID: <CAFECyb-B0X1bXLs-Q=rX7tY5GZiNASZZDP97ZLT9LSk_vSKS=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 14, 2013 at 8:58 PM, Mark Salter <msalter@redhat.com> wrote:
> On Wed, 2013-08-14 at 16:10 -0700, Roy Franz wrote:
>> Expand the arm64 image header to allow for co-existance with
>> PE/COFF header required by the EFI stub.  The PE/COFF format
>> requires the "MZ" header to be at offset 0, and the offset
>> to the PE/COFF header to be at offset 0x3c.  The image
>> header is expanded to allow 2 instructions at the beginning
>> to accommodate a benign intruction at offset 0 that includes
>> the "MZ" header, a magic number, and the offset to the PE/COFF
>> header.
>>
>>
>> Signed-off-by: Roy Franz <roy.franz@linaro.org>
>> ---
>>  Documentation/arm64/booting.txt |   16 +++++++++++++---
>>  arch/arm64/kernel/head.S        |    8 ++++++++
>>  2 files changed, 21 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/arm64/booting.txt b/Documentation/arm64/booting.txt
>> index 9c4d388..5273c4d 100644
>> --- a/Documentation/arm64/booting.txt
>> +++ b/Documentation/arm64/booting.txt
>> @@ -68,13 +68,23 @@ Image target is available instead.
>>
>>  Requirement: MANDATORY
>>
>> -The decompressed kernel image contains a 32-byte header as follows:
>> +The decompressed kernel image contains a 64-byte header as follows:
>>
>> -  u32 magic  = 0x14000008;   /* branch to stext, little-endian */
>> -  u32 res0   = 0;            /* reserved */
>> +  u32 code0;                 /* Executable code */
>> +  u32 code1;                 /* Executable code */
>>    u64 text_offset;           /* Image load offset */
>> +  u64 res0   = 0;            /* reserved */
>>    u64 res1   = 0;            /* reserved */
>>    u64 res2   = 0;            /* reserved */
>> +  u64 res3   = 0;            /* reserved */
>> +  u64 res4   = 0;            /* reserved */
>> +  u32 magic  = 0x644d5241;   /* Magic number, little endian, "ARM\x64" */
>> +  u32 res5 = 0;                      /* reserved */
>> +
>> +
>> +Header notes:
>> +
>> +- code0/code1 are responsible for branching to stext.
>
> Do we really want to change the already documented image header? Any
> existing bootloaders which check the magic number would stop working.
> In my preliminary patches to add an efi stub, I avoid that by making
> an Image.efi which is an Image file with pe/coff header prepended. I
> could easily switch to using the above header change, but wanted to
> point out an alternative that doesn't change the already established
> header.
>
> --Mark
>

Hi Mark,

   Yes, we do want to make the change, as one the goals is to have a
single binary format, not multiple formats.  This was discussed fairly
extensively at LCE, and I think my patch represents the consensus on
how the EFI stub should be integrated.
Also, since it is early enough in the arm64 development this should be
a relatively easy time to make it.  I don't think that the current
magic number is checked in the current UEFI loader, as the image boots
fine with either header.  If the current ARM64 loaders don't check the
magic number, then they will work with either format, since the entry
point is the same.

Roy
