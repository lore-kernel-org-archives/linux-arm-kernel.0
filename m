From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 20 Mar 2018 23:30:46 +0000
Subject: [PATCH 1/5] bus: arm-cci: use asm unreachable
In-Reply-To: <20180320230206.25289-2-stefan@agner.ch>
References: <20180320230206.25289-1-stefan@agner.ch>
 <20180320230206.25289-2-stefan@agner.ch>
Message-ID: <20180320233046.GL2743@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 21, 2018 at 12:02:02AM +0100, Stefan Agner wrote:
> Mixing asm and C code is not recommended in a naked function by
> gcc and leads to an error when using clang:
>   drivers/bus/arm-cci.c:2107:2: error: non-ASM statement in naked
>   function is not supported
>         unreachable();
>         ^
> 
> Instead of using the unreachable() macro use the assember variant
> ASM_UNREACHABLE.  This will no longer emit __builtin_unreachable(),
> but since the function is naked and its return type is void it seems
> not to have aversive effects.

I think that unreachable() there is rather silly - this function
*does* return, and the comments say as much.  Just delete the silly
"unreachable()", there's no need to put an ASM_UNREACHABLE in there.

The function is not declared as not returning, and nothing in this
file uses it anyway - it's called from the mcpm code, which also
_does_ expect this function to return (if it doesn't, then we're
basically saying the CPU that called it is dead.)

> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  drivers/bus/arm-cci.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
> index 5426c04fe24b..ee9da86fec47 100644
> --- a/drivers/bus/arm-cci.c
> +++ b/drivers/bus/arm-cci.c
> @@ -2084,6 +2084,7 @@ asmlinkage void __naked cci_enable_port_for_self(void)
>  
>  "	mov	r0, #0 \n"
>  "	bx	lr \n"
> +	ASM_UNREACHABLE
>  
>  "	.align	2 \n"
>  "5:	.word	cpu_port - . \n"
> @@ -2103,8 +2104,6 @@ asmlinkage void __naked cci_enable_port_for_self(void)
>  	[sizeof_struct_cpu_port] "i" (sizeof(struct cpu_port)),
>  	[sizeof_struct_ace_port] "i" (sizeof(struct cci_ace_port)),
>  	[offsetof_port_phys] "i" (offsetof(struct cci_ace_port, phys)) );
> -
> -	unreachable();
>  }
>  
>  /**
> -- 
> 2.16.2
> 

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
