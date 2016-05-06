From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 06 May 2016 08:24:32 +0200
Subject: [RFC v2 07/13] power: pwrseq: simple: Add support for toggling
 regulator
In-Reply-To: <d27c30c1-f205-973e-71f1-f5b410418d04@osg.samsung.com>
References: <1462451666-17945-1-git-send-email-k.kozlowski@samsung.com>
 <1462451666-17945-8-git-send-email-k.kozlowski@samsung.com>
 <d27c30c1-f205-973e-71f1-f5b410418d04@osg.samsung.com>
Message-ID: <572C38A0.7060707@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/05/2016 09:31 PM, Javier Martinez Canillas wrote:
> Hello Krzysztof,
> 
> On 05/05/2016 08:34 AM, Krzysztof Kozlowski wrote:
>> Some devices need real hard-reset by cutting the power.  During power
>> sequence turn off and on the regulator, if it is provided.
>>
>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>> ---
> 
> [snip]
> 
>>  
>>  #define to_pwrseq_simple(p) container_of(p, struct mmc_pwrseq_simple, pwrseq)
>> @@ -62,6 +65,13 @@ static void mmc_pwrseq_simple_post_power_on(struct pwrseq *_pwrseq)
>>  {
>>  	struct mmc_pwrseq_simple *pwrseq = to_pwrseq_simple(_pwrseq);
>>  
>> +	if (pwrseq->ext_reg) {
>> +		int err;
>> +
>> +		err = regulator_enable(pwrseq->ext_reg);
>> +		WARN_ON_ONCE(err);
>> +	}
>> +
> 
> Shouldn't this be in mmc_pwrseq_simple_pre_power_on() instead?
> 
> For example, a chip may need to be powered on before attempting to
> toggle its reset or power pins using some GPIO lines.

Indeed this should be still sorted out but here the assumption is that
regulator is disabled (by probe()) so it should be turned on with
GPIO-reset set.

This can be done at the end of pre-power-on or here (beginning of
post-power-on). On the other hand I understand these pre/post callbacks
as one starting the reset sequence (pre) and second as finishing it
(post). In case of regulators, finishing power sequence is to turn the
regulator on.

Best regards,
Krzysztof
