From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Thu, 10 Sep 2015 13:21:12 +0530
Subject: sdhci: runtime suspend/resume on card insert/removal
In-Reply-To: <20150910153129.07adbe68@xhacker>
References: <55F12CF8.50003@linaro.org> <20150910153129.07adbe68@xhacker>
Message-ID: <55F13670.1020902@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Thursday 10 September 2015 01:01 PM, Jisheng Zhang wrote:
> Hi Vaibhav,
>
> On Thu, 10 Sep 2015 12:40:48 +0530
> Vaibhav Hiremath <vaibhav.hiremath@linaro.org> wrote:
>
>> Hi,
>>
>> During my testing of SDHCI-PXAV3 driver on Marvell's pxa1928
>> based platform, I observed that runtime PM suspend/resume is having
>> issues with card insertion and removal.
>>
>> Let me try to explain it using execution sequence -
>>
>> During boot:
>>
>> MMC SD card gets detected as expected.
>>
>> [    2.431012] mmc1: new high speed SDHC card at address 1234
>> [    2.437235] mmcblk1: mmc1:1234 SA04G 3.63 GiB
>> [    2.444841]  mmcblk1: p1
>>
>>
>> Now after coming to the linux prompt, if card removal event occurs
>> then the call sequence is -
>>
>>    sdhci_irq() -->
>>     -> sdhci_thread_irq(): host->thread_isr - 0x80
>>        -> sdhci_card_event()
>>        -> mmc_detect_change()
>>           --> _mmc_detect_change()
>>               --->  mmc_sd_detect()
>>                     mmc_sd_remove()
>>                     mmc_remove_card()
>>                     mmc_bus_remove()
>>                     mmc_power_off()
>>                     mmc_set_initial_state()
>>                     sdhci_set_ios()
>>                     ...
>>          sdhci_pxav3_runtime_suspend()
>>          sdhci_runtime_suspend_host()
>>
>>
>> Till here everything looks perfect :) (if I got it right)
>>
>> Now on card insertion again, the expectation is, runtime resume should
>> get called as part of interrupt trigger from the SDHCI controller on
>> card insertion.
>
> AFAIK, card insertion => wakeup irq, this irq doesn't come from SDHCI
> controller itself because SDHCI controller is runtime suspended, clk gated
> or power gated. So the wakeup irq should come from other always on components.
> Take Marvell berlin SoC as an example:
>
> there's gpio for sdcard detect, card insertion => trigger cd gpio interrupt
> =>resume sdhci host etc.

Not always.

In my case SDHCI controller is generating card insert and remove
event/interrupts. Just to add here, I am not configuring any pins
to GPIO mode. My pin configuration for card-detect is in MMC_CD mode.

The card insertion and removal interrupt is mapped to SDHCI interrupt
line, which is interrupt number 12 in my case.

# cat /proc/interrupts
            CPU0
  11:         55       GIC 105 Level     mmc0
  12:        220       GIC 101 Level     mmc1


>
> If your changes work, the I guess your SDHCI host are not clk gated or
> power gated during runtime suspended.
>

This is what I suspected initially, but it doesn't look that way.

Without this change, if I just disable/remove

    pm_runtime_put_autosuspend(&pdev->dev);

then also it works for me.  What it tells me that, if I disable 
runtime_pm then it works.

I can cross-check register values to make sure that it is really turned
off. Let me do that as well.

Thanks,
Vaibhav
