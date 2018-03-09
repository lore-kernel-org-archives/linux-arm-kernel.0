From: ping.bai@nxp.com (Jacky Bai)
Date: Fri, 9 Mar 2018 05:12:33 +0000
Subject: [PATCH v4 2/3] ARM: debug: Add low level debug support for imx6sll
In-Reply-To: <20180309011908.GA3217@dragon>
References: <1520501697-22202-1-git-send-email-ping.bai@nxp.com>
 <1520501697-22202-2-git-send-email-ping.bai@nxp.com>
 <20180309011908.GA3217@dragon>
Message-ID: <HE1PR04MB3113C1EEE6DC6C27D5FDD5EF87DE0@HE1PR04MB3113.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Subject: Re: [PATCH v4 2/3] ARM: debug: Add low level debug support for imx6sll
> 
> On Thu, Mar 08, 2018 at 05:34:56PM +0800, Bai Ping wrote:
> > Add low level debug support for i.MX6SLL.
> >
> > Signed-off-by: Bai Ping <ping.bai@nxp.com>
> 
> With earlycon support in place, I'm not sure we want to add more SoC low-level
> debug port.
> 
OK, maybe we can drop this patch.
Jacky

> Shawn
> 
> > ---
> > change v1->v2:
> >  - no
> > change v2->v3:
> >  - no
> > change v3->v4:
> >  - no
> > ---
> >  arch/arm/Kconfig.debug            |  9 +++++++++
> >  arch/arm/include/debug/imx-uart.h | 10 ++++++++++
> >  2 files changed, 19 insertions(+)
> >
> > diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug index
> > 78a6470..2197239 100644
> > --- a/arch/arm/Kconfig.debug
> > +++ b/arch/arm/Kconfig.debug
> > @@ -451,6 +451,13 @@ choice
> >  		  Say Y here if you want kernel low-level debugging support
> >  		  on i.MX6SL.
> >
> > +	config DEBUG_IMX6SLL_UART
> > +		bool "i.MX6SLL Debug UART"
> > +		depends on SOC_IMX6SLL
> > +		help
> > +		  Say Y here if you want kernel low-level debugging support
> > +		  on i.MX6SLL.
> > +
> >  	config DEBUG_IMX6SX_UART
> >  		bool "i.MX6SX Debug UART"
> >  		depends on SOC_IMX6SX
> > @@ -1429,6 +1436,7 @@ config DEBUG_IMX_UART_PORT
> >  						DEBUG_IMX53_UART || \
> >  						DEBUG_IMX6Q_UART || \
> >  						DEBUG_IMX6SL_UART || \
> > +						DEBUG_IMX6SLL_UART || \
> >  						DEBUG_IMX6SX_UART || \
> >  						DEBUG_IMX6UL_UART || \
> >  						DEBUG_IMX7D_UART
> > @@ -1483,6 +1491,7 @@ config DEBUG_LL_INCLUDE
> >  				 DEBUG_IMX53_UART ||\
> >  				 DEBUG_IMX6Q_UART || \
> >  				 DEBUG_IMX6SL_UART || \
> > +				 DEBUG_IMX6SLL_UART || \
> >  				 DEBUG_IMX6SX_UART || \
> >  				 DEBUG_IMX6UL_UART || \
> >  				 DEBUG_IMX7D_UART
> > diff --git a/arch/arm/include/debug/imx-uart.h
> > b/arch/arm/include/debug/imx-uart.h
> > index bce58e9..24e60ce 100644
> > --- a/arch/arm/include/debug/imx-uart.h
> > +++ b/arch/arm/include/debug/imx-uart.h
> > @@ -81,6 +81,14 @@
> >  #define IMX6SL_UART_BASE_ADDR(n) IMX6SL_UART##n##_BASE_ADDR
> >  #define IMX6SL_UART_BASE(n)	IMX6SL_UART_BASE_ADDR(n)
> >
> > +#define IMX6SLL_UART1_BASE_ADDR 0x02020000 #define
> > +IMX6SLL_UART2_BASE_ADDR 0x02024000 #define
> IMX6SLL_UART3_BASE_ADDR
> > +0x02034000 #define IMX6SLL_UART4_BASE_ADDR 0x02018000 #define
> > +IMX6SLL_UART5_BASE_ADDR 0x021f4000 #define
> IMX6SLL_UART_BASE_ADDR(n)
> > +IMX6SLL_UART##n##_BASE_ADDR
> > +#define IMX6SLL_UART_BASE(n)	IMX6SLL_UART_BASE_ADDR(n)
> > +
> >  #define IMX6SX_UART1_BASE_ADDR	0x02020000
> >  #define IMX6SX_UART2_BASE_ADDR	0x021e8000
> >  #define IMX6SX_UART3_BASE_ADDR	0x021ec000
> > @@ -133,6 +141,8 @@
> >  #define UART_PADDR	IMX_DEBUG_UART_BASE(IMX6Q)
> >  #elif defined(CONFIG_DEBUG_IMX6SL_UART)
> >  #define UART_PADDR	IMX_DEBUG_UART_BASE(IMX6SL)
> > +#elif defined(CONFIG_DEBUG_IMX6SLL_UART)
> > +#define UART_PADDR	IMX_DEBUG_UART_BASE(IMX6SLL)
> >  #elif defined(CONFIG_DEBUG_IMX6SX_UART)
> >  #define UART_PADDR	IMX_DEBUG_UART_BASE(IMX6SX)
> >  #elif defined(CONFIG_DEBUG_IMX6UL_UART)
> > --
> > 1.9.1
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Flist
> >
> s.infradead.org%2Fmailman%2Flistinfo%2Flinux-arm-kernel&data=02%7C01%7
> >
> Cping.bai%40nxp.com%7Cff87034a5489455501c308d5855bdd78%7C686ea1d3
> bc2b4
> >
> c6fa92cd99c5c301635%7C0%7C0%7C636561551970392594&sdata=zDX%2Bgt
> WfguB5B
> > d7wNjd0rl5coxrVR1eLekMBc%2BIdnEg%3D&reserved=0
