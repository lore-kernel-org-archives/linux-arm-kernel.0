From: alex.bou9@gmail.com (Alex Bounine)
Date: Tue, 31 Jul 2018 08:54:14 -0400
Subject: [PATCH 6/6] arm64: enable RapidIO menu in Kconfig
In-Reply-To: <20180731084143.GA4680@arm.com>
References: <20180730225035.28365-1-acolin@isi.edu>
 <20180730225035.28365-7-acolin@isi.edu> <20180731084143.GA4680@arm.com>
Message-ID: <d09cb4f5-768b-acd8-f9b1-d1d320a93564@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-07-31 04:41 AM, Will Deacon wrote:
> On Mon, Jul 30, 2018 at 06:50:34PM -0400, Alexei Colin wrote:
>> Platforms with a PCI bus will be offered the RapidIO menu since they may
>> be want support for a RapidIO PCI device. Platforms without a PCI bus
>> that might include a RapidIO IP block will need to "select HAS_RAPIDIO"
>> in the platform-/machine-specific "config ARCH_*" Kconfig entry.
>>
>> Tested that kernel builds for arm64 with RapidIO subsystem and
>> switch drivers enabled, also that the modules load successfully
>> on a custom Aarch64 Qemu model.
>>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Russell King <linux@armlinux.org.uk>
>> Cc: John Paul Walters <jwalters@isi.edu>
>> Cc: linux-arm-kernel at lists.infradead.org
>> Cc: linux-kernel at vger.kernel.org,
>> Signed-off-by: Alexei Colin <acolin@isi.edu>
>> ---
>>   arch/arm64/Kconfig | 2 ++
>>   1 file changed, 2 insertions(+)
> 
> Thanks, this looks much cleaner than before:
> 
> Acked-by: Will Deacon <will.deacon@arm.com>
> 
> The only thing I'm not sure about is why we don't just select HAS_RAPIDIO
> unconditionally in the arm64 Kconfig. Does selecting only that option
> actually pull in new code to the build?
> 
HAS_RAPIDIO option is intended for SOCs that have built in SRIO 
controllers, like TI KeyStoneII or FPGAs. Because RapidIO subsystem core 
is required during RapidIO port driver initialization, having separate 
option allows us to control available build options for RapidIO core and 
port driver (bool vs. tristate) and disable module option if port driver 
is configured as built-in.

> Will
> 
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index a8f0c74e6f7f..5e8cf90505ec 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -308,6 +308,8 @@ config PCI_SYSCALL
>>   
>>   source "drivers/pci/Kconfig"
>>   
>> +source "drivers/rapidio/Kconfig"
>> +
>>   endmenu
>>   
>>   menu "Kernel Features"
>> -- 
>> 2.18.0
>>
