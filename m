From: james.morse@arm.com (James Morse)
Date: Thu, 28 Jun 2018 09:45:56 +0100
Subject: KVM guest sometimes failed to boot because of kernel stack
 overflow if KPTI is enabled on a hisilicon ARM64 platform.
In-Reply-To: <5B339068.5020304@hisilicon.com>
References: <5B2A6218.3030201@hisilicon.com> <20180620144257.GB27776@arm.com>
 <5B2A7832.4010502@hisilicon.com>
 <ebfabb8f-dcd9-3fb4-3655-368a882d8f09@arm.com>
 <5B2A7FE1.5040607@hisilicon.com>
 <e701eaa8-dcb9-777c-2211-67ee27b43acb@arm.com>
 <5B2B6DEA.2090100@hisilicon.com> <5B3274FC.7000206@hisilicon.com>
 <20180626174746.GO23375@arm.com>
 <942e76b6-a46a-6c5e-5ec3-67daca636d43@arm.com>
 <5B339068.5020304@hisilicon.com>
Message-ID: <9549e15d-4ec6-8dd3-2237-b6c9b52fc816@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wei,

On 27/06/18 14:26, Wei Xu wrote:
> Sorry, I should highlight that I have only updated the default value
> of CONFIG_NR_CPUS by menuconfig in the previous mail.
> That is why it showed dirty.

(menuconfig changes don't show up like this)


More than 64 CPUs ... Is this system running more VMs than it has VMIDs? Too-few
VMIDs does work with KVM, its just going to trigger rollover frequently.

Just to check, what kernel version is the host running? Does it have commit
f0cf47d939d0 ("KVM: arm/arm64: Close VMID generation race")
(looks like that went in as a fix for v4.17-rc3)

Are you running (lots) of other VMs whenever this happens? Do they have multiple
vcpus? (I'm thinking of the scenario in that patch's description)

Is the host system otherwise idle when this happens?
(If not, can you reproduce the issue without exhausting the VMIDs?)


It may be that writing back the page-table entries with the MMU off, and
changing the cache maintenance are just changing the timing of something else.


Thanks,

James
