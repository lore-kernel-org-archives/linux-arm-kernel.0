From: hacking@babibo.de (Thomas Bach)
Date: Sun, 22 Jul 2018 09:26:00 +0200
Subject: UG_ON(!may_use_simd()); hit in kernel_neon_begin(); on 4.17.5
Message-ID: <a1494fa6-682d-8a95-ca14-5dd9979b6ae9@babibo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi list,

I reported this bug on NixOS issue tracker:

https://github.com/NixOS/nixpkgs/issues/43808

where I was suggested to report this here:

I want add an additional device to an existing btrfs and convert data
and metadata to raid1. The existing btrfs is currently on a plain
partition, the added device resides on LUKS. During `btrfs balance` I
observe the attached error-log in the journal and the process stalls.
This happens on a RaspberryPi 3

# uname -a
Linux host 4.17.5 #1-NixOS SMP PREEMPT Sun Jul 8 13:32:21 UTC 2018
aarch64 GNU/Linux

This is reproducible on my system.

Regards

	Thomas Bach.
-------------- next part --------------
Jul 19 12:07:07 reichensachsen kernel: BTRFS info (device sdb1): found 20426 extents                                       
Jul 19 12:07:08 reichensachsen kernel: BTRFS info (device sdb1): relocating block group 3753864331264 flags data           
Jul 19 12:07:55 reichensachsen kernel: ------------[ cut here ]------------                                                
Jul 19 12:07:55 reichensachsen kernel: kernel BUG at ../arch/arm64/kernel/fpsimd.c:1117!                                   
Jul 19 12:07:55 reichensachsen kernel: Internal error: Oops - BUG: 0 [#1] PREEMPT SMP                                      
Jul 19 12:07:55 reichensachsen kernel: Modules linked in: aes_neon_bs aes_neon_blk dm_crypt btrfs zstd_decompress zstd_compress xxhash xor raid6_pq brcmfmac nls_iso8859_1 nls_cp437 brcmutil cfg80211 vc4 rfkill cec smsc95xx usbnet drm_kms_helper uas drm bcm2835_thermal vchiq(C) pwm_bcm2835 bcm2835_rng bcm2835_dma rng_core i2c_bcm2835 uio_pdrv_genirq uio crc32_ce iptable_nat nf_nat_ipv4 nf_nat nf_conntrack_ipv6 nf_defrag_ipv6 nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack libcrc32c ip6t_rpfilter ipt_rpfilter ip6table_raw iptable_raw xt_pkttype nf_log_ipv6 nf_log_ipv4 nf_log_common xt_LOG xt_tcpudp ip6table_filter ip6_tables iptable_filter nfsd ip_tables x_tables ipv6 dm_mod                                              
Jul 19 12:07:55 reichensachsen kernel: CPU: 2 PID: 1151 Comm: kworker/u9:4 Tainted: G         C        4.17.5 #1-NixOS     
Jul 19 12:07:55 reichensachsen kernel: Hardware name: Raspberry Pi 3 Model B (DT)                                          
Jul 19 12:07:55 reichensachsen kernel: Workqueue: kcryptd kcryptd_crypt [dm_crypt]                                         
Jul 19 12:07:55 reichensachsen kernel: pstate: 40000005 (nZcv daif -PAN -UAO)                                              
Jul 19 12:07:55 reichensachsen kernel: pc : kernel_neon_begin+0xc0/0xe8                                                    
Jul 19 12:07:55 reichensachsen kernel: lr : __xts_crypt+0x88/0xe0 [aes_neon_bs]                                            
Jul 19 12:07:55 reichensachsen kernel: sp : ffff00000d6cbb30                                                               
Jul 19 12:07:55 reichensachsen kernel: x29: ffff00000d6cbb30 x28: ffff800020181440                                         
Jul 19 12:07:55 reichensachsen kernel: x27: ffff800020181500 x26: ffff800026e78800                                         
Jul 19 12:07:55 reichensachsen kernel: x25: 000000000000005a x24: ffff7e00003f76c0                                         
Jul 19 12:07:55 reichensachsen kernel: x23: 0000000000000000 x22: ffff800036e3f080                                         
Jul 19 12:07:55 reichensachsen kernel: x21: ffff00000167511c x20: ffff800036d46580                                         
Jul 19 12:07:55 reichensachsen kernel: x19: ffff000009481000 x18: 0000000000000003                                         
Jul 19 12:07:55 reichensachsen kernel: x17: 000000000000000e x16: 0000000000000007                                         
Jul 19 12:07:55 reichensachsen kernel: x15: 0000000000000001 x14: 0000000000000200                                         
Jul 19 12:07:55 reichensachsen kernel: x13: 0000000000000080 x12: 0000000000000200                                         
Jul 19 12:07:55 reichensachsen kernel: x11: 0000000000000000 x10: 0000000000000000 
Jul 19 12:07:55 reichensachsen kernel: x9 : 0000000000000000 x8 : 000081ffffffffff 
Jul 19 12:07:55 reichensachsen kernel: x7 : ffff80000fddb400 x6 : 0000000000000000 
Jul 19 12:07:55 reichensachsen kernel: x5 : ffff800036e3f860 x4 : 0000000000000000 
Jul 19 12:07:55 reichensachsen kernel: x3 : 000000000000000a x2 : 0000000000000001 
Jul 19 12:07:55 reichensachsen kernel: x1 : ffff0000094810b0 x0 : 0000000000000001 
Jul 19 12:07:55 reichensachsen kernel: Process kworker/u9:4 (pid: 1151, stack limit = 0x0000000069538911)
Jul 19 12:07:55 reichensachsen kernel: Call trace:
Jul 19 12:07:55 reichensachsen kernel:  kernel_neon_begin+0xc0/0xe8
Jul 19 12:07:55 reichensachsen kernel:  __xts_crypt+0x88/0xe0 [aes_neon_bs]
Jul 19 12:07:55 reichensachsen kernel:  xts_encrypt+0x28/0x38 [aes_neon_bs]
Jul 19 12:07:55 reichensachsen kernel:  simd_skcipher_encrypt+0x68/0xc0
Jul 19 12:07:55 reichensachsen kernel:  crypt_convert+0x79c/0xd88 [dm_crypt]
Jul 19 12:07:55 reichensachsen kernel:  kcryptd_crypt+0x1f8/0x390 [dm_crypt]
Jul 19 12:07:55 reichensachsen kernel:  process_one_work+0x1dc/0x490
Jul 19 12:07:55 reichensachsen kernel:  worker_thread+0x50/0x478
Jul 19 12:07:55 reichensachsen kernel:  kthread+0x134/0x138
Jul 19 12:07:55 reichensachsen kernel:  ret_from_fork+0x10/0x1c
Jul 19 12:07:55 reichensachsen kernel: Code: a94153b3 a8c27bfd d65f03c0 d503201f (d4210000) 
Jul 19 12:07:55 reichensachsen kernel: ---[ end trace 5a6ce81eae32e332 ]---
Jul 19 12:08:39 reichensachsen kernel: BTRFS info (device sdb1): found 523 extents
