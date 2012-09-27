From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 26 Sep 2012 23:19:04 -0600
Subject: [RFC PATCH 1/3] ARM: move ICEDCC uncompress.h to common location
In-Reply-To: <20120926215651.GA20405@glitch>
References: <1348613212-21897-1-git-send-email-swarren@wwwdotorg.org>
 <1348613212-21897-2-git-send-email-swarren@wwwdotorg.org>
 <20120926215651.GA20405@glitch>
Message-ID: <5063E1C8.70801@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/26/2012 03:56 PM, Domenico Andreoli wrote:
> On Tue, Sep 25, 2012 at 04:46:50PM -0600, Stephen Warren wrote:
>> From: Stephen Warren <swarren@nvidia.com>
>>
>> Create a common location for uncompress.h, and select the included debug
>> macro file using config option.
>>
>> This does the same for uncompress.h as a recent patch for debug-macro.S,
>> which was based on a suggestion by Russell King and implemented by Rob
>> Herring.

>> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug

>> +config UNCOMPRESS_INCLUDE
>> +	string
>> +	default "debug/icedcc-uncompress.h" if DEBUG_ICEDCC
>> +	default "debug/none-uncompress.h" if ARCH_MULTIPLATFORM || \
>> +		DEBUG_HIGHBANK_UART || DEBUG_MVEBU_UART || \
>> +		DEBUG_PICOXCELL_UART || DEBUG_SOCFPGA_UART || \
>> +		DEBUG_VEXPRESS_UART0_DETECT || DEBUG_VEXPRESS_UART0_CA9 || \
>> +		DEBUG_VEXPRESS_UART0_RS1
> 
> I would ask to add DEBUG_LL_UART_NONE to the or-ed list, which fixes the
> build of platforms without mach/uncompress.h and mach/debug-macro.S in
> case NONE is selected, but I'm not sure.

Yes, I just noticed that it (UART_NONE) depends on !MULTIPLATFORM, and
with this patch it probably shouldn't any more; it should be the default
uncompress type for MULTIPLATFORM.

> If I got the point of Russel right, uncompress.h is not a debug trace and
> maybe should not depend on any DEBUG_LL* option?

The only way a multi-platform zImage can work (at the moment anyway) is
to have no serial/debug/... output from the uncompressor, nor
earlyprintk. Once the DT is parsed and the real platform-specific
console driver is registered, console output can commence. If the kernel
experiences problems before that point, you might want to turn on
earlyprintk or even output from the uncompressor. Once you've done that,
you've tied the kernel image to a single platform. This is likely only
something you'd do when debugging a problem, otherwise it would defeat
the point of single zImage. Hence, classifying this as a debug option
seems reasonable.
