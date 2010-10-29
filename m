From: ben-linux@fluff.org (Ben Dooks)
Date: Sat, 30 Oct 2010 00:26:14 +0100
Subject: [PATCH 0/2] ARM: SAMSUNG: Add Support Power Domain Control
In-Reply-To: <1286970422-15993-1-git-send-email-kgene.kim@samsung.com>
References: <1286970422-15993-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <4CCB5816.4040609@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/10/10 12:47, Kukjin Kim wrote:
> This patch adds support Power Domain Control based on Runtim PM.
> 
> Each Power Domain is represented by a Power Domain device and the devices
> belong to these Power Domains should be set as a child device of the Power
> Domain devices. The corresponding drivers of the devices should implement
> Runtime PM to control the Power Domains.

This sounds like a reasonable way to do this, although we still
need a way of signaling the drivers whether they've fully powered
down or not.


>From bogus@does.not.exist.com  Fri Oct 22 17:57:35 2010
From: bogus@does.not.exist.com ()
Date: Fri, 22 Oct 2010 21:57:35 -0000
Subject: No subject
Message-ID: <mailman.12.1289145330.1530.linux-arm-kernel@lists.infradead.org>

a direct clock, it relies on the main ipu clock to function, but it is
my first glance to omap4 and I might be wrong.

> That being said, when you will change that code to switch to runtime PM, you
> will end up managing the module state in the ISR context.

Mainly this patch was sent on my laziness to add device enable/disable
calls on all the parts the code is using clk disable/enable, given
that they are not really needed.

Regards,

Omar


>From bogus@does.not.exist.com  Fri Oct 22 17:57:35 2010
From: bogus@does.not.exist.com ()
Date: Fri, 22 Oct 2010 21:57:35 -0000
Subject: No subject
Message-ID: <mailman.15.1289532866.1530.linux-arm-kernel@lists.infradead.org>

around - so I just hacked up a simple patch. I also didn't bother to
use get_maintainer.pl for CC. As you may have noticed I also managed
to get the code wrong for msm in V1, so I guess it would have been
better to CC properly after all.

Anyway, I will break up the patch per sub-architecture in V3. That
makes per sub-arch back porting easier.

Thanks,

/ magnus


>From bogus@does.not.exist.com  Fri Oct 22 17:57:35 2010
From: bogus@does.not.exist.com ()
Date: Fri, 22 Oct 2010 21:57:35 -0000
Subject: No subject
Message-ID: <mailman.22.1290426417.1530.linux-arm-kernel@lists.infradead.org>

types, which hwmod uses to define the rev field.

/* timer ip constants */
#define OMAP_TIMER_IP_LEGACY			0x1
#define OMAP_TIMER_IP_VERSION_2			0x2


Thank you,
Best regards,
Hari Kanigeri


>From bogus@does.not.exist.com  Fri Oct 22 17:57:35 2010
From: bogus@does.not.exist.com ()
Date: Fri, 22 Oct 2010 21:57:35 -0000
Subject: No subject
Message-ID: <mailman.26.1290667452.1530.linux-arm-kernel@lists.infradead.org>

does not help and if the bus is busy for too much time,
there always was a h/w problem involved.

>>> +
>>> +       return timeout < 0 ? I2C_RETRY : 0;
>>> +}
>>>
>>>  #ifdef CONFIG_I2C_PXA_SLAVE
>>>  /*
>>> --
>>> 1.7.3.2
>>>
>>>
>>> _______________________________________________
>>> linux-arm-kernel mailing list
>>> linux-arm-kernel at lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>

-- 
Regards,
Igor.



>From bogus@does.not.exist.com  Fri Oct 22 17:57:35 2010
From: bogus@does.not.exist.com ()
Date: Fri, 22 Oct 2010 21:57:35 -0000
Subject: No subject
Message-ID: <mailman.28.1290946151.1530.linux-arm-kernel@lists.infradead.org>

larger than about 16K ?

A work-around would be to drop the MTU below 4K, which'll make these kinds
of allocations order-0, and see whether you can reproduce the problem.  If
you can, it would suggest there is a memory leak somewhere.

> [180923.061930] Unable to handle kernel paging request at virtual address 804f13e6
> [180923.070060] pgd = c0e98000
> [180923.072893] [804f13e6] *pgd=00000000
> [180923.076583] Internal error: Oops: 801 [#1]
> [180923.080782] last sysfs file: /sys/devices/virtual/net/ppp0/uevent
> [180923.086990] Modules linked in: pppol2tp pppox ppp_generic slhc xfrm_user ah6 ah4 esp6 esp4 xfrm4_mode_beet xfrm4_tunnel xfrm4_mode_tunnel xfrm4_mode_transport xfrm6_mode_transport xfrm6_mode_ro xfrm6_mode_beet xfrm6_mode_tunnel ipcomp ipcomp6 xfrm6_tunnel af_key nls_cp437 authenc ccm ecb sha512_generic tunnel4 xfrm_ipcomp tunnel6 ipv6 ctr twofish twofish_common camellia serpent blowfish cast5 des_generic cbc aes_generic xcbc rmd160 sha256_generic sha1_generic hmac crypto_null ext2 loop vfat fat nls_utf8 cifs ext3 jbd dm_crypt dm_mod evdev sata_mv mv643xx_eth libata libphy gpio_keys inet_lro ext4 mbcache jbd2 sd_mod crc_t10dif usb_storage scsi_mod ehci_hcd usbcore nls_base [last unloaded: slhc]
> [180923.149394] CPU: 0    Not tainted  (2.6.32-5-kirkwood #1)
> [180923.154915] PC is at __kprobes_text_end+0x818/0xae8
> [180923.159908] LR is at tcp_sendmsg+0x32c/0xae0
> [180923.164288] pc : [<c02b8bb8>]    lr : [<c026f2d8>]    psr: 00000013
> [180923.164294] sp : c0fabbb8  ip : 00000550  fp : c66f5790
> [180923.176005] r10: 00001000  r9 : c0fabc40  r8 : 00000000
> [180923.181342] r7 : 00000000  r6 : 00000550  r5 : 804f13e6  r4 : fffffff2
> [180923.187987] r3 : 00000000  r2 : 00000550  r1 : dba88130  r0 : c66f5790
> [180923.194633] Flags: nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
> [180923.202061] Control: 0005397f  Table: 00e98000  DAC: 00000017
> [180923.207922] Process vsftpd (pid: 11900, stack limit = 0xc0faa270)
> [180923.214130] Stack: (0xc0fabbb8 to 0xc0fac000)
> [180923.218595] bba0:                                                       dba88130 00000550
> [180923.226901] bbc0: dfb0f600 df226400 00000550 00000000 00000000 c026f2d8 c0fabc0c 00000000
> [180923.235211] bbe0: c0fabd68 00000000 00008000 00000550 00000790 00000870 00000550 df226470
> [180923.243521] bc00: c0faa000 00000000 c002e220 00000000 7fffffff 00000550 c050e0c0 00000000
> [180923.251832] bc20: 00000000 df9672c0 df617000 c0fabd4c c0fabc40 00001000 00000018 c022d094
> [180923.260141] bc40: 00000000 df974074 00000000 00000001 ffffffff 00000000 00000000 00000000
> [180923.268452] bc60: 00000000 00000000 df9672c0 c03d4fa0 00000000 00000000 1d260c67 df9672c0
> [180923.276763] bc80: c005d2e4 c0fabc84 c0fabc84 dfabd200 c0dddc00 dfaa9c00 c0fabcd0 c0d6a280
> [180923.285072] bca0: dfbff578 00000000 d6c1dde0 0003ffff 00000010 c0fabe08 d4e8c300 c0fabcd4
> [180923.293383] bcc0: 00000010 c01acf68 c0fabcd4 c0c40480 0000f140 0000f160 c0c40480 00001000
> [180923.301693] bce0: df617000 00000010 00000000 c0fabd4c 00000000 00000010 c0509ac0 c0fabe4c
> [180923.310002] bd00: 00000000 00000011 d4e8c2fc 00000000 00000017 bf000000 c0fabd4c df617000
> [180923.318314] bd20: 00001000 c00ea7c0 c02bf59c c022d3ec 00000018 000066f5 c66f5000 c022f8f4
> [180923.326623] bd40: 00001000 c0c404c0 00000000 00000000 00000000 c0fabd68 00000001 00000000
> [180923.334934] bd60: 00000000 00008000 c66f5000 00001000 df226400 c0c3f93c c0c40800 0000000b
> [180923.343243] bd80: c0c3f93c c026fad0 00008000 00000014 00000000 00001000 00000000 00000000
> [180923.351553] bda0: 00001000 c050dea0 00000000 00001000 c0c40800 00008000 c0c3f93c c0c40800
> [180923.359864] bdc0: 0000000b c0c3f93c c00ea7c0 c02bf59c 00000018 c022be64 00008000 c0fabe48
> [180923.368174] bde0: c0fabe48 c00ea834 00008000 00000001 0f15b000 00000000 00005000 c0fabe48
> [180923.376484] be00: c0c3f800 c00ea888 c050daa0 c0fabe48 c0c3f800 00000001 c00ea7c0 c0c40800
> [180923.384795] be20: 00010000 0f150000 050c9000 c00eac14 c050de80 00010000 c0c3f800 0f150000
> [180923.393104] be40: 00000000 c00eac98 00001000 00005000 00000000 c0c40800 0f15b000 00000000
> [180923.401415] be60: 0000b000 00000000 00000000 c0c40800 c0c3f800 00010000 c0fabf20 c0fabf10
> [180923.409725] be80: 0f150000 c00ead14 00000000 c00ea7c0 c0fabf10 c00eb43c 00000000 c0c3f800
> [180923.418035] bea0: c0fabf10 0f150000 00000000 00010000 c0c3f800 c00eb998 00000000 00010000
> [180923.426345] bec0: c0c3f800 c00eb280 00000000 00000001 000003e8 c00eb974 c0c40480 00000000
> [180923.434655] bee0: 0f160000 00000000 14219000 00000000 00000000 14219000 14219000 c0c40480
> [180923.442965] bf00: c0c404a0 c0c40800 c0c40480 c00eb3a8 14219000 00010000 00000000 c0c40800
> [180923.451275] bf20: 0f150000 00000000 00000000 00000000 df617028 d4e8c260 14219000 ff7fc000
> [180923.459585] bf40: c0c40800 c0c404a0 000001fe c00cd528 00000000 00000000 00000000 00000000
> [180923.467896] bf60: c0c40480 00000000 00000000 00000000 000000bb c0028048 c0faa000 00000000
> [180923.476205] bf80: 0000ffff c00cd75c 00000000 00000000 00000000 0002a8a4 14219000 0002a8a4
> [180923.484516] bfa0: 00000007 c0027ea0 14219000 0002a8a4 00000007 00000003 00000000 14219000
> [180923.492826] bfc0: 14219000 0002a8a4 00000007 000000bb 0002a034 00000003 00000000 0000ffff
> [180923.501136] bfe0: 00000003 bef27908 0001cac4 4029375c 60000010 00000007 00000000 00000000
> [180923.509447] Code: 00000000 00000000 e3e0400d e59b5004 (e5854000)
> [180923.518824] ---[ end trace 0c1f4f3521f172f3 ]---

This is not useful.  Unlike OABI with frame pointers, EABI seems to
omit the very important backtrace.  Moreover, because the kprobes
symbols appear in kallsyms, we don't know where PC was.  So all in
all, the above oops is undebuggable.

Can someone please fix the EABI backtracing to say _why_ it couldn't
produce a backtrace.



>From bogus@does.not.exist.com  Fri Oct 22 17:57:35 2010
From: bogus@does.not.exist.com ()
Date: Fri, 22 Oct 2010 21:57:35 -0000
Subject: No subject
Message-ID: <mailman.34.1291285386.1530.linux-arm-kernel@lists.infradead.org>

is added so that Driver's can avoid doing ioremap.
check Santosh's comment on this API
http://www.spinics.net/lists/arm-kernel/msg92260.html

>
> static int __devinit =A0dev_probe (*pdev) {
> =A0 struct resource *res;
> =A0 void __iomem *base;
> =A0 u16 irq;
> =A0 ....
> =A0 ....
> =A0 res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> =A0 if (unlikely(!res)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0....
> =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;
> =A0 }
>
> =A0 base =3D ioremap(res->start, resource_size(res));
> =A0 if (base) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ....
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> =A0 }
>
> =A0 res =3D platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> =A0 if (unlikely(!res)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ....
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> =A0 }
> =A0 irq =3D res->start;
> =A0 ....
> =A0 ....
> }
>
> -V Charulatha
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
