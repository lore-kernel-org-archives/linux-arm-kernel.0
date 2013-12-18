From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 19 Dec 2013 00:23:43 +0300
Subject: [PATCH 2/2] ARM: shmobile: Koelsch: add Ether support
In-Reply-To: <52A620C5.9030600@cogentembedded.com>
References: <201310310216.28673.sergei.shtylyov@cogentembedded.com>	<201310310219.58963.sergei.shtylyov@cogentembedded.com>
 <CANqRtoTa6-UP88146KPy9zNXNTRynBVqWZYb1k=0MK03NMJqhw@mail.gmail.com>
 <5272A98B.3030705@cogentembedded.com> <52A620C5.9030600@cogentembedded.com>
Message-ID: <52B2125F.2010404@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 12/09/2013 10:57 PM, Sergei Shtylyov wrote:

>>>> Register Ether platform device and pin data on  the  Koelsch board.
>>>> Register platform fixup for Micrel KSZ8041 PHY, just like on the Lager board.

>>>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

>>> Thanks for your patch. Just like on the Lager board we also need to
>>> tie in the PHY IRQ pin.

>>     Not only on the Lager board, BOCK-W also I think.

>>> Polling is not good enough when the hardware
>>> can do better. Can you please share your PHY IRQ plans with us?

>>     It's on my agenda now -- will start after I do away with the CAN driver
>> and the current Koelsch Ether support.

>     I have now implemented PHY IRQ support for BOCK-W, Lager, and Koelsch
> boards (had to extend the Micrel PHY driver to recognize undocumented
> KSZ8041RNLI PHY ID for that) but I must say that the PHY interrupt doesn't get
> generated on either of the board and I don't know why yet (I can't rule out
> the INTC driver issue); that's bad news. Good news is that even this doesn't
> prevent phylib from working properly as it still polls the PHY once a second.

    Oh yes, it does: phylib fails to recognize link down/up after you 
disconnect/reconnect the cable since it relies solely on IRQ for the link 
changes if it's specified.
    Now for the really good news: I was able to get the PHY IRQs on Koelsch 
board when I set the trigger mode to falling-edge; that seemed strange as the 
PHY interrupts are level-sensitive, according to the documentation. And only 
after we commented out the wild PHY reset done by the 'sh_eth' driver on each 
open, I was able to get the IRQs in the low-level trigger mode.
    So, I'm expecting to be able to finally resolve this issue on top of the 
net-next tree which now contains 2 patchsets that should enable me to finally 
remove that wild PHY reset for good:

http://marc.info/?l=linux-netdev&m=138636384109141
http://marc.info/?l=linux-netdev&m=138692649110301

>>> Best,

>>> / magnus

WBR, Sergei
