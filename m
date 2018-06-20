From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 21 Jun 2018 00:07:34 +0100
Subject: Dynamic ftrace self test broken on ARM
In-Reply-To: <ac0178fb75658a8d7d7b1931691c7755@agner.ch>
References: <65fb14b356bc0a414f1fe5cf5c6eb395@agner.ch>
 <20180618175437.3e6c85a1@gandalf.local.home>
 <b9f269ed2143688c38cdcbba7367b101@agner.ch>
 <20180619091735.7aec75d0@gandalf.local.home>
 <5e26cebbb2ebeb87fdc808509881736b@agner.ch>
 <20180620101311.0bcd73d3@gandalf.local.home>
 <7904ed3fe9f59a54526d64f366915b43@agner.ch>
 <e4181ae694d44913a8eba4618477bd3b@agner.ch>
 <ac0178fb75658a8d7d7b1931691c7755@agner.ch>
Message-ID: <20180620230734.GO17671@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 21, 2018 at 12:45:04AM +0200, Stefan Agner wrote:
> On 20.06.2018 23:32, Stefan Agner wrote:
> > On 20.06.2018 21:06, Stefan Agner wrote:
> >> On 20.06.2018 16:13, Steven Rostedt wrote:
> >>> On Wed, 20 Jun 2018 15:51:55 +0200
> >>> Stefan Agner <stefan@agner.ch> wrote:
> >>>
> >>>
> >>>> v4.9 seems to work, so I started bisecting. It turned out that commit
> >>>> 6f05d0761af6 ("ARM: 8668/1: ftrace: Fix dynamic ftrace with DEBUG_RODATA
> >>>> and !FRAME_POINTER") broke it, introduced during the v4.12 merge window.
> >>>
> >>> That patch doesn't appear to be the cause. It could have been a failed
> >>> bisect. Does the commit before that commit work? Does that commit fail?
> >>
> >> Pretty sure it is that one. Reverting it on top of v4.18-rc1 fixes it...
> >>
> >>>
> >>> It may be due to some other RODATA change though. That is actually one
> >>> of my thoughts when looking at the bug.
> >>
> >> CONFIG_STRICT_KERNEL_RWX=y is set, will test without.
> > 
> > Compiling without CONFIG_STRICT_KERNEL_RWX fixes the issue too. So seems
> > to be a RODATA issue...
> 
> Ok, I understand the issue now:
> 
> In ARM ftrace we set kernel text to RW and back to RO in
> arch_ftrace_update_code.
> 
> ARM sets the kernel at free_initmem to RO. So using ftrace selftest sets
> the kernel text to RO much earlier, which seems to cause issues.
> 
> Reverting the above commit actually fixes selftests during boot, but it
> breaks ftrace at runtime...
> 
> This resolves the issue:
> 
> +static int __ftrace_modify_code_boot(void *data)
> +{
> +       int *command = data;
> +
> +       ftrace_modify_all_code(*command);
> +
> +       return 0;
> +}
> +
>  void arch_ftrace_update_code(int command)
>  {
> -       stop_machine(__ftrace_modify_code, &command, NULL);
> +       if (system_state < SYSTEM_RUNNING)
> +               stop_machine(__ftrace_modify_code_boot, &command, NULL);
> +       else
> +               stop_machine(__ftrace_modify_code, &command, NULL);
>  }
> 
> Using system_state to indicate whether fix_kernmem_perms has been called
> is rather brittle...
> 
> Any input from ARM folks?

The same issues must exist on other architectures as ARM is not the only
architecture to implement read-only kernel text and dynamic ftrace, so
surely this problem isn't unique to ARM.

It looks to me like x86 sets ARCH_HAS_STRICT_KERNEL_RWX, so surely the
kernel text there is protected against modification of the kernel text.
x86 seems to use probe_kernel_write() in the ftrace code, but I don't
see how that would succeed with ARCH_HAS_STRICT_KERNEL_RWX.  Does
dynamic ftrace work on x86, if so, how?

It looks like powerpc also supports the combination, but again I don't
see anything obvious that suggests how it gets around the kernel text
read-only-ness.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
