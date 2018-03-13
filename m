From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue, 13 Mar 2018 19:22:03 +0900
Subject: [Query] ARM64 kaslr support - randomness, seeding and kdump
In-Reply-To: <CAKv+Gu8qd=rpJkG_GoVO=kkmc4qx_zZD8c_wwE16gr=8wSShSw@mail.gmail.com>
References: <CACi5LpMhHt4bjEueOzHZTGpzuR2zoQqXcReL-khoSNLG6=FVmg@mail.gmail.com>
 <CAKv+Gu8qd=rpJkG_GoVO=kkmc4qx_zZD8c_wwE16gr=8wSShSw@mail.gmail.com>
Message-ID: <20180313102158.GI25863@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 12, 2018 at 08:58:00PM +0000, Ard Biesheuvel wrote:
> On 12 March 2018 at 20:14, Bhupesh Sharma <bhsharma@redhat.com> wrote:
> > Hi Ard,
> >
> > I remember we had a discussion on this topic some time ago, but I was
> > working on enabling KASLR support on arm64 boards internally and
> > wanted to check your opinion on the following points (especially to
> > understand if there are any changes in the opinions of the ARM
> > maintainers now):
> >
> > A. Randomness / Seeding for arm64 kaslr:
> >
> > - Currently the arm64 kernel requires a bootloader to provide entropy,
> > by passing a
> >  random u64 value in '/chosen/kaslr-seed' at kernel entry (please see [1])
> >
> > - On platforms which support UEFI firmware, its the responsibility of
> > the UEFI firmware to implement EFI_RNG_PROTOCOL to supply the
> > '/chosen/kaslr-seed' property.
> >
> > - I was wondering if we have any possibility to support a random seed
> > generation like the x86 in the efistub only rather than relying on the
> > UEFI firmwares with EFI_RNG_PROTOCOL for the same - for e.g. by using
> > a randomness seed like the boot time or more proper entropy sources
> > like arm64 system timer (see [2] for x86 example).
> >
> > - I guess that the main problem is that most arm64 UEFI firmware
> > vendors still do not support EFI_RNG_PROTOCOL out of the box. We can
> > use the ChaosKey (see [3]) EFI driver and use this USB key as the
> > source of entropy on the arm64 systems for EFI firmwares which do not
> > provide a EFI_RNG_PROTOCOL implementation, but it might not be very
> > feasible to connect it to all boards in a production environment.
> >
> 
> The problem is that arm64 does not have an architected means of
> obtaining entropy, and we shouldn't rely on hacks to get pseudo
> entropy.
> 
> Note that EFI_RNG_PROTOCOL is not only used for KASLR, it is also used
> to seed the kernel entropy pool if the firmware provides an
> implementation of the protocol.
> 
> Any UEFI system that can boot off USB should be able to use the
> ChaosKey as well, but the best approach is obviously to implement
> EFI_RNG_PROTOCOL natively if the platform has an entropy source
> available.
> 
> If a platform vendor wants to hack something up based on the timer or
> the performance counter, they are free to do so. But that doesn't mean
> we should implement anything along those lines in the kernel.
> 
> > B. Regarding the arm64 kaslr support in kdump (I have Cc'ed AKASHI and
> > kexec list in this thread as well for their inputs), but currently we
> > don't seem to have a way to support kaslr in arm64 kdump kernel:
> >
> > - '/chosen/kaslr-seed' a property is zeroed out in the primary kernel
> > (to avoid leaking out randomness secret), but how should this be then
> > handed over to the kdump kernel.
> > - We pass the dtb over to the kdump kernel for arm64 kdump, but the
> > '/chosen/kaslr-seed' property would be zeroed out already by the
> > primary kernel and the secondary would work in a *nokaslr* environment
> > due to the same (see [4] for example)
> >
> 
> What would be the point of randomizing the placement of the kdump
> kernel? And don't say 'because x86 does it', because that is not a
> good reason.

More importantly, neither arm64 _kexec_ supports kaslr.

Currently kexec-tools is set to determine where the kernel actually be
loaded, using a constant offset, text_offset, which comes from an image's
boot header and relocation of an image to the load address is performed
at the very end of the first kernel without knowing whether the 2nd kernel
has kaslr support enabled or not.

> > B. Regarding the arm64 kaslr support in kdump (I have Cc'ed AKASHI and
> > kexec list in this thread as well for their inputs), but currently we
> > don't seem to have a way to support kaslr in arm64 kdump kernel:
> >
> > - '/chosen/kaslr-seed' a property is zeroed out in the primary kernel

So, even if adding /chosen/kaslr-seed to dtb at kexec would not be
difficult, we would have to have efi_entry-like entry code.

Thanks,
-Takahiro AKASHI
