From: omar.luna@linaro.org (Omar Ramirez Luna)
Date: Thu, 2 Aug 2012 17:20:27 -0500
Subject: [PATCH 2/3] ARM: OMAP: hwmod: revise deassert sequence
In-Reply-To: <alpine.DEB.2.00.1208020150240.4177@utopia.booyaka.com>
References: <1342466485-1050-1-git-send-email-omar.luna@linaro.org>
 <1342466485-1050-3-git-send-email-omar.luna@linaro.org>
 <alpine.DEB.2.00.1208020150240.4177@utopia.booyaka.com>
Message-ID: <CALLhW=6-b+kjfG-u3+uXiD64UwoNEdufjJKu0Mx-sGWp6n9csg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi.

On 2 August 2012 02:52, Paul Walmsley <paul@pwsan.com> wrote:
> On Mon, 16 Jul 2012, Omar Ramirez Luna wrote:
>
>> For a reset sequence to complete cleanly, a module needs its
>> associated clocks to be enabled, otherwise the timeout check
>> in prcm code can print a false failure (failed to hardreset)
>> that occurs because the clocks aren't powered ON and the status
>> bit checked can't transition without them.
>>
>> Signed-off-by: Omar Ramirez Luna <omar.luna@linaro.org>
>
> Is enabling the clocks sufficient?

During my testing it seemed enough, besides it looks clk framework is
doing the same as _omap4_enable_module.

> Or do we also need to enable the
> IP block, e.g. by calling
>
>         if (soc_ops.enable_module)
>                 soc_ops.enable_module(oh);
>
> as we do on OMAP4+ in _enable() ?

Basically this is a call to _omap4_enable_module, and the latter will
"Enable the modulemode inside CLKCTRL".

However, _enable_clocks path which ends calling omap2_dflt_clk_enable
does the same thing with its clk->enable_reg field.

So in _enable:

        _enable_clocks(oh);
        if (soc_ops.enable_module)
                soc_ops.enable_module(oh);

The enable_module part seems redundant to me, since the module should
be already enabled by the first call to _enable_clocks.

Regards,

Omar
