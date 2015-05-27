From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 27 May 2015 08:15:00 +0200
Subject: [PATCH v4 3/5] dmaengine: pxa: add pxa dmaengine driver
In-Reply-To: <1432625314.27695.200.camel@x220> (Paul Bolle's message of "Tue,
 26 May 2015 09:28:34 +0200")
References: <1432589362-23241-1-git-send-email-robert.jarzmik@free.fr>
 <1432589362-23241-3-git-send-email-robert.jarzmik@free.fr>
 <1432625314.27695.200.camel@x220>
Message-ID: <87siaizguz.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paul Bolle <pebolle@tiscali.nl> writes:

> Vinod already applied this, so my remarks, if valid, should probably be
> handled in a follow up patch.
>
>> +module_platform_driver(pxad_driver);
>
> (The series starting at https://lkml.org/lkml/2015/5/10/131 would allow
> to use builtin_platform_driver() for built-in only code.)
I won't be that way for forever, see next comment.

>> +MODULE_DESCRIPTION("Marvell PXA Peripheral DMA Driver");
>> +MODULE_AUTHOR("Robert Jarzmik <robert.jarzmik@free.fr>");
>> +MODULE_LICENSE("GPL v2");
>
> This patch added a bool Kconfig symbol. So pxa_dma.c will never be part
> of a module.
> Its code contains a few module specific macros. Was it actually intended for
> PXA_DMA to be tristate?
It is designed to be a module, and in the "end" it will be a module.

What is important to understand is the 3 phases which are going to happen :
 - phase 1 : state after this is merged
             pxa_dma must be builtin, for legacy support (see
             pxad_toggle_reserved_channel()).
 - phase 2 : slowly, all the pxa drivers are converted to dmaengine
 - phase 3 : after full conversion, the patch "add support for legacy
             transition" is reverted.
             There pxa_dma will become modular, and the tristate will appear.

In conclusion, it cannot be a module yet, but it will in the future.

Cheers.

-- 
Robert
