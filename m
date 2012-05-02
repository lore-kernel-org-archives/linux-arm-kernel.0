From: jonathan@jonmasters.org (Jon Masters)
Date: Wed, 02 May 2012 02:22:08 -0400
Subject: [PATCH] ARM: Fix restoration of IP scratch register when auditing
 syscalls
In-Reply-To: <20120430100746.GA11080@mudshark.cambridge.arm.com>
References: <1335681504-4609-1-git-send-email-jcm@jonmasters.org>
 <1335681504-4609-2-git-send-email-jcm@jonmasters.org>
 <20120430100746.GA11080@mudshark.cambridge.arm.com>
Message-ID: <4FA0D290.90300@jonmasters.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi will,

First, for the record, I want to note that I had an actual nightmare
about this last night. Woke up at 5am in a cold sweat with a fear that
"register 12" was out to get me (WTF?). I am *not* joking... ;)

On 04/30/2012 06:07 AM, Will Deacon wrote:

>> The fix is simply to have an additional out when not ptracing.

I retract that. The way to avoid trashing userspace is to do that. But
now that this is identified, I've spent some quality time reading the
audit code and I now even understand what it's trying to do :)

> Actually, I don't understand why we have to update pt_regs so early given
> that I don't think the saved ip is used by audit_syscall_{entry,exit} at
> all. Perhaps we could just move the ip manipulation until after the thread
> flag checks [completely untested patch below]?

Yea. There's no reason I can see to include the IP there, even for the
mach-specific macros we'll use later to pull stuff out of regs (e.g.
regs_return_value, or r0 to its friends). Your patch boots on my test
system running auditd, and more to the point - paraphrasing what Russell
said - the existing code wasn't exactly the best there, since it wants
to use "why" (set in common) and not ip as a conditional.

Ship it. Or er, I dunno, perhaps:

Reported-by: Jon Masters <jcm@jonmasters.org>
Tested-by: Jon Masters <jcm@jonmasters.org>

(or whatever else you want to shove in there for my signoff)

Jon.
