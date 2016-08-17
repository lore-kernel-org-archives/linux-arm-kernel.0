From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Wed, 17 Aug 2016 13:34:15 +0200
Subject: [PATCH v2 4/6] net: ethernet: bgmac: convert to feature flags
In-Reply-To: <1467932938-21819-5-git-send-email-jon.mason@broadcom.com>
References: <1467932938-21819-1-git-send-email-jon.mason@broadcom.com>
 <1467932938-21819-5-git-send-email-jon.mason@broadcom.com>
Message-ID: <CACna6rw1j3myPEkbn+YR71W7CF7Of_yahn9eDT7t3hKWGmWUmg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 July 2016 at 01:08, Jon Mason <jon.mason@broadcom.com> wrote:
>         mode = (bgmac_read(bgmac, BGMAC_DEV_STATUS) & BGMAC_DS_MM_MASK) >>
>                 BGMAC_DS_MM_SHIFT;
> -       if (ci->id != BCMA_CHIP_ID_BCM47162 || mode != 0)
> +       if (bgmac->feature_flags & BGMAC_FEAT_CLKCTLST || mode != 0)
>                 bgmac_set(bgmac, BCMA_CLKCTLST, BCMA_CLKCTLST_FORCEHT);
> -       if (ci->id == BCMA_CHIP_ID_BCM47162 && mode == 2)
> +       if (bgmac->feature_flags & BGMAC_FEAT_CLKCTLST && mode == 2)
>                 bcma_chipco_chipctl_maskset(&bgmac->core->bus->drv_cc, 1, ~0,
>                                             BGMAC_CHIPCTL_1_RXC_DLL_BYPASS);

Jon, it looks to me you translated two following conditions:
ci->id != BCMA_CHIP_ID_BCM47162
and
ci->id == BCMA_CHIP_ID_BCM47162
into the same flag check:
bgmac->feature_flags & BGMAC_FEAT_CLKCTLST

I don't think it's intentional, is it? Do you have a moment to fix this?
