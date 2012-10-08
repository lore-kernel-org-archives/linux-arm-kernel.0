From: dave.martin@linaro.org (Dave Martin)
Date: Mon, 8 Oct 2012 11:46:49 +0100
Subject: [PATCH] [ARM] Use AT() in the linker script to create correct
 program headers
In-Reply-To: <20121004175907.GB2994@obsidianresearch.com>
References: <20121001153952.GB2100@linaro.org>
 <20121001160639.GA31620@obsidianresearch.com>
 <20121001175647.GD2100@linaro.org>
 <20121001183543.GC22342@obsidianresearch.com>
 <20121002102346.GB2108@linaro.org>
 <20121002174759.GC23733@obsidianresearch.com>
 <20121003104335.GA2254@linaro.org>
 <20121003184437.GB12231@obsidianresearch.com>
 <20121004113637.GA2117@linaro.org>
 <20121004175907.GB2994@obsidianresearch.com>
Message-ID: <20121008104649.GD2302@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 04, 2012 at 11:59:07AM -0600, Jason Gunthorpe wrote:
> On Thu, Oct 04, 2012 at 12:36:37PM +0100, Dave Martin wrote:
> 
> > OK, so it is supported, but not for ARM, yet.  I'm not sure that
> > such a patch would be rejected, since building in a DTB is not
> > really that different from building in a command-line.
> 
> Maybe I will be able to look at this in a few months..
> 
> > The other solution to this problem is to distribute the dtb
> > alongside the kernel as a supplementary image (similar to
> > initramfs), with the bootloader doing the bare minimum of
> > modifications to it.
> 
> Yes, but we still need rely on complex code like I2C/MTD to create a
> correct DTB, which again puts us back to patching the kernel for that
> functionality.

I'm still confused as to where this complexity is coming from.

If you need to run some complex I2C and MTD code to generate the DT, what
is that code doing?  If it is probing to get the information, then can you
avoid putting the info in the DT at all?  Primarily the DT is to describe
those aspects of the hardware which can't be probed.

Otherwise, you that have a few static configurations: you could have one
pre-baked DT per hardware platform, and choose the correct one once you
have detected the platform.
 
> > Naturally, if zero modifications are needed then the bootloader does not
> > need libfdt (or equivalent code) at all.
> 
> If only :)
> 
> > One other option open to you would be to provide an ELF image loadable
> > by your bootloader via a simple wrapper.  This would probably be a more
> > robust approach than carrying patches against head.S, since it removes
> > any intimate dependency on the kernel code itself.
> 
> This is what I ment by having a 2nd stage loader, but this example is
> not complete because at this point you also have to patch into the DTB
> the initrd address (passed in r0/r1), and the various MAC addresses
> (getting them is the hard part..).
> 
> The nice thing about the head.S patch is that it lives right after
> _entry, so there actually are no dependencies on the kernel code, it
> executes in the same environment as the example you presented. 

Well, logically there's little difference unless your patch were to be
merged.  An out-of-tree patch against head.S could be more effort to
maintain in some situations, but that code doesn't evolve rapidly.

> Anyhow, exploring a CONFIG_ARM_BUILT_IN_DTB.. I think I'd add
> something like this to head.S:
> 
> #ifdef CONFIG_ARM_BUILT_IN_DTB
>        adr     r3,bootloader_r0
>        stmia   r3,{r0,r1,r2}
>        mov     r2, #0
>        mov     r1, #0
>        mov     r0, #0
> #else
>        bl      __vet_atags
> #endif
> 
> And something like this to early_dt_fixup:
> 
> #ifdef CONFIG_ARM_BUILT_IN_DTB
>         for_each_dt_provider(dtp) {
> 	      devtree = dtp->get_dtb();
> 	      if (devtree)
> 	      	   break;
>         }
> #else
>         devtree = phys_to_virt(dt_phys);
> #endif
> 
> Where the 'dev tree provider' would use the stored bootloader
> registers and any other information to return the proper DTB. 

It would need developing a bit, but something like that might be
possible -- it should probably be discussed via devicetree-discuss.

If it is doing anything less trivial than picking a pre-baked DT, the
rationale would need to be carefully argued.

Cheers
---Dave
