From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 2 Nov 2011 09:02:34 +0000
Subject: [PATCH] AMBA: Use suspend_noriq to force devices into runtime
	suspend
In-Reply-To: <4EAA7613.3030808@stericsson.com>
References: <1319730524-29483-1-git-send-email-ulf.hansson@stericsson.com>
	<20111027155434.GN19187@n2100.arm.linux.org.uk>
	<CAKnu2MpGOKFKpO=2mmu4a74gmbCUdO8Ui5+1nEB6GbfitGBLRw@mail.gmail.com>
	<20111027194832.GO19187@n2100.arm.linux.org.uk>
	<4EAA7613.3030808@stericsson.com>
Message-ID: <20111102090234.GW19187@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 28, 2011 at 11:29:55AM +0200, Ulf Hansson wrote:
> Russell King - ARM Linux wrote:
>> On Thu, Oct 27, 2011 at 08:27:36PM +0200, Linus Walleij wrote:
>>> I think this patch is on top of that one. This moves the
>>> runtime_[suspend|resume] so as to put all the runtime PM stuff
>>> inside the same #ifdef block, then adds two new _noirq
>>> functions to address the problems from the named
>>> commit by Rafael.
>>
>> I don't think it does address any problems mentioned by Rafael - the
>> referred to commit is about avoiding races between the system suspend
>> method and the runtime PM methods which is an entirely different
>> problem to ensuring that the bus clock is shutdown on suspend.
>
> Yes, but the solution in patch from Rafael is now preventing
> drivers/buses to do pm_runtime_suspend or pm_runtime_put_sync in their
> suspend hooks. So if devices are in runtime resume state when their
> suspend functions is entered, devices will be kept in runtime resume
> state.
>
> To accomplish the same things as when a runtime_suspend happens the
> suspend|resume_noirq hooks are now the recommended way to be used which
> is the main reason for this patch.

I think the problem is actually much worse - what if the device is
already runtime-PM suspended at the point that we enter the suspend
callbacks. pm_runtime_get_noresume() in __device_suspend() won't
resume the device, which means potentially registers won't be
accessible.

So, as things now stand, suspend callbacks can be entered with runtime-PM
in either state, although the 'usage_count' will be incremented preventing
a runtime-PM suspend occuring.

>> Ignoring runtime PM entirely, what this patch is doing is _adding_
>> management of the primecell bus clock to the bus layer and taking
>> control of that away from drivers.  When I implemented the bus clock
>> support, it was based around the bus clock being enabled at probe
>> time, and only subsequently disabling it after the driver was
>> removed - all other management was left to the driver to manage as
>> appropriate.
>
> If I not misunderstood something, the bus clock is supposed to be  
> controlled by the amba bus runtime functions. The control of the vcore  
> regulator is up to each amba driver (amba bus handles it in probe and  
> remove only). Please clarify if I missed out something here.

For runtime-PM, it is the intention that the bus clock is controlled
by the bus-level runtime functions.  However, ihis opens a can of worms
as I mentioned in my previous message - and is quited below.

>> That brings up the question whether there has been any check to
>> ensure that there are no drivers already managing the bus clock in
>> their suspend methods - if there are, this patch has the potential
>> to make the bus clock enable count to negative.
>
> The count is always restored as well as the runtime state from  
> amba_pm_resume_noirq.

No clock counts are ever 'restored' - they're never saved.  If you do
this:

	clk_enable(clk);
	clk_disable(clk);
	clk_disable(clk);

then the second clk_disable() will spit out a warning and refuse to
decrement the count (because non-zero counts mean that the clock is
enabled.)

>> There's also the related point here that the behaviour that you get
>> for the bus clock from a system suspend depends on whether you have
>> runtime-PM configured or not - and that's a recipe for drivers being
>> scattered with ifdefs to 'undo' this variable semantic.

>> Also throw into the mix whether it's appropriate for the bus clock
>> to be turned off while the primecell is acting as a wakeup source -
>> can we safely say that it is legal and proper to disable the bus
>> clock for every primecell?
>
> A most valid question.
>
> If you foresee that any amba driver would like to keep the device/bus  
> runtime resumed while the system is suspended; I can add a amba bus  
> function to be called from a driver probe function to set a flag to  
> prevent "force runtime suspend" from the suspend_noirq in the amba bus.

We don't need flags.  If we go down the route of managing the bus clock
on system suspend and a driver wants to keep the bus clock on while
suspended it can simply issue an amba_pclk_enable() in its own suspend
method and an amba_pclk_disable() in its resume method.  Starting to
create flags for these corner cases just makes things a lot more
complex by adding exceptions and creating more hairly code.
