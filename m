From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 29 Sep 2017 11:07:33 +0100
Subject: [PATCH] scripts/decodecode: Fix decoding for AArch64 (arm64)
 instructions
In-Reply-To: <20170928180135.GH9892@arm.com>
References: <1506596147-23630-1-git-send-email-will.deacon@arm.com>
 <20170928124206.GA3611@e103592.cambridge.arm.com>
 <20170928141447.GA27788@arm.com>
 <20170928143704.GC3611@e103592.cambridge.arm.com>
 <20170928180135.GH9892@arm.com>
Message-ID: <20170929100732.GE3611@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 28, 2017 at 07:01:35PM +0100, Will Deacon wrote:
> On Thu, Sep 28, 2017 at 03:37:04PM +0100, Dave Martin wrote:
> > On Thu, Sep 28, 2017 at 03:14:47PM +0100, Will Deacon wrote:
> > > On Thu, Sep 28, 2017 at 01:42:31PM +0100, Dave Martin wrote:
> > > > On Thu, Sep 28, 2017 at 11:55:47AM +0100, Will Deacon wrote:
> > > > > There are a couple of problems with the decodecode script and arm64:
> > > > > 
> > > > > 1. AArch64 objdump refuses to disassemble .4byte directives as instructions,
> > > > >    insisting that they are data values and displaying them as:
> > > > > 
> > > > > 	a94153f3	.word	0xa94153f3		<-- trapping instruction
> > > > > 
> > > > >    This is resolved by using the .inst directive instead.
> > > > > 
> > > > > 2. Disassembly of branch instructions attempts to provide the target as
> > > > >    an offset from a symbol, e.g.:
> > > > > 
> > > > >    0:	34000082	cbz	w2, 10 <.text+0x10>
> > > > > 
> > > > >   however this falls foul of the grep -v, which matches lines containing
> > > > >   ".text" and ends up removing all branch instructions from the dump.
> > > > 
> > > > Any idea why this doesn't affect other arches too ... or does it?
> > > 
> > > I'm not sure, although I don't know how .inst works for architectures
> > > with variable-length instructions and I *guess* the disassembly is less
> > > fussy about data vs text for those targets.
> > 
> > I rather meant the target disassembly for relative branches in the
> > absence of labels.
> > 
> > Anyway, I think this is at least harmless to other arches, and possibly
> > helpful to them (if they disassemble those branch targets in the same
> > sort of way).
> 
> Ah, I see what you mean. Something like the fixup below on top.
> 
> Will
> 
> --->8
> 
> diff --git a/scripts/decodecode b/scripts/decodecode
> index 67214ec5b2cb..f1ec57c3cbf7 100755
> --- a/scripts/decodecode
> +++ b/scripts/decodecode
> @@ -49,21 +49,14 @@ esac
>  
>  disas() {
>  	${CROSS_COMPILE}as $AFLAGS -o $1.o $1.s > /dev/null 2>&1
> +	${CROSS_COMPILE}strip $1.o
>  
> -	if [ "$ARCH" = "arm" ]; then
> -		if [ $width -eq 2 ]; then
> -			OBJDUMPFLAGS="-M force-thumb"
> -		fi
> -
> -		${CROSS_COMPILE}strip $1.o
> +	if [ "$ARCH" = "arm" -a $width -eq 2 ]; then
> +		OBJDUMPFLAGS="-M force-thumb"
>  	fi
>  
> -	if [ "$ARCH" = "arm64" ]; then
> -		if [ $width -eq 4 ]; then
> -			type=inst
> -		fi
> -
> -		${CROSS_COMPILE}strip $1.o
> +	if [ "$ARCH" = "arm64" -a $width -eq 4 ]; then
> +		type=inst
>  	fi

Reasonable, though I guess it doesn't matter unless another arch really
cares -- in which case someone will eventually spot the issue and
probably write the same patch.

Cheers
---Dave
