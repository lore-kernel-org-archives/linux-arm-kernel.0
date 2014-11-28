From: Suravee.Suthikulpanit@amd.com (Suthikulpanit, Suravee)
Date: Fri, 28 Nov 2014 16:42:04 +0000
Subject: [PATCH V5] arm64: amd-seattle: Adding device tree for AMD
 Seattle platform
In-Reply-To: <201411281613.11626.arnd@arndb.de>
Message-ID: <D09EA4E8.A828%suravee.suthikulpanit@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/28/14, 22:13, "Arnd Bergmann" <arnd@arndb.de> wrote:

>On Wednesday 26 November 2014, suravee.suthikulpanit at amd.com wrote:
>> From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>> 
>> Initial revision of device tree for AMD Seattle Development platform.
>> 
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>> Signed-off-by: Thomas Lendacky <Thomas.Lendacky@amd.com>
>> Signed-off-by: Joel Schopp <Joel.Schopp@amd.com>
>> ---
>> V5 Changes:
>>   * Rebase to arm-soc for-next (per Olof)
>>   * Restructure the DTS/DTSI into board and SoC configurations (per
>>Olof)
>>   * Add model property at the top level (per Olof)
>>   * Move pcie0 under smb and change smb's ranges property to empty
>>since pcie
>>     is not in the same range. (per Olof)
>>   * Change v2m0's ranges property (per Arnd)
>>   * Change timer interrupt type to level-trigger (per Marc)
>
>Applied to next/arm64, thanks!

Thank you
>
>Looking at this one more time, I had another question:
>
>> +	smb0: smb {
>> +		compatible = "simple-bus";
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>> +		ranges;
>> +
>> +		/* DDR range is 40-bit addressing */
>> +		dma-ranges = <0x80 0x0 0x80 0x0 0x7f 0xffffffff>;
>> +
>
>What is a DDR range?
>
>Also, what is special about the last byte? Did you intentionally
>leave it out? I think when we calculate the dma mask, we will
>use 0x3fffffffff so we don't step on the last byte, which I assume
>is not what you intended.
>
>	Arnd

Hm..probably not then. What I meant is to specify 40-bit addressing for
the memory range starting
from [0x80_0000_0000 - 0x100_0000_0000).

As, I discussed with you on IRC, it should also cover the V2m MSI register
frame, and should be starting from
0. The fix should then be:

dma-ranges = <0 0 0 0 0x100 0x00000000>


I will send a patch out to fix and add better comment for this.

Thanks,

Suravee
