From: frank.hofmann@tomtom.com (Frank Hofmann)
Date: Thu, 9 Jun 2011 11:00:56 +0100 (BST)
Subject: [PATCH 4/6] ARM: reset: add reset functionality for jumping to
	a physical address
In-Reply-To: <20110608162429.GA28436@arm.com>
References: <1307379898-14256-5-git-send-email-will.deacon@arm.com>
	<alpine.DEB.2.00.1106071126290.2247@localhost6.localdomain6>
	<alpine.DEB.2.00.1106071223100.2247@localhost6.localdomain6>
	<20110607132220.GB12639@e102144-lin.cambridge.arm.com>
	<alpine.DEB.2.00.1106071435020.2247@localhost6.localdomain6>
	<20110607153654.GA19855@arm.com>
	<alpine.DEB.2.00.1106071714400.2236@localhost6.localdomain6>
	<alpine.DEB.2.00.1106081638420.11513@localhost6.localdomain6>
	<20110608160527.GA6851@e102144-lin.cambridge.arm.com>
	<alpine.DEB.2.00.1106081707040.11513@localhost6.localdomain6>
	<20110608162429.GA28436@arm.com>
Message-ID: <alpine.DEB.2.00.1106091053340.11513@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Wed, 8 Jun 2011, Dave Martin wrote:

> On Wed, Jun 08, 2011 at 05:10:05PM +0100, Frank Hofmann wrote:
[ ... ]
>> It's not just that - the worse bit is that as long as the #define
>> looks like:
>>
>> #define	cpu_reset(addr)		processor.reset(addr)
>>
>> compile is being refused; one has to ditch the argument part of the
>> macro to be able to take the address.
>>
>> I'm unsure how desirable that change is; it's got the unwanted
>> consequence that people who decide to use function names like
>> "graphics_cpu_reset" or "cpu_reset_specialregisters" would fall flat
>> on their face.
>
> The preprocessor won't expand a macro name unless it appears as a separate
> token, surely?
>
> So if I have
>
> #define cpu_reset processor.reset
>
> then
>
> 	cpu_reset(graphics_cpu_reset)
>
> expands to
>
> 	processor.reset(graphics_cpu_reset)
>
> Which is the intention (even if it's a stupid example)

Ah, I was concerned that it'd change

 	graphics_cpu_reset ===> graphics_processor.reset

but you're correct that kind of substitution is not happening.

Anyway as Will mentioned, the !MULTI_CPU case has the #define the 
following way in any case:

#define	____glue(name,fn)	name##fn
#define	__glue(name,fn)		____glue(name,fn)
#define	cpu_reset		__glue(CPU_NAME,_reset)

I.e. in the !MULTI_CPU case cpu_reset is defined without the macro 
argument, while the MULTI_CPU define _has_ the macro argument.

Would it be ok to remove the (args) part from the MULTI_CPU #define then ?

Thanks,
FrankH.

>
> Cheers
> ---Dave
>
>
