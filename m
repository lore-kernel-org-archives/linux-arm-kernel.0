From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 24 Mar 2014 10:14:56 +0100
Subject: [PATCH 05/20] mmc: mmci: Add DT bindings for signal direction
In-Reply-To: <CAL_JsqLFJbC=ZVgc1xu9MN6iYN2871mxvZoJnAQJw3BQU07B+w@mail.gmail.com>
References: <1395404057-27835-1-git-send-email-ulf.hansson@linaro.org>
 <1395404057-27835-6-git-send-email-ulf.hansson@linaro.org>
 <CAL_JsqLFJbC=ZVgc1xu9MN6iYN2871mxvZoJnAQJw3BQU07B+w@mail.gmail.com>
Message-ID: <CAPDyKFrupT7sbT5eBsTC61ELCp_OZTe==Jc_6KUqo9Wb4Xf5dQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 March 2014 16:20, Rob Herring <robherring2@gmail.com> wrote:
> On Fri, Mar 21, 2014 at 7:14 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> Some variants have support for indicating the bus signal directions,
>> which currently are configured through platform data.
>>
>> Add corresponding DT bindings to enable us to move away from using the
>> platform data.
>>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> ---
>>  Documentation/devicetree/bindings/mmc/mmci.txt |    4 ++++
>>  drivers/mmc/host/mmci.c                        |    7 +++++++
>>  2 files changed, 11 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/mmci.txt b/Documentation/devicetree/bindings/mmc/mmci.txt
>> index d167562..eb9ad86 100644
>> --- a/Documentation/devicetree/bindings/mmc/mmci.txt
>> +++ b/Documentation/devicetree/bindings/mmc/mmci.txt
>> @@ -15,6 +15,7 @@ Optional properties:
>>  - mmc-cap-mmc-highspeed  : indicates whether MMC is high speed capable.
>>  - mmc-cap-sd-highspeed   : indicates whether SD is high speed capable.
>>  - vqmmc-supply           : phandle to the regulator device tree node.
>> +- signal-direction       : a bit pattern, indicating bus signals directions.
>
> You need to define the bit positions.

May I refer to the <dt-bindings/mmc/mmci.h> instead? To me, it seems a
bit silly to duplicate that information in the documentation.

>
>>
>>  Example:
>>
>> @@ -37,6 +38,9 @@ sdi0_per1 at 80126000 {
>>         mmc-cap-mmc-highspeed;
>>         cd-gpios  = <&gpio2 31 0x4>; // 95
>>
>> +       signal-direction = <(MCI_ST_DATA2DIREN | MCI_ST_CMDDIREN |
>> +                       MCI_ST_DATA0DIREN | MCI_ST_FBCLKEN)>;
>
> The "ST" here is for STMicro or some ST based company? Use the vendor
> prefix here.

We have way back already concluded to use "ST" as prefix for all
STMicro specific defines used in mmci. Please have a look at
drivers/mmc/host/mmci.h.
I would prefer to keep these aligned with the other defines, though if
you have strong feelings about it, sure I can change them.

>
> I don't really understand why you need to specify the direction here.
> Data lines are bi-directional and cmd and clk are outputs.
>

These bits are being used when you have an external levelshifter.

Without going into too much details, it all depends on how the
different pins are connected to the levelshifter, which isn't possible
to figure out in runtime.

>> +
>>         vmmc-supply = <&ab8500_ldo_aux3_reg>;
>>         vqmmc-supply = <&vmmci>;
>>
>> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
>> index d6f20ba..76e41ba 100644
>> --- a/drivers/mmc/host/mmci.c
>> +++ b/drivers/mmc/host/mmci.c
>> @@ -1390,8 +1390,15 @@ static struct mmc_host_ops mmci_ops = {
>>  static void mmci_dt_populate_generic_pdata(struct device_node *np,
>>                                         struct mmci_platform_data *pdata)
>>  {
>> +       u32 sigdir = 0;
>>         int bus_width = 0;
>>
>> +       if (!of_property_read_u32(np, "signal-direction", &sigdir)) {
>> +               sigdir &= MCI_ST_DATA2DIREN|MCI_ST_CMDDIREN|MCI_ST_DATA0DIREN|
>> +                       MCI_ST_DATA31DIREN|MCI_ST_FBCLKEN|MCI_ST_DATA74DIREN;
>
> Spaces around the '|'.
>
> Rob

Kind regards
Ulf Hansson
