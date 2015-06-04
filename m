From: balbi@ti.com (Felipe Balbi)
Date: Thu, 4 Jun 2015 15:37:32 -0500
Subject: [RFC/NOT FOR MERGING] HACK: add global/private timers for A9
In-Reply-To: <5570B5E8.90300@free.fr>
References: <1433363565-17725-1-git-send-email-balbi@ti.com>
 <2466648.WjMxjIpAUG@wuerfel>
 <20150603210455.GD6042@saruman.tx.rr.com>
 <20150603212821.GH6042@saruman.tx.rr.com>
 <556F7493.2060602@codeaurora.org>
 <20150603215445.GK6042@saruman.tx.rr.com> <55701E93.60303@free.fr>
 <20150604200850.GF5710@saruman.tx.rr.com> <5570B5E8.90300@free.fr>
Message-ID: <20150604203732.GI5710@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 04, 2015 at 10:32:40PM +0200, Mason wrote:
> On 04/06/2015 22:08, Felipe Balbi wrote:
> 
> > On Thu, Jun 04, 2015 at 11:46:59AM +0200, Mason wrote:
> >> Also, check /proc/timer_list for a "Broadcast device". If you don't
> >> define one, the TWD timers are set to periodic mode, with hrtimers
> >> disabled.
> > 
> > Did you manage to turn global timer into Broadcast device ?
> 
> Disclaimer: I am a kernel noob, take everything I say with
> a rock of salt.
> 
> As far as I can see, the global timer code doesn't handle
> frequency changes, whereas the TWD code does.

All right, but TWD has C3STOP and that prevents it from being used as
broadcast device.

Tony Lindgren had the idea of implementing a timer switch during idle
and that could help us strip the kernel off of C3STOP feature flag. That
means we might be able to use TWD as broadcast until CPU decides to
idle, at which point we need to switch to a different timer.

> Yet all these timers are clocked by PERIPHCLK, which is defined
> as CPUCLK / N. So if a platform enables cpufreq, CPUCLK will
> vary, meaning PERIPHCLK will vary. I don't see how the global
> timer can work in that situation.
> 
> cf. also this recent thread:
> http://thread.gmane.org/gmane.linux.kernel.cpufreq/15770

I'll have a read, cheers.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150604/b0f8da26/attachment.sig>
