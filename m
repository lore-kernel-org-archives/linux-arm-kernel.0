From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Wed, 22 Mar 2017 09:46:28 +0000
Subject: [PATCH v2] arm: Fix memory attribute inconsistencies when using
 fixmap
In-Reply-To: <CAKv+Gu82PsyyC=fQHxUn5mrCdmQvhwK+DK342-vv8y53mLcpng@mail.gmail.com>
References: <20170321173030.7751-1-tixy@linaro.org>
 <1490117781.3136.9.camel@linaro.org>
 <CAKv+Gu82PsyyC=fQHxUn5mrCdmQvhwK+DK342-vv8y53mLcpng@mail.gmail.com>
Message-ID: <1490175988.2890.1.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-03-21 at 19:00 +0000, Ard Biesheuvel wrote:
> On 21 March 2017 at 17:36, Jon Medhurst (Tixy) <tixy@linaro.org> wrote:
> > On Tue, 2017-03-21 at 17:30 +0000, Jon Medhurst wrote:
> > > To cope with the variety in ARM architectures and configurations, the
> > > pagetable attributes for kernel memory are generated at runtime to match
> > > the system the kernel finds itself on. This calculated value is stored
> > > in pgprot_kernel.
> > > 
> > > However, when early fixmap support was added for arm (commit
> > > a5f4c561b3b1) the attributes used for mappings were hard coded because
> > > pgprot_kernel is not set up early enough. Unfortunately, when fixmap is
> > > used after early boot this means the memory being mapped can have
> > > different attributes to existing mappings, potentially leading to
> > > unpredictable behaviour. A specific problem also exists due to the hard
> > > coded values not include the 'shareable' attribute which means on
> > > systems where this matters (e.g. those with multiple CPU clusters) the
> > > cache contents for a memory location can become inconsistent between
> > > CPUs.
> > > 
> > > To resolve these issues we change fixmap to use the same memory
> > > attributes (from pgprot_kernel) that the rest of the kernel uses. To
> > > enable this we need to refactor the initialisation code so
> > > build_mem_type_table is called early enough. Note, that relies on early
> > > param parsing for memory type overrides passed via the kernel command
> > > line, so we need to make sure this call is still after
> > > parse_early_params().
> > > 
> > > Fixes: a5f4c561b3b1 ("ARM: 8415/1: early fixmap support for earlycon")
> > > Cc: stable at vger.kernel.org # v4.3+
> > 
> > Sorry, this should have...
> > Signed-off-by: Jon Medhurst <tixy@linaro.org>
> > 
> 
> Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> 
> UEFI boot and earlycon both still work for me, so
> 
> Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> 
> It looks like nommu should be unaffected, but it is worth giving it a
> spin as well

I did build test a couple of nommu platforms. I'll try and work out how
to get Linux on the only nommu hardware I have (ARM's MPS2) but if that
kernel doesn't work before my applying my changes I'm not going to
debug, I've opened enough cans of worms for now.

-- 
Tixy
