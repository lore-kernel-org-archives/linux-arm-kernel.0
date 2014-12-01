From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Mon, 01 Dec 2014 18:25:23 +0100
Subject: [PATCH] tty: serial: serial-omap: depend on !8250_omap
In-Reply-To: <20141201163813.GA2817@atomide.com>
References: <1417039306-2384-1-git-send-email-bigeasy@linutronix.de>
 <20141129094823.GA10840@linutronix.de> <20141129173418.GY2817@atomide.com>
 <20141201140914.728aaa46@lxorguk.ukuu.org.uk>
 <20141201163813.GA2817@atomide.com>
Message-ID: <547CA483.3070801@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/01/2014 05:38 PM, Tony Lindgren wrote:
> * One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk> [141201 06:11]:
>>> Well the nightmare userspace switch from ttyS to ttyO few years ago is
>>> something we want to avoid.. I think the best solution would be to make
>>> serial-omap.c transparently provide support for ttyO using the new 8250
>>> code so both ttyS and ttyO devices would just work. Otherwise it will
>>> be years of "my serial port stopped working" questions again.
>>
>> Thata a udev problem not a kernel one surely.
> 
> How do you suggest we get people to update their kernel command line
> and inittab? Udev may not even be installed.

There are three use cases that I can think of right now:
- people that enable that new driver via oldconfig
  I would expect that they read the help message in Kconfig. No worry
  about them.

- people that get a complete system via magic_build_tool (may yocto or
  whatever)
  If $TOOL decides to use the new driver, then it should update
  commandline in bootloader. Those things create usually bootloader +
  kernel + rootfile system. If the commandline is saved on flash/mmc
  then it won't be reset from default. However udev should help here.
  So not a problem either (udev can't fix the kernel boot output but we
  should see atleast the login console).

- people that build omap2plus_defconfig and we switch to the new driver
  Those people get switched from one driver to the other without
  knowing. This is what I tried to bring to everyone's attention. The
  defconfig hasn't been changed yet so it is not problem for next
  release (yet).

I agree that this is a user problem. We agreed not to introduce a
console proxy in kernel _or_ hack the command line in kernel (to
replace O with S).
So I think the problem boils down to educate the user about this
change. Making the old driver disappear was one way of getting the
user's attention. Another idea would be to introduce a #warning which is
also activated by the defconfig and informs the user about the change.
Ideally this #warning could be switched off by Kconfig once the user
reads & deactivates it. This requires the pay attention to warnings
during build. #error would make sure he does but it breaks auto-builds
so it is not an option.

> Regards,
> 
> Tony
> 

Sebastian
