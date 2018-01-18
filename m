From: patrice.chotard@st.com (Patrice CHOTARD)
Date: Thu, 18 Jan 2018 13:24:52 +0000
Subject: [PATCH v2 03/15] mmc: mmci: Don't pretend all variants to have
 OPENDRAIN bit
In-Reply-To: <CAPDyKFrhBfGq0RBBdFLex+88XqrLB-Bm3rc2Q_UZCw8XB520ug@mail.gmail.com>
References: <1516105859-3525-1-git-send-email-patrice.chotard@st.com>
 <1516105859-3525-4-git-send-email-patrice.chotard@st.com>
 <CAPDyKFrhBfGq0RBBdFLex+88XqrLB-Bm3rc2Q_UZCw8XB520ug@mail.gmail.com>
Message-ID: <1fc0817f-2495-6996-4777-abc8c30c20d2@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ulf

On 01/17/2018 10:33 AM, Ulf Hansson wrote:
> [...]
> 
>>   /* Busy detection for the ST Micro variant */
>> @@ -1455,16 +1465,13 @@ static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>>                                  ~MCI_ST_DATA2DIREN);
>>          }
>>
>> -       if (ios->bus_mode == MMC_BUSMODE_OPENDRAIN) {
>> -               if (host->hw_designer != AMBA_VENDOR_ST)
>> -                       pwr |= MCI_ROD;
>> -               else {
>> -                       /*
>> -                        * The ST Micro variant use the ROD bit for something
>> -                        * else and only has OD (Open Drain).
>> -                        */
>> -                       pwr |= MCI_OD;
>> -               }
>> +       if (ios->bus_mode == MMC_BUSMODE_OPENDRAIN &&
>> +           host->variant->opendrain) {
> 
> A few nitpicks (because I anyway had some comment on patch4):
> 
> The above can be written on one line and the brackets isn't needed.
> 
> Replace host->variant->opendrain with variant->opendrain. The same
> applies to the below change.

Ah yes, i will fix it

> 
>> +               /*
>> +                * The ST Micro variant use the ROD bit for
>> +                * something else and only has OD (Open Drain).
>> +                */
> 
> I think we can remove this comment, as this information becomes
> implicit when we start using the variant data.

Ok

Thanks

Patrice

> 
>> +               pwr |= host->variant->opendrain;
>>          }
>>
>>          /*
>> --
>> 1.9.1
>>
> 
> Kind regards
> Uffe
> 
