From: chris@printf.net (Chris Ball)
Date: Tue, 28 Jan 2014 01:08:32 +0000
Subject: [PATCH 1/3] mmc: add support for power-on sequencing through DT
In-Reply-To: <52E700F0.7040708@gmail.com> (Tomasz Figa's message of "Tue, 28
 Jan 2014 01:59:28 +0100")
References: <1390190215-22700-1-git-send-email-olof@lixom.net>
 <1390190215-22700-2-git-send-email-olof@lixom.net>
 <52DEBDA7.7030200@samsung.com> <52E54540.8080304@gmail.com>
 <CAPDyKFqpOLZiUSDvxVtYrBM8DtrZDLE27LKzyoWaf29Ni2vcFQ@mail.gmail.com>
 <52E700F0.7040708@gmail.com>
Message-ID: <861tzs29rj.fsf@void.printf.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jan 28 2014, Tomasz Figa wrote:
>> I am not sure I understand why this is needed. I think it would be
>> more convenient to use MMC_CAP_NONREMOVABLE instead as stated earlier.
>> But please elaborate, I might have missed something.
>
> See above. I'm not quite convinced that state of MMC interface should
> determine power state of the chip. I can easily imagine a situation
> where the MMC link is powered down (link power management) but the
> WLAN chip keeps operation. Keep in mind that those are usually
> complete SoCs that can keep processing network traffic autonomously
> and wake-up the application processor whenever anything interesting
> happens using extra out of bounds signalling, which might trigger
> re-enabling the MMC link.

For what it's worth, we did this using upstream code (libertas-sd8686
WLAN with sdhci-pxav3) at OLPC.  We set the SDIO device to 1-bit mode
on system suspend, using MMC_CAP_NONREMOVABLE, MMC_PM_KEEP_POWER and
MMC_PM_WAKE_SDIO_IRQ, and tell the PMU to wake on the 1-bit data line.
When it wakes the system, the system sees the SDIO interrupt and
processes the waiting network traffic.

So this use case is already supported using the current interfaces.
If this interface doesn't work for your use case, could you talk a
little more about what you're trying to achieve?

Thanks,

- Chris.
-- 
Chris Ball   <chris@printf.net>   <http://printf.net/>
