From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 31 Oct 2016 08:51:26 +0000
Subject: [PATCH] [ARM] Fix stack alignment when processing backtraces
In-Reply-To: <20161018170510.GA12248@obsidianresearch.com>
References: <20161018170510.GA12248@obsidianresearch.com>
Message-ID: <20161031085126.GT1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 18, 2016 at 11:05:10AM -0600, Jason Gunthorpe wrote:
> The dumpstm helper within c_backtrace pushed 5 dwords onto the stack
> causing the stack to become unaligned and then calls printk. This
> causes memory corruption in the kernel which assumes AAPCS calling
> convention.
> 
> Since this bit of asm doesn't use the standard prologue just add
> another register to restore alignment.
> 
> Fixes: 7ab3f8d595a1b ("[ARM] Add ability to dump exception stacks to kernel backtraces")
> Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> ---
>  arch/arm/lib/backtrace.S | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> In my case the kernel was hitting a WARN_ON during boot and then
> reliably failed to start the compiled-in initramfs.
> 
> I'm inferring that the stack misalignment caused some kind of memory
> corruption which wiped out the unpacked initramfs.
> 
> Saw with gcc 5.4.0 on a kirkwood armv5te
> 
> diff --git a/arch/arm/lib/backtrace.S b/arch/arm/lib/backtrace.S
> index fab5a50503ae..25e1cce19991 100644
> --- a/arch/arm/lib/backtrace.S
> +++ b/arch/arm/lib/backtrace.S
> @@ -116,7 +116,8 @@ ENDPROC(c_backtrace)
>  #define reg   r5
>  #define stack r6
>  
> -.Ldumpstm:	stmfd	sp!, {instr, reg, stack, r7, lr}
> +	        /* Must maintain 8 byte stack alignment */
> +.Ldumpstm:	stmfd	sp!, {r3, instr, reg, stack, r7, lr}
>  		mov	stack, r0
>  		mov	instr, r1
>  		mov	reg, #10
> @@ -140,7 +141,7 @@ ENDPROC(c_backtrace)
>  		teq	r7, #0
>  		adrne	r0, .Lcr
>  		blne	printk
> -		ldmfd	sp!, {instr, reg, stack, r7, pc}
> +		ldmfd	sp!, {r3, instr, reg, stack, r7, pc}

I'd prefer r8 to get used rather than r3, as it makes it look like
r3 is somehow required to be preserved when that's not the case.
Makes the code slightly more difficult to understand.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
