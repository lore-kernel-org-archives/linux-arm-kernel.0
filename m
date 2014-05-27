From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Tue, 27 May 2014 14:52:33 +0100
Subject: [RESEND PATCH v5 3/5] ARM: Conceal DEBUG_LL_UART_NONE from
 unsupported platforms
In-Reply-To: <8143025.UYbkItXldM@wuerfel>
References: <1398355246-29571-1-git-send-email-daniel.thompson@linaro.org>
 <6624276.NBS809VbNB@wuerfel> <53848F7C.6020508@linaro.org>
 <8143025.UYbkItXldM@wuerfel>
Message-ID: <538498A1.4030006@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/05/14 14:37, Arnd Bergmann wrote:
>> I'm very happy to update my patch to follow this one. However since it
>> will render the corresponding debug-macro.S unreachable by KBuild I like
>> to nuke the file as well. Good idea?
> 
> No. See the description under config DEBUG_LL_UART_NONE:
> 
>                   Say Y here if your platform doesn't provide a UART option
>                   above. This relies on your platform choosing the right UART
>                   definition internally in order for low-level debugging to
>                   work.
> 
> The platforms I listed do have "a UART option above", e.g.
> 
>         config AT91_DEBUG_LL_DBGU0
>                 bool "Kernel low-level debugging on rm9200, 9260/9g20, 9261/9g10 and 9rl"
>                 depends on HAVE_AT91_DBGU0
> 
> Most of the platforms that have an option like this put the file into
> include/debug, as is required for ARCH_MULTIPLATFORM. The ones that are
> not converted to ARCH_MULTIPLATFORM can have it in either place, see
> 
> config DEBUG_LL_INCLUDE
>         string
>         default "debug/8250.S" if DEBUG_LL_UART_8250 || DEBUG_UART_8250
>         default "debug/pl01x.S" if DEBUG_LL_UART_PL01X || DEBUG_UART_PL01X
> 	...
>         default "debug/zynq.S" if DEBUG_ZYNQ_UART0 || DEBUG_ZYNQ_UART1
>         default "mach/debug-macro.S"
> 
> Anything that is not explicitly listed under DEBUG_LL_INCLUDE will default
> to "mach/debug-macro.S", and the list does not (have to) match the choice
> statements in "Kernel low-level debugging port".

Ok. Thanks.

I'll refresh the patch shortly.


Daniel.
