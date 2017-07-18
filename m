From: laurentiu.tudor@nxp.com (Laurentiu Tudor)
Date: Tue, 18 Jul 2017 14:36:07 +0000
Subject: [PATCH v2 8/8] staging: fsl-mc: allow the driver compile
 multi-arch
In-Reply-To: <CAK8P3a0WvNgk5eXQoPpXiLwOS_wB1NdfCyPtiKMys3qqEwHjDw@mail.gmail.com>
References: <20170718133723.12709-1-laurentiu.tudor@nxp.com>
 <20170718133723.12709-9-laurentiu.tudor@nxp.com>
 <CAK8P3a0WvNgk5eXQoPpXiLwOS_wB1NdfCyPtiKMys3qqEwHjDw@mail.gmail.com>
Message-ID: <596E1CD7.1050909@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 07/18/2017 05:25 PM, Arnd Bergmann wrote:
> On Tue, Jul 18, 2017 at 3:37 PM,  <laurentiu.tudor@nxp.com> wrote:
>
>> --- a/drivers/staging/fsl-dpaa2/Kconfig
>> +++ b/drivers/staging/fsl-dpaa2/Kconfig
>> @@ -4,7 +4,7 @@
>>
>>   config FSL_DPAA2
>>          bool "Freescale DPAA2 devices"
>> -       depends on FSL_MC_BUS
>> +       depends on FSL_MC_BUS && ARCH_LAYERSCAPE
>>          ---help---
>>            Build drivers for Freescale DataPath Acceleration
>>            Architecture (DPAA2) family of SoCs.
>
> I would probably leave the dependency in there conditionally, like
>
>           depends on ARCH_LAYERSCAPE || COMPILE_TEST
>
> That way, we can build the driver on all architectures with "make allmodconfig"
> or "make randconfig", but regular users that disable COMPILE_TEST
> won't be bothered by the extra config options unless they have the
> right hardware.
>

Good point, I'll take care of it. But don't you mean COMPILE_TEST be 
added on the actual MC_BUS config, like so:

  config FSL_MC_BUS
  	bool "QorIQ DPAA2 fsl-mc bus driver"
-	depends on OF && ARCH_LAYERSCAPE
+	depends on OF && (ARCH_LAYERSCAPE || COMPILE_TEST)
  	select GENERIC_MSI_IRQ_DOMAIN
?

The other drivers that depend on the MC_BUS won't compile on other 
architectures.

---
Thanks & Best Regards, Laurentiu
