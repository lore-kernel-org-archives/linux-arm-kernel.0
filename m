From: santosh.shilimkar@oracle.com (Santosh Shilimkar)
Date: Mon, 13 Nov 2017 09:07:33 -0800
Subject: [PATCH v5 2/2] memory: ti-emif-sram: introduce relocatable
 suspend/resume handlers
In-Reply-To: <20171110163922.GK28231@n2100.armlinux.org.uk>
References: <20171013205915.9652-1-d-gerlach@ti.com>
 <20171013205915.9652-3-d-gerlach@ti.com>
 <19256977-40e1-a972-4de8-838a8da863cc@oracle.com>
 <20171110163922.GK28231@n2100.armlinux.org.uk>
Message-ID: <2814bd15-d783-6e54-da0c-4b4ea0a31705@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/10/2017 8:39 AM, Russell King - ARM Linux wrote:
> On Mon, Oct 16, 2017 at 08:31:59AM -0700, Santosh Shilimkar wrote:
>> Hi Russell,
>>
>> On 10/13/2017 1:59 PM, Dave Gerlach wrote:
>>> Certain SoCs like Texas Instruments AM335x and AM437x require parts
>>> of the EMIF PM code to run late in the suspend sequence from SRAM,
>>> such as saving and restoring the EMIF context and placing the memory
>>> into self-refresh.
>>>
>>> One requirement for these SoCs to suspend and enter its lowest power
>>> mode, called DeepSleep0, is that the PER power domain must be shut off.
>>> Because the EMIF (DDR Controller) resides within this power domain, it
>>> will lose context during a suspend operation, so we must save it so we
>>> can restore once we resume. However, we cannot execute this code from
>>> external memory, as it is not available at this point, so the code must
>>> be executed late in the suspend path from SRAM.
>>>
>>> This patch introduces a ti-emif-sram driver that includes several
>>> functions written in ARM ASM that are relocatable so the PM SRAM
>>> code can use them. It also allocates a region of writable SRAM to
>>> be used by the code running in the executable region of SRAM to save
>>> and restore the EMIF context. It can export a table containing the
>>> absolute addresses of the available PM functions so that other SRAM
>>> code can branch to them. This code is required for suspend/resume on
>>> AM335x and AM437x to work.
>>>
>>> In addition to this, to be able to share data structures between C and
>>> the ti-emif-sram-pm assembly code, we can automatically generate all of
>>> the C struct member offsets and sizes as macros by processing
>>> emif-asm-offsets.c into assembly code and then extracting the relevant
>>> data as is done for the generated platform asm-offsets.h files.
>>>
>>> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
>>> ---
>>> v4->v5:
>>> * Simplify Makefile to generate include/generated/ti-emif-asm-offsets.h
>>>
>> If you are happy with this version from Dave, can I get your ack please?
>> I can add this to the driver-soc then.
> 
> Does it need my ack anymore?  It doesn't touch anything in arch/arm.
> If you still want it, then... notwithstanding the loss of type checking
> that fncpy() gave and the new sram stuff messes up...
> 
> Acked-by: Russell King <rmk+kernel@armlinux.org.uk>
> 
Thanks Russell !!
