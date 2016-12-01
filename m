From: slash.tmp@free.fr (Mason)
Date: Thu, 1 Dec 2016 13:29:26 +0100
Subject: arasan,sdhci.txt "compatibility" DT binding
In-Reply-To: <f64ea0f8-31be-c5b5-3a43-a30abd8aec30@rock-chips.com>
References: <56B07BA5.4060407@free.fr> <56B166F1.5080605@rock-chips.com>
 <56B1AA44.1010108@xilinx.com> <56B1BAF8.2050907@free.fr>
 <56B1CF40.1030203@xilinx.com> <20160203152104.GP4215@xsjsorenbubuntu>
 <56B21DDB.6050708@free.fr> <582ED9E0.5090506@free.fr>
 <CAFd313x6MJeO90_+rxditdPn762g7TqZc0_D6ojGTKmtGJKjPA@mail.gmail.com>
 <582EF744.8090307@free.fr> <a20b2b4f-15d4-3c29-324c-1ced5dbcc67f@xilinx.com>
 <583C50E7.6030400@free.fr>
 <f64ea0f8-31be-c5b5-3a43-a30abd8aec30@rock-chips.com>
Message-ID: <584017A6.3000301@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/12/2016 05:09, Shawn Lin wrote:

> On 2016/11/28 23:44, Mason wrote:
>
>> Shawn Lin, could you take a look below and tell me exactly
>> which IP core(s) Rockchip is using in its SoCs?
> 
> From the Host Controller version register (0xfe)
> bit[7:0]: 0x2 : specification version number is 3.00
> bit[15:8]: 0x10: Vendor version number is 1.0
> 
> Command Queueing version register (0x200)
> bit[11:8]: 0x5  eMMC Major version number
> bit[7:4]: 0x1 eMMC manor version number
> bit[3:0]: 0x0 eMMC version suffix
> 
> User guide "eMMC 5.1/SD3.0/SDIO3.0 Host Controller"
> Revision number: 1.14
> Released on Dec. 2014

Wow! Yet another HW revision I wasn't aware of :-)

For the record, I think the 0x200 register was introduced fairly
recently, as it's not documented in any of the user guides I have
access to.


To summarize the situation, Arasan has made (at least) the
following versions of the HW block:

  SD_2.0_SDIO_2.0__MMC_3.31_Host_Controller
  SD_3.0_SDIO_3.0_eMMC_4.4__Host_Controller
  SD_3.0_SDIO_3.0_eMMC_4.41_Host_Controller
  SD_3.0_SDIO_3.0_eMMC_4.5__Host_Controller
  SD_3.0_SDIO_3.0_eMMC_4.51_Host_Controller
  SD_3.0_SDIO_3.0_eMMC_5.1__Host Controller
  SD_4.1_SDIO_4.1_eMMC_4.51_Host_Controller
  SD_4.1_SDIO_4.1_eMMC_5.1__Host_Controller


Xilinx = "arasan,sdhci-8.9a" compat string
SD2.0 / SDIO2.0 /  MMC3.31 (in Zynq)
SD3.0 / SDIO3.0 / eMMC4.51 (in ZynqMP)
Vendor version 0x89 (Zynq, from 8.9a) and 0x10 (ZynqMP)

Sigma = no compat string yet
SD3.0 / SDIO3.0 / eMMC4.4  (in SMP87xx)
Vendor version 0x99 (not related to document revision)

APM = "arasan,sdhci-4.9a"
SD3.0 / SDIO3.0 / eMMC4.41
Vendor version unknown

Rockchip = "arasan,sdhci-5.1"
SD3.0 / SDIO3.0 / eMMC 5.1
Vendor version 0x10

Conclusion, it doesn't look like the "Vendor version" field
contains dependable information, considering the duplicate
0x10 in different HW revisions.

Regards.
