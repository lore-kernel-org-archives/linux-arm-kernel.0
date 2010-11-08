From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 8 Nov 2010 10:42:57 +0000
Subject: [PATCH 6/6] ARM: ftrace: enable function graph tracer
In-Reply-To: <20101108091858.GP16938@pengutronix.de>
References: <1289067954-5080-1-git-send-email-rabin@rab.in>
	<1289067954-5080-6-git-send-email-rabin@rab.in>
	<AANLkTin8UO9ixVep0jKK8H5roWEVRDJW4khUpT2TpPs+@mail.gmail.com>
	<20101108091858.GP16938@pengutronix.de>
Message-ID: <AANLkTinmSn1fqKv8sCCP8d0-_0HsLrhtorXvHCovOYve@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/11/8 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> On Sat, Nov 06, 2010 at 07:06:28PM +0000, Catalin Marinas wrote:
>> On Saturday, November 6, 2010, Rabin Vincent <rabin@rab.in> wrote:
>> > Add the options to enable the function graph tracer on ARM. ?Function
>> > graph tracer support requires frame pointers, so exclude Thumb-2 and
>> > also explicitly select FRAME_POINTER in FUNCTION_GRAPH_TRACER since
>> > FUNCTION_TRACER doesn't select FRAME_POINTER when ARM_UNWIND is used
>> > Therefore, with GCC 4.4.0+, you get plain function tracing without frame
>> > pointers, but you'll need them if you want function graph tracing.
>> .....
>> > --- a/kernel/trace/Kconfig
>> > +++ b/kernel/trace/Kconfig
>> > @@ -141,6 +141,7 @@ config FUNCTION_TRACER
>> >
>> > ?config FUNCTION_GRAPH_TRACER
>> > ?? ? ? ?bool "Kernel Function Graph Tracer"
>> > + ? ? ? select FRAME_POINTER if ARM_UNWIND
>>
>> Would it be better to modify FRAME_POINTER definition in the ARM
>> Kconfig so that it is enabled automatically when FUNCTION_GRAPH_TRACER
>> is enabled?
> I don't like that suggestion much because it hides the dependency.
> Moreover a "default y if FUNCTION_GRAPH_TRACER" doesn't work if a
> precondition for FRAME_POINTER isn't true. ?Rabin's approach at least
> generates a warning.

If a precondition for FRAME_POINTER isn't true, we should not force it
via 'select'. We try to get rid of such warnings in the kernel.

However, on ARM the FRAME_POINTER depends on !THUMB2_KERNEL but for
Thumb-2 kernels HAVE_FUNCTION_GRAPH_TRACER is also disabled, so there
isn't a dependency issue here. It's more like a personal preference to
keep the changes within the arch/arm tree.

-- 
Catalin
