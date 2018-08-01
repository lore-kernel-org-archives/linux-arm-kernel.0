From: alex.bou9@gmail.com (Alex Bounine)
Date: Wed, 1 Aug 2018 09:57:08 -0400
Subject: [PATCH 6/6] arm64: enable RapidIO menu in Kconfig
In-Reply-To: <20180731204656.GC38497@guest228.east.isi.edu>
References: <20180730225035.28365-1-acolin@isi.edu>
 <20180730225035.28365-7-acolin@isi.edu> <20180731084143.GA4680@arm.com>
 <d09cb4f5-768b-acd8-f9b1-d1d320a93564@gmail.com>
 <f2723578-f39d-27ac-b376-0f06905caa67@gmail.com>
 <20180731204656.GC38497@guest228.east.isi.edu>
Message-ID: <89caf5a7-f7cc-ea9b-71ab-038602244a5f@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-07-31 04:46 PM, Alexei Colin wrote:
> On Tue, Jul 31, 2018 at 04:29:56PM -0400, Alex Bounine wrote:
... skip
>>>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>>>> Cc: Russell King <linux@armlinux.org.uk>
>>>>> Cc: John Paul Walters <jwalters@isi.edu>
>>>>> Cc: linux-arm-kernel at lists.infradead.org
>>>>> Cc: linux-kernel at vger.kernel.org,
>>>>> Signed-off-by: Alexei Colin <acolin@isi.edu>
>>>>> ---
>>>>>  ? arch/arm64/Kconfig | 2 ++
>>>>>  ? 1 file changed, 2 insertions(+)
>>>>
>>>> Thanks, this looks much cleaner than before:
>>>>
>>>> Acked-by: Will Deacon <will.deacon@arm.com>
>>>>
>>>> The only thing I'm not sure about is why we don't just select HAS_RAPIDIO
>>>> unconditionally in the arm64 Kconfig. Does selecting only that option
>>>> actually pull in new code to the build?
>>>>
>>> HAS_RAPIDIO option is intended for SOCs that have built in SRIO
>>> controllers, like TI KeyStoneII or FPGAs. Because RapidIO subsystem core
>>> is required during RapidIO port driver initialization, having separate
>>> option allows us to control available build options for RapidIO core and
>>> port driver (bool vs. tristate) and disable module option if port driver
>>> is configured as built-in.
>>
>> I am thinking about where HAS_RAPIDIO option can be set for arm64 branch.
>> Having it set globally is too broad. For example we have Xilinx Zinq US
>> board with SRIO IP on it. Having it globally in arm64 branch - bad. Probably
>> having it set in drivers/soc/... is the best place.
>>
>> Will, Alexei what do you think?
> 
> Since the HAS_RAPIODIO flag adds meta info about SoC, maybe the line
> that 'select's it can go where the rest of the meta info is, which
> differs across architectures:
> * For ARM64, in arch/arm64/Kconfig.platforms under each config ARCH_*
> for each SoC that includes RapidIO.
> * For ARM, in arch/arm/mach-*/Kconfig
> 
> But, if we want the flag to be automatically selected for some larger
> set of ARM64 SoCs without explicitly adding it to each one, then the
> above is not going to do that.
>

Thank you for clarification. I am leaning towards fine control of 
available configuration options, on per-board basis.
As Russell mentioned in some of his comments, RapidIO is relatively rare 
thing to ordinary user. Because of that I would prefer not to pollute 
config menu with selection options unrelated to most of boards supported 
in given arch.

Also it looks like proposed patches introduce minimal changes to the 
generic part of code.

>>>>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>>>>> index a8f0c74e6f7f..5e8cf90505ec 100644
>>>>> --- a/arch/arm64/Kconfig
>>>>> +++ b/arch/arm64/Kconfig
>>>>> @@ -308,6 +308,8 @@ config PCI_SYSCALL
>>>>>  ? source "drivers/pci/Kconfig"
>>>>> +source "drivers/rapidio/Kconfig"
>>>>> +
>>>>>  ? endmenu
>>>>>  ? menu "Kernel Features"
>>>>> -- 
>>>>> 2.18.0
>>>>>
