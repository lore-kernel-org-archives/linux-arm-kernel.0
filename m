From: ipaton0@gmail.com (Iain Paton)
Date: Sun, 10 Aug 2014 23:36:45 +0100
Subject: [BUG]: imx6q (wandboard): Very unstable ethernet since kernel 3.16
In-Reply-To: <53E56C4E.9090708@boundarydevices.com>
References: <1407503758.19455.1.camel@sharkbay.at>	<20140808132754.GC30282@n2100.arm.linux.org.uk>	<1407507023.19455.3.camel@sharkbay.at>	<20140808143008.GD30282@n2100.arm.linux.org.uk>	<1407509932.19455.7.camel@sharkbay.at>	<53E548DB.90905@boundarydevices.com>
 <CAHKv19Cky2+vEOirwwd8xhix_V0Vivn_6BbuYq+D_k0o8o4Gsg@mail.gmail.com>
 <53E56C4E.9090708@boundarydevices.com>
Message-ID: <53E7F3FD.9030009@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/08/14 01:33, Troy Kisky wrote:
> On 8/8/2014 3:51 PM, George Joseph wrote:
>> On Fri, Aug 8, 2014 at 4:02 PM, Troy Kisky <troy.kisky@boundarydevices.com
>> <mailto:troy.kisky@boundarydevices.com>> wrote:
>>
>>     On 8/8/2014 7:58 AM, Thomas Scheiblauer wrote:
>>     >
>>     >
>>     > Indeed, commenting out these 2 lines in
>>     > arch/arm/boot/dts/imx6qdl-wandboard.dtsi fixes my problem without having
>>     > to increase TX_RING_SIZE.
>>     > Thank you very much!
>>     >
>>     Could you also please checkout commit
>>
>>     commit 9fc77821b17155c6e0ab50b1e1dd80c2b0e63e98
>>     Author: Sascha Silbe <x-linux at infra-silbe.de <mailto:x-linux@infra-silbe.de>>
>>     Date:   Thu Feb 6 23:24:13 2014 +0100
>>
>>         ARM: dts: imx6qdl-wandboard: use GPIO_6 for FEC interrupt
>>
>>
>>     and see if it also shows ethernet instabilities?
>>
>>
>> I'm confused by the references to GPIO_6 and GPIO1_IO06 as it relates to the wandboard.   According
>> to the schematic for both the rev B1 and C1, the GPIO_6 PAD is physically connected to pin 30 on the
>> camera interface and according to the dtb tree, GPIO1_IO06 isn't mapped to any PAD.
>>
>> This kinda fits with my own observation which is that Ethernet is working fine (40MB/s sustained)
>> regardless of whether fec is using "gpio1 6" and "intc 0 119" for extended interrupts or the default
>> "intc 0 118" and "intc 0 119".   Otherwise stock 3.16.0 on WB Quad C1.
>>
> Are you using a wandboard also?   With or without camera plugged in?

I have:

2x WBQUAD (B1)  i.MX6Q, silicon rev 1.2
1x Sabre-Lite   i.MX6Q, silicon rev 1.0
2x Sabre-Lite   i.MX6Q, silicon rev 1.2
2x RIoTboard i.MX6Solo, silicon rev 1.1
1x MarSBoard i.MX6Dual, silicon rev 1.2 (I haven't posted the dts for this yet)

all with the GPIO_6 interrupt patch in place, no cameras or anything else 
connected to that pad, no issues seen on 3.15 or 3.16 

I had seen problems on earlier kernels, before the GPIO_6 workaround was 
implemented, where one of my Sabre-Lite boards (only one, and always the 
same one) would vanish off the network for a few minutes. I'd even had it 
happen while in the middle of typing something over an ssh connection.
Connectivity usually seemed to recover on it's own eventually, or I 
could log in over a serial connection and ping something else on the 
network which would restore the connection immediately.
After the GPIO_6 workaround was implemented I've never had the problem 
re-occur.

I use the two wandboards and the three sabre-lites as builders with 
distcc and nfs in the mix, so network issues usually show up fairly 
quickly.

Iain
