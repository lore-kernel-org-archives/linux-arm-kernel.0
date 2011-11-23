From: javi.merino@arm.com (Javi Merino)
Date: Wed, 23 Nov 2011 09:46:18 +0000
Subject: [PATCH 1/4] ARM: PL330: Don't call the callbacks if there isn't
 any active transfer
In-Reply-To: <4ECBD8E6.3010605@arm.com>
References: <1320244259-10496-1-git-send-email-javi.merino@arm.com>	<CAJe_Zhf+PAeM+wquQykXNDG74Nc+jQNXrp+RLMKSySCNPum8Tg@mail.gmail.com>	<4EC28A76.7080606@arm.com>	<CABb+yY1atyLA8Ej57JBEM0JL3oK5e6+1vO0UH5VTNiBsKQPueA@mail.gmail.com>
 <CAJe_ZhftO+481BfL0ErEcM_brfmSuTXkTEniLRYxxM2T7OM2QA@mail.gmail.com>
 <4ECBD8E6.3010605@arm.com>
Message-ID: <4ECCC0EA.2030503@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jassi,

On 22/11/11 17:16, Javi Merino wrote:
> On 16/11/11 06:24, Jassi Brar wrote:
>> On 15 November 2011 22:30, Jassi Brar <jassisinghbrar@gmail.com> wrote:
>> I think the following strikes just the right balance and should fix
>> the issue ...
>>
>> diff --git a/arch/arm/common/pl330.c b/arch/arm/common/pl330.c
>> index 7129cfb..ecbca3f 100644
>> --- a/arch/arm/common/pl330.c
>> +++ b/arch/arm/common/pl330.c
>> @@ -1480,13 +1480,19 @@ int pl330_update(const struct pl330_info *pi)
>>
>>  	/* Now that we are in no hurry, do the callbacks */
>>  	while (!list_empty(&pl330->req_done)) {
>> +		struct pl330_req *r;
>> +
>>  		rqdone = container_of(pl330->req_done.next,
>>  					struct _pl330_req, rqd);
>>
>>  		list_del_init(&rqdone->rqd);
>>
>> +		/* Detach the req */
>> +		r = rqdone->r;
>> +		rqdone->r = NULL;
>> +
>>  		spin_unlock_irqrestore(&pl330->lock, flags);
>> -		_callback(rqdone->r, PL330_ERR_NONE);
>> +		_callback(r, PL330_ERR_NONE);
>>  		spin_lock_irqsave(&pl330->lock, flags);
>>  	}
> 
> I'll try this patch and if it works we can submit it instead of my
> original one.

It worked!  Can you please send it to Russell's patch system?  You can
add a:

Tested-by: Javi Merino <javi.merino@arm.com>

Cheers,
Javi
