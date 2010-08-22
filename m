From: marek.vasut@gmail.com (Marek Vasut)
Date: Sun, 22 Aug 2010 11:52:54 +0200
Subject: pxa168 and LINUX_REBOOT_CMD_POWER_OFF
In-Reply-To: <AANLkTikdGoVwo6igAzf2xtPDvM3adwkfG_X-3AtKN=fU@mail.gmail.com>
References: <AANLkTikdGoVwo6igAzf2xtPDvM3adwkfG_X-3AtKN=fU@mail.gmail.com>
Message-ID: <201008221152.54485.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne Ne 22. srpna 2010 11:21:31 Jaya Kumar napsal(a):
> Hi Arm friends,
> 
> I have a quick question about pxa168 and implementing support for
> power off. I am playing with a pxa168 board (I think it might be based
> off Aspenite) that appears to have no power off support, ie: I see all
> the normal shutdown messages but nothing happens, even the console
> stays active. I see userspace send:
> 
> sys_reboot (... LINUX_REBOOT_CMD_POWER_OFF )
> 
> to which the kernel responds with:
> [   87.248429] System halted.
> 
> which is coming from:
> 
>  316void kernel_halt(void)
>  317{
>  318        kernel_shutdown_prepare(SYSTEM_HALT);
>  319        sysdev_shutdown();
>  320        printk(KERN_EMERG "System halted.\n");
>  321        machine_halt();
>  322}
> 
> I noticed that we have:
>  366        /* Instead of trying to make the power_off code look like
>  367         * halt when pm_power_off is not set do it the easy way.
>  368         */
>  369        if ((cmd == LINUX_REBOOT_CMD_POWER_OFF) && !pm_power_off)
>  370                cmd = LINUX_REBOOT_CMD_HALT;
>  371
> 
> which suggests that I'm missing pm_power_off which is why the command
> got demoted to a halt. I suppose the correct path it should take if we
> really want it to power off is:
> 
>  392        case LINUX_REBOOT_CMD_POWER_OFF:
>  393                kernel_power_off();
>  394                unlock_kernel();
>  395                do_exit(0);
>  396                break;
> 
> and looking in arch/arm/mach-mmp/ , I see that other board drivers
> implement pm_power_off handlers that use an EC to shutdown. But I
> don't think there is an EC on this board. There's a MAX8660 PMIC but
> I'm not sure that should be involved in shutdown. Coming back to
> Aspenite, I tried to figure out how it achieves shutdown and I don't
> see it having a pm_power_off. I don't have an aspenite board to
> compare with but I was wondering if shutdown works on it and if so,
> some pointers to code that is involved would help me figure out how to
> make shutdown work on this board. I'd appreciate any advice.

There's no "poweroff" support on ARM I believe. The kernel just hangs at certain 
point and that's all (and this can be overridden on some platforms).

Cheers
> 
> Thanks,
> jaya
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
