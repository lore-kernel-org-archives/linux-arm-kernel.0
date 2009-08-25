From: somshekar@celestialsys.com (Somshekar ChandrashekarKadam)
Date: Tue, 25 Aug 2009 14:43:35 +0530
Subject: RealView: Fix SD/MMC card detection on RealView PB1176
Message-ID: <79203f12483a41d6a7108a5381676cdf@dr116.cyberspaceindia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalian,

I see this patch

 RealView: Fix SD/MMC card detection on RealView PB1176

The RealView PB1176 has to use GPIO for detecting the SD/MMC card
change.
Commit ID      :                                     e83e8eab985df97f2b49e2863c97bc929a921b63

This is no yet made to Kernel.org nor to stable arm git or is it dropped, or will be supported later.

Regards
Neelu

----------------------------------------
From: Catalin Marinas <catalin.marinas@arm.com>
Sent: Monday, August 24, 2009 8:47 PM
To: Jamie Lokier <jamie@shareable.org>
Subject: Re: LDREX/STREX and pre-emption on SMP hardware 

On Mon, 2009-08-24 at 22:12 +0100, Jamie Lokier wrote:
> Catalin Marinas wrote:
> > BTW, some time ago I sent a patch to clear the exclusive monitor at
> > every exception entry (interrupt, aborts etc.) but wasn't accepted. The
> > main reason for that was to be able to only use STR for atomic_set()
> > rather than the combination of LDREX/STREX we have now.
> 
> Would CLREX+STR work, and would it be an improvement?

IMHO, yes. You use CLREX at every exception entry and make the
atomic_set() function simply use STR. But the argument was that
atomic_set() isn't used very often anyway.

> > A similar reason for STR used in application signal handlers which
> > are usually invoked without a __switch_to call (unless the signal
> > handler is in a different application from the running one).
> 
> How about adding CLREX to the signal handling path?  Not exception
> entry, but the part which sets up the signal frame.

Yes, that's the solution, only that I've never had the time to revisit
it and send another patch.

-- 
Catalin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20090825/277a63bb/attachment.htm>
