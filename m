From: kevin@bracey.fi (Kevin Bracey)
Date: Thu, 18 Apr 2013 22:44:49 +0300
Subject: [PATCH] ARM: smp: call platform's cpu_die in ipi_cpu_stop
In-Reply-To: <20130418182534.GD14496@n2100.arm.linux.org.uk>
References: <1365251824-4852-1-git-send-email-kevin@bracey.fi>
 <1365251824-4852-2-git-send-email-kevin@bracey.fi>
 <20130418171801.GC14496@n2100.arm.linux.org.uk>
 <20130418182534.GD14496@n2100.arm.linux.org.uk>
Message-ID: <51704D31.10808@bracey.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/04/2013 21:25, Russell King - ARM Linux wrote:
> Now, with this patch applied, we guarantee that we push out any data 
> that matters from the dying CPU before platform_cpu_kill() is called. 
> That should mean that shmobile can remove that whole cpu_dead thing.

Patch looks supremely sensible. Clearly there is more centralisation 
needed for the generic cache issue, and that addresses the currently 
upstream shmobile stuff.

But I had also been intending to have "post-kill" co-ordination for 
power control and error reporting. Something along the lines of:

1) cpu_die tells the power hardware to shut down the core on next 
STANDBYWFI assertion, then does the final chip-specific clear-up, then WFI.

2) cpu_kill waits for the power hardware to report shutdown of that 
core, and reports success, or failure after timeout.

That seemed logical, but it just doesn't fly when cpu_kill routinely 
occurs without cpu_die. We again end up timing out (once per CPU) in 
that case, which can add a significant time to panic/shutdown.

Am I on the right lines here, or misunderstanding? It seems like a 
pretty natural thing to attempt. And it would have worked fine before 
the die-less kill was added to smp_send_stop.

If anyone ever has both die and kill implemented and doing something in 
a platform, they will have to have some sort of co-ordination, as 
there's a race for kill running before die is finished. (Although it 
could be that what they do is so simple/fast that die is "guaranteed" to 
win the race). This patch takes the slow cache clean out, so solves it 
for that, but the essential race problem remains for anything 
platform-specific in cpu_die. So I still think every kill needs a die. 
Unless you expect each platform to use only one of the hooks.

Alternatively, I guess you could just pass a parameter to cpu_kill to 
tell it "I'm not sending a die request". (I've not figured out a way to 
deduce it). In which case, cpu_kill would just become a NOP in that case 
for me. Although wasn't the original motivation for it being added to 
smp_send_stop that it would do the necessary to power down the core for 
a kexec restart? So it wouldn't achieve that.

Kevin
