From: okaya@codeaurora.org (Sinan Kaya)
Date: Tue, 3 Jul 2018 09:25:15 -0400
Subject: [PATCH V5 3/3] PCI: Mask and unmask hotplug interrupts during
 reset
In-Reply-To: <9e871cc3978fbdca12ccf8a91f34ad07@codeaurora.org>
References: <1530571967-19099-1-git-send-email-okaya@codeaurora.org>
 <1530571967-19099-4-git-send-email-okaya@codeaurora.org>
 <20180703083447.GA2689@wunner.de>
 <8b6ce0f415858463d1c0588c29e30415@codeaurora.org>
 <9e871cc3978fbdca12ccf8a91f34ad07@codeaurora.org>
Message-ID: <2640af5e-f00f-d814-425d-78ac57714f6d@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> 
> what if we only have conditional enumeration ?? (leaving removing devices followed by SBR as is) ?
> 

If we leave it as is, hotplug driver observes a link down interrupt as soon
as secondary bus reset is issued. Hotplug driver will try device removal while
AER driver is working on the currently observe FATAL error causing a race
condition. Hotplug driver wait for rescan lock to be obtained.

> following code is doing little more extra work than our normal ERR_FATAL path.
> 

See this comment and the pseudo code below.

/*
 * pciehp has a 1:1 bus:slot relationship so we ultimately want a secondary
 * bus reset of the bridge, but at the same time we want to ensure that it is
 * not seen as a hot-unplug, followed by the hot-plug of the device. Thus,
 * disable link state notification and presence detection change notification
 * momentarily, if we see that they could interfere. Also, clear any spurious
 * events after.
 */
int pciehp_reset_slot(struct slot *slot, int probe)
{
	<mask hotplug interrupts>
	<issue secondary bus reset>
	<unmask hotplug interrupts>
}

This patch is trying to mask the interrupt before secondary bus reset in AER
path not after.

Otherwise, hotplug driver will remove the devices as soon as it obtains the
rescan lock following AER recovery since hotplug interrupts will be pending.

> pciehp_unconfigure_device doing little more than enumeration to quiescence the bus.
> 
> /*
> ???????? * Ensure that no new Requests will be generated from
> ???????? * the device.
> ???????? */
> ??????? if (presence) {
> ??????????? pci_read_config_word(dev, PCI_COMMAND, &command);
> ??????????? command &= ~(PCI_COMMAND_MASTER | PCI_COMMAND_SERR);
> ??????????? command |= PCI_COMMAND_INTX_DISABLE;
> ??????????? pci_write_config_word(dev, PCI_COMMAND, command);
> ??????? }
> 
> 
> 
>>
>>>
>>> That would seem like a much simpler solution, given that it is known
>>> that the link will flap on reset, causing the hotplug driver to remove
>>> and re-enumerate devices.? That would also cover cases where hotplug is
>>> handled by a different driver than pciehp, or by the platform firmware.
>>>
>>> Thanks,
>>>
>>> Lukas
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
