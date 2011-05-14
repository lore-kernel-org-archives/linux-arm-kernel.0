From: mad_soft@inbox.ru (Dmitry Artamonow)
Date: Sun, 15 May 2011 01:13:05 +0400
Subject: [PATCH] pxa/hx4700: Avoid unbalanced irq wakeup enables/disables
In-Reply-To: <266912.5357.qm@web29010.mail.ird.yahoo.com>
References: <20110513101348.GA18716@rainbow>
	<266912.5357.qm@web29010.mail.ird.yahoo.com>
Message-ID: <20110514211305.GB16305@rainbow>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11:53 Fri 13 May     , Paul Parsons wrote:
> Hi Dmitry,
> 
> I tried your patch and found that the MAIL and CONTACTS buttons did not resume the unit. The same is true of the handhelds.org 2.6.21-hh20 kernel. I don't have WinCE any more so am unable to test that.
> 
> The reason appears to be that neither GPIO94 (MAIL) nor GPIO99 (CONTACTS) can be enabled as a wake-up source in the PWER register.

Well, you right here - GPIO94 and GPIO99 can't be enabled as wake-up
sources in PWER on PXA270. But they can be enabled in PKWR, according to
section 3.8.1.15 of PXA27x Developer's Manual. And there's a proof: WinCE
happily wakes on MAIL/CONTACTS presses. Though probably these pins will
need some configuration in MFP table to work as wake-up sources...

Anyway, I have no strong opinion about whether to disable just ASIC3
buttons, or to leave only POWER as wakeup source. So I think your patch is
fine as the solution to unbalanced irq wakeup problem and may go in, unless
Philipp or Eric have objections.

-- 
Best regards,
Dmitry "MAD" Artamonow
