From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 29 Aug 2017 11:01:12 +0100
Subject: [PATCH 14/14] arm64: kexec_file: add vmlinux format support
In-Reply-To: <20170824173049.GG29665@leverpostej>
References: <20170824081811.19299-1-takahiro.akashi@linaro.org>
 <20170824081811.19299-15-takahiro.akashi@linaro.org>
 <20170824173049.GG29665@leverpostej>
Message-ID: <20170829100112.GC2901@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 24, 2017 at 06:30:50PM +0100, Mark Rutland wrote:
> On Thu, Aug 24, 2017 at 05:18:11PM +0900, AKASHI Takahiro wrote:
> > The first PT_LOAD segment, which is assumed to be "text" code, in vmlinux
> > will be loaded at the offset of TEXT_OFFSET from the begining of system
> > memory. The other PT_LOAD segments are placed relative to the first one.
> 
> I really don't like assuming things about the vmlinux ELF file.
> 
> > Regarding kernel verification, since there is no standard way to contain
> > a signature within elf binary, we follow PowerPC's (not yet upstreamed)
> > approach, that is, appending a signature right after the kernel binary
> > itself like module signing.
> 
> I also *really* don't like this. It's a bizarre in-band mechanism,
> without explcit information. It's not a nice ABI.
> 
> If we can load an Image, why do we need to be able to load a vmlinux?

So IIUC, the whole point of this is to be able to kexec_file_load() a
vmlinux + signature bundle, for !CONFIG_EFI kernels.

For that, I think that we actually need a new kexec_file_load${N}
syscall, where we can pass the signature for the kernel as a separate
file. Ideally also with a flags argument and perhaps the ability to sign
the initrd too.

That way we don't ahve to come up with a magic vmlinux+signature format,
as we can just pass a regular image and a signature for that image
separately. That should work for PPC and others, too.

Thanks,
Mark.
