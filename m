From: paul@pwsan.com (Paul Walmsley)
Date: Sun, 10 Feb 2013 17:28:11 +0000 (UTC)
Subject: [GIT PULL] ARM: OMAP2+: clean up and standardize WFI handling
 for 3.9
In-Reply-To: <20130210170827.GK4801@atomide.com>
References: <alpine.DEB.2.00.1302081726480.28008@utopia.booyaka.com>
 <20130210170827.GK4801@atomide.com>
Message-ID: <alpine.DEB.2.00.1302101726020.2672@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony

On Sun, 10 Feb 2013, Tony Lindgren wrote:

> * Paul Walmsley <paul@pwsan.com> [130208 09:31]:
> > 
> > ----------------------------------------------------------------
> > On OMAP2+ devices, standardize and clean up WFI entry and WFI blocking.
> > 
> > Basic test logs are available here:
> > 
> >    http://www.pwsan.com/omap/testlogs/wfi_devel_a_3.9/20130208085027/
> 
> Thanks pulled into omap-for-v3.9/pm-wfi. While merging this into
> omap-for-v3.9/tmp-merge, got the following merge conlict. Maybe
> take a look if it's correct merge?

...

>   	}
>   
> - 	omap2_sram_idle();
> - 
> - 	pwrdm_set_next_pwrst(mpu_pwrdm, PWRDM_POWER_ON);
> + 	/* WFI */
> + 	asm("mcr p15, 0, %0, c7, c0, 4" : : "r" (zero) : "memory", "cc");
>   }

The inline asm is intended to replace the omap2_sram_idle() call.  I'd 
suggest:

        }

        /* WFI */
        asm("mcr p15, 0, %0, c7, c0, 4" : : "r" (zero) : "memory", "cc");

        pwrdm_set_next_pwrst(mpu_pwrdm, PWRDM_POWER_ON);
 }

as the end product.


- Paul
