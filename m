From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 5 Jul 2011 16:59:25 +0800
Subject: [PATCH] pxa/hx4700: Avoid unbalanced irq wakeup enables/disables
In-Reply-To: <55815.35947.qm@web29005.mail.ird.yahoo.com>
References: <20110514211305.GB16305@rainbow>
	<55815.35947.qm@web29005.mail.ird.yahoo.com>
Message-ID: <CAMPhdO_v+vXBJPdkp_zFoKrPA2-2Y_r+RUXLpoCuWmUaEXcgJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 15, 2011 at 7:20 AM, Paul Parsons <lost.distance@yahoo.com> wrote:
> Hi Dmitry,
>
>> Well, you right here - GPIO94 and GPIO99 can't be enabled
>> as wake-up
>> sources in PWER on PXA270. But they can be enabled in PKWR,
>> according to
>> section 3.8.1.15 of PXA27x Developer's Manual. And there's
>> a proof: WinCE
>> happily wakes on MAIL/CONTACTS presses. Though probably
>> these pins will
>> need some configuration in MFP table to work as wake-up
>> sources...
>
> Ah, another wake-up enable register; I missed that! Yes, that should work via tweaks to the MFP table.
>
>> Anyway, I have no strong opinion about whether to disable
>> just ASIC3
>> buttons, or to leave only POWER as wakeup source. So I
>> think your patch is
>> fine as the solution to unbalanced irq wakeup problem and
>> may go in, unless
>> Philipp or Eric have objections.
>
> My feeling is that it should be all or nothing; we either get all other 5 buttons working as wake-ups or we disable them. Perhaps Russell's comments are the clincher.
>

To use GPIOs in PKWR, you need to do two things:

1. WAKEUP_ON_LEVEL_HIGH or'ed with the pin configuration (see mfp-pxa2xx.h)
2. enable_irq_wakeup() will eventually invoke gpio_set_wake() in
mfp-pxa2xx.c, and that function will handle the PKWR setting.

> While on the subject, it turns out that the reset button (= GPIO reset) also acts as a wake-up on my unit. But the PXA27x manual says this:
>
> "In standby, sleep, and deep-sleep modes, GPIO reset is first treated as a wake-up event."
>
> Does this mean that both the SMR and GPR bits the RCSR register are set? And if so, does the bootloader then decide whether to wake-up the unit or whether to reset it?
>

The full statement is:

In standby, sleep, and deep-sleep modes, GPIO reset is first treated
as a wake-up event. It is then
recognized as a GPIO reset if held asserted for more than 1 ms after
all power supplies are stable.

And my understanding of this is - an assertion on GPIO<1> will firstly be
treated as a wake-up event and cause the sleep-exit. SMR in RCSR will
be set. A normal resume process begins from software perspective. If
the assertion is a pulse less than 1ms, no reset will happen. However,
if the assertion is more than 1ms, then GPIO reset will happen wherever
the software resuming process is. SMR will most likely be cleared during
this reset process.

In other word, the whole process is transparent to software including
the bootloader.

> Regards,
> Paul
>
