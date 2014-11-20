From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 20 Nov 2014 09:49:00 +0100
Subject: [PATCH v4] clocksource: arch_timer: Fix code to use physical
 timers when requested
In-Reply-To: <1412753937-29343-1-git-send-email-sonnyrao@chromium.org>
References: <1412753937-29343-1-git-send-email-sonnyrao@chromium.org>
Message-ID: <20141120084900.GC24143@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Oct 08, 2014 at 12:38:57AM -0700, Sonny Rao wrote:
> This is a bug fix for using physical arch timers when
> the arch_timer_use_virtual boolean is false.  It restores the
> arch_counter_get_cntpct() function after removal in
> 
> 0d651e4e "clocksource: arch_timer: use virtual counters"
> 
> We need this on certain ARMv7 systems which are architected like this:
> 
> * The firmware doesn't know and doesn't care about hypervisor mode and
>   we don't want to add the complexity of hypervisor there.
> 
> * The firmware isn't involved in SMP bringup or resume.
> 
> * The ARCH timer come up with an uninitialized offset between the
>   virtual and physical counters.  Each core gets a different random
>   offset.
> 
> * The device boots in "Secure SVC" mode.
> 
> * Nothing has touched the reset value of CNTHCTL.PL1PCEN or
>   CNTHCTL.PL1PCTEN (both default to 1 at reset)
> 
> One example of such as system is RK3288 where it is much simpler to
> use the physical counter since there's nobody managing the offset and
> each time a core goes down and comes back up it will get reinitialized
> to some other random value.
> 
> Fixes: 0d651e4e65e9 ("clocksource: arch_timer: use virtual counters")
> Cc: stable at vger.kernel.org
> Signed-off-by: Sonny Rao <sonnyrao@chromium.org>
> Acked-by: Olof Johansson <olof@lixom.net>

Has this been merged yet?

If not, you can add my Tested-by, it makes the Allwinner A31 boot
flawlessly with the arch timers (together with the patch "clocksource:
arch_timer: Allow the device tree to specify uninitialized timer
registers")

Thanks!
Maxime

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141120/1344830f/attachment.sig>
