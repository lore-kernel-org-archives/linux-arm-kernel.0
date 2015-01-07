From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 07 Jan 2015 10:15:56 -0700
Subject: [PATCH 1/4] ARM: tegra: rely on bootloader pinmux programming
 on nyan-big
In-Reply-To: <CAAObsKB1gMcLZ=n8Mc6JSLQHn5-6VWOhERLgYTdi6nit6yCj5w@mail.gmail.com>
References: <1420540653-14816-1-git-send-email-tomeu.vizoso@collabora.com>
 <1420540653-14816-2-git-send-email-tomeu.vizoso@collabora.com>
 <54AC16B0.5050703@wwwdotorg.org>
 <CAAObsKB1gMcLZ=n8Mc6JSLQHn5-6VWOhERLgYTdi6nit6yCj5w@mail.gmail.com>
Message-ID: <54AD69CC.7010902@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/07/2015 01:06 AM, Tomeu Vizoso wrote:
> On 6 January 2015 at 18:09, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> On 01/06/2015 03:37 AM, Tomeu Vizoso wrote:
>>>
>>> Following 6dbaff2b, the kernel expects that the bootloader has correctly
>>> programmed the Tegra pinmux.
>>>
>>> DTs for the Jetson and the Venice2 had been updated already but this one
>>> was left behind.
>>
>>
>> So this setup is true for NVIDIA-controlled development/reference boards
>> where we've ensured that the bootloader sets up 100% of the pinmux.
>>
>> However, I know that Coreboot on this board doesn't set up everything in the
>> pinmux, and since it's in r/o flash never will. As such, I'm not sure this
>> change is safe for this board. That is, unless you want to force upstream
>> kernels to be booted via a chain-loaded path: Coreboot (r/o) -> U-Boot (r/w
>> with full pinmux setup) -> kernel.
>>
>>> Have tested this with the stock vendor firmware (coreboot) and have found
>>> no
>>> issues.
>>
>>
>> There are presumably a bunch of features which aren't yet supported
>> upstream, and hence you couldn't test though? That means we might find that
>> parts of the pinmux aren't yet programmed but need to be to enable those
>> features.
>
> Sure, there's no chance that my testing could have been extensive enough.
>
> Following Andrew's feedback, I will be looking at getting the pinmux
> programming right in the DTs.

As an FYI, the way this typically works (for NVIDIA reference boards, 
and many/most customer boards) is that NVIDIA syseng publishes an Excel 
spreadsheet that can be edited to define the board's pinmux, and which 
performs some error checks. This spreadsheet can directly generate (via 
Excel macros/...) pinmux data tables and/or DT files for our 
product/internal/downstream Android and L4T kernels. For recent SoCs, 
the tegra-pinmux-scripts project[1] can take a CSV representation of the 
spreadsheet and generate both a U-Boot header file (for upstream or L4T; 
they're the same) and upstream Linux kernel DT files that represent the 
pinmux.

So, your best bet is to see if such a spreadsheet exists for these 
platforms, and import it into tegra-pinmux-scripts. That will save a lot 
of work if the spreadsheet exists (and is up-to-date).

[1] https://github.com/NVIDIA/tegra-pinmux-scripts
