From: blaterblater@hotmail.com (Frank)
Date: Sun, 28 Nov 2010 12:44:56 +0100
Subject: memory allocation errors on Marvell Kirkwood
Message-ID: <BLU0-SMTP90312A69589CE7FD162BA4CF230@phx.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On the Marvell Kirkwood platform running Debian Squeeze w/kernel 2.6.32-5 (v2.6.32-27), when transferring data through ftp (vsftpd) over a l2tp-ppp tunnel (openl2tp/pppd), I often get these two errors in the kernel log:

[323570.011580] swapper: page allocation failure. order:3, mode:0x4020
[323570.017916] [<c002df70>] (unwind_backtrace+0x0/0xdc) from [<c00a53f4>] (__alloc_pages_nodemask+0x4e4/0x584)
[323570.027817] [<c00a53f4>] (__alloc_pages_nodemask+0x4e4/0x584) from [<c00a54a8>] (__get_free_pages+0x14/0x44)
[323570.037802] [<c00a54a8>] (__get_free_pages+0x14/0x44) from [<c00c9aa4>] (__kmalloc_track_caller+0x40/0x19c)
[323570.047696] [<c00c9aa4>] (__kmalloc_track_caller+0x40/0x19c) from [<c0234a30>] (__alloc_skb+0x50/0x10c)
[323570.057236] [<c0234a30>] (__alloc_skb+0x50/0x10c) from [<c028efbc>] (igmpv3_newpack+0x40/0x1cc)
[323570.066077] [<c028efbc>] (igmpv3_newpack+0x40/0x1cc) from [<c028f174>] (add_grhead+0x2c/0x8c)
[323570.074742] [<c028f174>] (add_grhead+0x2c/0x8c) from [<c028f5d8>] (add_grec+0x3c0/0x3fc)
[323570.082975] [<c028f5d8>] (add_grec+0x3c0/0x3fc) from [<c028f7a4>] (igmp_ifc_timer_expire+0x94/0x29c)
[323570.092255] [<c028f7a4>] (igmp_ifc_timer_expire+0x94/0x29c) from [<c00519d8>] (run_timer_softirq+0x210/0x2f8)
[323570.102318] [<c00519d8>] (run_timer_softirq+0x210/0x2f8) from [<c004b2a0>] (__do_softirq+0xc0/0x1a4)
[323570.111600] [<c004b2a0>] (__do_softirq+0xc0/0x1a4) from [<c004b3c4>] (irq_exit+0x40/0x94)
[323570.119913] [<c004b3c4>] (irq_exit+0x40/0x94) from [<c0027070>] (asm_do_IRQ+0x70/0x8c)
[323570.127970] [<c0027070>] (asm_do_IRQ+0x70/0x8c) from [<c0027ad4>] (__irq_svc+0x34/0x80)
[323570.136117] Exception stack(0xc03abf48 to 0xc03abf90)
[323570.141283] bf40:                   000ca9a3 000ca9a3 4ce8d976 000c8578 c03b1d70 c03b1d80
[323570.149602] bf60: c03b1d70 c0438c68 00022aa4 56251311 00022904 00000000 3176a6b8 c03abf90
[323570.157917] bf80: c00664dc c00320ec 20000013 ffffffff
[323570.163096] [<c0027ad4>] (__irq_svc+0x34/0x80) from [<c00320ec>] (kirkwood_enter_idle+0x64/0x88)
[323570.172030] [<c00320ec>] (kirkwood_enter_idle+0x64/0x88) from [<c0226dfc>] (cpuidle_idle_call+0xb0/0x150)
[323570.181749] [<c0226dfc>] (cpuidle_idle_call+0xb0/0x150) from [<c002944c>] (cpu_idle+0x5c/0xa4)
[323570.190494] [<c002944c>] (cpu_idle+0x5c/0xa4) from [<c0008b20>] (start_kernel+0x280/0x2e4)
[323570.198922] [<c0008b20>] (start_kernel+0x280/0x2e4) from [<00008034>] (0x8034)
[323570.206277] Mem-info:
[323570.208649] Normal per-cpu:
[323570.211552] CPU    0: hi:  186, btch:  31 usd: 166
[323570.216462] active_anon:3015 inactive_anon:7915 isolated_anon:0
[323570.216468]  active_file:22445 inactive_file:79978 isolated_file:0
[323570.216474]  unevictable:0 dirty:27 writeback:0 unstable:0
[323570.216480]  free:9193 slab_reclaimable:3548 slab_unreclaimable:1018
[323570.216486]  mapped:4868 shmem:138 pagetables:232 bounce:0
[323570.246474] Normal free:36772kB min:2884kB low:3604kB high:4324kB active_anon:12060kB inactive_anon:31660kB active_file:89780kB inactive_file:319912kB unevictable:0kB isolated(anon):0kB isolated(file):0kB present:520192kB mlocked:0kB dirty:108kB writeback:0kB mapped:19472kB shmem:552kB slab_reclaimable:14192kB slab_unreclaimable:4072kB kernel_stack:816kB pagetables:928kB unstable:0kB bounce:0kB writeback_tmp:0kB pages_scanned:0 all_unreclaimable? no
[323570.286551] lowmem_reserve[]: 0 0
[323570.289988] Normal: 1057*4kB 3870*8kB 99*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 36772kB
[323570.301098] 102561 total pagecache pages
[323570.305133] 0 pages in swap cache
[323570.308545] Swap cache stats: add 0, delete 0, find 0/0
[323570.313888] Free swap  = 185972kB
[323570.317299] Total swap = 185972kB
[323570.328827] 131072 pages of RAM
[323570.332090] 9584 free pages
[323570.334984] 2254 reserved pages
[323570.338227] 3163 slab pages
[323570.341113] 24922 pages shared
[323570.344271] 0 pages swap cached

And

[180923.061930] Unable to handle kernel paging request at virtual address 804f13e6
[180923.070060] pgd = c0e98000
[180923.072893] [804f13e6] *pgd=00000000
[180923.076583] Internal error: Oops: 801 [#1]
[180923.080782] last sysfs file: /sys/devices/virtual/net/ppp0/uevent
[180923.086990] Modules linked in: pppol2tp pppox ppp_generic slhc xfrm_user ah6 ah4 esp6 esp4 xfrm4_mode_beet xfrm4_tunnel xfrm4_mode_tunnel xfrm4_mode_transport xfrm6_mode_transport xfrm6_mode_ro xfrm6_mode_beet xfrm6_mode_tunnel ipcomp ipcomp6 xfrm6_tunnel af_key nls_cp437 authenc ccm ecb sha512_generic tunnel4 xfrm_ipcomp tunnel6 ipv6 ctr twofish twofish_common camellia serpent blowfish cast5 des_generic cbc aes_generic xcbc rmd160 sha256_generic sha1_generic hmac crypto_null ext2 loop vfat fat nls_utf8 cifs ext3 jbd dm_crypt dm_mod evdev sata_mv mv643xx_eth libata libphy gpio_keys inet_lro ext4 mbcache jbd2 sd_mod crc_t10dif usb_storage scsi_mod ehci_hcd usbcore nls_base [last unloaded: slhc]
[180923.149394] CPU: 0    Not tainted  (2.6.32-5-kirkwood #1)
[180923.154915] PC is at __kprobes_text_end+0x818/0xae8
[180923.159908] LR is at tcp_sendmsg+0x32c/0xae0
[180923.164288] pc : [<c02b8bb8>]    lr : [<c026f2d8>]    psr: 00000013
[180923.164294] sp : c0fabbb8  ip : 00000550  fp : c66f5790
[180923.176005] r10: 00001000  r9 : c0fabc40  r8 : 00000000
[180923.181342] r7 : 00000000  r6 : 00000550  r5 : 804f13e6  r4 : fffffff2
[180923.187987] r3 : 00000000  r2 : 00000550  r1 : dba88130  r0 : c66f5790
[180923.194633] Flags: nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
[180923.202061] Control: 0005397f  Table: 00e98000  DAC: 00000017
[180923.207922] Process vsftpd (pid: 11900, stack limit = 0xc0faa270)
[180923.214130] Stack: (0xc0fabbb8 to 0xc0fac000)
[180923.218595] bba0:                                                       dba88130 00000550
[180923.226901] bbc0: dfb0f600 df226400 00000550 00000000 00000000 c026f2d8 c0fabc0c 00000000
[180923.235211] bbe0: c0fabd68 00000000 00008000 00000550 00000790 00000870 00000550 df226470
[180923.243521] bc00: c0faa000 00000000 c002e220 00000000 7fffffff 00000550 c050e0c0 00000000
[180923.251832] bc20: 00000000 df9672c0 df617000 c0fabd4c c0fabc40 00001000 00000018 c022d094
[180923.260141] bc40: 00000000 df974074 00000000 00000001 ffffffff 00000000 00000000 00000000
[180923.268452] bc60: 00000000 00000000 df9672c0 c03d4fa0 00000000 00000000 1d260c67 df9672c0
[180923.276763] bc80: c005d2e4 c0fabc84 c0fabc84 dfabd200 c0dddc00 dfaa9c00 c0fabcd0 c0d6a280
[180923.285072] bca0: dfbff578 00000000 d6c1dde0 0003ffff 00000010 c0fabe08 d4e8c300 c0fabcd4
[180923.293383] bcc0: 00000010 c01acf68 c0fabcd4 c0c40480 0000f140 0000f160 c0c40480 00001000
[180923.301693] bce0: df617000 00000010 00000000 c0fabd4c 00000000 00000010 c0509ac0 c0fabe4c
[180923.310002] bd00: 00000000 00000011 d4e8c2fc 00000000 00000017 bf000000 c0fabd4c df617000
[180923.318314] bd20: 00001000 c00ea7c0 c02bf59c c022d3ec 00000018 000066f5 c66f5000 c022f8f4
[180923.326623] bd40: 00001000 c0c404c0 00000000 00000000 00000000 c0fabd68 00000001 00000000
[180923.334934] bd60: 00000000 00008000 c66f5000 00001000 df226400 c0c3f93c c0c40800 0000000b
[180923.343243] bd80: c0c3f93c c026fad0 00008000 00000014 00000000 00001000 00000000 00000000
[180923.351553] bda0: 00001000 c050dea0 00000000 00001000 c0c40800 00008000 c0c3f93c c0c40800
[180923.359864] bdc0: 0000000b c0c3f93c c00ea7c0 c02bf59c 00000018 c022be64 00008000 c0fabe48
[180923.368174] bde0: c0fabe48 c00ea834 00008000 00000001 0f15b000 00000000 00005000 c0fabe48
[180923.376484] be00: c0c3f800 c00ea888 c050daa0 c0fabe48 c0c3f800 00000001 c00ea7c0 c0c40800
[180923.384795] be20: 00010000 0f150000 050c9000 c00eac14 c050de80 00010000 c0c3f800 0f150000
[180923.393104] be40: 00000000 c00eac98 00001000 00005000 00000000 c0c40800 0f15b000 00000000
[180923.401415] be60: 0000b000 00000000 00000000 c0c40800 c0c3f800 00010000 c0fabf20 c0fabf10
[180923.409725] be80: 0f150000 c00ead14 00000000 c00ea7c0 c0fabf10 c00eb43c 00000000 c0c3f800
[180923.418035] bea0: c0fabf10 0f150000 00000000 00010000 c0c3f800 c00eb998 00000000 00010000
[180923.426345] bec0: c0c3f800 c00eb280 00000000 00000001 000003e8 c00eb974 c0c40480 00000000
[180923.434655] bee0: 0f160000 00000000 14219000 00000000 00000000 14219000 14219000 c0c40480
[180923.442965] bf00: c0c404a0 c0c40800 c0c40480 c00eb3a8 14219000 00010000 00000000 c0c40800
[180923.451275] bf20: 0f150000 00000000 00000000 00000000 df617028 d4e8c260 14219000 ff7fc000
[180923.459585] bf40: c0c40800 c0c404a0 000001fe c00cd528 00000000 00000000 00000000 00000000
[180923.467896] bf60: c0c40480 00000000 00000000 00000000 000000bb c0028048 c0faa000 00000000
[180923.476205] bf80: 0000ffff c00cd75c 00000000 00000000 00000000 0002a8a4 14219000 0002a8a4
[180923.484516] bfa0: 00000007 c0027ea0 14219000 0002a8a4 00000007 00000003 00000000 14219000
[180923.492826] bfc0: 14219000 0002a8a4 00000007 000000bb 0002a034 00000003 00000000 0000ffff
[180923.501136] bfe0: 00000003 bef27908 0001cac4 4029375c 60000010 00000007 00000000 00000000
[180923.509447] Code: 00000000 00000000 e3e0400d e59b5004 (e5854000)
[180923.518824] ---[ end trace 0c1f4f3521f172f3 ]---

Searching for similar posts shows that these are a form of (non-fatal?) memory allocation errors. I'm kind of stumped how to resolve these, as there seems to be plenty of free RAM on the machine.

Regards,
Frank
