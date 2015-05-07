From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 07 May 2015 14:48:39 +0200
Subject: [Discussion] how to implement external power down for ARM
In-Reply-To: <CAFEAcA_EJSm_OHxsGvDfydacHHz=RcvrHHCg_LEFpLCBUxHmtA@mail.gmail.com>
References: <55417F5A.4040300@linaro.org> <554B5830.2090600@huawei.com>
 <CAFEAcA_EJSm_OHxsGvDfydacHHz=RcvrHHCg_LEFpLCBUxHmtA@mail.gmail.com>
Message-ID: <2710086.QZJtQiM3YX@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 07 May 2015 13:34:10 Peter Maydell wrote:
> On 7 May 2015 at 13:18, Shannon Zhao <zhaoshenglong@huawei.com> wrote:
> > On 2015/5/7 20:12, Peter Maydell wrote:
> >> On 7 May 2015 at 13:10, Shannon Zhao <zhaoshenglong@huawei.com> wrote:
> >>> BTW, IIUC QEMU doesn't support the gracefully reboot support. The reboot
> >>> depends on libvirt or other management tools. So the reboot case in
> >>> virtualization is firstly poweroff, then start again.
> >>
> >> I'm not sure what you mean by this -- QEMU supports 'reset this
> >> VM' at the machine emulation level, so if we can tell the guest
> >> to reboot then it should as part of this process issue the
> >> PSCI SYSTEM_RESET command, which QEMU/KVM will then handle
> >> to do a reset of the VM.
> 
> > Yes, QEMU supports reset, but doesn't support (gracefully) reboot.
> 
> Isn't that what this ACPI work is about? Tell the guest to initiate
> a graceful reboot, and then the guest will tell QEMU to reboot
> the emulated h/w when it's ready.
> 

The problem here is user space: acpid only listens for KEY_POWER
events, not KEY_RESTART. This means graceful shutdown works as
expected, but graceful reboot requires a process that listens
to the input device and calls /sbin/reboot if it KEY_RESTART
appears. I think that can be done by adding a configuration file
in /etc/acpi/events/, but it's not there by default because PCs
only have a power button and no reset button (they use CTRL+ALT+DEL
on the keyboard for that).

	Arnd
