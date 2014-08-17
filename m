From: holler@ahsoftware.de (Alexander Holler)
Date: Sun, 17 Aug 2014 19:14:51 +0200
Subject: [BUG]: imx6q (wandboard): Very unstable ethernet since kernel 3.16
In-Reply-To: <e5e80736-6acc-4106-acfd-a14cbd0fd751@email.android.com>
References: <1407503758.19455.1.camel@sharkbay.at>
 <20140808132754.GC30282@n2100.arm.linux.org.uk>
 <1407507023.19455.3.camel@sharkbay.at>
 <20140808143008.GD30282@n2100.arm.linux.org.uk>
 <1407509932.19455.7.camel@sharkbay.at> <53E548DB.90905@boundarydevices.com>
 <CAHKv19Cky2+vEOirwwd8xhix_V0Vivn_6BbuYq+D_k0o8o4Gsg@mail.gmail.com>
 <53E56C4E.9090708@boundarydevices.com> <53E7F3FD.9030009@gmail.com>
 <e5e80736-6acc-4106-acfd-a14cbd0fd751@email.android.com>
Message-ID: <53F0E30B.7090308@ahsoftware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 11.08.2014 07:24, schrieb Thomas Scheiblauer:
> On 11. August 2014 00:36:45 MESZ, Iain Paton <ipaton0@gmail.com> wrote:
>> On 09/08/14 01:33, Troy Kisky wrote:
>>> On 8/8/2014 3:51 PM, George Joseph wrote:
>>>> On Fri, Aug 8, 2014 at 4:02 PM, Troy Kisky

>>>> I'm confused by the references to GPIO_6 and GPIO1_IO06 as it
>> relates to the wandboard.   According
>>>> to the schematic for both the rev B1 and C1, the GPIO_6 PAD is
>> physically connected to pin 30 on the
>>>> camera interface and according to the dtb tree, GPIO1_IO06 isn't
>> mapped to any PAD.

I was confused by that too. Unfortunately the patch didn't include some 
comment in the .dts itself, just the commit message. Something I see 
very often. Maybe it helps to tell people that a commit message is no 
replacement for usefull comments in the source. Escpecially for things 
like this one very it isn't obvious why a not connect (and unrelated) 
pin does get some pinmux-settings.

>>>> This kinda fits with my own observation which is that Ethernet is
>> working fine (40MB/s sustained)
>>>> regardless of whether fec is using "gpio1 6" and "intc 0 119" for
>> extended interrupts or the default
>>>> "intc 0 118" and "intc 0 119".   Otherwise stock 3.16.0 on WB Quad
>> C1.
>>>>
>>> Are you using a wandboard also?   With or without camera plugged in?
>>
>> I have:
>>
>> 2x WBQUAD (B1)  i.MX6Q, silicon rev 1.2
>> 1x Sabre-Lite   i.MX6Q, silicon rev 1.0
>> 2x Sabre-Lite   i.MX6Q, silicon rev 1.2
>> 2x RIoTboard i.MX6Solo, silicon rev 1.1
>> 1x MarSBoard i.MX6Dual, silicon rev 1.2 (I haven't posted the dts for
>> this yet)
>>
>> all with the GPIO_6 interrupt patch in place, no cameras or anything
>> else
>> connected to that pad, no issues seen on 3.15 or 3.16
>>
>> I had seen problems on earlier kernels, before the GPIO_6 workaround
>> was
>> implemented, where one of my Sabre-Lite boards (only one, and always
>> the
>> same one) would vanish off the network for a few minutes. I'd even had
>> it
>> happen while in the middle of typing something over an ssh connection.
>> Connectivity usually seemed to recover on it's own eventually, or I
>> could log in over a serial connection and ping something else on the
>> network which would restore the connection immediately.
>> After the GPIO_6 workaround was implemented I've never had the problem
>> re-occur.
>>
>> I use the two wandboards and the three sabre-lites as builders with
>> distcc and nfs in the mix, so network issues usually show up fairly
>> quickly.
>>
>> Iain
>
> I've always had ethernet problems with my Wandboards. Especially when I hadn't increased the TX_RING_SIZE in the fec driver. I'm pretty sure I've been using the GPIO_6 patch for a long time since I always patch my kernels with Robert C. Nelson's ARM patch collection. Now that I've removed the patch (on Kernel 3.16.0) the problems seem to have an end.
>
> I've also experienced your special case with one of my Wandboard quads where it would loose the connection every minute or so but would restore it when sending some data by itself, e.g. a ping. I worked around this by installing a systemd timer which did exactly that.

I've just reverted commit 9fc77821b17155c6e0ab50b1e1dd80c2b0e63e98 in 
3.16.1 and experienced the mentioned stability problem with a Wandboard 
Quad C1.

But I don't know if it's related to that commit at all. I just own this 
board since a few weeks and I'm still just playing with it, trying to 
get all bits together to use it 24/7. That means I'm unsure if it was 
stable without reverting that commit.

Regards,

Alexander Holler
