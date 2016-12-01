From: jeremy.linton@arm.com (Jeremy Linton)
Date: Thu, 1 Dec 2016 10:46:11 -0600
Subject: 4.9-rc7 nouveau fails on arm64 64k page kernel but works with 4k
Message-ID: <042c54f3-e52b-6658-18c7-9c19492485a4@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I placed a 9600GT in a softiron 3k running fedora 25, and the nouveau 
driver failed to claim the device with :

[drm] Initialized
nouveau 0000:01:00.0: NVIDIA G94 (094100a1)
nouveau 0000:01:00.0: bios: version 62.94.0d.00.04
nouveau: probe of 0000:01:00.0 failed with error -22

Which with a little bit of debugging seems to be a failure in:

[77216.692605] [<ffff000001404120>] ttm_bo_validate+0xb0/0x1e8 [ttm]
[77216.698697] [<ffff0000014045ac>] ttm_bo_init+0x354/0x410 [ttm]
[77216.704706] [<ffff0000019d7bd0>] nouveau_bo_new+0x1f4/0x314 [nouveau]
[77216.711308] [<ffff0000019e4620>] nv50_display_create+0x10c/0xa1c 
[nouveau]
[77216.718340] [<ffff0000019df898>] nouveau_display_create+0x50c/0x59c 
[nouveau]
[77216.725632] [<ffff0000019d3e24>] nouveau_drm_load+0x22c/0x8c0 [nouveau]
[77216.732286] [<ffff00000137a1a0>] drm_dev_register+0xc0/0xf0 [drm]
[77216.738409] [<ffff00000137b8a4>] drm_get_pci_dev+0xbc/0x188 [drm]
[77216.744663] [<ffff0000019d35e8>] nouveau_drm_probe+0x180/0x208 [nouveau]
[77216.751354] [<ffff0000084c30dc>] local_pci_probe+0x50/0xb4
[77216.756827] [<ffff0000084c3e40>] pci_device_probe+0xf8/0x148
[77216.762474] [<ffff0000085b6a10>] driver_probe_device+0x284/0x420
[77216.768467] [<ffff0000085b6ccc>] __driver_attach+0x120/0x124
[77216.774115] [<ffff0000085b446c>] bus_for_each_dev+0x6c/0xac
[77216.779673] [<ffff0000085b6204>] driver_attach+0x2c/0x34
[77216.784972] [<ffff0000085b5cb4>] bus_add_driver+0x244/0x2b0
[77216.790531] [<ffff0000085b78e4>] driver_register+0x68/0xfc
[77216.796004] [<ffff0000084c29a8>] __pci_register_driver+0x60/0x6c
[77216.802047] [<ffff00000137bcb8>] drm_pci_init+0x108/0x138 [drm]
[77216.808146] [<ffff000001530158>] nouveau_drm_init+0x158/0x10000 [nouveau]
[77216.814922] [<ffff0000080831a8>] do_one_initcall+0x44/0x128
[77216.820483] [<ffff0000081cad6c>] do_init_module+0x68/0x1e0
[77216.825957] [<ffff000008150d84>] load_module+0xfac/0x12bc
[77216.831343] [<ffff00000815132c>] SyS_finit_module+0xe4/0xf0
[77216.836902] [<ffff000008082b70>] el0_svc_naked+0x24/0x28

By default fedora is using a 64k page kernel, switching to a mainline 
4.9-rc7 kernel using the same configuration the same problem exists 
(there are a couple others, mentioned briefly in the defect). Changing 
the mainline kernel from 64k to 4k pages corrects the problem and a 
terminal display can be seen.

The fedora defect is:
https://bugzilla.redhat.com/show_bug.cgi?id=1400623


Thanks,
