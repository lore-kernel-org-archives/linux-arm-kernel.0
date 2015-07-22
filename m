From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 22 Jul 2015 10:52:28 +0530
Subject: [PATCHv4 1/6] dmaengine: mv_xor: fix big endian operation in
 register mode
In-Reply-To: <1436365699-6862-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1436365699-6862-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1436365699-6862-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20150722052228.GT23525@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 08, 2015 at 04:28:14PM +0200, Thomas Petazzoni wrote:
> Commit 6f166312c6ea2 ("dmaengine: mv_xor: add support for a38x command
> in descriptor mode") introduced the support for a feature that
> appeared in Armada 38x: specifying the operation to be performed in a
> per-descriptor basis rather than globally per channel.
> 
> However, when doing so, it changed the function mv_chan_set_mode() to
> use:
> 
>   if (IS_ENABLED(__BIG_ENDIAN))
> 
> instead of:
> 
>   #if defined(__BIG_ENDIAN)
> 
> While IS_ENABLED() is perfectly fine for CONFIG_* symbols, it is not
> for other symbols such as __BIG_ENDIAN that is provided directly by
> the compiler. Consequently, the commit broke support for big-endian,
> as the XOR_DESCRIPTOR_SWAP flag was not set in the XOR channel
> configuration register.
> 
> The primarily visible effect was some nasty warnings and failures
> appearing during the self-test of the XOR unit:
> 
> [    1.197368] mv_xor d0060900.xor: error on chan 0. intr cause 0x00000082
> [    1.197393] mv_xor d0060900.xor: config       0x00008440
> [    1.197410] mv_xor d0060900.xor: activation   0x00000000
> [    1.197427] mv_xor d0060900.xor: intr cause   0x00000082
> [    1.197443] mv_xor d0060900.xor: intr mask    0x000003f7
> [    1.197460] mv_xor d0060900.xor: error cause  0x00000000
> [    1.197477] mv_xor d0060900.xor: error addr   0x00000000
> [    1.197491] ------------[ cut here ]------------
> [    1.197513] WARNING: CPU: 0 PID: 1 at ../drivers/dma/mv_xor.c:664 mv_xor_interrupt_handler+0x14c/0x170()
> 
> See also:
> 
>   http://storage.kernelci.org/next/next-20150617/arm-mvebu_v7_defconfig+CONFIG_CPU_BIG_ENDIAN=y/lab-khilman/boot-armada-xp-openblocks-ax3-4.txt
>

Applied, thanks

-- 
~Vinod
