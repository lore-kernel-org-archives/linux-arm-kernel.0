From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 01 Jun 2015 16:42:58 +0200
Subject: [PATCH v11 4/5] edac: Add APM X-Gene SoC EDAC driver
In-Reply-To: <1432337580-3750-5-git-send-email-lho@apm.com>
References: <1432337580-3750-1-git-send-email-lho@apm.com>
 <1432337580-3750-4-git-send-email-lho@apm.com>
 <1432337580-3750-5-git-send-email-lho@apm.com>
Message-ID: <3195065.IK73o60xya@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 22 May 2015 17:32:59 Loc Ho wrote:
> +static bool xgene_edac_pmd_l2c_version1(void)
> +{
> +       /* Check all chips with PMD L2C version 1 HW */
> +       #define REVIDR_MINOR_REV(revidr)        ((revidr) & 0x00000007)
> +
> +       switch (MIDR_VARIANT(read_cpuid_id())) {
> +       case 0:
> +               switch (MIDR_REVISION(read_cpuid_id())) {
> +               case 0:
> +
> +                       switch (REVIDR_MINOR_REV(read_cpuid(REVIDR_EL1))) {
> +                       case 1:
> +                       case 2:
> +                               return true;
> +                       };
> +                       break;
> +               case 1:
> +                       if (REVIDR_MINOR_REV(read_cpuid(REVIDR_EL1)) == 1)
> +                               return true;
> +                       break;
> +               }
> +               break;
> +       case 1:
> +               switch (MIDR_REVISION(read_cpuid_id())) {
> +               case 0:
> +                       switch (REVIDR_MINOR_REV(read_cpuid(REVIDR_EL1))) {
> +                       case 1:
> +                               return true;
> +                       };
> +                       break;
> +               case 1:
> +                       switch (REVIDR_MINOR_REV(read_cpuid(REVIDR_EL1))) {
> +                       case 1:
> +                       case 0:
> +                               return true;
> +                       };
> +                       break;
> +               }
> +               break;
> +       }
> +

As this is causing build errors on other architectures with COMPILE_TEST
now, I'd suggest removing the function completely.

Please use different compatible strings for IP blocks that are different
and undetectable, instead of reading the ID of another IP block.

	Arnd
