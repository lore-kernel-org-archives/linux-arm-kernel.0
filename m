From: lucorsel@gmail.com (L.C.)
Date: Sun, 18 Apr 2010 19:23:21 +0200
Subject: Bug#552270: Marvell CESA driver and Kirkwood
In-Reply-To: <20091204212847.GC28480@deprecation.cyrius.com>
References: <4B12F9E7.1020207@gmail.com>
	<20091130211531.GK18101@deprecation.cyrius.com>
	<4B144627.7060901@gmail.com>
	<20091204212847.GC28480@deprecation.cyrius.com>
Message-ID: <4BCB4009.70707@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gentlemen,

I understand from Martin Michmayr you are maintainers of the module, so 
I'm reporting you this.

mv_cesa when enabled on Kirkwood always causes an OOPS whenever openswan 
tries to use the AES module. I'm talking about 2.6.32.

I saw no problems anymore with mv_cesa disabled or blacklisted. Here 
comes the trace.

Cheers, L.C.

--------------cut
[   75.000907] alg: No test for authenc(hmac(sha1),cbc(aes)) 
(authenc(hmac(sha1-generic),mv-cbc-aes))
[   82.634680] Unable to handle kernel paging request at virtual address 
e0000004
[   82.641968] pgd = deb84000
[   82.644689] [e0000004] *pgd=00000000
[   82.648293] Internal error: Oops: 5 [#1]
[   82.652232] last sysfs file: /sys/module/aes_generic/initstate
[   82.658091] Modules linked in: authenc ctr camellia cast5 rmd160 
sha1_generic hmac crypto_null ccm serpent blowfish twofish 
twofish_common ecb xcbc cbc sha256_generic sha512_generic des_generic 
xfrm_user ah6 ah4 esp6 esp4 xfrm4_mode_beet xfrm4_tunnel tunnel4 
xfrm4_mode_tunnel xfrm4_mode_transport xfrm6_mode_transport 
xfrm6_mode_ro xfrm6_mode_beet xfrm6_mode_tunnel ipcomp ipcomp6 
xfrm_ipcomp xfrm6_tunnel tunnel6 af_key tun ipv6 ext2 loop mv_cesa 
aes_generic ext3 jbd mbcache mmc_block ehci_hcd mvsdio mv643xx_eth 
usbcore mmc_core nls_base libphy
[   82.706822] CPU: 0    Not tainted  (2.6.32-trunk-kirkwood #1)
[   82.712609] PC is at queue_manag+0x230/0x2b0 [mv_cesa]
[   82.717778] LR is at queue_manag+0x220/0x2b0 [mv_cesa]
[   82.722937] pc : [<bf0d69fc>]    lr : [<bf0d69ec>]    psr: a0000013
[   82.722943] sp : c086dfb0  ip : 00000000  fp : 00000000
[   82.734480] r10: bf0d6f48  r9 : 00000000  r8 : 00000001
[   82.739730] r7 : c086c000  r6 : bf0d6f48  r5 : a1c1d680  r4 : df9de460
[   82.746288] r3 : 00000048  r2 : 000621a3  r1 : df9de5c8  r0 : dffffff8
[   82.752846] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  
Segment kernel
[   82.760188] Control: 0005397f  Table: 1eb84000  DAC: 00000017
[   82.765959] Process mv_crypto (pid: 241, stack limit = 0xc086c270)
[   82.772168] Stack: (0xc086dfb0 to 0xc086e000)
[   82.776549] dfa0:                                     c086dfd4 
deb3be6c de937480 bf0d67cc
[   82.784765] dfc0: 00000000 00000000 00000000 c005be04 00000000 
00000000 c086dfd8 c086dfd8
[   82.792987] dfe0: 00000000 00000000 00000000 00000000 00000000 
c0027e7c 00000000 00000000
[   82.801233] [<bf0d69fc>] (queue_manag+0x230/0x2b0 [mv_cesa]) from 
[<c005be04>] (kthread+0x78/0x80)
[   82.810241] [<c005be04>] (kthread+0x78/0x80) from [<c0027e7c>] 
(kernel_thread_exit+0x0/0x8)
[   82.818633] Code: e5941020 e5945018 e3a02000 e1a00001 (e590300c)
[   82.824879] ---[ end trace 1206762c21c134f8 ]---
--------------cut


  Bug#552270: Marvell CESA driver and Kirkwood

Martin Michlmayr
Tue, 27 Oct 2009 13:54:11 -0700

I got the following answer, so I'll go ahead and enable CESA for
Kirkwood.

* Sebastian Andrzej Siewior<sebast...@breakpoint.cc>  [2009-10-26 22:53]:
>  * Martin Michlmayr | 2009-10-26 18:26:08 [+0800]:
>
>  >Hi Sebastian and Nico,
>  Hi Martin,
>
>  >I put Sebastian's CESA driver into Debian's 2.6.31 kernel and enabled
>  >it for orion5x.  A Debian user asked me why I didn't enable it for
>  >Kirkwood.  AFAIK, there are some differences between the CESA on
>  >Orion5x and Kirkwood, so my assumption was that the current CESA
>  >driver doesn't work on Kirkwood.  But I'm actually not sure if this is
>  >true.
>  >
>  >Do you know if the current driver will work on Kirkwood?
>  I don't really know. I just looked through the spec and compared them
>  and they look very alike:
>  - Orion's has larger sram space. The driver does not assume, it uses the
>    size specified and Kirkwood's is set to 2KiB
>  - the register seem to be at the same spot. Orion has two engines,
>    Kirkwood just one. Right now, only the first one is used.
>  - security engine's descriptor looks the same
>  - the DMA engine differs in a few spot but it is not yet implemented so
>    it doesn't matter.
>
>  As far as I can see in current git, Nico enabled the CESA engine on
>  Kirkwood [0]. It looks like he assumes that it should work, I don't know
>  if he ever has tested it :)
>
>  [0]
>  http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=ae5c8c83735f5fcb09b380944e4854a383006998
>  Sebastian


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100418/b521b34a/attachment.htm>
