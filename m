From: dianders@google.com (Doug Anderson)
Date: Fri, 6 Jun 2014 16:03:50 -0700
Subject: Problems booting exynos5420 with >1 CPU
In-Reply-To: <alpine.LFD.2.11.1406061836130.25775@knanqh.ubzr>
References: <539145B4.5000200@gmail.com>
 <CAD=FV=XqwEQNJmij-4Gh62OY+B66AjdQjZC0=f_6tbot3UfQaA@mail.gmail.com>
 <CAM4voaknx3+X4O8MUwaruUFPyquY8Opq61ucKX08xTrv8PqfLg@mail.gmail.com>
 <CAD=FV=Vo1JR6n496Q3FqXjRBkbTBRg89_fJQNsqeRx8WQW_a9w@mail.gmail.com>
 <CAM4voakAMN4jdAZDPz55tnc3woZDieZ5aL3TVU2kYsNHT+AMqg@mail.gmail.com>
 <CAD=FV=UjmN5AwWMPy7mQt-J4A_niO8Ug4r15Ez2ZWPT1g3L=VA@mail.gmail.com>
 <20140606203721.GA10422@quad.lixom.net>
 <CAM4voanSpTd=dAXLZhdZKRP4Z_YShbD4Hr-6UWn3DFYueoxeTA@mail.gmail.com>
 <20140606210126.GA10219@quad.lixom.net>
 <alpine.LFD.2.11.1406061717520.25775@knanqh.ubzr>
 <20140606214921.GA10969@quad.lixom.net>
 <CAD=FV=WSEBRH-Py8oGXp0soAx_Y=j8NdoX89YiPGYeTBzQdOyw@mail.gmail.com>
 <alpine.LFD.2.11.1406061836130.25775@knanqh.ubzr>
Message-ID: <CAD=FV=WWNs7wQCjthmtGrRh=rB5jZo448c55D+WVtxKZ_iJC8w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolas,

On Fri, Jun 6, 2014 at 3:38 PM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Fri, 6 Jun 2014, Doug Anderson wrote:
>
>> Note that handling CPU resume in a way that can be updated by RW
>> firmware is non-trivial and requires some SRAM to be saved across
>> suspend/resume.
>
> Saved by the kernel or the firmware?

By the SoC / board.

The problem on the original ARM Chromebook:

1. After resume, the boot CPU comes up just as if it were booting from
a cold boot.  All clocks are back at their default and the SDRAM
controller is no longer initted.  SDRAM is sitting in self refresh.

2. CPU loads boot code from SPI flash.

3. Boot code needs to be read only for security reasons.  You can have
RW updates for some portion of boot code, but only the part _after_
clock init (needed for SDRAM), SDRAM reinit, cache init.  That's
because you need those parts to (quickly) run crypto verification
code.


If the SoC / board can keep its internal SRAM powered across suspend
resume you've got an out.  Now you can have the firmware stash its
"wakeup" code into a location in SRAM.  At wakeup time you can jump
straight there and that code can worry about everything.  Now a
read-write firmware update can update the wakeup code and you're all
set.  In this case wakeup code doesn't survive a full power cycle /
reboot so you don't need any extra verification like you do if you
load from persistent storage.


That all still means you need to qualify a rw firmware update, but
that's better than nothing.

-Doug
