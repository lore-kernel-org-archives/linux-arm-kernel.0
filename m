From: Russ.Dill@ti.com (Russ Dill)
Date: Thu, 29 Aug 2013 17:25:24 -0700
Subject: [PATCH v4 0/4] ARM: OMAP2+: AM33XX: VDD CORE OPP50 support
In-Reply-To: <87hae8tc6e.fsf@linaro.org>
References: <1376432412-8509-1-git-send-email-Russ.Dill@ti.com>
 <1376487480.3889.64.camel@coredoba.hi.pengutronix.de>
 <CA+Bv8XYe0UzBkjqtO7bNkgNVTQtxiM7Hv93BOu8Lw1=pESOwLA@mail.gmail.com>
 <87txiasqhk.fsf@linaro.org>
 <CA+Bv8XZagHZ9mUuZB49hrH=901fXzoAcV8C0Fm3EfLa2eiBu0w@mail.gmail.com>
 <87ppsw7cgq.fsf@linaro.org>
 <CA+Bv8XbxV=BFjcSsUMX2pz9LeCkSwrjzZmj_=YbHGzyfbLXmaQ@mail.gmail.com>
 <874na8xqfl.fsf@linaro.org>
 <CANacCWzK1w9+XKEoUfS4ZB7QGxi_0JkVWBLs_wsaUjrzW2QB+A@mail.gmail.com>
 <87hae8tc6e.fsf@linaro.org>
Message-ID: <CA+Bv8XaQgOiSiScQW=CVxzXBuG0soafQotApjoVEZ0P9U3netg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 29, 2013 at 2:33 PM, Kevin Hilman <khilman@linaro.org> wrote:
> Vaibhav Bedia <vaibhav.bedia@gmail.com> writes:
[snip]
>> Morevoer, all the suggestions on how to keep the code in Linux working
>> around the complications due to the main memory not being accessible
>> will need to be replicated on the non-Linux s/w stacks and that's just
>> make it more difficult for them.
>
> The linux code has to be very self-contained (in assembler or C), so I'm
> not sure how it's difficult to replicated in any other OS (or non-OS.)

Let me pull on this thread a little bit. Would this involve defining a
bunch of different sections for each arch so that I could do:

void __sram_am33xx am33xx_some_pm_function(args....)
{
}

static struct am33xx_foo_dyn *blargity __sramdata_am33xx = { ...};

static const struct am33xx_foo_const *blarg __sramconst_am33xx = { ... };

The sram push code could then push these sections into sram. There
would then be a set of inlines or macros for converting addresses
within these sections to SRAM addresses, maybe also inlines or macros
for calling code that has been pushed into sram by wrapping the
original function pointer. The macros or inlines that call SRAM code
could perform the trampoline as well.

Would there be much general interest in a scheme like this? Is there
already I scheme like this I haven't noticed. Would such an explosion
of sections be a problem if all platforms started using this for SRAM
code?
