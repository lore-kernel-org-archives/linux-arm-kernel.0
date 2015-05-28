From: juhl@gai-tronics.com (Uhl, Joe)
Date: Thu, 28 May 2015 17:04:57 +0000
Subject: imx6 fsl,fiq-stream-filter
Message-ID: <A34315704930CF44BA74E64F19E02E917DEEE3FC@S1P5DAG1A.EXCHPROD.USA.NET>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,
Is it possible to disable dma transfers on ssi1 using FIQ instead?  I am able to 
transfer data out successfully to an SGTL5000 codec (using imx-sgtl5000.c as 
machine driver) with dma enabled.  In the devicetree I added "fsl,fiq-stream-filter" 
which I see in fsl_ssi.c is checked for and set's  the variable use_dma to false.  
Are there any additional things to do besides changing the devicetree to get this 
to work?  Doing this produces alsa underruns and no sound.  Thank you for any advice.
I'm using freescale linux version 3.14.28 although I updated all the way to mainline 
4.0 with the same results.

imx6qdl.dtsi =
ssi1: ssi at 02028000 {
  compatible = "fsl,imx6q-ssi","fsl,imx21-ssi";
  reg = <0x02028000 0x4000>;
  interrupts = <0 46 IRQ_TYPE_LEVEL_HIGH>;
  clocks = <&clks IMX6QDL_CLK_SSI1_IPG>,
  <&clks IMX6QDL_CLK_SSI1>;	
  clock-names = "ipg", "baud";	
  fsl,fiq-stream-filter;					
  dmas = <&sdma 37 1 0>,					
  <&sdma 38 1 0>;					
  dma-names = "rx", "tx";					
  fsl,fifo-depth = <15>;					
  fsl,ssi-dma-events = <38 37>;					
  status = "okay";					
};
						
Here is my /proc/interrupts output:
Interrupt 78 is blank and increments by 11 during each attempt at running aplay so I 
assume this is somehow related to ssi.
root at cgtqmx6:/proc# cat interrupts
           CPU0
34:          0       GIC  34  sdma
37:          0       GIC  37  2400000.ipu
38:          4       GIC  38  2400000.ipu
50:          0       GIC  50  vdoa
51:          0       GIC  51  rtc alarm
55:          0       GIC  55  mmc1
56:        528       GIC  56  mmc2
57:          0       GIC  57  mmc3
59:       2300       GIC  59  21e8000.serial
63:          4       GIC  63  2008000.ecspi
65:          0       GIC  65  2010000.ecspi
68:        545       GIC  68  21a0000.i2c
69:        284       GIC  69  21a4000.i2c
70:         78       GIC  70  21a8000.i2c
72:         30       GIC  72  2184200.usb
**78:         22       GIC  78
81:          0       GIC  81  imx_thermal
82:          0       GIC  82  asrc
87:      13566       GIC  87  i.MX Timer Tick
112:          0       GIC 112  20bc000.wdog
139:          0       GIC 139  mmdc_1
150:      49111       GIC 150  2188000.ethernet
151:          0       GIC 151  2188000.ethernet
156:          0       GIC 156  20e4000.dcic
157:          0       GIC 157  20e8000.dcic
164:          0  gpio-mxc   4  2194000.usdhc cd
193:          0  gpio-mxc   1  key-menu
194:          0  gpio-mxc   2  key-back
195:          0  gpio-mxc   3  key-search
196:          0  gpio-mxc   4  key-home
198:          0  gpio-mxc   6  219c000.usdhc cd
253:          0  gpio-mxc  29  Power Button
261:          0  gpio-mxc   5  Volume Down
263:          0  gpio-mxc   7  Sleep Button
365:          0  gpio-mxc  13  Volume Up
**FIQ:              imx-ssi
IPI0:          0  CPU wakeup interrupts
IPI1:          0  Timer broadcast interrupts
IPI2:          0  Rescheduling interrupts
IPI3:          0  Function call interrupts
IPI4:          0  Single function call interrupts
IPI5:          0  CPU stop interrupts
IPI6:          0  IRQ work interrupts
IPI7:          0  completion interrupts
Err:          0

---------------------------------------------------------------------------------------------------------------------------- 
Confidentiality Requirement: This communication, including any attachment(s), may contain confidential information and is for the sole use of the intended recipient(s). If you are not the intended recipient, you are hereby notified that you have received this communication in error and any unauthorized review, use, disclosure, dissemination, distribution or copying of it or its contents is strictly prohibited.  If you have received this communication in error, please notify the sender immediately by telephone or e-mail and destroy all copies of this communication and any attachments.
