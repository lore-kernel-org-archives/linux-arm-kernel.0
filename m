From: olof@lixom.net (Olof Johansson)
Date: Thu, 5 Jan 2012 17:36:46 -0800
Subject: [PATCH v3] arm/tegra: emc: convert tegra2_emc to a platform driver
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF17761F1818@HQMAIL01.nvidia.com>
References: <1325742994-1178-1-git-send-email-olof@lixom.net>
 <1325743288-2460-1-git-send-email-olof@lixom.net>
 <74CDBE0F657A3D45AFBB94109FB122FF17761F1818@HQMAIL01.nvidia.com>
Message-ID: <CAOesGMg7e4bVjyzZ25VarPVFvMpGcKioVSDN=Esn9u6S4idRoA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 5, 2012 at 2:14 PM, Stephen Warren <swarren@nvidia.com> wrote:
> Olof Johansson wrote at Wednesday, January 04, 2012 11:01 PM:
>> This is the first step in making it device-tree aware and get rid of the
>> in-kernel EMC tables (of which there are none in mainline, thankfully).
>>
>> Changes since v2:
>>
>> * D'oh -- missed a couple of variables that were added, never used and then
>> ? later removed in a later patch.
>>
>> Changes since v1:
>>
>> * Fixed messed up indentation
>> * Removed code that should be gone (was added here and removed later in series)
>>
>> Signed-off-by: Olof Johansson <olof@lixom.net>
> ...
>> diff --git a/arch/arm/mach-tegra/tegra2_emc.c b/arch/arm/mach-tegra/tegra2_emc.c
> ...
>> +static int __devinit tegra_emc_probe(struct platform_device *pdev)
> ...
>> + ? ? if (!request_mem_region(res->start, resource_size(res), "tegra_emc")) {
>> + ? ? ? ? ? ? dev_err(&pdev->dev, "failed to request register region\n");
>> + ? ? ? ? ? ? return -EBUSY;
>> + ? ? }
>> +
>> + ? ? emc_regbase = ioremap(res->start, resource_size(res));
>
> Don't you need to error-check the ioremap() result, and undo the
> request_mem_region() too? Or, use the devm variant to request the
> region. The rest of the code checks emc_pdev!=NULL which won't detect
> this failure.
>
> Isn't there a get_resource && request && remap function now; I think I
> recall a patch that wraps all that into one function, but it might have
> been DT-only.

Nope, it's there -- devm_request_and_ioremap(). I'll move it over to
that and repost, it's a good idea.


-Olof
