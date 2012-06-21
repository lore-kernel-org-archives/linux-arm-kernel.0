From: robherring2@gmail.com (Rob Herring)
Date: Thu, 21 Jun 2012 10:00:51 -0500
Subject: [PATCH v3 0/4] DT clock bindings
In-Reply-To: <87bokd15x7.fsf@octavius.laptop.org>
References: <1339512111-11172-1-git-send-email-robherring2@gmail.com>
 <87bokd15x7.fsf@octavius.laptop.org>
Message-ID: <4FE33723.3040403@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Chris,

On 06/21/2012 02:27 AM, Chris Ball wrote:
> Hi Rob,
> 
> On Tue, Jun 12 2012, Rob Herring wrote:
>> This series defines clock bindings for Device-Tree and adds kernel
>> support using the common clock infrastructure. The last patch enables
>> DT clock support for the Calxeda Highbank platform.
>>
>> I'm posting this again to solicit further review. There has been some
>> discussion[1], but no definite path forward. This series is not changed
>> from the last post other than rebasing to v3.5-rc2.
> 
> This is a very useful patchset, thanks!  Mitch Bradley and I have been
> hooking up the mach-mmp ARM subarchitecture to it and we needed to
> make a few changes, mainly because mach-mmp doesn't use COMMON_CLK.
> The changes are:
> 
> 1) Remove the COMMON_CLK dependency that the of_clk_* functions have by
>    moving them into a new file, drivers/clk/clk-of.c.  The OF functions
>    in drivers/clk/clk.c aren't dependent on anything else in clk.c
>    (since you pass them a struct clk) so they can be moved out easily.
>    The of_clk_* entries in clk-provider.h move to clk.h.

Well, if you look at prior versions, it was separate being in
drivers/of/. I'm not sure we want to encourage/allow not converting to
COMMON_CLK. I would consider not using COMMON_CLK is deprecated. Having
a single definition of struct clk is the primary reason for COMMON_CLK.
What is the reason for not converting mmp to COMMON_CLK? It appears to
be a pretty trivial clock implementation, and will be required for
multi-platform kernels.

> 
> 2) Use alloc_bootmem() instead of kzalloc() in of_clk_add_provider(),
>    because we need to set up clocks during .init_early on ARM (which
>    happens pre-slab) so that they are available for platform init.

This depends on 1 as the common clock code would have the same issue.
Generally, the first place clocks are needed is the timer init. At that
point, you can call kzalloc. This is where all the clock init used to be
done until init_early was added and some platforms have moved their
clock init. I don't think there was really ever much reason to move it
other than to make the timer init function only deal with timer setup.

Is alloc_bootmem available on all arches? There's 3 occurrences in
drivers/* which tells me that is the wrong thing to do.

Rob

> I'll send our patches in a reply to this mail.  Are you okay with these
> changes, and would you like to include them in your patchset?
> 
> Thanks very much,
> 
> - Chris.
