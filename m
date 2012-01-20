From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 20 Jan 2012 18:56:54 +0100
Subject: [PATCH] ARM: ux500: Initialize irq affinity
In-Reply-To: <20120120175018.GC11845@n2100.arm.linux.org.uk>
References: <1327064356-3603-1-git-send-email-per.xx.fransson@stericsson.com>
 <20120120130310.GO1068@n2100.arm.linux.org.uk>
 <CACRpkdYgT-Q+ZEzhjOaOb_2Pihx0-pMXo+Dc-CESDT7BAWAOqg@mail.gmail.com>
 <20120120175018.GC11845@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdYg-5vBcWU6uOeKsTtObqhWf9gv19HZTqPTVvRCAN3ayg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 20, 2012 at 6:50 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Jan 20, 2012 at 04:45:40PM +0100, Linus Walleij wrote:

>> Currently the gic_set_affinity() in common/gic.c isn't called for any
>> IRQs so they are left in their power-on state (from U-Boot or
>> similar) which is essentially correct (we checked dumps of the
>> registers).
>
> No they aren't. ?See the gic code:
>(...)
> At boot, we program _all_ the GIC IRQs to point at the boot CPU as part
> of the initialization, which will be logical CPU 0.

Yes, I was dead wrong. And I even read that code just hours ago :-(

>> However when we look at the irq descriptors in e.g. crash:
>>
>> ? ? crash> irq -s
>> ? ? IRQ NAME ? ? ? ? ? ? ? ? AFFINITY
>> ? ? ?36 Nomadik Timer Tick ? 0
>> ? ? ?43 uart-pl011 ? ? ? ? ? 0-1
>> ? ? ?44 nmk-i2c ? ? ? ? ? ? ?0-1
>> ? ? ?46 pl022 ? ? ? ? ? ? ? ?0-1
>> ? ? ?53 nmk-i2c ? ? ? ? ? ? ?0-1
>> ? ? ?54 nmk-i2c ? ? ? ? ? ? ?0-1
>> ? ? (... etc ...)
>
> Yes, and as I said in my previous email, having the affinity mask report
> more CPUs than we set the hardware to is perfectly legal.

OK I see, then it's no problem.

Yours,
Linus Walleij
