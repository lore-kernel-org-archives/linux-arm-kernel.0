From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 10 Jul 2014 23:13:38 +0100
Subject: dove (marvell A510) crash on boot with config_preempt
In-Reply-To: <53BEFDAB.4090606@gmail.com>
References: <20140706080845.723e9787@armhf>
 <20140708151705.GE13433@titan.lakedaemon.net> <53BE8817.10703@gmail.com>
 <53BEFDAB.4090606@gmail.com>
Message-ID: <20140710221338.GY21766@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 10, 2014 at 10:55:07PM +0200, Sebastian Hesselbarth wrote:
> On 07/10/2014 02:33 PM, Sebastian Hesselbarth wrote:
> > Ok, I have been able to debug this despite my limited knowledge of
> > iWMMXt and ARM asm. While the patch below fixes the issue, I have
> > no clue if it is the right approach or if there should be a different
> > solution. I'd like to leave that to either Russell or Catalin to decide.
> 
> After thinking a while about it and because I missed it to mention:
> 
> I did a bisect which ends in
> 
> commit 1fb333489fb917c704ad43e51b45c12f52215a9c
>  ("Merge branches 'alignment', 'fixes', 'l2c' (early part) and 'misc'
> into for-next")
> 
> which clearly isn't the offending commit itself but finally causing
> iwmmxt code to show the issue.
> 
> I compared introduced {inc,dec}_preempt_count macros
> 
> .macro  inc_preempt_count, ti, tmp
> ldr     \tmp, [\ti, #TI_PREEMPT]        @ get preempt count
> add     \tmp, \tmp, #1                  @ increment it
> str     \tmp, [\ti, #TI_PREEMPT]
> .endm
> 
> .macro  dec_preempt_count, ti, tmp
> ldr     \tmp, [\ti, #TI_PREEMPT]        @ get preempt count
> sub     \tmp, \tmp, #1                  @ decrement it
> str     \tmp, [\ti, #TI_PREEMPT]
> .endm
> 
> with common C defines for preempt_{disable,enable}
> 
> #define preempt_disable() \
> do { \
>         preempt_count_inc(); \
>         barrier(); \
> } while (0)
> 
> #define preempt_enable() \
> do { \
>         barrier(); \
>         preempt_count_dec(); \
> } while (0)
> 
> and wondered about the missing barriers.

The barriers there are just compiler barriers - they're there to
prevent the compiler moving stores across the change in preempt
count.  The assembly is safe because we're in control of when and
how we insert the explicit data accesses.

> Anyway, I may be wrong about it. At least I wanted to mention that
> bisect ends in above merge commit of l2c related cleanup and not
> the iwmmxt preempt commit itself.

The iwmmxt preempt commit is definitely incorrect, and your analysis of
the dump based on Jean-Francois's report is spot on, and your solution
looks pretty much like a good solution.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
