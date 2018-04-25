From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 25 Apr 2018 14:57:02 +0100
Subject: arm64: W+X mapping check failures
In-Reply-To: <20180425133704.GA6474@hc>
References: <20180425133704.GA6474@hc>
Message-ID: <20180425135702.zvt4vjoegqblgr7c@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 25, 2018 at 03:37:04PM +0200, Jan Glauber wrote:
> Hi all,

Hi Jan,

> enabling CONFIG_DEBUG_WX we see insecure mappings reported across various kernel
> versions and machines. I've not yet seen this with upstream but that doesn't
> mean much as the issue is a race and I cannot trigger it reliably.

Can you please tell us which kernel version(s) you're seeing this with,
and with chich config options (if not defconfig)?

... and if possible, on which machines.

> The reported W+X mappings are gone after the boot is finished. The addresses
> all belong to .init.* sections of the first loaded kernel modules.

I'm afraid I haven't tried loading modules before getting to userspace,
and I'm not sure what I'd need to set up to test that.

> Example log (I changed the warnings as I found the backtrace quite useless):
> 
> [   39.157884] Freeing unused kernel memory: 5248K
> [   39.167997] note_prot_wx: Found insecure W+X mapping at start: ffff000000ab9000  addr: ffff000000abd000  pages: 4
> [   39.178246] note_prot_wx: Found insecure W+X mapping at start: ffff000000ac3000  addr: ffff000000ac5000  pages: 2
> [   39.188495] note_prot_wx: Found insecure W+X mapping at start: ffff000000acd000  addr: ffff000000ad0000  pages: 3
> [   39.198745] note_prot_wx: Found insecure W+X mapping at start: ffff000000af9000  addr: ffff000000afc000  pages: 3
> [   39.212981] Checked W+X mappings: FAILED, 12 W+X pages found, 0 non-UXN pages found
> 
> I think this is a race between module loading and the ptdump_check_wx().
> The RCU'd do_free_init() can be delayed _after_ ptdump_check_wx() for a coming module.

Do we need some explicit RCU sync to complete this, prior to
ptdump_check_wx(), perhaps?

> I tried using stop_machine() around the memory check similar to arm but that does not
> solve the race. It is not a critical issue as the .init sections are freed afterwards
> anyway but still the warning is a bit misleading.
> 
> Any thoughts?

I'm not sure if stop_machine() would complete an RCU grace period and
complete the freeing of module memory. As above, woudl some explicit RCU
sync help?

Thanks,
Mark.
