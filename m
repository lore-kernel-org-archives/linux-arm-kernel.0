From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 20 Jan 2017 11:46:02 -0800
Subject: [PATCH v3 0/9] meson-gx: reset RGMII PHYs and configure TX delay
In-Reply-To: <CAFBinCBQ8S7-tCnkY+Vabs3etSv-gJCsK=tE+RNJZS8+uFfB=Q@mail.gmail.com>
 (Martin Blumenstingl's message of "Fri, 20 Jan 2017 16:32:18 +0100")
References: <20170120132650.9784-1-martin.blumenstingl@googlemail.com>
 <20170120152232.13943-1-martin.blumenstingl@googlemail.com>
 <CAFBinCBQ8S7-tCnkY+Vabs3etSv-gJCsK=tE+RNJZS8+uFfB=Q@mail.gmail.com>
Message-ID: <m2y3y53479.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> On Fri, Jan 20, 2017 at 4:22 PM, Martin Blumenstingl
> <martin.blumenstingl@googlemail.com> wrote:
>> This series adds the reset GPIOs for the (external) ethernet PHYs on all
>> GXBB boards.
>> Additionally it provides a ethernet PHY node which can be used to specify
>> PHY-specific properties (this may be required if more boards require the
>> "eee-broken-1000t" for the RTL8211F ethernet PHY). To make all board .dts
>> consistent I chose to add the PHY node also for boards which don't have a
>> RTL8211F PHY.
>>
>> Patch #7 from this series also removes ethernet support for the P200
>> board because it was broken anyways and nobody seems to have a board
>> available for testing. This was the outcome of the discussion from [0]
>>
>> Patch #8 was taken from (older versions of) my other series (see [1]):
>> "[PATCH net-next v3 0/2] stmmac: dwmac-meson8b: configurable
>> RGMII TX delay".
>> The binding changes for amlogic,tx-delay-ns were ACK'ed already.
>>
>> Changes since v2:
>> - fixed patch #2 to really update the P200 board (as it's the P200 which
>>   actually uses a Micrel KSZ9031 RGMII PHY). Thanks to Neil Armstrong for
>>   spotting this huge mistake!
>> - instead of dropping ethernet support for P201 we simply re-configure it
>>   to RMII mode (replaces patch #7) without a MDIO node (which keeps PHY
>>   auto-scanning enabled). This got Neil Armstrong's ACK off-list already
>>
>> Changes since v1:
>> - do not move the MDIO bus to meson-gx as this disables PHY auto-scanning
>>   in the stmmac driver (this drops patch #1 from v1)
>> - add the ethernet PHY reset GPIO for nexbox a95x which was forgotten in
>>   v1
>> - add the ethernet PHY reset GPIO for boards which were added since v1
>>   (wetek hub and wetek play2)
>> - rebased to apply against the current v4.11/dt64 branch
>> - new in v2 (patch #7): disabled ethernet support for the P200 board (see
>>   the commit description for more information). this patch is optional
>> - new in v2 (patch #9): removed the phy-mode property from meson-gx (see
>>   the commit description for more information). this patch is optional
>>
>>
>> [0] http://lists.infradead.org/pipermail/linux-amlogic/2017-January/002053.html
>> [1] http://lists.infradead.org/pipermail/linux-amlogic/2016-December/001834.html
>>
>> Martin Blumenstingl (9):
>>   ARM64: dts: meson-gxbb-odroidc2: add the ethernet PHY's reset GPIO
>>   ARM64: dts: meson-gxbb-p200: add the ethernet PHY's reset GPIO
>>   ARM64: dts: meson-gxbb-vega-s95: add the ethernet PHY's reset GPIO
>>   ARM64: dts: meson-gxbb-nexbox-a95x: add the ethernet PHY's reset GPIO
>>   ARM64: dts: meson-gxbb-wetek-hub: add the ethernet PHY's reset GPIO
>>   ARM64: dts: meson-gxbb-wetek-play2: add the ethernet PHY's reset GPIO
>>   ARM64: dts: meson-gxbb-p201: fix ethernet support
>>   ARM64: dts: amlogic: add the ethernet TX delay configuration
>>   ARM64: dts: meson-gx: remove the phy-mode property from meson-gx
>>
>>  arch/arm64/boot/dts/amlogic/meson-gx.dtsi          |  1 -
>>  .../boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts    | 17 ++++++++++++++
>>  .../arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts |  7 ++++++
>>  arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts    | 26 ++++++++++++++++++++++
>>  arch/arm64/boot/dts/amlogic/meson-gxbb-p201.dts    | 11 +++++++++
>>  arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi   |  6 -----
>>  .../boot/dts/amlogic/meson-gxbb-vega-s95.dtsi      | 20 +++++++++++++++++
>>  .../boot/dts/amlogic/meson-gxbb-wetek-hub.dts      | 26 ++++++++++++++++++++++
>>  .../boot/dts/amlogic/meson-gxbb-wetek-play2.dts    | 26 ++++++++++++++++++++++
>>  .../boot/dts/amlogic/meson-gxl-s905d-p230.dts      |  2 ++
>>  .../arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts |  2 ++
>>  arch/arm64/boot/dts/amlogic/meson-gxm-q200.dts     |  2 ++
>>  12 files changed, 139 insertions(+), 7 deletions(-)
> I totally forgot to mention:
> this applies to Kevin's v4.11/dt64 branch with Jerome's Odroid-C2
> ethernet fix [0] applied on top of it

So when Jerome's fix lands in mainline (probably by -rc5, maybe -rc6)
I'll rebase the dt64 branch on that and apply this series.

Kevin
