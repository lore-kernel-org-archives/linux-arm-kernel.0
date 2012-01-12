From: m-karicheri2@ti.com (Karicheri, Muralidharan)
Date: Thu, 12 Jan 2012 12:00:15 +0000
Subject: [PATCH v2] DaVinci: can only power up domains on DM644x
In-Reply-To: <201201062148.32025.sshtylyov@ru.mvista.com>
References: <201109151829.49256.sshtylyov@ru.mvista.com>
 <201201062140.33712.sshtylyov@ru.mvista.com>
 <201201062148.32025.sshtylyov@ru.mvista.com>
Message-ID: <3E54258959B69E4282D79E01AB1F32B7265471@DFLE34.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sekhar & Sergei,

This will affect the new SoCs that have capabilities to power up different domains. Why do we need this enforcement? We are working on a DaVinci variant SoC that can do power up multiple domains (That is why I had a patch earlier to support
Multiple PD which is already part of the tree). So I don't want this patch to go through unless I see a reason for pushing this.

Murali Karicheri
Software Design Engineer
email: m-karicheri2 at ti.com

>> -----Original Message-----
>> From: davinci-linux-open-source-bounces at linux.davincidsp.com
>> [mailto:davinci-linux-open-source-bounces at linux.davincidsp.com] On Behalf
>> Of Sergei Shtylyov
>> Sent: Friday, January 06, 2012 1:49 PM
>> To: davinci-linux-open-source at linux.davincidsp.com; Nori, Sekhar; linux-
>> arm-kernel at lists.infradead.org
>> Subject: [PATCH v2] DaVinci: can only power up domains on DM644x
>> 
>> Only DM644x has the domain power up procedure documented; for all other
>> SoCs a
>> bootloader probably should have powered the domain up. Print error message
>> and
>> give up if it hasn't done so.
>> 
>> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
>> 
>> ---
>> Duh, forgot a newline in the message!
>> 
>>  arch/arm/mach-davinci/psc.c |    8 ++++++++
>>  1 file changed, 8 insertions(+)
>> 
>> Index: linux-davinci/arch/arm/mach-davinci/psc.c
>> ===================================================================
>> --- linux-davinci.orig/arch/arm/mach-davinci/psc.c
>> +++ linux-davinci/arch/arm/mach-davinci/psc.c
>> @@ -81,6 +81,14 @@ void davinci_psc_config(unsigned int dom
>> 
>>  	pdstat = __raw_readl(psc_base + PDSTAT + 4 * domain);
>>  	if ((pdstat & PDSTAT_STATE_MASK) == 0) {
>> +		/* Only DM644x has the domain power up procedure documented.
>> */
>> +		if (!cpu_is_davinci_dm644x()) {
>> +			pr_err("Don't know how to power on domain %u of PSC%u, "
>> +			       "probably bootloader should have done this!\n",
>> +			       domain, ctlr);
>> +			BUG();
>> +		}
>> +
>>  		pdctl = __raw_readl(psc_base + PDCTL + 4 * domain);
>>  		pdctl |= PDCTL_NEXT;
>>  		__raw_writel(pdctl, psc_base + PDCTL + 4 * domain);
>> _______________________________________________
>> Davinci-linux-open-source mailing list
>> Davinci-linux-open-source at linux.davincidsp.com
>> http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source
