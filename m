From: okaya@kernel.org (Sinan Kaya)
Date: Fri, 20 Jul 2018 23:07:20 -0700
Subject: [PATCH V5 3/3] PCI: Mask and unmask hotplug interrupts during
 reset
In-Reply-To: <2febe688-f973-5ff5-f61d-0451ad7d36ae@kernel.org>
References: <CAK9iUCM=zWexWow9TwkRfO186Hwr5WyGy0NHZF1vtXn3wbbZGQ@mail.gmail.com>
 <12fc8de5-ff03-cb00-52cb-25a43c71d03a@codeaurora.org>
 <20180708171418.GA11476@wunner.de>
 <CAK9iUCMcic5mzGiT20KNxgwPo6AuajHFsoj7GOjSht5SwrQevg@mail.gmail.com>
 <20180709160008.GA1490@wunner.de>
 <CAK9iUCMMVR114msKiMHu7ik0VK8T5j=LAYAKsEkdnocTqkdMjQ@mail.gmail.com>
 <20180720200123.GS128988@bhelgaas-glaptop.roam.corp.google.com>
 <2febe688-f973-5ff5-f61d-0451ad7d36ae@kernel.org>
Message-ID: <d34eb5da-0ae1-d455-93e2-2432ec7931ea@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/20/2018 7:58 PM, Sinan Kaya wrote:
> We need to figure out how to gracefully return inside hotplug driver
> if link down happened and there is an error pending.

How about adding the following into the hotplug ISR?

1. check if firmware first is disabled
2. check if there is a fatal error pending in the device_status register
of the PCI Express capability on the root port.
3. bail out from hotplug routine if this is the case.
4. otherwise, existing behavior.
