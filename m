From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 30 Jan 2018 00:12:56 +0100
Subject: [PATCH v7 2/2] media: V3s: Add support for Allwinner CSI.
In-Reply-To: <c86097d7-dade-01e5-3826-3f22f9ca4b4f@infradead.org>
References: <1517217696-17816-1-git-send-email-yong.deng@magewell.com>
 <c86097d7-dade-01e5-3826-3f22f9ca4b4f@infradead.org>
Message-ID: <CAK8P3a1W2VC3CEUvPLKoE7FGU1Osm53YQ-F892wqNekn-h8m1A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 29, 2018 at 10:49 PM, Randy Dunlap <rdunlap@infradead.org> wrote:
> On 01/29/2018 01:21 AM, Yong Deng wrote:
>> Allwinner V3s SoC features two CSI module. CSI0 is used for MIPI CSI-2
>> interface and CSI1 is used for parallel interface. This is not
>> documented in datasheet but by test and guess.
>>
>> This patch implement a v4l2 framework driver for it.
>>
>> Currently, the driver only support the parallel interface. MIPI-CSI2,
>> ISP's support are not included in this patch.
>>
>> Tested-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>> Signed-off-by: Yong Deng <yong.deng@magewell.com>
>> ---
>
>
> A previous version (I think v6) had a build error with the use of
> PHYS_OFFSET, so Kconfig was modified to depend on ARM and ARCH_SUNXI
> (one of which seems to be overkill).  As is here, the COMPILE_TEST piece is
> meaningless for all arches except ARM.  If you care enough for COMPILE_TEST
> (and I would), then you could make COMPILE_TEST useful on any arch by
> removing the "depends on ARM" (the ARCH_SUNXI takes care of that) and by
> having an alternate value for PHYS_OFFSET, like so:
>
> +#if defined(CONFIG_COMPILE_TEST) && !defined(PHYS_OFFSET)
> +#define PHYS_OFFSET    0
> +#endif
>
> With those 2 changes, the driver builds for me on x86_64.

I think the PHYS_OFFSET really has to get removed from the driver, it's
wrong on ARM as well.

      Arnd
