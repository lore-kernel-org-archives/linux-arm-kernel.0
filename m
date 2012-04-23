From: akpm@linux-foundation.org (Andrew Morton)
Date: Mon, 23 Apr 2012 13:53:22 -0700
Subject: [PATCH] drivers/rtc/rtc-m41t93.c: don't let get_time() reset
 error state
In-Reply-To: <201204231230.q3NCUbbP015327@gatekeeper.vosshq.de>
References: <201204231230.q3NCUbbP015327@gatekeeper.vosshq.de>
Message-ID: <20120423135322.5b9b1635.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 23 Apr 2012 12:51:23 +0200
Nikolaus Voss <n.voss@weinmann.de> wrote:

> If the rtc reports the time might be invalid due to oscillator
> failure, this flags must not be reset by get_time() as the read
> operation doesn't make the time valid.
> 
> Instead, the flag is reset in set_time() when a valid time is
> to be written.

This is rather vague - what is/are "these flags"?  From the patch I
think you're referring to (the maddeningly undocumented)
M41T93_FLAG_ST?  If so, I'd suggest something like

: If the rtc reports the time might be invalid due to oscillator failure,
: the M41T93_FLAG_ST flag must not be reset by get_time() as the read
: operation doesn't make the time valid.
: 
: Instead, the M41T93_FLAG_ST flag is reset in set_time() when a valid time
: is to be written.

Secondly, you provided no description of the user-visible effects of
the bug.  Hence I cannot work out which kernel version(s) this patch
should be merged into.
