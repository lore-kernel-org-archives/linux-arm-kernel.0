From: jan.glauber@caviumnetworks.com (Jan Glauber)
Date: Wed, 25 Apr 2018 15:37:04 +0200
Subject: arm64: W+X mapping check failures
Message-ID: <20180425133704.GA6474@hc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

enabling CONFIG_DEBUG_WX we see insecure mappings reported across various kernel
versions and machines. I've not yet seen this with upstream but that doesn't
mean much as the issue is a race and I cannot trigger it reliably.

The reported W+X mappings are gone after the boot is finished. The addresses
all belong to .init.* sections of the first loaded kernel modules.

Example log (I changed the warnings as I found the backtrace quite useless):

[   39.157884] Freeing unused kernel memory: 5248K
[   39.167997] note_prot_wx: Found insecure W+X mapping at start: ffff000000ab9000  addr: ffff000000abd000  pages: 4
[   39.178246] note_prot_wx: Found insecure W+X mapping at start: ffff000000ac3000  addr: ffff000000ac5000  pages: 2
[   39.188495] note_prot_wx: Found insecure W+X mapping at start: ffff000000acd000  addr: ffff000000ad0000  pages: 3
[   39.198745] note_prot_wx: Found insecure W+X mapping at start: ffff000000af9000  addr: ffff000000afc000  pages: 3
[   39.212981] Checked W+X mappings: FAILED, 12 W+X pages found, 0 non-UXN pages found

I think this is a race between module loading and the ptdump_check_wx().
The RCU'd do_free_init() can be delayed _after_ ptdump_check_wx() for a coming module.

I tried using stop_machine() around the memory check similar to arm but that does not
solve the race. It is not a critical issue as the .init sections are freed afterwards
anyway but still the warning is a bit misleading.

Any thoughts?

--Jan
