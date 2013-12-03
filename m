From: roy.franz@linaro.org (Roy Franz)
Date: Tue, 3 Dec 2013 11:31:29 -0800
Subject: [PATCH 1/3] arm64: add EFI stub
In-Reply-To: <20131203183844.GA22668@mudshark.cambridge.arm.com>
References: <1385762712-17043-1-git-send-email-msalter@redhat.com>
 <1385762712-17043-2-git-send-email-msalter@redhat.com>
 <20131203183844.GA22668@mudshark.cambridge.arm.com>
Message-ID: <CAFECyb-jx=f4T=NARGhGVJjQXGX1t4n8YbWuzJ050O4AQY2p4Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 3, 2013 at 10:38 AM, Will Deacon <will.deacon@arm.com> wrote:
> Hi Mark, Roy,
>
> On Fri, Nov 29, 2013 at 10:05:10PM +0000, Mark Salter wrote:
>> This patch adds PE/COFF header fields to the start of the Image
>> so that it appears as an EFI application to EFI firmware. An EFI
>> stub is included to allow direct booting of the kernel Image. Due
>> to EFI firmware limitations, only little endian kernels with 4K
>> page sizes are supported at this time. Support in the COFF header
>> for signed images was provided by Ard Biesheuvel.
>
> I haven't really jumped into this but, whilst I see the use of EFI_STUB on
> both arm and arm64, there seems to be some duplication/reinvention between
> the two series you've put together.
>
> Maybe I'm just being ignorant, but the stuff in efi-stub.c really looks to
> be doing the same thing on both architectures. Would you guys be able to
> work to together to produce an independent series containing the common
> parts, then add arm/arm64 backends on top of that please? In particular,
> factoring out the device-tree parts ensures that we don't introduce subtle
> differences between the two architectures when there's no real need to do
> so...
>
> ...or shout at me because I didn't understand what you were doing!
>
> Cheers,
>
> Will

Hi Will,

   Some of the device tree code is already factored out in
drivers/firmware/efi/fdt.c, but
looking at this again I think that there is more that can be moved to
common code.  The
main difference between the arm/arm64 stubs is the restrictions on
where the kernel binary
can be loaded.  On arm64 it is the kernel image itself, and on arm it
is the zImage that is the
next stage.  This also affects the build environment - the arm64 stub
is part of the kernel itself,
and the arm stub is part of the decompressor.
I'll work with Mark to see how much of the two stubs we can refactor
into shared code.

Roy
