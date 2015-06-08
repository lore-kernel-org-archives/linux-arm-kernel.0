From: wxt@rock-chips.com (Caesar Wang)
Date: Mon, 08 Jun 2015 12:56:07 +0800
Subject: [PATCH v3 2/3] ARM: rockchip: ensure CPU to enter WFI/WFE state
In-Reply-To: <CAD=FV=UamkH+RHmHHVzGKZda_w0teGBdfcH-LbCKqyp2q1OVqA@mail.gmail.com>
References: <1433517104-7595-1-git-send-email-wxt@rock-chips.com>	<1433517104-7595-3-git-send-email-wxt@rock-chips.com>	<CAD=FV=UMkFtOFYpY+MUZOegnmFLdW3ZgNivwdHChv0MLr50sVQ@mail.gmail.com>	<20150605182947.GN7557@n2100.arm.linux.org.uk>
 <CAD=FV=UamkH+RHmHHVzGKZda_w0teGBdfcH-LbCKqyp2q1OVqA@mail.gmail.com>
Message-ID: <55752067.2040108@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2015?06?06? 04:24, Doug Anderson ??:
> Russell,
>
> On Fri, Jun 5, 2015 at 11:29 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> 1) v7_coherency_exit() is specific to v7 CPUs and can't be used by
>>     generic code.
> Oh, I see.  So (I think) you're saying that perhaps the reason that
> Caesar needed his patch was that he needed the dying processor to
> execute v7_exit_coherency_flush(), NOT that he needed the dying
> processor to be in WFI/WFE.  That actually makes a lot more sense to
> me!  :)  Thanks a lot for pointing that out, it's very helpful.
>
>
>> So, we're actually in a very sticky position over taking CPUs offline.
>> It seems to be something that the ARM architecture and kernel
>> architecture doesn't actually allow to be done safely.  So much so,
>> that in a similar way to the original Keystone 2 physical address
>> switch, I'm tempted to make taking a CPU offline taint the kernel!
> Wow, that's going to suck.  So if you want to suspend / resume you
> need to taint your kernel.  So much for saving the planet by going
> into suspend...  ...or are you thinking that it won't taint the kernel
> when the kernel takes CPUs offline for suspend/resume purposes?  ...or
> are you thinking you've some solution that works for suspend/resume
> that doesn't work for the general cpu offlining problem?  I'd be very
> interested to hear...
>
>
> I know I'm not a maintainer, but if I were and I knew that lots of
> smart people had thought about the problem of CPU offlining and they
> didn't have a solution and I could make my platform 99.99999999%
> reliable by allowing a very safe mdelay(1) where I had a pretty strong
> guarantee that the 1ms was enough time, I would probably accept that
> code...
>
>
> So since I'm not a maintainer and I certainly couldn't ack such code,
> I would certainly be happy to add my Reviewed-by to Caesar's patch if
> he changed it mention that he needed to make sure that
> v7_exit_coherency_flush() in rockchip_cpu_die() executed in time.

OK.
The dying processor to execute v7_exit_coherency_flush(),not that the 
dying processor to be in WFI/WFE.

It's needed to enter WFI/WFE state from the ARM refer document when CPU 
down.

But......

Here is my test: (won't to enter the WFI state)
@@ -331,8 +331,8 @@ static int rockchip_cpu_kill(unsigned int cpu)
  static void rockchip_cpu_die(unsigned int cpu)
  {
         v7_exit_coherency_flush(louis);
-       while (1)
-               cpu_do_idle();
+       while (1);
+               //cpu_do_idle();
  }

echo 0 > /sys/module/printk/parameters/console_suspend
echo 1 > /sys/power/pm_print_times
echo mem > sys/power/state

You can play anything
or do some test for CPU up/down:

cd /sys/devices/system/cpu/
for i in $(seq 10000); do
   echo "================= $i ============"
   for j in $(seq 100); do
     while [[ "$(cat cpu1/online)$(cat cpu2/online)$(cat cpu3/online)" 
!= "000" ]]; do

       echo 0 > cpu1/online
       echo 0 > cpu2/online
       echo 0 > cpu3/online
     done
     while [[ "$(cat cpu1/online)$(cat cpu2/online)$(cat cpu3/online)" 
!= "111" ]]; do
       echo 1 > cpu1/online
       echo 1 > cpu2/online
       echo 1 > cpu3/online
     done
   done
done
Sometimes,the system will be restart when do the about test.
I'm no sure what's happen, That maybe abnormal won't to enter the WFI 
state.

>
> -Doug
>
>
>

-- 
Thanks,
- Caesar
