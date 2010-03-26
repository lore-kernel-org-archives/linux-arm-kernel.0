From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Thu, 25 Mar 2010 22:55:00 -0400
Subject: PXA3xx internal SRAM
In-Reply-To: <63386a3d1003250847n3ac9e1fg5f7873bad6006af@mail.gmail.com>
References: <20100321124739.GG30801@buzzloop.caiaq.de>
	<63386a3d1003221409j63413b5o7a0515836eaa8b86@mail.gmail.com>
	<771cded01003250558y6bf9a8b6q7fc969d448faa1df@mail.gmail.com>
	<63386a3d1003250847n3ac9e1fg5f7873bad6006af@mail.gmail.com>
Message-ID: <771cded01003251955m53ed1b61u9fa89208cdf9c0db@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 25, 2010 at 11:47 AM, Linus Walleij
<linus.ml.walleij@gmail.com> wrote:
>> It's depend on the silicon implementation. It seems
>> that current implementation of tcm module is for seprated ITCM & DTCM.
>
> You mean that in PXA3xx it's an ITCM and a DTCM and the thing
> called SRAM is actually an ITCM?
>

TCM is in the same level of L1 cache. Internal SRAM of PXA3xx is in
the bus, so it's behind of L2.

>> But if it's a unified TCM, we can't copy data into TCM in
>> initialization since there's no DTCM.
>
> Yeah that's true... :-/
>
> I think it can easily be fixed with some #if FOO preprocessor
> hacking in arch/arm/kernel/vmlinux.ld.S so that symbols marked
> with .tcm.data are allocated to the DTCM_OFFSET is not
> defined, so you only define ITCM_OFFSET and ITCM_END
> for your system.
>
> If you promise to test it, I can make a try at fixing this,
> because I have no system to test it on.
>

Internal SRAM is different from TCM. It seems that SRAM can't fit tcm
code. I haven't any silicon with unified TCM. So I can't help you on
this.

>> 5. ARM supports smart cache that switch the functionality between TCM
>> and cache. Is it necessary to be supported by TCM module?
>
> It is not necessary and not supported right now, but it would be cool
> to have this. In that case we shouldn't free the pages used by the
> TCM upload area after kernel init, instead we should keep it as a
> backup storage area for TCM when it's used as cache, then switch
> this back and forth when TCM is to be used.
>
> Do you have this in your system?
>
> I assume the only practical usage for this would be to disable a
> cache and enable its use as TCM when going to sleep for example,
> is this what you intend to do with your system?
>

In pxa168, SRAM can be configured either SRAM or L2. Maybe keeping it
in one function is better.

>> reading co-processor instruction is
>> contained. It means that it's closely bind to ARM TCM. In custom SoC,
>> internal SRAM is just similar TCM. It doesn't support these
>> co-processor instruction of acquiring region and size. What's your
>> suggestion on supporting this kind of SoC in TCM module?
>
> The TCM code is used for the TCM that is part of the ARM architecture,
> it has no other intended usage.
>
> SRAMs are typically Von Neumann type and not as complicated
> as a pair of TCMs.
>
> There are several SRAM solutions already in the kernel I think,
> implemented per architecture, but no generic SRAM handler,
> sadly :-(
>
> It would be good if SRAM could be handled by a per-machine
> vmlinux.ld.S file so that code can be compiled there from simple
> C files, a generic include/linux/sram.h file to tag code sections properly
> and something generic in the style of the TCM code
> to handle the copying of code to SRAM and handling the ?residual
> memory pool.
>

It seems that copying code into SRAM may not bring performance
benefit. If code can be locked into L2, it may get more performance.
Since SRAM is behind of L2.

So I think the requirement between SRAM and TCM is totally different.
SRAM can't get benefit from TCM code. SRAM just need a memory
management for storing data.

Thanks
Haojian
