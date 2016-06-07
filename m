From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 7 Jun 2016 09:13:54 +0200
Subject: [PATCH 07/13] ARM: dts: r8a7792: initial SoC device tree
In-Reply-To: <fdab2628-60bd-c41b-296b-38cd71a6c5da@cogentembedded.com>
References: <13205049.n7pM8utpHF@wasted.cogentembedded.com>
 <2539026.OyU5nvpxa6@wasted.cogentembedded.com>
 <20160601005751.GG20527@verge.net.au>
 <fdab2628-60bd-c41b-296b-38cd71a6c5da@cogentembedded.com>
Message-ID: <CAMuHMdUkOpEp+YCbZVZppdN4C7KKpDS9_gEuXi_WKZXM9YHgEQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Tue, Jun 7, 2016 at 12:26 AM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
>> With regards to SMP. Have you checked to make sure CPU hotplug works
>> on all CPUs?
>
>    How to test the CPU hotplug? I've now added the SMP support and made sure
> both CPUs are online and serve IRQs...

Off/online all CPUs:

    for i in /sys/*/*/cpu/cpu[0-9]*; do echo 0 > $i/online; echo 1 >
$i/online; done

Offline all CPUs:

    for i in /sys/*/*/cpu/cpu[0-9]*; do echo 0 > $i/online; done; cat
/proc/cpuinfo

Online all CPUs:

   for i in /sys/*/*/cpu/cpu[0-9]*; do echo 1 > $i/online; done; cat
/proc/cpuinfo

>> And that the system behaves sanely on suspend/resume.
>
>    I'd be thankful if you told me how to test that. :-)

System suspend:

    echo mem > /sys/power/state

System resume: You're gonna need a "wakeup-source" in your DTS, e.g. gpio-keys.
Serial should work too, echo "enabled" to the corresponding wakeup
file in /sys first.

In case of issues, try "echo 0 > /sys/module/printk/parameters/console_suspend".

Good luck!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
