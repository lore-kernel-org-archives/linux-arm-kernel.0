From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 28 Feb 2018 15:51:55 +0000
Subject: Internal error: Oops - BUG() / kvm boot race - arm64 kpti
 patchset related
In-Reply-To: <20180228154523.GA29931@akinoame>
References: <20180228154523.GA29931@akinoame>
Message-ID: <64e691b2-24be-ef7c-3b31-619e6b373a52@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paolo,

On 28/02/18 15:45, Paolo Pisati wrote:
> Reproducible on 4.16-rc3 and 4.4.20 using defconfig - the failure it's
> intermittent, but i could reproduce it 100% if i boot loop the kvm instance 
> (it usually shows up in less than 10 iterations but i tested 32 boots before
> marking it good).
> 
> I bisected it down to this interval in linux-4.14.y:
> 
> 2feb36e arm64: kpti: Add ->enable callback to remap swapper using nG mappings
> ee28fed arm64: mm: Permit transitioning from Global to Non-Global without BBM
> 6928820 arm64: kpti: Make use of nG dependent on arm64_kernel_unmapped_at_el0()
> c98c8c2 arm64: Turn on KPTI only on CPUs that need it
> 
> c98c8c2 is good, 2feb36e is bad - couldn't bisect in between, since it didn't
> boot there.
> And yes, when i tested 2feb36e i applied the "el1 trashing fix" mentioned here:
> https://www.spinics.net/lists/arm-kernel/msg636489.html
> 
> Anything else i can do to help debug this?

What HW are you using? Your command line? Your configuration? How are
you rebooting your guest (to EFI? directly to the kernel itself?)? How
comes it didn't boot between these 4 commits? Does the failure affects
the host or the guest?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
