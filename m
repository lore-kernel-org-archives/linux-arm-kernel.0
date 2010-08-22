From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Sun, 22 Aug 2010 23:01:26 +0800
Subject: pxa168 and LINUX_REBOOT_CMD_POWER_OFF
In-Reply-To: <AANLkTikdxhpwF637joeyRcbNd1CuU4-pKh6EPETDw1_v@mail.gmail.com>
References: <AANLkTikdGoVwo6igAzf2xtPDvM3adwkfG_X-3AtKN=fU@mail.gmail.com>
	<AANLkTikdxhpwF637joeyRcbNd1CuU4-pKh6EPETDw1_v@mail.gmail.com>
Message-ID: <AANLkTikn_0=w07d=zkPk0nn4r7m6jzBKGaMKkc4dKdmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 22, 2010 at 6:43 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
> On Sun, Aug 22, 2010 at 5:21 PM, Jaya Kumar <jayakumar.lkml@gmail.com> wrote:
>> Hi Arm friends,
>>
>> I have a quick question about pxa168 and implementing support for
>> power off. I am playing with a pxa168 board (I think it might be based
>> off Aspenite) that appears to have no power off support, ie: I see all
>> the normal shutdown messages but nothing happens, even the console
>> stays active. I see userspace send:
>>
>> sys_reboot (... LINUX_REBOOT_CMD_POWER_OFF )
>>
>> to which the kernel responds with:
>> [ ? 87.248429] System halted.
>>
>> which is coming from:
>>
>> ?316void kernel_halt(void)
>> ?317{
>> ?318 ? ? ? ?kernel_shutdown_prepare(SYSTEM_HALT);
>> ?319 ? ? ? ?sysdev_shutdown();
>> ?320 ? ? ? ?printk(KERN_EMERG "System halted.\n");
>> ?321 ? ? ? ?machine_halt();
>> ?322}
>>
>> I noticed that we have:
>> ?366 ? ? ? ?/* Instead of trying to make the power_off code look like
>> ?367 ? ? ? ? * halt when pm_power_off is not set do it the easy way.
>> ?368 ? ? ? ? */
>> ?369 ? ? ? ?if ((cmd == LINUX_REBOOT_CMD_POWER_OFF) && !pm_power_off)
>> ?370 ? ? ? ? ? ? ? ?cmd = LINUX_REBOOT_CMD_HALT;
>> ?371
>>
>> which suggests that I'm missing pm_power_off which is why the command
>> got demoted to a halt. I suppose the correct path it should take if we
>> really want it to power off is:
>>
>> ?392 ? ? ? ?case LINUX_REBOOT_CMD_POWER_OFF:
>> ?393 ? ? ? ? ? ? ? ?kernel_power_off();
>> ?394 ? ? ? ? ? ? ? ?unlock_kernel();
>> ?395 ? ? ? ? ? ? ? ?do_exit(0);
>> ?396 ? ? ? ? ? ? ? ?break;
>>
>> and looking in arch/arm/mach-mmp/ , I see that other board drivers
>> implement pm_power_off handlers that use an EC to shutdown. But I
>> don't think there is an EC on this board. There's a MAX8660 PMIC but
>> I'm not sure that should be involved in shutdown. Coming back to
>> Aspenite, I tried to figure out how it achieves shutdown and I don't
>> see it having a pm_power_off. I don't have an aspenite board to
>> compare with but I was wondering if shutdown works on it and if so,
>> some pointers to code that is involved would help me figure out how to
>> make shutdown work on this board. I'd appreciate any advice.
>
> Yes, normally have to use an external EC for shutdown. And I believe
> it isn't implemented in the version of aspenite.c in mainline, probably a
> good idea to check Marvell's latest release on their extranet.
>
> And I believe power off normally means deep-sleep for PXA processor
> without an EC.
>
> Haojian,
>
> Can we help check this?
>

Before talking about power off state, I need to clarify some
background. Max8660 is a PMIC compatible with PXA3xx series. And
there's no EC to control power on Aspenite board.

There's all eight power domains can be controlled by max8660. V1~V5 is
controlled by SYS_EN signal. V6 & V7 is controlled by I2C bus. V8 is
VCC_BBATT domain that should be always ON. So we can't shutdown all
power on Aspenite since V8 shoudl be always ON.

So the key is SYS_EN. In Aspenite board, one signal of GPIO expander
is named EXP2_SYS_DIS_N. If we put this signal to low, the SYS_EN
signal will do a negative transition.

In marvell's reference code, we didn't implement power off mode in
Aspenite board. We implemented system hibernation mode that is used to
save information to DDR and shutdown most of power of board. If you
like, you can control EXP2_SYS_DIS_N signal to implement your power
off mode. One thing should be noticed, there's still a little power
consumption on Aspenite board even this signal is controlled to low.
So there's no purely power off mode in Aspenite board.

Thanks
Haojian
