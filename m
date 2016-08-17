From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 17 Aug 2016 18:22:18 +0100
Subject: [PATCH] arm64: kernel: avoid literal load of virtual address
 with MMU off
In-Reply-To: <20160817171134.GF20762@e104818-lin.cambridge.arm.com>
References: <1471449281-10367-1-git-send-email-ard.biesheuvel@linaro.org>
 <20160817171134.GF20762@e104818-lin.cambridge.arm.com>
Message-ID: <20160817172218.GE14898@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 17, 2016 at 06:11:34PM +0100, Catalin Marinas wrote:
> On Wed, Aug 17, 2016 at 05:54:41PM +0200, Ard Biesheuvel wrote:
> > Literal loads of virtual addresses are subject to runtime relocation when
> > CONFIG_RELOCATABLE=y, and given that the relocation routines run with the
> > MMU and caches enabled, literal loads of relocated values performed with
> > the MMU off are not guaranteed to return the latest value unless the
> > memory covering the literal is cleaned to the PoC explicitly.
> > 
> > So defer the literal load until after the MMU has been enabled, just like
> > we do for primary_switch() and secondary_switch() in head.S.
> 
> I think for consistency with head.S the patch is fine but do we actually
> expect a literal pool value to be inconsistent between cache and PoC?
> Presumably, the first time the kernel image was loaded it had to be
> cleaned to PoC but after that we wouldn't expect modifications of the
> literal pool data.

The kernel modifies literal pool values within itself, at boot time,
after having enabled the MMU. This is after any loader has cleaned the
kernel Image to the PoC and branched to it with the MMU off.

See __primary_switch in head.S

With upcoming patches [1], resuming from hibernation can also leave
stale data at the PoC for relocated literals like this.

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-August/448996.html
