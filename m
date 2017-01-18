From: pmladek@suse.com (Petr Mladek)
Date: Wed, 18 Jan 2017 10:55:23 +0100
Subject: [PATCH] ARM: smp: Remove CPU: shutdown notice
In-Reply-To: <fd4a4f48-f19e-dcac-c286-8e03db89e99a@gmail.com>
References: <20170117230714.6799-1-f.fainelli@gmail.com>
 <20170117232314.GI27312@n2100.armlinux.org.uk>
 <fd4a4f48-f19e-dcac-c286-8e03db89e99a@gmail.com>
Message-ID: <20170118095523.GK20462@pathway.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 2017-01-17 15:39:45, Florian Fainelli wrote:
> On 01/17/2017 03:23 PM, Russell King - ARM Linux wrote:
> > On Tue, Jan 17, 2017 at 03:07:12PM -0800, Florian Fainelli wrote:
> >> This message is not particularly informative, and is not paired with an
> >> identical message when a CPU is brought online. Finally, it slows the
> >> CPU hotplug path down, thus allowing less CPU hotplug operations per
> >> second. Just remove it.
> > 
> > CPU hotplug isn't a fast operation anyway - it's also fairly disruptive
> > in that it uses stop_machine() to halt activity everywhere while taking
> > the CPU offline.
> 
> We have a test that consists in shutting down all CPUs as frequently as
> we can and do this for about 2 million iterations which takes roughly
> 24h, and this printk slows thing down by a reasonable amount. Here are
> some numbers on 500 hotplug operations:
> 
> w/ printk:
> real    0m9.997s
> user    0m0.725s
> sys     0m3.030s
> #
> 
> w/o printk:
> real    0m8.547s
> user    0m0.436s
> sys     0m1.838s

I am curious that a single printk() might make such a big difference.

One reason might be that the messages are pushed to a "slow" console.

Another reason might be that there are many other messages printed
on the system and there is a contention on logbuf_lock or other
console related locks.

There might be also the opposite problem. The messages are also read
by userspace tools that store them into /var/log/messages or systemd
logs. If these are the only messages printed to the log and if there
is no other activity on the system. Then the waken loggers might make
a difference, especially if all CPUs are getting disabled and only
one is available at some point.

Well, I am not sure what other operations are needed to do the
CPU hotplug operation.

I cannot judge how the message is useful and if the speed up
is worth removing it.

Best Regards,
Petr
