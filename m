From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 22 May 2014 14:15:09 +0200
Subject: [GIT PULL] MMC updates for mmc-next for 3.16, take 3
In-Reply-To: <86zjiaqarn.fsf@void.printf.net>
References: <CAPDyKFo44fucVebB3f_qby1iWqjyq5P4XPAyD6og5ZWpqgO4=A@mail.gmail.com>
 <86zjiaqarn.fsf@void.printf.net>
Message-ID: <CAPDyKFqhsErJvw-GYFq=x0xQigt=Tr3Luw=-n12cL5o5D5eGNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 May 2014 14:05, Chris Ball <chris@printf.net> wrote:
> Hi Ulf,
>
> On Thu, May 22 2014, Ulf Hansson wrote:
>> Here are a third and final collection of patches for 3.16.
>>
>> I have as you and I discussed (off list), collected the patches from
>> Russell's sdhci patchset. I needed to resolve some conflicts while
>> applying them, but it was manageable. I also omitted the patch which
>> was reported to caused problem with eMMC, (mmc: sdhci: hack up driver
>> to make it more compliant with UHS-1).
>
> Pulled, but:

Great!

>
> drivers/mmc/host/sdhci.c: In function ?sdhci_set_uhs_signaling?:
> drivers/mmc/host/sdhci.c:1432:12: error: ?ios? undeclared (first use
> in this function)
>   else if ((ios->timing == MMC_TIMING_UHS_DDR50) ||
>             ^

Seems like I manage to break it while I resolved the conflict for the
below commit:

"mmc: sdhci: convert sdhci_set_uhs_signaling() into a library function"

The following lines...
+       else if ((ios->timing == MMC_TIMING_UHS_DDR50) ||
+                (ios->timing == MMC_TIMING_MMC_DDR52))
+               ctrl_2 |= SDHCI_CTRL_UHS_DDR50;

Should be replaced by;
+       else if ((timing == MMC_TIMING_UHS_DDR50) ||
+                (timing == MMC_TIMING_MMC_DDR52))
+               ctrl_2 |= SDHCI_CTRL_UHS_DDR50;

Can you update the code and amend the commit?

Kind regards
Uffe
