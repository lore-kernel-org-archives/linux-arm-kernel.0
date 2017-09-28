From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 28 Sep 2017 13:42:31 +0100
Subject: [PATCH] scripts/decodecode: Fix decoding for AArch64 (arm64)
 instructions
In-Reply-To: <1506596147-23630-1-git-send-email-will.deacon@arm.com>
References: <1506596147-23630-1-git-send-email-will.deacon@arm.com>
Message-ID: <20170928124206.GA3611@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 28, 2017 at 11:55:47AM +0100, Will Deacon wrote:
> There are a couple of problems with the decodecode script and arm64:
> 
> 1. AArch64 objdump refuses to disassemble .4byte directives as instructions,
>    insisting that they are data values and displaying them as:
> 
> 	a94153f3	.word	0xa94153f3		<-- trapping instruction
> 
>    This is resolved by using the .inst directive instead.
> 
> 2. Disassembly of branch instructions attempts to provide the target as
>    an offset from a symbol, e.g.:
> 
>    0:	34000082	cbz	w2, 10 <.text+0x10>
> 
>   however this falls foul of the grep -v, which matches lines containing
>   ".text" and ends up removing all branch instructions from the dump.

Any idea why this doesn't affect other arches too ... or does it?

> This patch resolves both issues by using the .inst directive for 4-byte
> quantities on arm64 and stripping the resulting binaries (as is done on
> arm already) to remove the mapping symbols.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> 
> ---
>  scripts/decodecode | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/scripts/decodecode b/scripts/decodecode
> index d8824f37acce..67214ec5b2cb 100755
> --- a/scripts/decodecode
> +++ b/scripts/decodecode
> @@ -58,6 +58,14 @@ disas() {
>  		${CROSS_COMPILE}strip $1.o
>  	fi
>  
> +	if [ "$ARCH" = "arm64" ]; then
> +		if [ $width -eq 4 ]; then
> +			type=inst

Can we merge with arm here, or does arm still support toolchains that
don't have .inst?  Anyway, no big deal.

> +		fi
> +
> +		${CROSS_COMPILE}strip $1.o
> +	fi
> +
>  	${CROSS_COMPILE}objdump $OBJDUMPFLAGS -S $1.o | \
>  		grep -v "/tmp\|Disassembly\|\.text\|^$" > $1.dis 2>&1

FWIW,

Reviewed-by: Dave Martin <Dave.Martin@arm.com>

Here's hoping someone runs this as a CGI script somewhere ;) 

Cheers
---Dave
