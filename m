From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 2 Jan 2017 21:15:29 +0100
Subject: [PATCH 15/20] ARM/hw_breakpoint: Convert to hotplug state machine
In-Reply-To: <20170102150015.GJ14217@n2100.armlinux.org.uk>
References: <20161117183541.8588-1-bigeasy@linutronix.de>
 <20161117183541.8588-16-bigeasy@linutronix.de>
 <CACRpkdZE+h0+3EizLCMUr-e-4pv4w9iAatSqL8k0Ovd2iUaS8Q@mail.gmail.com>
 <CACRpkda2gdjM--LSoJTL0dvqyw796w1hMSAhUQwv9X0EPzJHig@mail.gmail.com>
 <20170102150015.GJ14217@n2100.armlinux.org.uk>
Message-ID: <CACRpkdaxAPSU-XPQrgVRoBecAD1ZpVVP4qPe59af-yy11WqBQw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 2, 2017 at 4:00 PM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Mon, Jan 02, 2017 at 03:34:32PM +0100, Linus Walleij wrote:
>> in the first line of arch_hw_breakpoint_init() in
>> arch/arm/kernel/hw_breakpoint.c
>>
>> I suspect that is not an accepable solution ...
>>
>> It hangs at PC is at write_wb_reg+0x20c/0x330
>> Which is c03101dc, and looks like this in objdump -d:
>>
>> c031020c:       ee001eba        mcr     14, 0, r1, cr0, cr10, {5}
>> c0310210:       eaffffb3        b       c03100e4 <write_wb_reg+0x114>
>
> ... and this is several instructions after the address you mention above.
> Presumably c03101dc is accessing a higher numbered register?

Ah sorry. It looks like this:

c03101dc:       ee001ed0        mcr     14, 0, r1, cr0, cr0, {6}
c03101e0:       eaffffbf        b       c03100e4 <write_wb_reg+0x114>
c03101e4:       ee001ebf        mcr     14, 0, r1, cr0, cr15, {5}
c03101e8:       eaffffbd        b       c03100e4 <write_wb_reg+0x114>
c03101ec:       ee001ebe        mcr     14, 0, r1, cr0, cr14, {5}
c03101f0:       eaffffbb        b       c03100e4 <write_wb_reg+0x114>
c03101f4:       ee001ebd        mcr     14, 0, r1, cr0, cr13, {5}
c03101f8:       eaffffb9        b       c03100e4 <write_wb_reg+0x114>

Yours,
Linus Walleij
