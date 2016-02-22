From: frank.li@nxp.com (Frank Li)
Date: Mon, 22 Feb 2016 20:48:19 +0000
Subject: iMX7d cpu1 issue
In-Reply-To: <CAOMZO5Aa+veHWQCrKGz4rsvmjKWiitd81D8ncGnX8Fdk0aYe7Q@mail.gmail.com>
References: <56C2D63F.1030408@compulab.co.il>	<20160218140913.GY6756@tiger>
 <AMSPR04MB263D00A3F8D9A8D9D3A536D88AF0@AMSPR04MB263.eurprd04.prod.outlook.com>
 <56C5F4D7.1070704@compulab.co.il>
 <AMSPR04MB26334EB884FA8A4B565278188AF0@AMSPR04MB263.eurprd04.prod.outlook.com>
 <56C6CE36.6040503@compulab.co.il>
 <CAOMZO5Aa+veHWQCrKGz4rsvmjKWiitd81D8ncGnX8Fdk0aYe7Q@mail.gmail.com>
Message-ID: <AMSPR04MB2634AA127C6397584AF6BA488A30@AMSPR04MB263.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Fabio Estevam [mailto:festevam at gmail.com]
> Sent: Sunday, February 21, 2016 9:23 AM
> To: Ilya Ledvich <ilya@compulab.co.il>
> Cc: Frank Li <frank.li@nxp.com>; Shawn Guo <shawnguo@kernel.org>;
> Yongcai Huang <anson.huang@nxp.com>; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: iMX7d cpu1 issue
> 
> Hi Ilya/Frank,
> 
> On Fri, Feb 19, 2016 at 6:11 AM, Ilya Ledvich <ilya@compulab.co.il> wrote:
> > Hi Frank,
> > Thank you for so brilliant suggestion!!!
> >
> >> #define CONFIG_MX7_SEC
> >
> >
> > Seems it works!
> > The  CPU1 is brought up, and kernel can successfully boot!
> 
> I changed U-boot as suggested:
> 
> --- a/include/configs/mx7_common.h
> +++ b/include/configs/mx7_common.h
> @@ -94,10 +94,7 @@
>  #define CONFIG_CMD_FUSE
>  #define CONFIG_MXC_OCOTP
> 
> -/*
> - * Default boot linux kernel in no secure mode.
> - * If want to boot kernel in secure mode, please define CONFIG_MX7_SEC
> - */
> +#define CONFIG_MX7_SEC

Upstream kernel use PSCI to enable second core.  You can't define CONFIG_MX7_SEC. 

NXP released kernel use legacy method, which require kernel run in security mode. So you have to define CONFIG_MX7_SEC.

Best regards
Frank Li

>  #ifndef CONFIG_MX7_SEC
>  #define CONFIG_ARMV7_NONSEC
>  #define CONFIG_ARMV7_PSCI
> 
> 
> but still see only one core brought up in the kernel:
> 
> [    0.003051] /cpus/cpu at 0 missing clock-frequency property
> [    0.003076] /cpus/cpu at 1 missing clock-frequency property
> [    0.003092] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
> [    0.003157] Setting up static identity map for 0x80008280 - 0x800082f0
> [    0.005152] Brought up 1 CPUs
> [    0.005169] SMP: Total of 1 processors activated (48.00 BogoMIPS).
> 
> I am booting 4.5-rc5 on a imx7d-sdb board.
> 
> Any ideas on how to bring up the second core?
