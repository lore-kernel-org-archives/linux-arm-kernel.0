From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 11 Oct 2012 09:59:51 +0100
Subject: [PATCH 6/6] mfd: Differentiate between u8500 and u9540 TCDM
 address mapping
In-Reply-To: <201210101834.40749.arnd@arndb.de>
References: <1349882335-6786-1-git-send-email-lee.jones@linaro.org>
 <1349882335-6786-7-git-send-email-lee.jones@linaro.org>
 <201210101834.40749.arnd@arndb.de>
Message-ID: <20121011085951.GU9707@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 10 Oct 2012, Arnd Bergmann wrote:

> On Wednesday 10 October 2012, Lee Jones wrote:
> > @@ -2688,7 +2688,11 @@ void __init db8500_prcmu_early_init(void)
> >                         iounmap(tcpm_base);
> >                 }
> >  
> > -               tcdm_base = __io_address(U8500_PRCMU_TCDM_BASE);
> > +               if (cpu_is_u9540())
> > +                       tcdm_base = ioremap_nocache(U8500_PRCMU_TCDM_BASE,
> > +                                               SZ_4K + SZ_8K) + SZ_8K;
> > +               else
> > +                       tcdm_base = __io_address(U8500_PRCMU_TCDM_BASE);
> >         } else {
> >                 pr_err("prcmu: Unsupported chip version\n");
> >                 BUG();
> 
> Would it be possible to get the base out of the device tree and always
> map it from there? Adding another dependency on a fixed constant is
> just going to make the conversion to multiplatform harder, since it
> was decided that device drivers should not have access to platform
> header files in the multiplatform case.

>From what I understand, this code has to be called before Device
Tree kicks in. Actually, this code is mearly a stand-in until Loic
has finished with the PRCMU re-vamp. Once that's complete, this
stuff will be passed from init_IRQ(), which is invoked directly in
start_kernel().

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
