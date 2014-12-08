From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 8 Dec 2014 15:17:33 +0000
Subject: using DMA-API on ARM
In-Reply-To: <2863746.4sUSEYqahB@wuerfel>
References: <5481794E.4050406@broadcom.com>
 <F51492713EF10846800D8C0ED37A7DCE01901765@SJEXCHMB15.corp.ad.broadcom.com>
 <F51492713EF10846800D8C0ED37A7DCE01902076@SJEXCHMB15.corp.ad.broadcom.com>
 <2863746.4sUSEYqahB@wuerfel>
Message-ID: <20141208151733.GF11285@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 08, 2014 at 04:01:32PM +0100, Arnd Bergmann wrote:
> In your log, I see this message:
> 
> [    0.000000] PL310 OF: cache setting yield illegal associativity
> [    0.000000] PL310 OF: -1069781724 calculated, only 8 and 16 legal
> [    0.000000] L2C-310 enabling early BRESP for Cortex-A9
> [    0.000000] L2C-310 full line of zeros enabled for Cortex-A9
> [    0.000000] L2C-310 dynamic clock gating enabled, standby mode enabled
> [    0.000000] L2C-310 cache controller enabled, 16 ways, 256 kB
> [    0.000000] L2C-310: CACHE_ID 0x410000c8, AUX_CTRL 0x4e130001
> 
> Evidently the cache controller information in DT is incorrect and
> the setup may be wrong as a consequence, which may explain cache
> coherency problems.

No.  See d0b92845e54 (ARM: 8182/1: l2c: Make l2x0_cache_size_of_parse() return 'int')
which was merged in rc3, post-dating this kernel.  The original commit
was buggy, and produces those harmless "illegal associativity" messages.
They occur if DT *doesn't* specify the cache parameters, in which case
we use the hardware-set value (which /should/ be correct.)

We made these optional in DT as hardware really should set these
correctly in the first place.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
