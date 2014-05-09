From: arunks.linux@gmail.com (Arun KS)
Date: Fri, 9 May 2014 08:13:20 +0530
Subject: ARM: Disable preemption along with interrupts during shutdown
In-Reply-To: <20140508152220.GG3693@n2100.arm.linux.org.uk>
References: <1399555411-15330-1-git-send-email-arunks.linux@gmail.com>
 <20140508134910.GF3693@n2100.arm.linux.org.uk>
 <CAKZGPAMwqWP44Cv7V11Q+8Ykdt=3huFCRi-eKKSt5d9zPp8H+w@mail.gmail.com>
 <20140508152220.GG3693@n2100.arm.linux.org.uk>
Message-ID: <CAKZGPAN1FhoeZ9=QEkWrcJxQ6bAbx59gZyaT=iZXzWtZVB6O7w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 8, 2014 at 8:52 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, May 08, 2014 at 07:46:21PM +0530, Arun KS wrote:
>> What if we fall in a path which calls spin_unlock_irq().
>> Interrupts will get enabled and only preempt_count will help to bail
>> out early from preempt_schedule().
>> I recently hit a similar situation.
>
> Use of spin_lock_irq()..spin_unlock_irq() in code which was entered with
> interrupts already disabled is a bug in itself.
>
> Papering over it with preempt_disable() is not an option.  /Always/ fix
> the real problem, never paper over stuff like this.

Thanks Russell for your explanation.

During power onoff test, we hit the below scenario,
 #0 [<c072df48>] (__schedule) from [<c072e3a0>]
 #1 [<c072e3a0>] (preempt_schedule) from [<c072f244>]
 #2 [<c072f244>] (_raw_spin_unlock_irq) from [<c0394468>]
 #3 [<c0394468>] (__rpm_callback) from [<c03944b0>]
 #4 [<c03944b0>] (rpm_callback) from [<c03957bc>]
 #5 [<c03957bc>] (rpm_resume) from [<c0395d18>]
 #6 [<c0395d18>] (__pm_runtime_resume) from [<c04675b4>]
 #7 [<c04675b4>] (sh_mobile_i2c_xfer) from [<c0460390>]
 #8 [<c0460390>] (__i2c_transfer) from [<c0462094>]
 #9 [<c0462094>] (i2c_transfer) from [<c03b2738>]
 #10 [<c03b2738>] (d2153_i2c_write_device) from [<c03b08b0>]
 #11 [<c03b08b0>] (d2153_write) from [<c03b1574>]
 #12 [<c03b1574>] (d2153_reg_write) from [<c03b2490>]
 #13 [<c03b2490>] (d2153_system_poweroff) from [<c0011278>]
 #14 [<c0011278>] (machine_power_off) from [<c0047d58>]
 #15 [<c0047d58>] (kernel_power_off) from [<c0048420>]
 #16 [<c0048420>] (sys_reboot) from [<c0010240>]

I can fix this by adding pm_runtime_irq_safe(&dev->dev);

Thanks,
Arun

>
> --
> FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
> improving, and getting towards what was expected from it.
