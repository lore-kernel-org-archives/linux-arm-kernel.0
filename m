From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Tue, 24 Nov 2015 12:15:13 +0000
Subject: [RFC/PATCH 0/3] ARM: Use udiv/sdiv for __aeabi_{u}idiv library
 functions
In-Reply-To: <3811106.btnGdZynet@wuerfel> (Arnd Bergmann's message of "Tue, 24
 Nov 2015 11:17:23 +0100")
References: <1448068997-26631-1-git-send-email-sboyd@codeaurora.org>
 <6359949.bhCrxaQvmL@wuerfel> <20151123231352.GH19156@codeaurora.org>
 <3811106.btnGdZynet@wuerfel>
Message-ID: <yw1xoaejr3u6.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> On Monday 23 November 2015 15:13:52 Stephen Boyd wrote:
>> On 11/23, Arnd Bergmann wrote:
>> > On Monday 23 November 2015 13:32:06 Stephen Boyd wrote:
>> > diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
>> > index b251013eef0a..bad6343c34d5 100644
>> > --- a/drivers/clocksource/Kconfig
>> > +++ b/drivers/clocksource/Kconfig
>> > @@ -324,8 +324,9 @@ config EM_TIMER_STI
>> >  	  such as EMEV2 from former NEC Electronics.
>> >  
>> >  config CLKSRC_QCOM
>> > -	bool "Qualcomm MSM timer" if COMPILE_TEST
>> > +	bool "Qualcomm MSM timer" if ARCH_QCOM || COMPILE_TEST
>> >  	depends on ARM
>> > +	default ARCH_QCOM
>> >  	select CLKSRC_OF
>> >  	help
>> >  	  This enables the clocksource and the per CPU clockevent driver for the
>> > 
>> > would make both of them equally configurable and not clutter up
>> > the Kconfig file when ARCH_QCOM is not selected. I've added
>> > Daniel Lezcano to Cc, he probably has an opinion on this too.
>> 
>> Yeah I think that architected timers are an outlier. I recall
>> some words from John Stultz that platforms should select the
>> clocksources they use, but maybe things have changed. For this
>> kind of thing I wouldn't mind putting it in the defconfig though.
>> I'll put the patches on the list to get the discussion started.
>
> Ok, thanks!
>
>> > This works perfectly for Cortex-A5, -A8, -A9, -A12, -A15, -A17, Brahma-B15,
>> > PJ4B-MP, Scorpion and Krait-450, which all clearly fall into one of
>> > the two other categories.
>> > 
>> > The two exceptions that don't quite fit are still "good enough":
>> > 
>> > - PJ4/PJ4B (not PJ4B-MP) has a different custom opcode for udiv and sdiv
>> >   in ARM mode. We don't support that with true multiplatform kernels
>> >   because those opcodes work nowhere else, though with your proposed
>> >   series we could easily do that for dynamic patching.
>> 
>> Do you have the information on these custom opcodes? I can work
>> that into the patches assuming the MIDR is different.
>
> Thomas Petazzoni said this in a private mail:
>
> | According to the datasheet, the PJ4B has integer signed and unsigned
> | divide, similar to the sdiv and udiv ARM instructions. But the way to
> | access it is by doing a MRC instruction.
> |
> |    MRC<cond> p6, 1, Rd , CRn , CRm, 4
> |
> |for PJ4B is the same as:
> |
> |    SDIV Rd , Rn, Rm
> |
> | on ARM cores.
> |
> |And:
> |
> |    MRC<cond> p6, 1, Rd , CRn , CRm, 0
> |
> |for PJ4B is the same as:
> |
> |    UDIV Rd , Rn, Rm
> |
> |on ARM cores.
> |
> |This is documented in the "Extended instructions" section of the
> |PJ4B datasheet.
>
> I assume what he meant was that this is true for both PJ4 and PJ4B
> but not for PJ4B-MP, which has the normal udiv/sdiv instructions.
>
> IOW, anything with CPU implementer 0x56 part 0x581 should use those,
> while part 0x584 can use the sdiv/udiv that it reports correctly.

Or we could simply ignore those and they'd be no worse off than they are
now.

-- 
M?ns Rullg?rd
mans at mansr.com
