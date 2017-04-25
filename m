From: jon.mason@broadcom.com (Jon Mason)
Date: Tue, 25 Apr 2017 11:15:43 -0400
Subject: [PATCH 2/2] ARM: dts: Add the ethernet and ethernet PHY to the
 cygnus core DT.
In-Reply-To: <f870339f-2fa1-411d-5ce8-adbe8802d8a8@cogentembedded.com>
References: <20170424215022.30382-1-eric@anholt.net>
 <20170424215022.30382-3-eric@anholt.net>
 <f870339f-2fa1-411d-5ce8-adbe8802d8a8@cogentembedded.com>
Message-ID: <CAC3K-4qn5oCXvyMCkFESGqMHqHXGiNUW6wfRx2LUZ8qZ39qroQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 25, 2017 at 5:40 AM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Hello.
>
> On 4/25/2017 12:50 AM, Eric Anholt wrote:
>
>> Cygnus has a single amac controller connected to the B53 switch with 2
>> PHYs.  On the BCM911360_EP platform, those two PHYs are connected to
>> the external ethernet jacks.
>
>
>    My spell checker trips on "amac" and "ethernet" -- perhaps they need
> capitalization?
>
>> Signed-off-by: Eric Anholt <eric@anholt.net>
>> ---
>>  arch/arm/boot/dts/bcm-cygnus.dtsi      | 60
>> ++++++++++++++++++++++++++++++++++
>>  arch/arm/boot/dts/bcm911360_entphn.dts |  8 +++++
>>  2 files changed, 68 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi
>> b/arch/arm/boot/dts/bcm-cygnus.dtsi
>> index 009f1346b817..318899df9972 100644
>> --- a/arch/arm/boot/dts/bcm-cygnus.dtsi
>> +++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
>> @@ -142,6 +142,56 @@
>>                         interrupts = <0>;
>>                 };
>>
>> +               mdio: mdio at 18002000 {
>> +                       compatible = "brcm,iproc-mdio";
>> +                       reg = <0x18002000 0x8>;
>> +                       #size-cells = <1>;
>> +                       #address-cells = <0>;
>> +
>> +                       gphy0: eth-gphy at 0 {
>
>
>    The node anmes must be generic, the DT spec has standardized
> "ethernet-phy" name for this case.
>
>> +                               reg = <0>;
>> +                               max-speed = <1000>;
>> +                       };
>> +
>> +                       gphy1: eth-gphy at 1 {
>> +                               reg = <1>;
>> +                               max-speed = <1000>;
>> +                       };
>> +               };
>
> [...]
>>
>> @@ -295,6 +345,16 @@
>>                         status = "disabled";
>>                 };
>>
>> +               eth0: enet at 18042000 {
>> +                       compatible = "brcm,amac";
>> +                       reg = <0x18042000 0x1000>,
>> +                             <0x18110000 0x1000>;
>> +                       reg-names = "amac_base", "idm_base";
>
>
>    I don't think "_base" suffixes are necessary here.

100% necessary, per the driver.  See
drivers/net/ethernet/broadcom/bgmac-platform.c


>
> [...]
>
> MBR, Sergei
>
