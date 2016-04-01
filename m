From: stefan@agner.ch (Stefan Agner)
Date: Thu, 31 Mar 2016 23:40:42 -0700
Subject: [PATCH 15/18] ARM: vf610: PM: initial suspend/resume support
In-Reply-To: <20160401022507.GF18833@tiger>
References: <1457576219-7971-1-git-send-email-stefan@agner.ch>
 <1457576219-7971-16-git-send-email-stefan@agner.ch>
 <20160401022507.GF18833@tiger>
Message-ID: <f8da1f10269809cd07dfdda9f43a5dbf@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016-03-31 19:25, Shawn Guo wrote:
> On Wed, Mar 09, 2016 at 06:16:56PM -0800, Stefan Agner wrote:
>> Add system suspend and resume support for Vybrid SoC. The standby
>> sleep state puts the SoC in STOP mode. The SoC can be woken through
>> an interrupt from GPC (Global Power Controller). The GPC can use any
>> interrupt as wake-up source. To save power the main PLL1 is bypassed
>> and uses the 24MHz on-chip oscillator. However, memory clock need to
>> be at full speed, hence the PLL2 needs to be on to keep the memory
>> clocked. The mode is completely implemented in C since we can access
>> the full memory at all times. The mode provides most power saving
>> while being able to be woken by any IRQ as wake-up source.
>>
>> The mem sleep state (Suspend-to-RAM) uses Vybrid's LPSTOP2 mode. This
>> mode powergates most parts of the SoC expect some peripherials such as
>> Wake-Up controller (WKPU) or LP RTC. Parts of the internal SRAM is
>> retained too. The suspend code written in assembly runs from this SRAM.
>> The code puts the main memory (DDR3) into self-refresh mode and takes
>> it out of self-refresh mode on resume. Verified with Colibri VF50/VF61
>> V1.2A.
>>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> ---
>>  arch/arm/mach-imx/Makefile        |   3 +
>>  arch/arm/mach-imx/common.h        |  10 +
>>  arch/arm/mach-imx/mach-vf610.c    |   8 +
>>  arch/arm/mach-imx/pm-vf610.c      | 634 ++++++++++++++++++++++++++++++++++++++
>>  arch/arm/mach-imx/suspend-vf610.S | 437 ++++++++++++++++++++++++++
>>  drivers/clk/imx/clk-vf610.c       |  17 +
>>  6 files changed, 1109 insertions(+)
>>  create mode 100644 arch/arm/mach-imx/pm-vf610.c
>>  create mode 100644 arch/arm/mach-imx/suspend-vf610.S
> 
> I know this is how we implemented suspend for i.MX6.  But this is not
> the direction moving forward.  When people was pushing a pile of code
> adding suspend for i.MX7D, I refused to take it and asked them to push
> those hardware details into firmware and use PSCI to implement suspend.
> I would like to suggest the same for Vybrid.

Yeah I saw your comment on the i.MX7D patchset, and kind of hoped it
does not apply for Vybrid :-)

I see, need to look into PSCI closer, and see how much work it would be
to set that up and transfer the code into it...

--
Stefan
