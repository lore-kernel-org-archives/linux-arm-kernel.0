From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 28 Nov 2017 14:19:22 +0000
Subject: kasan: false use-after-scope warnings with KCOV
In-Reply-To: <747765dd-b156-9388-6471-bb0f9a256a89@virtuozzo.com>
References: <20171128123555.mo4ikj2ru6mkibwo@lakrids.cambridge.arm.com>
 <747765dd-b156-9388-6471-bb0f9a256a89@virtuozzo.com>
Message-ID: <20171128141921.xgil7fvp7g2fl5n2@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Nov 28, 2017 at 04:00:49PM +0300, Andrey Ryabinin wrote:
> On 11/28/2017 03:35 PM, Mark Rutland wrote:
> > As a heads-up, I'm seeing a number of what appear to be
> > false-positive use-after-scope warnings when I enable both KCOV and
> > KASAN (inline or outline), when using the Linaro 17.08 GCC7.1.1 for
> > arm64. So far I haven't spotted these without KCOV selected, and I'm
> > only seeing these for sanitize-use-after-scope.
> > 
> > The reports vary depending on configuration even with the same
> > trigger. I'm not sure if it's the reporting that's misleading, or
> > whether the detection is going wrong.

> > [   37.584702] BUG: KASAN: use-after-scope in __alloc_pages_nodemask+0x104/0x1608

> > $ ./scripts/faddr2line vmlinux __alloc_pages_nodemask+0x104/0x1608
> > __alloc_pages_nodemask+0x104/0x1608:
> > __alloc_pages_nodemask at mm/page_alloc.c:4215
> > 
> > ... which is the declaration+initialisation of a local variable in
> > __alloc_pages_nodemask:

> > 4215         struct alloc_context ac = { };

> > ... which is clearly not a use-after-scope bug.

> > Any ideas? I'm a bit confused by this.
> 
> Search in lkml gave me this: http://lkml.kernel.org/r/<20171128124534.3jvuala525wvn64r@wfg-t540p.sh.intel.com>
> 
> Do you have  GCC_PLUGIN_STRUCTLEAK_BYREF_ALL=y ?

No; I just have defconfig + KCOV + KASAN_OUTLINE, which gives me:

[mark at lakrids:~/src/linux]% grep GCC_PLUGIN .config
CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y
CONFIG_GCC_PLUGIN_SANCOV=y
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK is not set
# CONFIG_GCC_PLUGIN_RANDSTRUCT is not set

> Note, that in  Fengguang's config, CONFIG_KCOV=y but
> CONFIG_KCOV_INSTRUMENT_ALL=n,  so at least in his case KCOV shouldn't
> be involved.

I do have CONFIG_KCOV_INSTRUMENT_ALL set, as this seems to be the
default when KCOV is selected on arm64:

[mark at lakrids:~/src/linux]% grep KCOV .config                                                          
CONFIG_ARCH_HAS_KCOV=y
CONFIG_KCOV=y
# CONFIG_KCOV_ENABLE_COMPARISONS is not set
CONFIG_KCOV_INSTRUMENT_ALL=y

Thanks,
Mark.
