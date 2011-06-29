From: robherring2@gmail.com (Rob Herring)
Date: Tue, 28 Jun 2011 21:41:29 -0500
Subject: [PATCH 2/4] ARM: remove unnecessary mach/hardware.h includes
In-Reply-To: <20110628232429.GI21898@n2100.arm.linux.org.uk>
References: <1309301859-17651-1-git-send-email-robherring2@gmail.com>
	<1309301859-17651-3-git-send-email-robherring2@gmail.com>
	<20110628232429.GI21898@n2100.arm.linux.org.uk>
Message-ID: <4E0A90D9.1060601@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/28/2011 06:24 PM, Russell King - ARM Linux wrote:
> On Tue, Jun 28, 2011 at 05:57:37PM -0500, Rob Herring wrote:
>> From: Rob Herring <rob.herring@calxeda.com>
>>
>> Remove some includes of mach/hardware.h which are not needed. hardware.h will
>> be removed completely for tegra and cns3xxx in follow on patch.
> 
> At least this one is incorrect:
> 
> arch/arm/mach-rpc/include/mach/hardware.h:#define IO_EC_MEMC_BASE              0x80000000
> arch/arm/kernel/ecard.c:                    address = IO_EC_MEMC_BASE + (slot << 12);
> 
> That's just one of the defines that ecard.c uses from mach/hardare.h.
> 
It happens to still compile, so it's getting included thru another
include. I see these options:

-Revert this change. RPC is not going to be built in a multi-platform
kernel anyway. Leaving it could affect how include paths get setup for
multi-platform builds.
-Move ecard.c into mach-rpc. It doesn't appear to be used by anything else.

I'll do the 1st option for now.

Rob
