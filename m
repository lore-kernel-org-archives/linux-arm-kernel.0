From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Tue, 25 Aug 2015 15:24:16 +0100
Subject: [PATCH v1 3/3] arm64: dts: add Hi6220 mailbox node
In-Reply-To: <1440510194.10987.52.camel@linaro.org>
References: <20150821184059.GB2000@svinekod>
 <20150824091845.GA28290@leoy-linaro>
 <20150824095144.GA7139@leverpostej>
 <1440411596.3517.12.camel@linaro.org>
 <20150824114903.GT10728@bivouac.eciton.net>
 <1440490427.10987.29.camel@linaro.org>
 <20150825094630.GU10728@bivouac.eciton.net>
 <1440497710.10987.42.camel@linaro.org>
 <20150825104256.GB13471@leverpostej>
 <1440510194.10987.52.camel@linaro.org>
Message-ID: <20150825142416.GW10728@bivouac.eciton.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 25, 2015 at 09:43:14PM +0800, Haojian Zhuang wrote:
> Since we discussed a lot on this, let's make a conclusion on it.
> 
> 1. UEFI could append the reserved buffer in it's memory mapping.

Yes. It needs to.

(I will let Mark comment on points 2-4.)

> 5. A patch is necessary in kernel. If efi stub feature is enabled,
>    arm kernel should not parse memory node or reserved memory buffer in
>    DT any more.

This is already the case. The stub deletes any present memory nodes and
reserved entries in drivers/firmware/efi/libstub/fdt.c:update_fdt().

Then, during setup_arch(), arch/arm64/kernel/efi.c:efi_init() calls
reserve_regions(), which adds only those memory regions available for
use by Linux as RAM to memblock.

>    Arm kernel should either fetch memory information from 
>    efi or DT.

Absolutely.

>    Currently arm kernel fetch both efi memory information and
>    reserved buffer from DTB at the same time.

No, it does not.

Regards,

Leif
