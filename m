From: robherring2@gmail.com (Rob Herring)
Date: Tue, 07 Feb 2012 16:52:14 -0600
Subject: [PATCH 2/3] ARM: make disable_fiq macro optional
In-Reply-To: <alpine.LFD.2.02.1202062116210.1656@xanadu.home>
References: <1328562200-8810-1-git-send-email-robherring2@gmail.com>
 <1328562200-8810-3-git-send-email-robherring2@gmail.com>
 <alpine.LFD.2.02.1202061424130.1656@xanadu.home> <4F30B225.60605@gmail.com>
 <alpine.LFD.2.02.1202062116210.1656@xanadu.home>
Message-ID: <4F31AB1E.4010800@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/06/2012 11:24 PM, Nicolas Pitre wrote:
> On Mon, 6 Feb 2012, Rob Herring wrote:
> 
>> Nicolas,
>>
>> On 02/06/2012 04:34 PM, Nicolas Pitre wrote:
>>> On Mon, 6 Feb 2012, Rob Herring wrote:
>>>
>>>> From: Rob Herring <rob.herring@calxeda.com>
>>>>
>>>> Only rpc uses disable_fiq, so make its use conditional on ARCH_RPC.
>>>>
>>>> With this, entry-macro.S is no longer needed for platforms that
>>>> select MULTI_IRQ_HANDLER and the include of it can be conditional.
>>>
>>> Using set_fiq_handler() in the rpc boot code we could get rid of 
>>> disable_fiq entirely.
>>>
>>
>> That's already being done here:
>> arch/arm/mach-rpc/dma.c:290:    set_fiq_handler(fiqhandler_start,
>> fiqhandler_length);
>>
>> Can the macro just be deleted? Or a default handler needs to be setup
>> earlier?
> 
> That's the handler installed by the RPC DMA code.  Another one is needed 
> by default for when that code is not active.

Wouldn't the fiq be masked then? rpc_init_irq masks out the interrupts
in the same register as disable_fiq macro:

iomd_writeb(0, IOMD_FIQMASK);

Rob
