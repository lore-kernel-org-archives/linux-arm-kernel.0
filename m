From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Thu, 27 Sep 2018 09:55:05 +0100
Subject: [PATCH V2 03/27] mmc: mmci: convert dma_setup callback to return
 an int
In-Reply-To: <CAPDyKFqnN0gg9WsbNPQcodqUXJmFEzMM+ST36s6oEZ2OPoONug@mail.gmail.com>
References: <1537523181-14578-1-git-send-email-ludovic.Barre@st.com>
 <1537523181-14578-4-git-send-email-ludovic.Barre@st.com>
 <CAPDyKFqnN0gg9WsbNPQcodqUXJmFEzMM+ST36s6oEZ2OPoONug@mail.gmail.com>
Message-ID: <55622e1c-190f-6903-ab04-16089264f277@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for looping me!

On 24/09/18 15:28, Ulf Hansson wrote:
>>   /* Initialize the dml hardware connected to SD Card controller */
>> -static void qcom_dma_setup(struct mmci_host *host)
>> +static int qcom_dma_setup(struct mmci_host *host)
>>   {
>>          u32 config;
>>          void __iomem *base;
>> @@ -131,7 +131,7 @@ static void qcom_dma_setup(struct mmci_host *host)
>>
>>          if (producer_id < 0 || consumer_id < 0) {
>>                  host->variant->qcom_dml = false;
> It seems like the existing code is an attempt to fallback to use pio
> mode. However, I doubt it works as is.

If I remember it correctly, Yes, that was the intent. we should still be 
able to use the pio mode if the dma setup fails.

I believe pio mode should work, Last time when I tried (3-4 years back) 
it did work!

> 
>> -               return;
>> +               return -EINVAL;
> My point is, if you return an error code here, it means that the error
> code becomes propagated and ->probe() will fail.
That would be very bad!, We should report it and may be just continue 
with pio mode.

> 
> Ideally, we should be able fall back to pio mode when dma doesn't
> work. I have looped in Srinivas who implemented the qcom dml support,
> let's see if he can explains the intent with the code.
> 
> I also volunteer to help out running some tests on the 410c platform,
I think you meant IFC6410.. DB410c uses sdhci.


--srini
> however allow me a day or two to do that.
> 
