From: tpiepho@gmail.com (Trent Piepho)
Date: Thu, 23 Feb 2012 14:01:20 -0500
Subject: [alsa-devel] [PATCH 4/4] ASoC: fsl: make fsl_ssi driver
 compilable on ARM/IMX
In-Reply-To: <20120223171407.GC22562@n2100.arm.linux.org.uk>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
 <1330008519-3584-1-git-send-email-shawn.guo@linaro.org>
 <1330008519-3584-5-git-send-email-shawn.guo@linaro.org>
 <4F465A33.3020208@ru.mvista.com> <4F465EE5.4010908@freescale.com>
 <20120223165242.GB22562@n2100.arm.linux.org.uk>
 <4F4671BB.7060409@freescale.com>
 <20120223171407.GC22562@n2100.arm.linux.org.uk>
Message-ID: <CA+7tXigQ=R3-b0jiFJF3rmBRQS4RM77Z9Thq2pkE2yrs03NYWw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 23, 2012 at 12:14 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Feb 23, 2012 at 11:04:59AM -0600, Timur Tabi wrote:
>> Russell King - ARM Linux wrote:
>> We almost never use readl. ?I see that it is used in some places, but
>> honestly I can't see how it can be valid. ?For instance, the mpic driver
>> uses it in mpic_startup_ht_interrupt(). ?I don't understand how that's
>> valid, since there's nothing preventing the readl() from happening
>> *before* the writeb.
>
> That just sounds broken. ?If readl() can happen before a writeb() issued
> in program order, how do most of the PCI drivers work?

I was under the impression that on powerpc io memory was mapped
cache-inhibited and guarded, which provides most ordered, but not
store to load ordering without an additional synchronization
instruction.  See
http://cache.freescale.com/files/32bit/doc/app_note/AN3441.pdf on page
8.

PCI adds some additional complexity, since the PCI device is not
connected directly to the CPU.  One must consider the actions of the
PCI host controller.
