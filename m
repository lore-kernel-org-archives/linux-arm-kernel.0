From: mats.liljegren@enea.com (Mats Liljegren)
Date: Mon, 11 Feb 2013 20:03:17 +0100
Subject: Porting 3.8-rc4-nohz3 to ARM (PandaBoard)
In-Reply-To: <CAFTL4hyNZdjmSij0DDouu0mmD5E3xApq7i=dZD941ZtCM1QyjQ@mail.gmail.com>
References: <20130204200238.GA16718@enea.se>
 <CAFTL4hyNZdjmSij0DDouu0mmD5E3xApq7i=dZD941ZtCM1QyjQ@mail.gmail.com>
Message-ID: <20130211190317.GA8513@enea.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Frederic Weisbecker wrote:
> 2013/2/4 Mats Liljegren <mats.liljegren@enea.com>:
> > Hi Frederic,
> >
> > (Sorry for the re-post, I spelled the mailing list wrong...)
> >
> > I want to port dynticks patches 3.8-rc4-nohz3 to ARM architecture, and try it out on the PandaBoard. Initially this is for evaluating it, but if it looks promising I'd like to upstream this.
> >
> > As far as I can see the first thing to do is to implement virtual time accounting. After an initial look at the patches done for ia64, it doesn't look too difficult.
> 
> No that part is handled by the core code. But you need to implement
> the context tracking arch backend.
> Here is what Li Zhong did to port it on Powerpc for example:
> https://lkml.org/lkml/2013/2/1/216
> 
> > Are there any caveats I should be aware of?
> 
> The generic cputime accounting only works on 64 bits archs. We'll need
> to do some safe accessors to read the kernel_stat. In the meantime you
> can do home tests by removing the CONFIG_64BIT dependency. This
> shouldn't be dangerous
> 
> > Has anyone else started any work in this area that I could co-operate with?
> 
> Yeah two people have been working on this. But it was several month
> ago and I haven't hear from them since then. I'm adding Geoff in Cc. I
> can't retrieve the other guy who has worked on it too.

Could the other guy be Kevin Hillman? The name has been mentioned to me but
I don't have his e-mail address.

I have stumbled across a problem, I get the following error messages during
boot:

---- Start snippet ----
[   41.119873] INFO: task rcuo1:10 blocked for more than 20 seconds.
[   41.126373] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[   41.134765] rcuo1           D c045c5d8     0    10      2 0x00000000
[   41.141662] [<c045c5d8>] (__schedule+0x8f4/0xa74) from [<c045c880>] (schedule+0x74/0x78)
[   41.150329] [<c045c880>] (schedule+0x74/0x78) from [<c00df138>] (rcu_nocb_kthread+0xdc/0x224)
[   41.159423] [<c00df138>] (rcu_nocb_kthread+0xdc/0x224) from [<c006d830>] (kthread+0xb0/0xbc)
[   41.168487] [<c006d830>] (kthread+0xb0/0xbc) from [<c00142c8>] (ret_from_fork+0x14/0x20)
[   41.177124] no locks held by rcuo1/10.
[   41.181182] INFO: task rcuo1:12 blocked for more than 20 seconds.
[   41.187683] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[   41.196044] rcuo1           D c045c5d8     0    12      2 0x00000000
[   41.202911] [<c045c5d8>] (__schedule+0x8f4/0xa74) from [<c045c880>] (schedule+0x74/0x78)
[   41.211578] [<c045c880>] (schedule+0x74/0x78) from [<c00df138>] (rcu_nocb_kthread+0xdc/0x224)
[   41.220733] [<c00df138>] (rcu_nocb_kthread+0xdc/0x224) from [<c006d830>] (kthread+0xb0/0xbc)
[   41.229705] [<c006d830>] (kthread+0xb0/0xbc) from [<c00142c8>] (ret_from_fork+0x14/0x20)
[   41.238372] no locks held by rcuo1/12.
[   61.239868] INFO: task rcuo1:10 blocked for more than 20 seconds.
[   61.246337] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[   61.254730] rcuo1           D c045c5d8     0    10      2 0x00000000
[   61.261596] [<c045c5d8>] (__schedule+0x8f4/0xa74) from [<c045c880>] (schedule+0x74/0x78)
[   61.270294] [<c045c880>] (schedule+0x74/0x78) from [<c00df138>] (rcu_nocb_kthread+0xdc/0x224)
[   61.279357] [<c00df138>] (rcu_nocb_kthread+0xdc/0x224) from [<c006d830>] (kthread+0xb0/0xbc)
[   61.288391] [<c006d830>] (kthread+0xb0/0xbc) from [<c00142c8>] (ret_from_fork+0x14/0x20)
[   61.297058] no locks held by rcuo1/10.
[   61.301116] INFO: task rcuo1:12 blocked for more than 20 seconds.
[   61.307617] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[   61.315979] rcuo1           D c045c5d8     0    12      2 0x00000000
[   61.322845] [<c045c5d8>] (__schedule+0x8f4/0xa74) from [<c045c880>] (schedule+0x74/0x78)
[   61.331512] [<c045c880>] (schedule+0x74/0x78) from [<c00df138>] (rcu_nocb_kthread+0xdc/0x224)
[   61.340667] [<c00df138>] (rcu_nocb_kthread+0xdc/0x224) from [<c006d830>] (kthread+0xb0/0xbc)
[   61.349639] [<c006d830>] (kthread+0xb0/0xbc) from [<c00142c8>] (ret_from_fork+0x14/0x20)
[   61.358306] no locks held by rcuo1/12.
[   81.359863] INFO: task swapper/0:1 blocked for more than 20 seconds.
[   81.366638] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[   81.374999] swapper/0       D c045c5d8     0     1      0 0x00000000
[   81.381866] [<c045c5d8>] (__schedule+0x8f4/0xa74) from [<c045c880>] (schedule+0x74/0x78)
[   81.390563] [<c045c880>] (schedule+0x74/0x78) from [<c0459c0c>] (schedule_timeout+0x1e4/0x244)
[   81.399719] [<c0459c0c>] (schedule_timeout+0x1e4/0x244) from [<c0459c9c>] (schedule_timeout_uninterruptible+0x30/0x34)
[   81.411163] [<c0459c9c>] (schedule_timeout_uninterruptible+0x30/0x34) from [<c0057a98>] (msleep+0x24/0x30)
[   81.421508] [<c0057a98>] (msleep+0x24/0x30) from [<c0659d20>] (mount_root+0x74/0xfc)
[   81.429748] [<c0659d20>] (mount_root+0x74/0xfc) from [<c0659ed0>] (prepare_namespace+0x128/0x18c)
[   81.439270] [<c0659ed0>] (prepare_namespace+0x128/0x18c) from [<c044e35c>] (kernel_init+0x1cc/0x338)
[   81.449066] [<c044e35c>] (kernel_init+0x1cc/0x338) from [<c00142c8>] (ret_from_fork+0x14/0x20)
[   81.458282] no locks held by swapper/0/1.
[   81.462615] INFO: task rcuo1:10 blocked for more than 20 seconds.
[   81.469085] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[   81.477447] rcuo1           D c045c5d8     0    10      2 0x00000000
[   81.484313] [<c045c5d8>] (__schedule+0x8f4/0xa74) from [<c045c880>] (schedule+0x74/0x78)
[   81.493011] [<c045c880>] (schedule+0x74/0x78) from [<c00df138>] (rcu_nocb_kthread+0xdc/0x224)
[   81.502136] [<c00df138>] (rcu_nocb_kthread+0xdc/0x224) from [<c006d830>] (kthread+0xb0/0xbc)
[   81.511169] [<c006d830>] (kthread+0xb0/0xbc) from [<c00142c8>] (ret_from_fork+0x14/0x20)
[   81.519836] no locks held by rcuo1/10.
[   81.523834] INFO: task rcuo1:12 blocked for more than 20 seconds.
[   81.530364] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[   81.538696] rcuo1           D c045c5d8     0    12      2 0x00000000
[   81.545562] [<c045c5d8>] (__schedule+0x8f4/0xa74) from [<c045c880>] (schedule+0x74/0x78)
[   81.554229] [<c045c880>] (schedule+0x74/0x78) from [<c00df138>] (rcu_nocb_kthread+0xdc/0x224)
[   81.563354] [<c00df138>] (rcu_nocb_kthread+0xdc/0x224) from [<c006d830>] (kthread+0xb0/0xbc)
[   81.572387] [<c006d830>] (kthread+0xb0/0xbc) from [<c00142c8>] (ret_from_fork+0x14/0x20)
[   81.581054] no locks held by rcuo1/12.
[  101.579895] INFO: task rcuo1:10 blocked for more than 20 seconds.
[  101.586364] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  101.594757] rcuo1           D c045c5d8     0    10      2 0x00000000
[  101.601623] [<c045c5d8>] (__schedule+0x8f4/0xa74) from [<c045c880>] (schedule+0x74/0x78)
[  101.610290] [<c045c880>] (schedule+0x74/0x78) from [<c00df138>] (rcu_nocb_kthread+0xdc/0x224)
[  101.619384] [<c00df138>] (rcu_nocb_kthread+0xdc/0x224) from [<c006d830>] (kthread+0xb0/0xbc)
[  101.628417] [<c006d830>] (kthread+0xb0/0xbc) from [<c00142c8>] (ret_from_fork+0x14/0x20)
[  101.637084] no locks held by rcuo1/10.
[  101.641143] INFO: task rcuo1:12 blocked for more than 20 seconds.
[  101.647613] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  101.656005] rcuo1           D c045c5d8     0    12      2 0x00000000
[  101.662872] [<c045c5d8>] (__schedule+0x8f4/0xa74) from [<c045c880>] (schedule+0x74/0x78)
[  101.671539] [<c045c880>] (schedule+0x74/0x78) from [<c00df138>] (rcu_nocb_kthread+0xdc/0x224)
[  101.680664] [<c00df138>] (rcu_nocb_kthread+0xdc/0x224) from [<c006d830>] (kthread+0xb0/0xbc)
[  101.689636] [<c006d830>] (kthread+0xb0/0xbc) from [<c00142c8>] (ret_from_fork+0x14/0x20)
[  101.698303] no locks held by rcuo1/12.
[  112.400695] VFS: Unable to mount root fs via NFS, trying floppy.
[  112.407226] List of all partitions:
[  112.411041] No filesystem could mount root, tried:
[  112.416351] Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(2,0)
[  112.425262] CPU1: stopping
[  112.428161] [<c001dcb8>] (unwind_backtrace+0x0/0x104) from [<c0453cb8>] (dump_stack+0x20/0x24)
[  112.437316] [<c0453cb8>] (dump_stack+0x20/0x24) from [<c001b16c>] (handle_IPI+0xf4/0x154)
[  112.445983] [<c001b16c>] (handle_IPI+0xf4/0x154) from [<c0008600>] (gic_handle_irq+0x68/0x84)
[  112.455047] [<c0008600>] (gic_handle_irq+0x68/0x84) from [<c045df84>] (__irq_svc+0x44/0x58)
[  112.463897] Exception stack(0xeda29f68 to 0xeda29fb0)
[  112.469238] 9f60:                   00000001 00000001 00000000 eda20a80 eda28000 eda28000
[  112.477905] 9f80: c073d9c8 c06c0574 c0468c60 eda28000 c06c4f90 eda29fdc eda29f80 eda29fb0
[  112.486572] 9fa0: c00ab854 c00156fc 20000113 ffffffff
[  112.491943] [<c045df84>] (__irq_svc+0x44/0x58) from [<c00156fc>] (cpu_idle+0xac/0x128)
[  112.500366] [<c00156fc>] (cpu_idle+0xac/0x128) from [<c0450a1c>] (secondary_start_kernel+0xec/0x104)
[  112.510040] [<c0450a1c>] (secondary_start_kernel+0xec/0x104) from [<8044ff88>] (0x8044ff88)
PANIC: VFS: Unable to mount root fs on unknown-block(2,0)

---- End snipped ----

Do you have any suggestions for the best way of tracking down the cause?

Regards
Mats Liljegren
