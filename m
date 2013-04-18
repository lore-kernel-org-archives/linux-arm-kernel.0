From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 18 Apr 2013 17:22:33 +0100
Subject: [PATCH] Report double word access atomicity on LPAE enabled
 targets through AUXV
In-Reply-To: <20130416172258.GE3770@mudshark.cambridge.arm.com>
References: <C3FF039D-7DE3-4A99-8317-789094095D8B@oracle.com>
 <20130408142406.GL17995@n2100.arm.linux.org.uk>
 <20130408155749.GS17476@mudshark.cambridge.arm.com>
 <CD54D5A4-2E19-49D9-B6E7-051F36AB5DF8@oracle.com>
 <20130416172258.GE3770@mudshark.cambridge.arm.com>
Message-ID: <20130418162232.GB23112@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 16, 2013 at 06:22:59PM +0100, Will Deacon wrote:
> On Fri, Apr 12, 2013 at 09:58:43PM +0100, Vladimir Danushevsky wrote:
> > On Apr 8, 2013, at 11:57 AM, Will Deacon wrote:
> > > Actually, it's not just the presence of those instructions -- it's their
> > > behaviour wrt atomicity. They are only guaranteed to be atomic if the CPU in
> > > question supports LPAE. We could call it "lpae" but it might be set even
> > > when the kernel is using the short-descriptor format.
> > 
> > I also think that ATOMICD would describe the intended behavior better.
> 
> I started having second thoughts about the name, on the offchance that some
> other feature introduced with LPAE is found to be useful to userspace. Then
> userspace would end up checking ATOMICD in order to determine something
> different, which is counter-intuitive.
> 
> Maybe there is no other `killer feature' for userspace with LPAE, but at
> least we'd be reporting what the hardware says, rather than the small bit
> which we're interested in.
> 
> Patch below...
> 
> Will
> 
> --->8
> 
> commit c6eaaa758c7956b18aa0cfabe9500ef73514b319
> Author: Will Deacon <will.deacon@arm.com>
> Date:   Mon Apr 8 17:13:12 2013 +0100
> 
>     ARM: elf: add new hwcap for identifying atomic ldrd/strd instructions
>     
>     CPUs implementing LPAE have atomic ldrd/strd instructions, meaning that
>     userspace software can avoid having to use the exclusive variants of
>     these instructions if they wish.
>     
>     This patch advertises the atomicity of these instructions via the
>     hwcaps, so userspace can detect this CPU feature.
>     
>     Signed-off-by: Will Deacon <will.deacon@arm.com>
> 
> diff --git a/arch/arm/include/uapi/asm/hwcap.h b/arch/arm/include/uapi/asm/hwcap.h
> index 3688fd1..6d34d08 100644
> --- a/arch/arm/include/uapi/asm/hwcap.h
> +++ b/arch/arm/include/uapi/asm/hwcap.h
> @@ -25,6 +25,6 @@
>  #define HWCAP_IDIVT    (1 << 18)
>  #define HWCAP_VFPD32   (1 << 19)       /* set if VFP has 32 regs (not 16) */
>  #define HWCAP_IDIV     (HWCAP_IDIVA | HWCAP_IDIVT)
> -
> +#define HWCAP_LPAE     (1 << 20)

I would rather add individual entries like atomicd. User space does not
need to know whether LPAE is supported or not.

-- 
Catalin
