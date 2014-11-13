From: segher@kernel.crashing.org (Segher Boessenkool)
Date: Thu, 13 Nov 2014 08:19:50 -0600
Subject: gcc 4.9 build warnings (was: Re: next build: 2674 warnings 1
 failures (next/next-20141022))
In-Reply-To: <2480226.26bJjjL2fl@wuerfel>
References: <5447442c.a9ca440a.2060.5e09@mx.google.com>
 <20141024094412.GN27405@n2100.arm.linux.org.uk>
 <20141024182509.GA31232@gate.crashing.org> <2480226.26bJjjL2fl@wuerfel>
Message-ID: <20141113141950.GA17287@gate.crashing.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 11, 2014 at 10:32:23PM +0100, Arnd Bergmann wrote:
> I've decided to investigate it further. It seems that your change to
> 'arm-linux-eabi' did not have the intended effect.

"It worked for me", i.e., it did build kernels.  I don't build arm terribly
often, does it show?

> I got it to work with this patch:

> -	arm)		TARGET=arm-linux-eabi ;;
> +	arm)		TARGET=arm-linux-gnueabi ;;

That looks right (and Olof says it works :-) ).  I'll apply the patch.

> What happens in gcc apparently is that the configuration logic gets confused
> and uses this entry in gcc/config.gcc:
> 
> arm*-*-eabi*)
>         default_use_cxa_atexit=yes
>         tm_file="dbxelf.h elfos.h arm/unknown-elf.h arm/elf.h arm/bpabi.h"
>         tmake_file="${tmake_file} arm/t-arm arm/t-arm-elf"
>         tm_file="$tm_file newlib-stdint.h"
>         tmake_file="${tmake_file} arm/t-bpabi"
>         use_gcc_stdint=wrap
>         tm_file="${tm_file} arm/aout.h vxworks-dummy.h arm/arm.h"
>         ;;
> 
> instead of this one:
> 
> arm*-*-linux-*)                 # ARM GNU/Linux with ELF

That one would match arm-unknown-linux-eabi (as it does
arm-unknown-linux-gnueabi), not arm-linux-eabi.  "triples" ;-)

arm-linux-eabi canonicalises to arm-linux-eabi;
arm-linux-gnueabi canonicalises to arm-unknown-linux-gnueabi.

>         tm_file="dbxelf.h elfos.h gnu-user.h linux.h linux-android.h glibc-stdint.h arm/elf.h arm/linux-gas.h arm/linux-elf.h"
>         extra_options="${extra_options} linux-android.opt"
>         tmake_file="${tmake_file} arm/t-arm arm/t-arm-elf arm/t-bpabi arm/t-linux-eabi"
>         tm_file="$tm_file arm/bpabi.h arm/linux-eabi.h arm/aout.h vxworks-dummy.h arm/arm.h"
>         # The EABI requires the use of __cxa_atexit.
>         default_use_cxa_atexit=yes
>         with_tls=${with_tls:-gnu}
>         ;;
> 
> so among other things, we are missing linux.h and glibc-stdint.h.

Right.  The kernel should not depend on anything about userland (i.e., the
linux.h header); but the stdint thing is needed to get the ABI you expect it
seems.

Great that you managed to figure out the mess,


Segher
