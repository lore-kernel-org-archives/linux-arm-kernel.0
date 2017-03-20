From: leo.yan@linaro.org (Leo Yan)
Date: Mon, 20 Mar 2017 20:10:46 +0800
Subject: [PATCH v4 4/7] coresight: add support for CPU debug module
In-Reply-To: <74d6fd19-89f0-7edf-ace3-8b07f13e9569@arm.com>
References: <1489762943-25849-1-git-send-email-leo.yan@linaro.org>
 <1489762943-25849-5-git-send-email-leo.yan@linaro.org>
 <74d6fd19-89f0-7edf-ace3-8b07f13e9569@arm.com>
Message-ID: <20170320121046.GB19581@leoy-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 17, 2017 at 06:44:03PM +0000, Suzuki K Poulose wrote:
> On 17/03/17 15:02, Leo Yan wrote:
> >Coresight includes debug module and usually the module connects with CPU
> >debug logic. ARMv8 architecture reference manual (ARM DDI 0487A.k) has
> >description for related info in "Part H: External Debug".
> >
> >Chapter H7 "The Sample-based Profiling Extension" introduces several
> >sampling registers, e.g. we can check program counter value with
> >combined CPU exception level, secure state, etc. So this is helpful for
> >analysis CPU lockup scenarios, e.g. if one CPU has run into infinite
> >loop with IRQ disabled. In this case the CPU cannot switch context and
> >handle any interrupt (including IPIs), as the result it cannot handle
> >SMP call for stack dump.
> >
> >This patch is to enable coresight debug module, so firstly this driver
> >is to bind apb clock for debug module and this is to ensure the debug
> >module can be accessed from program or external debugger. And the driver
> >uses sample-based registers for debug purpose, e.g. when system detects
> >the CPU lockup and trigger panic, the driver will dump program counter
> 
> Do we dump it when the CPU lockup is detected with this change ? If not,
> we shouldn't claim that here.

Right, the mainline kernel missed Colin Cross's patch to trigger panic
when detect CPU lockup which used by Android common kernel:
http://people.linaro.org/~leo.yan/0001-hardlockup-detect-hard-lockups-without-NMIs-using-se.patch

Will fix it.

[...]

> >+	pr_emerg("\tEDPCSR:  [<%p>] %pS\n", (void *)pc, (void *)pc);
> 
> Are we safe calling %pS on the PC, when the PC offset in implementation defined ?

I did some quick testing, if cannot find proper kernel symbol for PC
value, then %pS will directly output pc value rather than symbol value.

Other suggestions are good for me; I will fix for all for them.

[...]

Thanks,
Leo Yan
