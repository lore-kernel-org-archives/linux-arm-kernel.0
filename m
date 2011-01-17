From: ryan@bluewatersys.com (Ryan Mallon)
Date: Tue, 18 Jan 2011 11:42:07 +1300
Subject: [PATCH] MTD: atmel_nand: Add DMA support to access Nandflash
In-Reply-To: <4D34A37E.1060300@bluewatersys.com>
References: <hong.xu@atmel.com>
	<1295248809-30334-2-git-send-email-hong.xu@atmel.com>
	<4D34A37E.1060300@bluewatersys.com>
Message-ID: <4D34C5BF.2070107@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/18/2011 09:15 AM, Ryan Mallon wrote:
> On 01/17/2011 08:20 PM, Hong Xu wrote:
>> Some SAM9 chips have the ability to perform DMA between CPU and SMC controller.
>> This patch adds DMA support for SAM9RL, SAM9G45, SSAM9G46,AM9M10, SAM9M11.

I'm trying to patch this into a 2.6.33 kernel running on a custom
SAM9G45 based board, but I get a failure requesting the DMA channel:

root at snapper:~$ dmesg | grep -i dma
[    0.850000] atmel_nand atmel_nand: Failed to request DMA channel
[    0.860000] atmel_nand atmel_nand: No DMA support for NAND access.
[    1.530000] at_hdmac at_hdmac: Atmel AHB DMA Controller ( cpy slave ), 8 channels


It looks like the registration for the DMA controller happens after the
NAND driver probe and so the request is failing. I had a quick look, but
I can't see anything that would change this in more recent kernels. Any
ideas?

Also, I think you want to add the following for the atmel_nand Kconfig:
  select AT_HDMAC

or make the DMA parts of the driver ifdef CONFIG_AT_HDMAC (if the above
won't work for some reason) since you will get build errors on the
dmaengine functions otherwise.

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751 
Fax:   +64 3 3779135			  USA 1800 261 2934
