From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 8 May 2013 16:38:22 +0200
Subject: [RFC 2/8] ARM:global_timer: Add ARM global timer support.
In-Reply-To: <1368022260-2197-1-git-send-email-srinivas.kandagatla@st.com>
References: <1368022187-1633-1-git-send-email-srinivas.kandagatla@st.com>
 <1368022260-2197-1-git-send-email-srinivas.kandagatla@st.com>
Message-ID: <201305081638.23100.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 08 May 2013, Srinivas KANDAGATLA wrote:
> From: Stuart Menefy <stuart.menefy@st.com>
> 
> This is a simple driver for the global timer module found in the Cortex
> A9-MP cores from revision r1p0 onwards. This should be able to perform
> the functions of the system timer and the local timer in an SMP system.
> 
> The global timer has the following features:
>     The global timer is a 64-bit incrementing counter with an
> auto-incrementing feature. It continues incrementing after sending
> interrupts. The global timer is memory mapped in the private memory
> region.
>     The global timer is accessible to all Cortex-A9 processors in the
> cluster. Each Cortex-A9 processor has a private 64-bit comparator that
> is used to assert a private interrupt when the global timer has reached
> the comparator value. All the Cortex-A9 processors in a design use the
> banked ID, ID27, for this interrupt. ID27 is sent to the Interrupt
> Controller as a Private Peripheral Interrupt. The global timer is
> clocked by PERIPHCLK.
> 
> Signed-off-by: Stuart Menefy <stuart.menefy@st.com>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
>

Are you sure we don't already have a driver for this? It sounds unlikely
that you are the first one to do this when the hardware is so common.

>  Documentation/devicetree/bindings/arm/gt.txt |   21 ++
>  arch/arm/Kconfig                             |    6 +
>  arch/arm/include/asm/global_timer.h          |   12 +
>  arch/arm/kernel/Makefile                     |    1 +
>  arch/arm/kernel/global_timer.c               |  325 ++++++++++++++++++++++++++
>  5 files changed, 365 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/gt.txt
>  create mode 100644 arch/arm/include/asm/global_timer.h
>  create mode 100644 arch/arm/kernel/global_timer.c

Move it into drivers/clocksource?
 
> diff --git a/arch/arm/include/asm/global_timer.h b/arch/arm/include/asm/global_timer.h
> new file mode 100644
> index 0000000..46f9188
> --- /dev/null
> +++ b/arch/arm/include/asm/global_timer.h
> @@ -0,0 +1,12 @@
> +int __init global_timer_init(void __iomem *base, unsigned int timer_irq);

I don't see a need to call this from platform code for non-DT platforms, it
can easily be used with CLOCKSOURCE_OF_DECLARE() all the time I think.

	Arnd
