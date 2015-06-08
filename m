From: dianders@chromium.org (Doug Anderson)
Date: Mon, 8 Jun 2015 13:52:15 -0700
Subject: [PATCH v3 2/3] ARM: rockchip: ensure CPU to enter WFI/WFE state
In-Reply-To: <55752067.2040108@rock-chips.com>
References: <1433517104-7595-1-git-send-email-wxt@rock-chips.com>
 <1433517104-7595-3-git-send-email-wxt@rock-chips.com>
 <CAD=FV=UMkFtOFYpY+MUZOegnmFLdW3ZgNivwdHChv0MLr50sVQ@mail.gmail.com>
 <20150605182947.GN7557@n2100.arm.linux.org.uk>
 <CAD=FV=UamkH+RHmHHVzGKZda_w0teGBdfcH-LbCKqyp2q1OVqA@mail.gmail.com>
 <55752067.2040108@rock-chips.com>
Message-ID: <CAD=FV=W3Ot0vymVguuE5YwENjmFVaFOxXoNODdu7UwzErGxTxA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Caesar,

On Sun, Jun 7, 2015 at 9:56 PM, Caesar Wang <wxt@rock-chips.com> wrote:
> OK.
> The dying processor to execute v7_exit_coherency_flush(),not that the dying
> processor to be in WFI/WFE.
>
> It's needed to enter WFI/WFE state from the ARM refer document when CPU
> down.
>
> But......
>
> Here is my test: (won't to enter the WFI state)
> @@ -331,8 +331,8 @@ static int rockchip_cpu_kill(unsigned int cpu)
>  static void rockchip_cpu_die(unsigned int cpu)
>  {
>         v7_exit_coherency_flush(louis);
> -       while (1)
> -               cpu_do_idle();
> +       while (1);
> +               //cpu_do_idle();
>  }
>
> echo 0 > /sys/module/printk/parameters/console_suspend
> echo 1 > /sys/power/pm_print_times
> echo mem > sys/power/state
>
> You can play anything
> or do some test for CPU up/down:
>
> cd /sys/devices/system/cpu/
> for i in $(seq 10000); do
>   echo "================= $i ============"
>   for j in $(seq 100); do
>     while [[ "$(cat cpu1/online)$(cat cpu2/online)$(cat cpu3/online)" !=
> "000" ]]; do
>
>       echo 0 > cpu1/online
>       echo 0 > cpu2/online
>       echo 0 > cpu3/online
>     done
>     while [[ "$(cat cpu1/online)$(cat cpu2/online)$(cat cpu3/online)" !=
> "111" ]]; do
>       echo 1 > cpu1/online
>       echo 1 > cpu2/online
>       echo 1 > cpu3/online
>     done
>   done
> done
> Sometimes,the system will be restart when do the about test.

I assume you meant the _above_ test.  So it sometimes works and
sometimes doesn't?  Strange...

> I'm no sure what's happen, That maybe abnormal won't to enter the WFI state.

Good test.  I think I understood what you said above: basically if you
don't get to the WFI state then the system will sometimes restart.

I guess that seems a little strange to me since I would have thought
that since you assert "reset" to the CPU before you power it off it
wouldn't matter a whole lot what state the system was in.  The
processor has exited concurrency and isn't touching any memory, so
nothing it does should be hurting anyone.  ...but I also am only
guessing about how all this works / trying to use common sense.  If we
really need to be in WFI/WFE then I guess that's what we need to do.

It still makes me nervous to say both that we "need to be in WFI" and
that we have a loop around cpu_do_idle().  The loop implies that
cpu_do_idle() might return sometimes.  That would be OK, except now
we've learned that if we happen to kill the CPU while we're executing
the loop that it might crash the system.  That's pretty non-ideal.  I
know the chances are incredibly unlikely, but still something that
worries me...


-Doug
