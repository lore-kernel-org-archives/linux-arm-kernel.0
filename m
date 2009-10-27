From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 27 Oct 2009 18:06:33 +0000
Subject: abt kernel 2.6 compressed/head.s
In-Reply-To: <18250270.157661256615664391.JavaMail.coremail@bj126app51.126.com>
References: <18250270.157661256615664391.JavaMail.coremail@bj126app51.126.com>
Message-ID: <20091027180633.GA26281@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 27, 2009 at 11:54:24AM +0800, zyxsjl wrote:
>  
>  hi anyone, 
> I have not understood some code in this file below: 
...
> my question is:what is the different between the both CONFIG_ZBOOT_ROM=y
> or n, and so led to the different tackles from the above code on relocation?

The first thing to note is that there is no initialized data section -
we only have text, constant data, and BSS.


When ZBOOT_ROM=n, we relocate all entries.  This means that the entire
image can be relocated as a whole anywhere in RAM, and the BSS segment
moves with the image.  Such an image can not be programmed into ROM or
flash.


When ZBOOT_ROM=y, we exclude BSS entries from being relocated.  This
means that the image can still be relocated _provided_ it is located
in RAM, but the BSS remains at the compile-time fixed address.

If the image is located in ROM or flash, it can not be relocated and
_must_ be built for the precise address it will be executed from.
This restriction is because the GOT table will be in ROM and therefore
can not be written to (the code explicitly avoids any writes to the GOT
in this case.)
