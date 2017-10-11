From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Wed, 11 Oct 2017 11:07:32 +0100
Subject: arm64: 4.14 of_match_node() issues
In-Reply-To: <42630b8b-8987-57ff-be7e-79af7294856e@samsung.com>
References: <5d2ff063-1f7e-0200-cc02-99804f7d9219@suse.de>
 <20171009092409.GB5127@arm.com>
 <66956548-fa7a-332a-8045-8202ae0aa564@arm.com>
 <CGME20171009120447epcas2p3d22ec871318e38a71a5b92f840b5e4d4@epcas2p3.samsung.com>
 <d4e48d3d-015f-08d2-7745-51c482c1a09a@arm.com>
 <42630b8b-8987-57ff-be7e-79af7294856e@samsung.com>
Message-ID: <bbf611c8-c7e8-d67f-f933-3e7b23bdba22@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/10/17 13:20, Marek Szyprowski wrote:
> Hi All,
> 
> On 2017-10-09 14:04, Robin Murphy wrote:
>> On 09/10/17 11:58, Robin Murphy wrote:
>>> On 09/10/17 10:24, Will Deacon wrote:
>>>> Hi Andreas,
>>>>
>>>> On Sat, Oct 07, 2017 at 02:42:13AM +0200, Andreas F?rber wrote:
>>>>> Since 4.14-rc1 I am seeing frequent oopses during module loading (e.g.,
>>>>> MMC, USB) from initrd on aarch64. Symptoms are similar to this in -rc3:
>>>>>
>>>>> [? OK? ] Started udev Coldplug all Devices.
>>>>> [?? 10.117775] usbcore: registered new interface driver usbfs
>>>>> [?? 10.118235] Unable to handle kernel paging request at virtual address
>>>>> ffff000008e5abc0
>>>>> [?? 10.118238] Mem abort info:
>>>>> [?? 10.118245]?? Exception class = DABT (current EL), IL = 32 bits
>>>>> [?? 10.118249]?? SET = 0, FnV = 0
>>>>> [?? 10.118253]?? EA = 0, S1PTW = 0
>>>>> [?? 10.118256] Data abort info:
>>>>> [?? 10.118261]?? ISV = 0, ISS = 0x00000006
>>>>> [?? 10.118264]?? CM = 0, WnR = 0
>>>>> [?? 10.118274] swapper pgtable: 4k pages, 48-bit VAs, pgd = ffff0000094a5000
>>>>> [?? 10.118279] [ffff000008e5abc0] *pgd=00000000bfffe003,
>>>>> *pud=00000000bfffd003, *pmd=0000000000000000
>>>>> [?? 10.118299] Internal error: Oops: 96000006 [#1] SMP
>>>>> [?? 10.118305] Modules linked in: fixed usbcore(+) sunxi_mmc mmc_core
>>>>> phy_sun4i_usb sg
>>>>> [?? 10.118341] CPU: 3 PID: 49 Comm: kworker/3:1 Not tainted
>>>>> 4.14.0-rc3-2.gf27997b-default #1
>>>>> [?? 10.118345] Hardware name: sunxi sunxi/sunxi, BIOS 2017.05-rc1 04/13/2017
>>>>> [?? 10.118369] Workqueue: events deferred_probe_work_func
>>>>> [?? 10.118378] task: ffff80007c8f4000 task.stack: ffff0000099d8000
>>>>> [?? 10.118394] PC is at __of_match_node.part.1+0x48/0x88
>>>>> [?? 10.118403] LR is at of_match_node+0x40/0x70
>>>>> [?? 10.118411] pc : [<ffff00000879aed0>] lr : [<ffff00000879af50>]
>>>> [...]
>>>>
>>>>> This has been observed on Pine64 (>60%; also by Stefan) and Odroid-C2;
>>>>> my other arm64 boards such as Raspberry Pi 3 have not run into this so
>>>>> far. No such problems on 32-bit boards.
>>>>>
>>>>> This is using the openSUSE config:
>>>>> https://kernel.opensuse.org/cgit/kernel-source/plain/config/arm64/default
>>>> Hmm, hard to know what to suggest without a concrete reproducer. Do you know
>>>> which driver is being probed in the log above? Also, does this still break
>>>> if you pass "keepinitrd" on the cmdline? Finally, can you dump the kernel
>>>> virtual memory layout, please?
>>> FWIW, this looks a lot like what happens when a built-in driver's
>>> of_match_table is marked __init, but for whatever reason (deferred probe
>>> etc.) winds up getting poked by a module load after it no longer exists.
>> Heh, synchronicity...
>>
>> https://lists.linuxfoundation.org/pipermail/iommu/2017-October/024572.html
>>
>> Looks like we either have to revert plenty of patches from the const
>> brigade, avoid freeing init, or come up with some way to make the driver
>> core cleverer about the whole deal :(
> 
> It's not that bad. I did a quick check with
> 
> # git grep "of_device_id.*init"
> 
> and Exynos SYSMMU driver was the only candidate for a fix. Maybe someone
> else should double check that list to make sure that there is no other
> platform device/driver related code there.
> 
> Best regards

The root cause of the problem we hit here is definitely the exynos_smmu driver
problem. The modrpobe triggers a device scan and the deferred_probe work goes
through the registered drivers again for each device and since the exynos_smmu
driver table is gone already, we end up in this crash.

Andreas,

Please could you try with the patch above in the link ?

Kind regards
Suzuki
