From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 24 Jan 2013 11:57:57 +0530
Subject: [PATCH v5 9/9] ARM: davinci: da850: Added dsp clock definition
In-Reply-To: <13514BD7FAEBA745BBD7D8A672905C1431206095@DFLE08.ent.ti.com>
References: <1357863807-380-1-git-send-email-rtivy@ti.com>
 <1357863807-380-10-git-send-email-rtivy@ti.com> <50FE802E.2020306@ti.com>
 <13514BD7FAEBA745BBD7D8A672905C1431206095@DFLE08.ent.ti.com>
Message-ID: <5100D46D.9030408@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/23/2013 7:07 AM, Tivy, Robert wrote:
>> -----Original Message-----
>> From: Nori, Sekhar
>> Sent: Tuesday, January 22, 2013 4:04 AM
>>
>> Rob,
>>
>> On 1/11/2013 5:53 AM, Robert Tivy wrote:
>>> Added dsp clock definition, keyed to "davinci-rproc.0".
>>>
>>> Signed-off-by: Robert Tivy <rtivy@ti.com>
>>> ---
>>>  arch/arm/mach-davinci/da850.c |    9 +++++++++
>>>  1 file changed, 9 insertions(+)
>>>
>>> diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-
>> davinci/da850.c
>>> index 097fcb2..50107c5 100644
>>> --- a/arch/arm/mach-davinci/da850.c
>>> +++ b/arch/arm/mach-davinci/da850.c
>>> @@ -375,6 +375,14 @@ static struct clk sata_clk = {
>>>  	.flags		= PSC_FORCE,
>>>  };
>>>
>>> +static struct clk dsp_clk = {
>>> +	.name		= "dsp",
>>> +	.parent		= &pll0_sysclk1,
>>> +	.domain		= DAVINCI_GPSC_DSPDOMAIN,
>>> +	.lpsc		= DA8XX_LPSC0_GEM,
>>> +	.flags		= PSC_LRST,
>>> +};
>>> +
>>>  static struct clk_lookup da850_clks[] = {
>>>  	CLK(NULL,		"ref",		&ref_clk),
>>>  	CLK(NULL,		"pll0",		&pll0_clk),
>>> @@ -421,6 +429,7 @@ static struct clk_lookup da850_clks[] = {
>>>  	CLK("spi_davinci.1",	NULL,		&spi1_clk),
>>>  	CLK("vpif",		NULL,		&vpif_clk),
>>>  	CLK("ahci",		NULL,		&sata_clk),
>>> +	CLK("davinci-rproc.0",	NULL,		&dsp_clk),
>>
>> Adding this clock node without the having the driver probed leads to
>> kernel hang while booting. With CONFIG_DAVINCI_RESET_CLOCKS=n, the
>> kernel boot fine. It looks like there is some trouble disabling the
>> clock if it is not used. Can you please check this issue?
>>
>> Thanks,
>> Sekhar
> 
> Sekhar,
> 
> Thankyou for trying that out.
> 
> I discovered that the kernel boot hang is caused when trying to disable this clk during init, from within the function davinci_clk_disable_unused().  That function calls davinci_psc_config() which attempts to disable the DSP clock.  Since this clk is enabled after reset, disabling it involves a state transition, and therefore the function must wait for GOSTAT[1] to be 0.  For most peripherals this happens automatically, but for the DSP (and ARM, too), the DSP must execute the IDLE instruction to allow a clock enable->disable transition.  Since this is bootup and there is no real program on the DSP yet, this doesn't happen.
> 
> I was able to overcome this by adding PSC_FORCE to the clk->flags for dsp_clk.  In fact, without PSC_FORCE I was not able to "rmmod davinci_remoteproc" since the firmware file that I'm loading did not execute IDLE.  It feels like for davinci we should have a way to control the clk->flags' PSC_FORCE setting at run-time.  The PSC_FORCE would be set initially (during boot) and the user (or system integrator) would have a way to unset it dynamically.  That way, when the DSP firmware does actually have a structured way to enter IDLE, the user can say "I'd like a structured shutdown" and unset PSC_FORCE (via a clean API).  But for now I'm just going to turn on PSC_FORCE:
> 	.flags		= PSC_LRST | PSC_FORCE,

Thanks for the debug. It works for me after I added PSC_FORCE. Here is 
the patch I am finally committing.

Thanks,
Sekhar

commit 09810a853b9a7920ba8c250d18815ef236effc47
Author:     Robert Tivy <rtivy@ti.com>
AuthorDate: Thu Jan 10 16:23:22 2013 -0800
Commit:     Sekhar Nori <nsekhar@ti.com>
CommitDate: Thu Jan 24 10:54:08 2013 +0530

    ARM: davinci: da850: add dsp clock definition
    
    Added dsp clock definition, keyed to "davinci-rproc.0".
    DSP clocks is derived from pll0 sysclk1. Add a clock tree
    node for that too.
    
    Signed-off-by: Robert Tivy <rtivy@ti.com>
    [nsekhar at ti.com: merge addition of pll0 sysclk1 and dsp clock
    into one commit. Add PSC_FORCE to dsp clock node to handle the
    case where DSP does not go into IDLE and its clock needs to
    be disabled.]
    Signed-off-by: Sekhar Nori <nsekhar@ti.com>

diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 6b9154e..0c4a26d 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -76,6 +76,13 @@ static struct clk pll0_aux_clk = {
 	.flags		= CLK_PLL | PRE_PLL,
 };
 
+static struct clk pll0_sysclk1 = {
+	.name		= "pll0_sysclk1",
+	.parent		= &pll0_clk,
+	.flags		= CLK_PLL,
+	.div_reg	= PLLDIV1,
+};
+
 static struct clk pll0_sysclk2 = {
 	.name		= "pll0_sysclk2",
 	.parent		= &pll0_clk,
@@ -368,10 +375,19 @@ static struct clk sata_clk = {
 	.flags		= PSC_FORCE,
 };
 
+static struct clk dsp_clk = {
+	.name		= "dsp",
+	.parent		= &pll0_sysclk1,
+	.domain		= DAVINCI_GPSC_DSPDOMAIN,
+	.lpsc		= DA8XX_LPSC0_GEM,
+	.flags		= PSC_LRST | PSC_FORCE,
+};
+
 static struct clk_lookup da850_clks[] = {
 	CLK(NULL,		"ref",		&ref_clk),
 	CLK(NULL,		"pll0",		&pll0_clk),
 	CLK(NULL,		"pll0_aux",	&pll0_aux_clk),
+	CLK(NULL,		"pll0_sysclk1",	&pll0_sysclk1),
 	CLK(NULL,		"pll0_sysclk2",	&pll0_sysclk2),
 	CLK(NULL,		"pll0_sysclk3",	&pll0_sysclk3),
 	CLK(NULL,		"pll0_sysclk4",	&pll0_sysclk4),
@@ -413,6 +429,7 @@ static struct clk_lookup da850_clks[] = {
 	CLK("spi_davinci.1",	NULL,		&spi1_clk),
 	CLK("vpif",		NULL,		&vpif_clk),
 	CLK("ahci",		NULL,		&sata_clk),
+	CLK("davinci-rproc.0",	NULL,		&dsp_clk),
 	CLK(NULL,		NULL,		NULL),
 };
 
