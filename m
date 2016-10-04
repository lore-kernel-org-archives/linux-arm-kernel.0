From: john.garry@huawei.com (John Garry)
Date: Tue, 4 Oct 2016 13:02:25 +0100
Subject: [PATCH V3 2/4] ARM64 LPC: LPC driver implementation on Hip06
In-Reply-To: <2af4f2d8-e3a4-fa00-e700-60af70bf4560@jonmasters.org>
References: <1473855354-150093-1-git-send-email-yuanzhichang@hisilicon.com>
 <5140357.dcW9ibtZJ6@wuerfel> <57D963C4.4010406@hisilicon.com>
 <5869118.UilSPY9Sai@wuerfel>
 <2af4f2d8-e3a4-fa00-e700-60af70bf4560@jonmasters.org>
Message-ID: <6bbfeb57-7a55-6a3e-60b2-3f44525e5882@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/10/2016 23:03, Jon Masters wrote:
> On 09/14/2016 02:32 PM, Arnd Bergmann wrote:
>> On Wednesday, September 14, 2016 10:50:44 PM CEST zhichang.yuan wrote:
>
>>> And there are probably multiple child devices under LPC, the global arm64_extio_ops only can cover one PIO range. It is fortunate only ipmi driver can not support I/O
>>> operation registering, serial driver has serial_in/serial_out to
>>> be registered. So, only the PIO range for ipmi device is stored
>>> in arm64_extio_ops and the indirect-IO
>>> works well for ipmi device.
>>
>> You should not do that in the serial driver, please just use the
>> normal 8250 driver that works fine once you handle the entire
>> port range.
>
> Just for the record, Arnd has the right idea. There is only one type of
> UART permitted by SBSA (PL011). We carved out an exception for a design
> that was already in flight and allowed it to be 16550. That other design
> was then corrected in future generations to be PL011 as we required it
> to be. Then there's the Hip06. I've given feedback elsewhere about the
> need for there to be (at most) two types of UART in the wild. This "LPC"
> stuff needs cleaning up (feedback given elsewhere already on that), but
> we won't be adding a third serial driver into the mix in order to make
> it work. There will be standard ARM servers. There will not be the
> kinda-sorta-standard. Thanks.
>

Right, so I think Zhichang can make the necessary generic changes to 
8250 OF driver to support IO port as well as MMIO-based.

However an LPC-based earlycon driver is still required.

A note on hip07-based D05 (for those unaware): this does not use 
LPC-based uart. It uses PL011. The hardware guys have managed some 
trickery where they loopback the serial line around the BMC/CPLD. But we 
still need it for hip06 D03 and any other boards which want to use LPC 
bus for uart.

A question on SBSA: does it propose how to provide serial via BMC for SOL?


> Jon.
>
>
> .
>
