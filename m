From: kyle@redhat.com (Kyle McMartin)
Date: Thu, 16 Jan 2014 12:53:18 -0500
Subject: [PATCH] aarch64: always map VDSO at worst case alignment
In-Reply-To: <20140116174344.GJ30257@mudshark.cambridge.arm.com>
References: <20140115214144.GF18705@redacted.bos.redhat.com>
 <20140116174344.GJ30257@mudshark.cambridge.arm.com>
Message-ID: <20140116175318.GK18705@redacted.bos.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 16, 2014 at 05:43:44PM +0000, Will Deacon wrote:
> > +		struct vm_unmapped_area_info info =
> > +			{
> > +				.flags = 0,
> > +				.length = vdso_mapping_len,
> > +				.low_limit = mm->mmap_base,
> > +				.high_limit = TASK_SIZE,
> > +				.align_mask = (1 << 16) - 1,
> > +			};
> > +		vdso_base = vm_unmapped_area(&info);
> > +	}
> 
> I don't like this fix. The kernel is perfectly alright mapping the vdso at
> the actual page size, as opposed to the maximum. Since the vdso isn't
> demand-paged, we can actually just tell the linker not to bother forcing 64k
> (worst case) alignment for PT_LOAD segments. Please can you try the patch
> below?
> 

Me either, tbh. ;-)

I was testing out using -Wl,-z,max-page-size for the
!CONFIG_ARM64_64K_PAGES case, and that seemed to work. A quick compile
check shows the segment alignment being 0x10 with -Wl,-n:

kmcmarti ~/linux $ eu-readelf -l
arch/arm64/kernel/vdso/vdso.so
Program Headers:
  Type           Offset   VirtAddr           PhysAddr           FileSiz
MemSiz   Flg Align
  LOAD           0x000000 0x0000000000000000 0x0000000000000000 0x000700
0x000700 R E 0x10

so I think that should work nicely!

I'll reboot a machine with this fix to test it as soon as possible.

Acked-by: Kyle McMartin <kyle@redhat.com>

> --- a/arch/arm64/kernel/vdso/Makefile
> +++ b/arch/arm64/kernel/vdso/Makefile
> @@ -48,7 +48,7 @@ $(obj-vdso): %.o: %.S
>  
>  # Actual build commands
>  quiet_cmd_vdsold = VDSOL $@
> -      cmd_vdsold = $(CC) $(c_flags) -Wl,-T $^ -o $@
> +      cmd_vdsold = $(CC) $(c_flags) -Wl,-n -Wl,-T $^ -o $@
>  quiet_cmd_vdsoas = VDSOA $@
>        cmd_vdsoas = $(CC) $(a_flags) -c -o $@ $<
>  
