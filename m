From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Mon, 5 Sep 2016 21:07:03 +0200
Subject: [PATCH v4 4/5] net: stmmac: add a glue driver for the Amlogic
 Meson 8b / GXBB DWMAC
In-Reply-To: <14789887.lyko4Om94p@wuerfel>
References: <201609050953.67GKeUAU%fengguang.wu@intel.com>
 <14789887.lyko4Om94p@wuerfel>
Message-ID: <CAFBinCAC3c=o1=8DGfiPhw6w6V42jvYLUfHXHpHLe03pw8P=LQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 5, 2016 at 12:53 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday, September 5, 2016 9:37:29 AM CEST kbuild test robot wrote:
>> All error/warnings (new ones prefixed by >>):
>>
>> >> drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c:63:18: error: field 'm250_mux' has incomplete type
>>      struct clk_mux  m250_mux;
>>                      ^
>> >> drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c:67:21: error: field 'm250_div' has incomplete type
>>      struct clk_divider m250_div;
>>                         ^
>>
>
> I think this needs a compile-time dependency on COMMON_CLK
indeed, since we are also a clock provider we have to depend on
CONFIG_COMMON_CLK.

That brings up a question though:
so far the new driver uses the same Kconfig symbol as the "old" driver
(CONFIG_DWMAC_MESON).
The "old" driver does not need CONFIG_COMMON_CLK while the new one does.
I see a few options here:
1. simply adding the dependency (as most configurations will have
CONFIG_COMMON_CLK enabled anyways)
2. add some depends on COMMON_CLK || MACH_MESON6 || MACH_MESON8 foo
3. use a new Kconfig symbol for new new driver (CONFIG_DWMAC_MESON8B?)

And finally regarding your other mail: I have already changed
WARN_ON(PTR_ERR_OR_ZERO(...)) to WARN_ON(IS_ERR(...)) in v4


Regards,
Martin
