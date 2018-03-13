From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue, 13 Mar 2018 20:07:49 +0900
Subject: [Query] ARM64 kaslr support - randomness, seeding and kdump
In-Reply-To: <20180313104715.prurmrizho4ddc4l@lakrids.cambridge.arm.com>
References: <CACi5LpMhHt4bjEueOzHZTGpzuR2zoQqXcReL-khoSNLG6=FVmg@mail.gmail.com>
 <CAKv+Gu8qd=rpJkG_GoVO=kkmc4qx_zZD8c_wwE16gr=8wSShSw@mail.gmail.com>
 <20180313102158.GI25863@linaro.org>
 <20180313104715.prurmrizho4ddc4l@lakrids.cambridge.arm.com>
Message-ID: <20180313110747.GJ25863@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 13, 2018 at 10:47:15AM +0000, Mark Rutland wrote:
> On Tue, Mar 13, 2018 at 07:22:03PM +0900, AKASHI Takahiro wrote:
> > On Mon, Mar 12, 2018 at 08:58:00PM +0000, Ard Biesheuvel wrote:
> > > On 12 March 2018 at 20:14, Bhupesh Sharma <bhsharma@redhat.com> wrote:
> 
> > More importantly, neither arm64 _kexec_ supports kaslr.
> 
> The below is just considering this, and ignoring kdump (where I don't
> think we care at all about KASLR).
> 
> > Currently kexec-tools is set to determine where the kernel actually be
> > loaded, using a constant offset, text_offset, which comes from an image's
> > boot header and relocation of an image to the load address is performed
> > at the very end of the first kernel without knowing whether the 2nd kernel
> > has kaslr support enabled or not.
> 
> The kexec tools shouldn't need to know whether the kernel supports KASLR
> at all.
> 
> If the new kernel image has bit 3 (Kernel physical placement) set, kexec
> tools can choose to randomize the physical load address, regardless of
> whether that kernel has KASLR enabled.

So, by definition, is randomness, if we say so, in physical address not
part of KASLR?

> Note that the bootloader is responsible for physical randomization, and
> the kernel is responsible for virtual randomization. It just happens
> that the EFI stub acts as a bootloader when we use EFI.
> 
> > > > B. Regarding the arm64 kaslr support in kdump (I have Cc'ed AKASHI and
> > > > kexec list in this thread as well for their inputs), but currently we
> > > > don't seem to have a way to support kaslr in arm64 kdump kernel:
> > > >
> > > > - '/chosen/kaslr-seed' a property is zeroed out in the primary kernel
> > 
> > So, even if adding /chosen/kaslr-seed to dtb at kexec would not be
> > difficult, we would have to have efi_entry-like entry code.
> 
> The kaslr-seed property is used for *virtual* randomization, so we don't
> need more code in the kernel for this. The kexec tools can populate this
> property if desired.

Hmm, so saving/re-using kaslr-seed of the 1st kernel, as Bhupesh hinted,
is not important, anyway.

-Takahiro AKASHI


> Thanks,
> Mark.
