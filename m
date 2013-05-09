From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 09 May 2013 18:35:12 +0200
Subject: [PATCH 1/2] Revert "drivers/rtc/rtc-pxa.c: fix set time sync time
 issue"
In-Reply-To: <1367889447-15619-2-git-send-email-chao.xie@marvell.com> (Chao
 Xie's message of "Mon, 6 May 2013 21:17:26 -0400")
References: <1367889447-15619-1-git-send-email-chao.xie@marvell.com>
 <1367889447-15619-2-git-send-email-chao.xie@marvell.com>
Message-ID: <877gj8i01r.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Chao Xie <chao.xie@marvell.com> writes:

> This patch have something wrong.
> 1.The pxa_sync_time API is not needed. The RTC sync can be done
> by user space applications, so in kernel this API is not needed.
> 2.The pxa_rtc_open can not be deleted. This change has been
> declined during review at the mail list
> 3.Based on specification and talked with owner of driver, it
> does not matter to set WOM and DOW.
>
> Only need to keep PSBR control for pxa95x
>
> This reverts commit 57489fabb7f3fc02483df2125fdbfb8b1bb1fcd8.

This commit doesn't exist in Linus's tree. Maybe in linux-next ?

Anyway, as you are reverting, please consider this :
the commit that exists is : c4243de70f7d536d95196b8a31539298bb15238c
"drivers/rtc/rtc-pxa.c: drivers/rtc/rtc-pxa.c: fix alarm not match issue".

This commit should be reverted :
 - because it's wrong :
   > tm->tm_wday = ((rycr & RDxR_DOW_MASK) >> RDxR_DOW_S) - 1;
   See how RYCR is used with a RDCR mask ...

 - because as maintainer I have already nacked this kind of patch :
   https://patchwork.kernel.org/patch/1819851/
   The reasons given here are still valid AFAIK.

I'm pretty sure I didn't receive this patch in my mailbox. After I refused
ChaoXie first patch, the second "same approach" patch from Liangs was sent in my
back. I don't understand how that could happen ...

Liangs, please make sure to add me to the reviewers next time ?

Cheers.

--
Robert
