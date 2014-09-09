From: gabriel.fernandez@linaro.org (Gabriel Fernandez)
Date: Tue, 9 Sep 2014 11:23:45 +0200
Subject: [PATCH v2 7/8] phy: miphy28lp: Add SSC support for PCIE
In-Reply-To: <540DC81F.6000901@ti.com>
References: <1409758637-28654-1-git-send-email-gabriel.fernandez@linaro.org>
 <1409758637-28654-8-git-send-email-gabriel.fernandez@linaro.org>
 <540DC81F.6000901@ti.com>
Message-ID: <CAG374jAGFXFJJkNjHBcApgzMw+VdfFQJOFmvOnvzozknk20XDw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kishon,

On 8 September 2014 17:15, Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
>
> On Wednesday 03 September 2014 09:07 PM, Gabriel FERNANDEZ wrote:
>> SSC is the technique of modulating the operating frequency of a signal
>> slightly to spread its radiated emissions over a range of frequencies.
>> This reduction in the maximum emission for a given frequency helps meet
>> radiated emission requirements.
>> These settings are applicable for PCIE with Internal clock.
>>
>> Signed-off-by: Harsh Gupta <harsh.gupta@st.com>
>> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.orgm>
>> ---
>>  drivers/phy/phy-miphy28lp.c | 32 ++++++++++++++++++++++++++++++++
>>  1 file changed, 32 insertions(+)
>>
>> diff --git a/drivers/phy/phy-miphy28lp.c b/drivers/phy/phy-miphy28lp.c
>> index b36e737..976fdda 100644
>> --- a/drivers/phy/phy-miphy28lp.c
>> +++ b/drivers/phy/phy-miphy28lp.c
>> @@ -679,6 +679,36 @@ static int miphy28lp_init_sata(struct miphy28lp_phy *miphy_phy)
>>       return miphy_is_ready(miphy_phy);
>>  }
>>
>> +static void miphy_pcie_tune_ssc(struct miphy28lp_phy *miphy_phy)
>> +{
>> +     u8 val;
>> +
>> +     /* Compensate Tx impedance to avoid out of range values */
>> +     if (miphy_phy->ssc) {
>> +             /*
>> +              * Enable the SSC on PLL for all banks
>> +              * SSC Modulation @ 31 KHz and 4000 ppm modulation amp
>> +              */
>> +             val = readb_relaxed(miphy_phy->base + 0x0c);
>> +             val |= 0x04;
>> +             writeb_relaxed(val, miphy_phy->base + 0x0c);
>> +             val = readb_relaxed(miphy_phy->base + 0x0a);
>> +             val |= 0x10;
>> +             writeb_relaxed(val, miphy_phy->base + 0x0a);
>
> macros for these registers and values is needed. Or else it's difficult to review.
ok will be fix to v3

>> +
>> +             for (val = 0; val < 2; val++) {
>> +                     writeb_relaxed(val, miphy_phy->base + 0x0f);
>> +                     writeb_relaxed(0x69, miphy_phy->base + 0xe5);
>
> Do these registers have to be written for every iteration?

Yes because we select the bank value before (with val)

>
> Thanks
> Kishon
