From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Tue, 14 Nov 2017 13:03:42 +0000
Subject: [PATCH v3 1/4] net: nb8800: Drop generic support
In-Reply-To: <f197b96e-55b1-463d-1276-1fecc1e5220d@sigmadesigns.com> (Marc
 Gonzalez's message of "Tue, 14 Nov 2017 13:47:26 +0100")
References: <230165aa-eaf1-6e2b-7ff3-45b3ee4ffc62@sigmadesigns.com>
 <3c0385f3-bae9-8b40-aec4-3818456b2767@sigmadesigns.com>
 <yw1x60ad2fyz.fsf@mansr.com>
 <f197b96e-55b1-463d-1276-1fecc1e5220d@sigmadesigns.com>
Message-ID: <yw1xo9o5107l.fsf@mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc Gonzalez <marc_gonzalez@sigmadesigns.com> writes:

> On 14/11/2017 13:37, M?ns Rullg?rd wrote:
>
>> Marc Gonzalez writes:
>> 
>>> According to our HW dev, there is no provision for software to safely
>>> disable RX DMA in the AU-NB8800 hardware block (ethernet DMA). Thus,
>>> it is the responsibility of the SoC designer to provide such a feature.
>>>
>>> The nb8800_dma_stop() implementation is a clever hack that works most
>>> of the times, but it breaks the DMA state machine in rare cases.
>>>
>>> Therefore, let's drop generic support.
>>>
>>> FWIW, tango chips provide a reset register. When the ethernet block
>>> comes out of reset, DMA is disabled.
>>>
>>> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
>>> ---
>>>  drivers/net/ethernet/aurora/nb8800.c | 3 ---
>>>  1 file changed, 3 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/aurora/nb8800.c b/drivers/net/ethernet/aurora/nb8800.c
>>> index e94159507847..26f719e2d6ca 100644
>>> --- a/drivers/net/ethernet/aurora/nb8800.c
>>> +++ b/drivers/net/ethernet/aurora/nb8800.c
>>> @@ -1335,9 +1335,6 @@ static const struct nb8800_ops nb8800_tango4_ops = {
>>>  };
>>>
>>>  static const struct of_device_id nb8800_dt_ids[] = {
>>> -	{
>>> -		.compatible = "aurora,nb8800",
>>> -	},
>>>  	{
>>>  		.compatible = "sigma,smp8642-ethernet",
>>>  		.data = &nb8800_tangox_ops,
>>> -- 
>> 
>> Please leave this.  It works just fine on tango3.
>
> What you call "tango3" is your SMP8642-based board, I suppose.
> That is covered by the "sigma,smp8642-ethernet" string.
>
> There is no need for the generic "aurora,nb8800" string, as no other
> known SoC uses the Aurora SSN8800+NB8800 IP; and as I point out in the
> commit message, the raw IP lacks certain features.
>
> There is no point in keeping this around. It just adds unnecessary
> existence tests for every use of the ops struct.

And if someone discovers another chip using this controller, having the
base support in there makes it much easier to get it working.

-- 
M?ns Rullg?rd
