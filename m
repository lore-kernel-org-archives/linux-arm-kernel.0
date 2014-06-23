From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 23 Jun 2014 18:32:46 +0200
Subject: [PATCH V2 0/2] Sound support for Exynos4412 Odroid X2, U3 board
In-Reply-To: <CAD8Lp44h6zc2Rt2MGLjhmNG-YB0kYCWf5G7hX5JmdmBfc1PvKg@mail.gmail.com>
References: <1403108551-25058-1-git-send-email-s.nawrocki@samsung.com>
 <CAD8Lp44h6zc2Rt2MGLjhmNG-YB0kYCWf5G7hX5JmdmBfc1PvKg@mail.gmail.com>
Message-ID: <53A856AE.1030202@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/06/14 11:40, Daniel Drake wrote:
> I tested ODROID-U2's 3.5mm analog headphone jack output with:
> 
> # speaker-test -c 2 -t wav -l 2
> 
> On my x86 laptop this command takes ~6 seconds and produces audible output:
> "Front left, front right, front left, front right"
> 
> When those words are reproduced over the speakers, there is a
> corresponding message printed to stdout which synchronizes nicely.
> 
> On ODROID-U2 the same command doesn't work quite right - execution
> takes only 3.5 seconds and the audible output is truncated:
> "Front left, front right, front"
> and the stdout messages do not really coincide with the audio being
> reproduced at that time.
> 
> No pulseaudio or anything like that.
> 
> Can you reproduce this?

I could reproduce such behaviour on the U3 board, but only with u-boot
which sets the MPLL clock frequency (fout_mpll) to 880 MHz, rather
than 800 MHz, which was the case in my original environment.
All fout_mpll child clocks have then different frequency values
in both cases.
It's a bit strange though, because frequencies of all the audio
subsystem clocks seem to be same anyway:

# cat /sys/kernel/debug/clk/clk_summary
    ...
    fout_epll                   0           0            192000000
       mout_audss               0           0            192000000
          dout_rp               0           0            19200000
             dout_aud_bus       0           0            19200000
          mout_i2s0             0           0            192000000
             dout_i2s0          0           0            192000000
       sclk_epll                0           0            192000000
          audss                 0           0            192000000

So there might be some other difference I'm overlooking.
Will let you know as soon I find out anything else.

Regards,
Sylwester
