From: mike.looijmans@topic.nl (Mike Looijmans)
Date: Fri, 13 Nov 2015 15:06:55 +0100
Subject: [PATCH v3 1/5] spi: introduce mmap read support for spi flash
 devices
In-Reply-To: <5642E546.3040806@ti.com>
References: <1447133399-25658-1-git-send-email-vigneshr@ti.com>
 <1447133399-25658-2-git-send-email-vigneshr@ti.com>
 <20151110232341.GU12143@google.com> <5642E546.3040806@ti.com>
Message-ID: <5645EE7F.5040101@topic.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

?On 11-11-15 07:50, R, Vignesh wrote:
> Hi Brain,
>
> On 11/11/2015 4:53 AM, Brian Norris wrote:
>> Hi Vignesh,
...

>> Also, this API doesn't actually have anything to do with memory mapping.
>> It has to do with the de facto standard flash protocol. So I don't think
>> mmap belongs in the name; it should be something about flash. (I know of
>> at least one other controller that could probably use this API, excpet
>> it doesn't use memory mapping to accomplish the accelerated flash read.)

The Zynq has a similar way of accessing QSPI flash through a memory map. The 
memory window is only 16MB, so some form of paging would be needed.

It's why I have been following this thread with great interest, since the QSPI 
performance on the Zynq is way below what it could potentially be.

> As far as TI QSPI controller is concerned, the accelerated read happens
> via mmap port whereby a predefined memory address space of SoC is
> exposed as QSPI mmap region. This region can be accessed like normal
> RAM(via memcpy()) and the QSPI controller interface takes care of
> fetching data from flash on SPI bus automatically hence, I named it as
> above. But, I have no hard feelings if it needs to be generalized to
> spi_mtd_read() or something else.

I know that on the Zynq, you can even let the DMA controller access the QSPI 
flash via this memory mapping. The QSPI controller itself doesn't support any 
DMA at all.

If something similar applies to the TI platform (most of the TI procs have 
nice DMA controllers) one could go one step further and implement a generic 
DMA-through-mmap access to QSPI flash.

Mike.


Kind regards,

Mike Looijmans
System Expert

TOPIC Embedded Products
Eindhovenseweg 32-C, NL-5683 KH Best
Postbus 440, NL-5680 AK Best
Telefoon: +31 (0) 499 33 69 79
Telefax: +31 (0) 499 33 69 70
E-mail: mike.looijmans at topicproducts.com
Website: www.topicproducts.com

Please consider the environment before printing this e-mail

Visit us at : Aerospace Electrical Systems Expo Europe which will be held from 17.11.2015 till 19.11.2015, Findorffstrasse 101 Bremen, Germany, Hall 5, stand number C65
http://www.aesexpo.eu
