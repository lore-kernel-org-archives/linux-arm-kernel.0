From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 18 Jul 2018 13:25:25 +0100
Subject: [PATCH] mmc: sunxi: remove output of virtual base address
In-Reply-To: <7cda9046-ec72-02d9-6474-0f4fbaa7e170@arm.com>
References: <20180717100958.12042-1-andre.przywara@arm.com>
 <20180717114348.lv2ngzrekp5zpcmk@flea.home>
 <7cda9046-ec72-02d9-6474-0f4fbaa7e170@arm.com>
Message-ID: <8ae0e971-903f-43fa-8027-887282b6426e@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/07/18 12:19, Andre Przywara wrote:
> Hi,
> 
> On 17/07/18 12:43, Maxime Ripard wrote:
>> 1;5202;0c
>> On Tue, Jul 17, 2018 at 11:09:58AM +0100, Andre Przywara wrote:
>>> Recent Linux versions refuse to print actual virtual kernel addresses,
>>> to not give a hint about the location of the kernel in a randomized virtual
>>> address space. This affects the output of the sunxi MMC controller
>>> driver, which now produces the rather uninformative line:
>>>
>>> [    1.482660] sunxi-mmc 1c0f000.mmc: base:0x(____ptrval____) irq:8
>>>
>>> Since the virtual base address is not really interesting in the first
>>> place, let's just drop this value. We have the physical address as part
>>> of the DT node name, which is way more useful for debugging purposes.
>>>
>>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>>> ---
>>>   drivers/mmc/host/sunxi-mmc.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
>>> index 8e7f3e35ee3d..811b08d2d0f2 100644
>>> --- a/drivers/mmc/host/sunxi-mmc.c
>>> +++ b/drivers/mmc/host/sunxi-mmc.c
>>> @@ -1407,7 +1407,7 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
>>>   	if (ret)
>>>   		goto error_free_dma;
>>>   
>>> -	dev_info(&pdev->dev, "base:0x%p irq:%u\n", host->reg_base, host->irq);
>>> +	dev_info(&pdev->dev, "irq:%u\n", host->irq);
>>
>> Can't we just remove it? It doesn't look like it brings much value anyway.
> 
> Yes, the IRQ value is the virtual Linux number, so equally
> non-informative. But this line is the only info message left from the
> mmc driver, so since we have scary "deferring probe" messages before,
> I'd rather leave this "success!" message in, to help debugging:
> # dmesg | grep mmc
> [    1.314211] sunxi-mmc 1c0f000.mmc: could not find pctldev for node
> /soc/pinctrl at 1c20800/mmc0-pins, deferring probe
> [    1.324705] sunxi-mmc 1c11000.mmc: could not find pctldev for node
> /soc/pinctrl at 1c20800/mmc2-pins, deferring probe
> [    1.737310] sunxi-mmc 1c0f000.mmc: irq:6
> [    1.771255] sunxi-mmc 1c11000.mmc: irq:7
> [    1.787003] mmc0: new high speed SDHC card at address 1234

That seems like a pretty effective success message right there ;)

FWIW, I find the easiest tool for sanity-checking driver probe status 
(if it's not already obvious by stuff working correctly, as above) is 
/proc/interrupts, followed if necessary by digging into 
/sys/bus/*/drivers/ for the canonical state of things.

If anything I'd argue for the "scary" probe-deferral messages to be 
downgraded to dev_dbg, since the average user shouldn't need to care.

Robin.

> [    1.796029] mmcblk0: mmc0:1234 SA08G 7.21 GiB
> [    1.809093]  mmcblk0: p1 p2 p3
> ....
> 
> We could just say something like: "initialized.". It would be even more
> useful if we could print the type of MMC: SD card, SDIO, eMMC, but apart
> from eMMC vs. MMC0/1 for the A64 we don't have this information (not
> even the index number) at this level, I think.
> 
> Cheers,
> Andre.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
