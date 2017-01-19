From: sergey.senozhatsky@gmail.com (Sergey Senozhatsky)
Date: Thu, 19 Jan 2017 21:07:44 +0900
Subject: [PATCH] ARM: smp: Remove CPU: shutdown notice
In-Reply-To: <1041c46f-13e7-4446-33e0-75eee9ffb91f@gmail.com>
References: <20170117230714.6799-1-f.fainelli@gmail.com>
 <20170117232314.GI27312@n2100.armlinux.org.uk>
 <fd4a4f48-f19e-dcac-c286-8e03db89e99a@gmail.com>
 <20170118095523.GK20462@pathway.suse.cz>
 <1041c46f-13e7-4446-33e0-75eee9ffb91f@gmail.com>
Message-ID: <20170119120744.GB435@tigerII.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On (01/18/17 11:56), Florian Fainelli wrote:
[..]
> >>> CPU hotplug isn't a fast operation anyway - it's also fairly disruptive
> >>> in that it uses stop_machine() to halt activity everywhere while taking
> >>> the CPU offline.
> >>
> >> We have a test that consists in shutting down all CPUs as frequently as
> >> we can and do this for about 2 million iterations which takes roughly
> >> 24h, and this printk slows thing down by a reasonable amount. Here are
> >> some numbers on 500 hotplug operations:
> >>
> >> w/ printk:
> >> real    0m9.997s
> >> user    0m0.725s
> >> sys     0m3.030s
> >> #
> >>
> >> w/o printk:
> >> real    0m8.547s
> >> user    0m0.436s
> >> sys     0m1.838s
> > 
> > I am curious that a single printk() might make such a big difference.
> 
> It does, because of how printk() is implemented (there is nothing wrong
> with it, just slow by nature and how the UART gets written to as well).
> 
> > 
> > One reason might be that the messages are pushed to a "slow" console.
> 
> 115200 UART, yes that's slow, but not unusual.
> 
> > 
> > Another reason might be that there are many other messages printed
> > on the system and there is a contention on logbuf_lock or other
> > console related locks.
> 
> The other messages being printed are those from the hotplug script that
> I run which just checkpoints its running every 50 instances, so it does
> not occur that often, the console really is not busy, which really
> extracts the overhead of printing "CPU: shutdown".

there is also console_cpu_notify(), which basically serializes all
CPU hotplug events. and that's a sleepable console_lock(), followed
by a potentially long console_unlock(). for hotplug each notification.

static int console_cpu_notify(unsigned int cpu)
{
        if (!cpuhp_tasks_frozen) {
                console_lock();
                console_unlock();
        }
        return 0;
}




out of curiosity, does the change below improve anything in your test?

---

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 7180088cbb23..72e86e06c4e4 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2035,8 +2035,9 @@ void resume_console(void)
 static int console_cpu_notify(unsigned int cpu)
 {
        if (!cpuhp_tasks_frozen) {
-               console_lock();
-               console_unlock();
+               /* If trylock fails, someone else is doing the printing */
+               if (console_trylock())
+                       console_unlock();
        }
        return 0;
 }
