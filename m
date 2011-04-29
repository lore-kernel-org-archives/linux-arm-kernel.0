From: jochen@scram.de (Jochen Friedrich)
Date: Fri, 29 Apr 2011 16:38:37 +0200
Subject: [PATCHv3 2.6.40 2/4] ARM: simpad: Cleanup CS3 accessors.
In-Reply-To: <20110428092327.GR17290@n2100.arm.linux.org.uk>
References: <1303377543-24794-1-git-send-email-jochen@scram.de>	<1303377543-24794-3-git-send-email-jochen@scram.de>
	<20110428092327.GR17290@n2100.arm.linux.org.uk>
Message-ID: <4DBACD6D.1070200@scram.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

thanks for the review.

>> @@ -47,15 +43,15 @@ simpad_pcmcia_socket_state(struct soc_pcmcia_socket *skt,
>>   			   struct pcmcia_state *state)
>>   {
>>   	unsigned long levels = GPLR;
>> -	long cs3reg = get_cs3_shadow();
>> +	long cs3reg = simpad_get_cs3_shadow();
>>
>>   	state->detect=((levels&  GPIO_CF_CD)==0)?1:0;
>>   	state->ready=(levels&  GPIO_CF_IRQ)?1:0;
>>   	state->bvd1=1; /* Not available on Simpad. */
>>   	state->bvd2=1; /* Not available on Simpad. */
>>   	state->wrprot=0; /* Not available on Simpad. */
>> -
>> -	if((cs3reg&  0x0c) == 0x0c) {
>> +
>> +	if ((cs3reg&  0x0c) == 0x0c) {
>
> Are there no definitions for the 0x0c magic value?

Unfortunately, this function has a bug as it currently accesses EN0|EN1, 
but then this test is never true as EN1 is never being set in this 
driver. Intended was the access to PCMCIA_VS1|PCMCIA_VS2, but then 
get_cs3_shadow() was wrong and should now be simpad_get_cs3_ro().

I'll fix this and hope someone can test this as I don't have a Simpad 
with PCMCIA.

Thanks,
Jochen
