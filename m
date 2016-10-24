From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 24 Oct 2016 11:17:36 +0100
Subject: Question about arm64 earlycon
In-Reply-To: <4966376.bRx4fgSjbT@wuerfel>
References: <CADaLNDnB3QBjODYNTndBsexGQfnL1rj6DAUPcf1nT9+aJaqCtw@mail.gmail.com>
 <4966376.bRx4fgSjbT@wuerfel>
Message-ID: <1f1eeb4a-925a-9fac-d442-fbee503deb0a@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/10/16 11:06, Arnd Bergmann wrote:
> On Sunday, October 23, 2016 12:26:59 AM CEST Duc Dang wrote:
>> Hi Catalin, Marc, Mark, Arnd,
>>
>> I am testing with 3.12 kernel with earlyprintk enabled and I see some
>> garbage characters in the console log right before the message
>> indicating that the real console device is initialized:
>>
>> <some garbage characters here>01c020000.serial: ttyS0 at MMIO
>> 0x1c020000 (irq = 108, base_baud = 3125000) is a U6_16550A
>> console [ttyS0] enabled, bootconsole disabled

Well, you get two independent, unsynchronized bits of code writing to
the same peripheral. Things are bound to go badly. Unless you're trying
to debug things, do not use earlyprintk in production.

>>
>> I looked through early_prink.c file and printk.c file and it looks
>> like there is case that some early boot code can touch the UART
>> hardware via ealy console driver while the 'real' console driver is
>> setting up the same UART port? Please let me know if I missed some
>> important piece of code that can prevent this.
> 
> I don't think we every supported earlyprintk on arm64, and
> earlycon support may have been added later.

We did support some form of earlyprintk for a while (though not in the
same way as 32bit ARM does), until Rob introduced earlycon.

> If you can't use a modern kernel, try backporting all the
> relevant earlycon changes.

Agreed. That's the most sensible course of action.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
