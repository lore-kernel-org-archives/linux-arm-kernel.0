From: tim.bird@am.sony.com (Tim Bird)
Date: Fri, 4 Feb 2011 12:29:25 -0800
Subject: Question about ARM function graph tracing
In-Reply-To: <AANLkTinoFRE2ho9u9yF5nhfgr1gGouHV3anf2OX0mN2T@mail.gmail.com>
References: <4D4B3D63.4090207@am.sony.com>
	<AANLkTinoFRE2ho9u9yF5nhfgr1gGouHV3anf2OX0mN2T@mail.gmail.com>
Message-ID: <4D4C61A5.4050403@am.sony.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rabin,

For a quick update, see below.

On 02/03/2011 08:07 PM, Rabin Vincent wrote:
> On Fri, Feb 4, 2011 at 05:12, Tim Bird <tim.bird@am.sony.com> wrote:
>> I sheepishly admit that I haven't been following mainline very
>> well. ?I was happily surprised to see you have mainlined ARMj
>> function graph tracing. ?I gave it a test on my old OMAP
>> OSK board, with the results shown below.
> 
> OMAP is missing a notrace annotation on omap_readl():
> 
> http://www.mail-archive.com/linux-omap at vger.kernel.org/msg38911.html
> 
> Part of that patch was merged through rmk's work, but the
> omap_readl() annotation seems to have been missed.
Yep.  It's missing in 2.6.38-rc3.

> Also, if this is OMAP1 and not latest mainline, I think you
> will need  a notrace on omap_rev() also (called from inside
> omap_readl() until recently).

I couldn't find that in the sched_clock code paths, but
I 'notrace'd it anyways.

> 
> I think this is most probably what is wrong, since IIRC I saw
> crashes like this on BeagleBoard before I added the notrace on
> omap_readl.  Could you please try with these changes?

I have sprinkled 'notrace's liberally throughout the sched_clock
code (including omap_readl() and omap_rev()), and I'm still
seeing problems.  I put a recursion guard in
prepare_ftrace_return, and I'm seeing lots of recursion.  So
there's still a notrace missing somewhere.

I'm sure this is the problem, so thanks for pointing me in the
right direction.  I'll keep trying to pin it down, and let
you know what I find.
 -- Tim

=============================
Tim Bird
Architecture Group Chair, CE Linux Forum
Senior Staff Engineer, Sony Network Entertainment
=============================
