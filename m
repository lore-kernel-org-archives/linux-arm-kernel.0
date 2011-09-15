From: m-karicheri2@ti.com (Karicheri, Muralidharan)
Date: Thu, 15 Sep 2011 19:27:33 +0000
Subject: [PATCH] DaVinci: only poll EPCPR on DM644x and DM355
In-Reply-To: <201109151829.49256.sshtylyov@ru.mvista.com>
References: <201109151829.49256.sshtylyov@ru.mvista.com>
Message-ID: <3E54258959B69E4282D79E01AB1F32B701D2A6@DLEE12.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sergei,

Thanks for the patch. Looks good to me.

Murali Karicheri
Software Design Engineer
email: m-karicheri2 at ti.com


>> -----Original Message-----
>> From: davinci-linux-open-source-bounces at linux.davincidsp.com
>> [mailto:davinci-linux-open-source-bounces at linux.davincidsp.com] On Behalf
>> Of Sergei Shtylyov
>> Sent: Thursday, September 15, 2011 10:30 AM
>> To: Hilman, Kevin; davinci-linux-open-source at linux.davincidsp.com; Nori,
>> Sekhar
>> Cc: linux-arm-kernel at lists.infradead.org
>> Subject: [PATCH] DaVinci: only poll EPCPR on DM644x and DM355
>> 
>> EPCPR register and PDCTL.EPCGOOD bit exist only on DaVinci DM644x and
>> DM35x,
>> so do not try to poll EPCPR and set PDCTL.EPCGOOD on the other SoCs -- it
>> would
>> lead to lock up if some power domain hasn't been powered up by this time
>> (which
>> hasn't happened yet on any board, it seems).
>> 
>> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
>> 
>> ---
>> The patch is against the recent DaVinci tree plus this patch:
>> 
>> http://linux.davincidsp.com/pipermail/davinci-linux-open-source/2011-
>> September/023308.html
>> 
>> Index: linux-davinci/arch/arm/mach-davinci/psc.c
>> ===================================================================
>> --- linux-davinci.orig/arch/arm/mach-davinci/psc.c
>> +++ linux-davinci/arch/arm/mach-davinci/psc.c
>> @@ -88,14 +88,19 @@ void davinci_psc_config(unsigned int dom
>>  		ptcmd = 1 << domain;
>>  		__raw_writel(ptcmd, psc_base + PTCMD);
>> 
>> -		do {
>> -			epcpr = __raw_readl(psc_base + EPCPR);
>> -		} while ((((epcpr >> domain) & 1) == 0));
>> -
>> -		pdctl = __raw_readl(psc_base + PDCTL + 4 * domain);
>> -		pdctl |= 0x100;
>> -		__raw_writel(pdctl, psc_base + PDCTL + 4 * domain);
>> -
>> +		/*
>> +		 * EPCPR register and PDCTL.EPCGOOD bit exist only on DaVinci
>> +		 * DM644x and DM35x...
>> +		 */
>> +		if (cpu_is_davinci_dm644x() || cpu_is_davinci_dm355()) {
>> +			do {
>> +				epcpr = __raw_readl(psc_base + EPCPR);
>> +			} while (((epcpr >> domain) & 1) == 0);
>> +
>> +			pdctl = __raw_readl(psc_base + PDCTL + 4 * domain);
>> +			pdctl |= 0x100;
>> +			__raw_writel(pdctl, psc_base + PDCTL + 4 * domain);
>> +		}
>>  	} else {
>>  		ptcmd = 1 << domain;
>>  		__raw_writel(ptcmd, psc_base + PTCMD);
>> _______________________________________________
>> Davinci-linux-open-source mailing list
>> Davinci-linux-open-source at linux.davincidsp.com
>> http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source
