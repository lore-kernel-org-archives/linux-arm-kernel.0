From: dave.anglin@bell.net (John David Anglin)
Date: Fri, 21 Sep 2018 10:39:53 -0400
Subject: armada-37xx CPU rates are incorrectly set at 1 and 1.2 GHz
In-Reply-To: <87y3bvi1tt.fsf@bootlin.com>
References: <668ea8e4-7a77-54e3-d9e8-07d21ee31366@bell.net>
 <87y3bvi1tt.fsf@bootlin.com>
Message-ID: <5c642e9c-18c5-5c01-03c4-1d3851ba1358@bell.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-09-21 6:26 AM, Gregory CLEMENT wrote:
>> See benchmark the testing reported here:
>> https://forum.armbian.com/topic/4089-espressobin-support-development-efforts/?page=22&tab=comments#comment-60349
> I had a look on the forum and the issue is not really clear for me.
I have two espressobin cards which we are using to evaluate the Marvell 
CPU and switch for a design.

When CPU frequency scaling is enabled (CONFIG_ARM_ARMADA_37XX_CPUFREQ) 
and the
board boots at 1 GHz or 1.2 GHz, the effective CPU speed shown by the 
sbc-bench benchmark
is just under 800 MHz.? The bench performance at 1.2 GHz is actually 
slightly worse than at 1 GHz.

If one turns off CONFIG_ARM_ARMADA_37XX_CPUFREQ, the effective CPU speed 
agrees
with the speed set by u-boot.? I only checked this at 1 GHz as I don't 
have a 1.2 GHz board.

There is also a problem with the divider settings at 600 MHz:
-?????? {.cpu_freq_max = 600*1000*1000,? .divider = {2, 4, 5, 6} },
+?????? {.cpu_freq_max = 600*1000*1000,? .divider = {1, 1, 1, 1} },
The maximum speed is currently 300 MHz.? I changed it to 600 MHz for all 
settings.? The CPU didn't
want to shift down from 600 to 300 or 200.

There are some other things that might be clock related.? When running 
at 1 GHz for a period
of time, ntp loses lock on one board and can't sync.? The other doesn't 
lose lock but it develops
a large jitter (~ 30 ms).? When cold, the jitter is under 1 ms.? I put a 
heat sink on the CPU and
reduced the processor speed to 600 MHz.? This fixed the ntp jitter 
problem.? This might be a
thermal issue.? Maybe the oscillator or phase lock loop in the CPU 
develops a lot of jitter?

ptp4l is losing lock between the two cards.? It's also losing time stamps.

With some SD cards, board may hang after it finishes shutting down and 
not boot.
If it does reboot, the SD card may get a data CRC error in u-boot. 
Strangely, these errors
never occur when Linux is running.? Reports indicate that this problem 
is present for
several brands of SD cards.

>
> Could you first confirm that you use a mainline kernel?
Yes.
> Also which version do you use?
debian at espressobin:~$ uname -a
Linux espressobin 4.19.0-rc3+ #1 SMP PREEMPT Wed Sep 12 14:34:49 EDT 
2018 aarch64 GNU/Linux

The config file was derived from that used by Armbian stretch.

Dave

-- 
John David Anglin  dave.anglin at bell.net
