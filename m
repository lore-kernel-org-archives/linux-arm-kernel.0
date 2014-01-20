From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 20 Jan 2014 12:20:40 +0100
Subject: [PATCH v5 0/4] Fix i2c bus hang on A0 version of the Armada XP
 SoCs
In-Reply-To: <52D4F966.6060200@free-electrons.com>
References: <1389193589-18485-1-git-send-email-gregory.clement@free-electrons.com>
 <20140114021421.GK19878@titan.lakedaemon.net>
 <52D4F966.6060200@free-electrons.com>
Message-ID: <52DD0688.1080802@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/01/2014 09:46, Gregory CLEMENT wrote:
> On 14/01/2014 03:14, Jason Cooper wrote:
>> Gregory,
>>
>> On Wed, Jan 08, 2014 at 04:06:25PM +0100, Gregory CLEMENT wrote:
>>> Hi,
>>>
>>> Here come the 5th version of the series fixing the i2c bus hang on A0
>>> version of the Armada XP SoCs. It occurred on the early release of the
>>> OpenBlocks AX3-4 boards. Indeed the first variants of Armada XP SoCs
>>> (A0 stepping) have issues related to the i2c controller which prevent
>>> to use the offload mechanism and lead to a kernel hang during boot.
>>>
>>> The main change are the use of marvell,mv78230-a0-i2c and that the
>>> function mvebu_get_soc_id() is now local to mach-mvebu.
>>>
>>> The first patch add a mean to detect the SoCs version at run-time and
>>> the second one use this feature in the driver.
>>>
>>> The 3 first patches should be applied on 3.13-rc and on stable kernel
>>> 3.12 as it fixes a regression introduce by the commit 930ab3d403ae
>>> "i2c: mv64xxx: Add I2C Transaction Generator support".
>>
>> Ok, I've pulled this in by cherrypicking the commits.  I needed to add
>> the 'Fixes: ...' and 'Cc: stable ...' language, so the commit ids were
>> going to change anyhow.  I also added the note to the binding as we
>> discussed.  I've also based this against v3.13-rc1 as there doesn't
>> appear to be any need to drag in everything up to -rc6.
>>
>> I've pushed this to mvebu/fixes.  Please take a look.  If it all looks
>> good I'll send the pull request off tomorrow.
> Hi Jason,
> 
> Everything looks perfect!
> 
> Thanks for having improved it,
> 
> Gregory
> 

Hi Jason,

Eventually we didn't finish with it!
Ezequiel found an issue when we try to access pci_base if it have
not been properly mapped, in this case the kernel hang. Indeed the check
of  the return of of_iomap was wrong.

The fix would be something like:

-o<---o<---o<---o<---o<---o<---o<---o<---o<---o<---o<--
--- a/arch/arm/mach-mvebu/mvebu-soc-id.c
+++ b/arch/arm/mach-mvebu/mvebu-soc-id.c
@@ -88,7 +88,7 @@ static int __init mvebu_soc_id_init(void)
        }

        pci_base = of_iomap(child, 0);
-       if (IS_ERR(pci_base)) {
+       if (pci_base == NULL) {
                pr_err("cannot map registers\n");
                ret = -ENOMEM;
                goto res_ioremap;
-o<---o<---o<---o<---o<---o<---o<---o<---o<---o<---o<--

How do you want we handle it?

Do you want a proper patch to amend?
A new series?
Something else?

Thanks,

Gregory


>>
>> thx,
>>
>> Jason.
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
> 
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
