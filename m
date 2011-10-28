From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Fri, 28 Oct 2011 11:29:55 +0200
Subject: [PATCH] AMBA: Use suspend_noriq to force devices into runtime
	suspend
In-Reply-To: <20111027194832.GO19187@n2100.arm.linux.org.uk>
References: <1319730524-29483-1-git-send-email-ulf.hansson@stericsson.com>
	<20111027155434.GN19187@n2100.arm.linux.org.uk>
	<CAKnu2MpGOKFKpO=2mmu4a74gmbCUdO8Ui5+1nEB6GbfitGBLRw@mail.gmail.com>
	<20111027194832.GO19187@n2100.arm.linux.org.uk>
Message-ID: <4EAA7613.3030808@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> On Thu, Oct 27, 2011 at 08:27:36PM +0200, Linus Walleij wrote:
>> I think this patch is on top of that one. This moves the
>> runtime_[suspend|resume] so as to put all the runtime PM stuff
>> inside the same #ifdef block, then adds two new _noirq
>> functions to address the problems from the named
>> commit by Rafael.
> 
> I don't think it does address any problems mentioned by Rafael - the
> referred to commit is about avoiding races between the system suspend
> method and the runtime PM methods which is an entirely different
> problem to ensuring that the bus clock is shutdown on suspend.

Yes, but the solution in patch from Rafael is now preventing 
drivers/buses to do pm_runtime_suspend or pm_runtime_put_sync in their 
suspend hooks. So if devices are in runtime resume state when their 
suspend functions is entered, devices will be kept in runtime resume state.

To accomplish the same things as when a runtime_suspend happens the 
suspend|resume_noirq hooks are now the recommended way to be used which 
is the main reason for this patch.

> 
> Ignoring runtime PM entirely, what this patch is doing is _adding_
> management of the primecell bus clock to the bus layer and taking
> control of that away from drivers.  When I implemented the bus clock
> support, it was based around the bus clock being enabled at probe
> time, and only subsequently disabling it after the driver was
> removed - all other management was left to the driver to manage as
> appropriate.

If I not misunderstood something, the bus clock is supposed to be 
controlled by the amba bus runtime functions. The control of the vcore 
regulator is up to each amba driver (amba bus handles it in probe and 
remove only). Please clarify if I missed out something here.

> 
> That brings up the question whether there has been any check to
> ensure that there are no drivers already managing the bus clock in
> their suspend methods - if there are, this patch has the potential
> to make the bus clock enable count to negative.
> 

The count is always restored as well as the runtime state from 
amba_pm_resume_noirq.

> There's also the related point here that the behaviour that you get
> for the bus clock from a system suspend depends on whether you have
> runtime-PM configured or not - and that's a recipe for drivers being
> scattered with ifdefs to 'undo' this variable semantic.
> 
> However, that's not the only problem - let's look closer at what is
> being done in the patch.
> 
> The ordering on suspend is:
> 
> Enter amba_pm_suspend_noirq()
> Call amba_pm_runtime_suspend_noirq()
> 	If runtime PM is not suspended
> 		Disable pclk
> Call driver suspend_noirq method
> Return
> ...
> Enter amba_pm_resume_noirq()
> 	If runtime PM is not suspended
> 		Enable pclk
> Call driver resume_noirq method
> Call amba_pm_runtime_resume_noirq()
> Return
> 
> This _can't_ be correct - we're potentially disabling the bus clock
> and then calling the driver (which may try to access the registers)
> which may cause a bus fault, a data abort and therefore a kernel oops.
> That's really not nice and sane behaviour.

I agree! Let's reverse the order of when calling noirq callbacks!

Although I would like the status of pm_runtime_status_suspended to be 
fetched before we enter any noirq callback. This will make it possible 
for the noirq function to change runtime state, which may be wanted to 
for example prevent an unnecessary runtime resume during system resume.

> 
> Also throw into the mix whether it's appropriate for the bus clock
> to be turned off while the primecell is acting as a wakeup source -
> can we safely say that it is legal and proper to disable the bus
> clock for every primecell?

A most valid question.

If you foresee that any amba driver would like to keep the device/bus 
runtime resumed while the system is suspended; I can add a amba bus 
function to be called from a driver probe function to set a flag to 
prevent "force runtime suspend" from the suspend_noirq in the amba bus.

Or maybe there is another more generic way of telling that "this" device 
is a wake_up device, do not runtime_suspend it.

> 

Best regards
Ulf Hansson
