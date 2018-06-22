From: Chris.Brandt@renesas.com (Chris Brandt)
Date: Fri, 22 Jun 2018 16:40:55 +0000
Subject: [PATCHv4 4/4] ARM: versatile: support configuring versatile
 machine for no-MMU
In-Reply-To: <20180622161101.GW17671@n2100.armlinux.org.uk>
References: <20180618141905.7789-1-gerg@linux-m68k.org>
 <20180618141905.7789-5-gerg@linux-m68k.org>
 <CAMuHMdUyCEq0U_CJindwcSEF+0dR-SJc1v8zGT-CcUqVkdOeVw@mail.gmail.com>
 <nycvar.YSQ.7.76.1806211212010.16670@knanqh.ubzr>
 <20180622110145.GU17671@n2100.armlinux.org.uk>
 <nycvar.YSQ.7.76.1806221110140.16670@knanqh.ubzr>
 <CAMuHMdWZPM3Q9fVXWiw1bMVWNRCYGoQa-XukJka-2xsP-=HmVQ@mail.gmail.com>
 <nycvar.YSQ.7.76.1806221146140.16670@knanqh.ubzr>
 <20180622161101.GW17671@n2100.armlinux.org.uk>
Message-ID: <TY1PR01MB15627B7B0BE8BABD439724A78A750@TY1PR01MB1562.jpnprd01.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> That is actually incorrect - you're too used to the dynamic fixup of
> virt_to_phys() and friends now!
> 
> Given that XIP is typically used in environments where the kernel text
> is very much unmodifyable, we disable CONFIG_ARM_PATCH_PHYS_VIRT.  When
> disabled, we use a constant translation, based upon the build-time
> CONFIG_PHYS_OFFSET and CONFIG_PAGE_OFFSET settings.

CONFIG_PHYS_OFFSET (RAM address) and CONFIG_XIP_PHYS_ADDR (ROM address) 
are set today in kconfig.

Instead of having them hard coded, they could be global variables set 
during boot.

CONFIG_XIP_PHYS_ADDR could be determined by looking at the value of the 
PC.

CONFIG_PHYS_OFFSET is still the issue because that has to be passed in 
via boot register.


> I suppose someone who was sufficiently motivated could write assembly-
> based parsing of DT to extract the memory regions and work out what the
> right settings are.  Is there really the motivation to do that - there
> was a burst of XIP interest a few releases ago but it seems to have
> tailed off.

Because at least for me, by simply removing the !ARCH_MULTIPLATFORM 
dependency for setting XIP_KERNEL works perfectly fine for building and 
running kernels.

So, it's hard to justify doing a lot more work than what can be done 
today with just 1 line edit.

I still test every kernel release to make XIP_KERNEL still works.

Actually, I just tested 4.18.0-rc1 this morning.


Chris
