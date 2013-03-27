From: monstr@monstr.eu (Michal Simek)
Date: Wed, 27 Mar 2013 10:37:58 +0100
Subject: [PATCH v2 04/10] arm: zynq: Load scu baseaddress at run time
In-Reply-To: <201303270929.45733.arnd@arndb.de>
References: <1364319822-5504-1-git-send-email-michal.simek@xilinx.com>
 <201303262144.45158.arnd@arndb.de>
 <CAHTX3dJoAW=KPAS4x-==bLY-COxCXPKdtNuEMGZEu-npR5t-hg@mail.gmail.com>
 <201303270929.45733.arnd@arndb.de>
Message-ID: <CAHTX3d+9ST0X7x5hx5aLV2YMFUhPcmQg-VThX81vwk64WXj-eQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/3/27 Arnd Bergmann <arnd@arndb.de>:
> On Wednesday 27 March 2013, Michal Simek wrote:
>> 2013/3/26 Arnd Bergmann <arnd@arndb.de>:
>> > On Tuesday 26 March 2013, Michal Simek wrote:
>> >> +void __iomem *scu_base;
>> >> +
>> >
>> > This cannot be a global variable in a multiplatform kernel. Can you
>> > make it static?
>>
>> This global variable is shared because I am using it in smp code
>> and also it will be used in pm code we have.
>>
>> What is it another way how to handle this?
>>
>> Because the same problem could be with zynq_slcr_base.
>>
>> Or the rule is just to use zynq_ prefix for all global variables?
>>
>
> Yes. The best solution is to mke variables local to some context and
> only pointed to by other data structures. If that doesn't work, you
> should try using a static variable in one file and move all code using
> it there. If that doesn't work, you need a global variable, but that
> must be uniquely named.

FYI: I have looked at some code and I saw that Rob is using scu_base_addr
in highbank. And then pointing to it in cpuidle-calxeda.c.

Moving everything to one file is probably impossible.

And in connection to symbols/functions/variables. It means that all
specific soc functions in mach
should also use specific prefix for everything.

Thanks,
Michal


-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform
