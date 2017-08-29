From: bauerman@linux.vnet.ibm.com (Thiago Jung Bauermann)
Date: Tue, 29 Aug 2017 13:15:08 -0300
Subject: [PATCH 14/14] arm64: kexec_file: add vmlinux format support
In-Reply-To: <20170829100112.GC2901@leverpostej>
References: <20170824081811.19299-1-takahiro.akashi@linaro.org>
 <20170824081811.19299-15-takahiro.akashi@linaro.org>
 <20170824173049.GG29665@leverpostej> <20170829100112.GC2901@leverpostej>
Message-ID: <87r2vue4fn.fsf@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Mark Rutland <mark.rutland@arm.com> writes:

> On Thu, Aug 24, 2017 at 06:30:50PM +0100, Mark Rutland wrote:
>> On Thu, Aug 24, 2017 at 05:18:11PM +0900, AKASHI Takahiro wrote:
>> > The first PT_LOAD segment, which is assumed to be "text" code, in vmlinux
>> > will be loaded at the offset of TEXT_OFFSET from the begining of system
>> > memory. The other PT_LOAD segments are placed relative to the first one.
>> 
>> I really don't like assuming things about the vmlinux ELF file.
>> 
>> > Regarding kernel verification, since there is no standard way to contain
>> > a signature within elf binary, we follow PowerPC's (not yet upstreamed)
>> > approach, that is, appending a signature right after the kernel binary
>> > itself like module signing.
>> 
>> I also *really* don't like this. It's a bizarre in-band mechanism,
>> without explcit information. It's not a nice ABI.
>> 
>> If we can load an Image, why do we need to be able to load a vmlinux?
>
> So IIUC, the whole point of this is to be able to kexec_file_load() a
> vmlinux + signature bundle, for !CONFIG_EFI kernels.
>
> For that, I think that we actually need a new kexec_file_load${N}
> syscall, where we can pass the signature for the kernel as a separate
> file. Ideally also with a flags argument and perhaps the ability to sign
> the initrd too.
>
> That way we don't ahve to come up with a magic vmlinux+signature format,
> as we can just pass a regular image and a signature for that image
> separately. That should work for PPC and others, too.

powerpc uses the same format that is used for signed kernel modules,
which is a signature appended at the end of the file. It doesn't need to
be passed separately since it's embedded in the file itself.

The kernel already has a mechanism to verify signatures that aren't
embedded in the file: it's possible to use IMA via the LSM hook in
kernel_read_file_from_fd (which is called in
kimage_file_prepare_segments) to verify a signature stored in an
extended attribute by using an IMA policy rule such as:

appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig

Of course, that only works if the kernel image is stored in a filesystem
which supports extended attributes. But that is the case of most
filesystems nowadays, with the notable exception of FAT-based
filesystems.

evmctl, the IMA userspace tool, also support signatures stored in a
separate file as well ("sidecar" signatures), but the kernel can only
verify them if they are copied into an xattr (which I believe the
userspace tool can do).

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
