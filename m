From: rogerq@ti.com (Roger Quadros)
Date: Tue, 23 Jul 2013 14:13:54 +0300
Subject: [PATCH] ARM: Do not run dummy_flush_tlb_a15_erratum() on
 non-Cortex-A15
In-Reply-To: <CAOMZO5Brgj2CzJXqjUfihi-aNxumvamDUGdvZuU94rHMwutCog@mail.gmail.com>
References: <1374556774-18795-1-git-send-email-festevam@gmail.com>
 <51EE3B46.7020906@ti.com>
 <CAOMZO5Brgj2CzJXqjUfihi-aNxumvamDUGdvZuU94rHMwutCog@mail.gmail.com>
Message-ID: <51EE6572.50909@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/23/2013 02:02 PM, Fabio Estevam wrote:
> Hi Roger,
> 
> On Tue, Jul 23, 2013 at 5:13 AM, Roger Quadros <rogerq@ti.com> wrote:
> 
>>> -     if (!erratum_a15_798181())
>>> -             return;
>>> -
>>
>> Removing this if statement will cause "ipi_flush_tlb_a15_erratum" to be called
>> on non A15 platforms. So I would just keep it to be safe.
> 
> I just moved the if statement into the the beginning of
> dummy_flush_tlb_a15_erratum(), so ipi_flush_tlb_a15_erratum will not
> be called on non-A15 systems.

It will be called. Please see the code below after your patch is applied.

 static void broadcast_tlb_a15_erratum(void)
 {
 	dummy_flush_tlb_a15_erratum();
 	smp_call_function(ipi_flush_tlb_a15_erratum, NULL, 1);
 }

cheers,
-roger
