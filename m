From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 13 Mar 2018 11:20:17 +0000
Subject: [Query] ARM64 kaslr support - randomness, seeding and kdump
In-Reply-To: <20180313110747.GJ25863@linaro.org>
References: <CACi5LpMhHt4bjEueOzHZTGpzuR2zoQqXcReL-khoSNLG6=FVmg@mail.gmail.com>
 <CAKv+Gu8qd=rpJkG_GoVO=kkmc4qx_zZD8c_wwE16gr=8wSShSw@mail.gmail.com>
 <20180313102158.GI25863@linaro.org>
 <20180313104715.prurmrizho4ddc4l@lakrids.cambridge.arm.com>
 <20180313110747.GJ25863@linaro.org>
Message-ID: <20180313112016.ocx4qqhji3zfwjhs@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 13, 2018 at 08:07:49PM +0900, AKASHI Takahiro wrote:
> On Tue, Mar 13, 2018 at 10:47:15AM +0000, Mark Rutland wrote:
> > On Tue, Mar 13, 2018 at 07:22:03PM +0900, AKASHI Takahiro wrote:
> > > On Mon, Mar 12, 2018 at 08:58:00PM +0000, Ard Biesheuvel wrote:
> > > > On 12 March 2018 at 20:14, Bhupesh Sharma <bhsharma@redhat.com> wrote:
> > 
> > > More importantly, neither arm64 _kexec_ supports kaslr.
> > 
> > The below is just considering this, and ignoring kdump (where I don't
> > think we care at all about KASLR).
> > 
> > > Currently kexec-tools is set to determine where the kernel actually be
> > > loaded, using a constant offset, text_offset, which comes from an image's
> > > boot header and relocation of an image to the load address is performed
> > > at the very end of the first kernel without knowing whether the 2nd kernel
> > > has kaslr support enabled or not.
> > 
> > The kexec tools shouldn't need to know whether the kernel supports KASLR
> > at all.
> > 
> > If the new kernel image has bit 3 (Kernel physical placement) set, kexec
> > tools can choose to randomize the physical load address, regardless of
> > whether that kernel has KASLR enabled.
> 
> So, by definition, is randomness, if we say so, in physical address not
> part of KASLR?

Physical randomization is not part of the kernel's KASLR implementation.

We happen to do it in the EFI stub, because we can in that context. But
generally, physical randomization is not part of arm64's in-kernel
KASLR.

For various reasons, the physical address that the kernel is loaded to
may be arbitrary, so we have to cope with physical randomization
regardless.

Thanks,
Mark.
