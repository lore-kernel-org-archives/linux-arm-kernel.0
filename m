From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sat, 19 May 2018 13:50:05 +0200 (CEST)
Subject: [RESEND][PATCH] pwm: Set class for exported channels in sysfs
In-Reply-To: <c1b6b62e-8fcb-bff0-b532-aa0879d301ed@st.com>
References: <20170926115951.GA29367@sukzessiv.net>
 <c1b6b62e-8fcb-bff0-b532-aa0879d301ed@st.com>
Message-ID: <492690429.60492.1526730605765@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Fabrice,

> Fabrice Gasnier <fabrice.gasnier@st.com> hat am 30. M?rz 2018 um 14:40 geschrieben:
> 
> 
> On 09/26/2017 01:59 PM, gohai at sukzessiv.net wrote:
> > Notifications for devices without bus or class set get dropped by
> > dev_uevent_filter. Adding the class to the exported child matches
> > what the gpio subsystem is doing.
> > 
> > With this change exporting a channel triggers a udev event, which
> > gives userspace a chance to fixup permissions and makes it possible
> > for non-root users to make use of the pwm subsystem.
> > 
> > Signed-off-by: Gottfried Haider <gottfried.haider@gmail.com>
> > CC: Thierry Reding <thierry.reding@gmail.com>
> > CC: H Hartley Sweeten <hsweeten@visionengravers.com>
> > CC: linux-pwm at vger.kernel.org
> > CC: linux-arm-kernel at lists.infradead.org
> > CC: linux-rpi-kernel at lists.infradead.org
> > ---
> >  drivers/pwm/sysfs.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
> > index a813239..83f2b0b 100644
> > --- a/drivers/pwm/sysfs.c
> > +++ b/drivers/pwm/sysfs.c
> > @@ -263,6 +263,7 @@ static int pwm_export_child(struct device *parent, struct pwm_device *pwm)
> >         export->pwm = pwm;
> >         mutex_init(&export->lock);
> > 
> > +       export->child.class = parent->class;
> 
> Hi all,
> 
> Sorry to raise this old mail thread. I just figured out this patch is
> causing *regression* on v4.16-rcs.
> 
> This patch has side effect at my end, with multiple pwm chip. It creates
> a new entry in '/sys/class/pwm' every time a 'pwmX' is exported:
> - echo X > export
> 
> This breaks pwm on platforms that have multiple pwmchip:
> - 1st time export will create a /sys/class/pwm/pwmX
> - when another export happens on another pwmchip, it can't be created
> (e.g. -EEXIST)
> 
> I looked at /Documentation/ABI/testing/sysfs-class-pwm:
> - pmwX should be there: /sys/class/pwm/pwmchipN/pwmX (only ?)
> 
> With this patch:
> - pwmX symlink is created in addition, directly under /sys/class/pwm
> 
> Example on stm32 (stm32429i-eval) platform:
> ---
> $ ls /sys/class/pwm
> pwmchip0 pwmchip4
> 
> $ cd /sys/class/pwm/pwmchip0/
> $ echo 0 > export
> 
> $ ls /sys/class/pwm
> pwm0 pwmchip0 pwmchip4
> 
> $ cd /sys/class/pwm/pwmchip4/
> $ echo 0 > export
> 
> sysfs: cannot create duplicate filename '/class/pwm/pwm0'
> CPU: 0 PID: 50 Comm: sh Not tainted 4.16.0-rc7-00020-g3361545 #1682
> Hardware name: STM32 (Device Tree Support)
> [<0000c0f1>] (unwind_backtrace) from [<0000b23b>] (show_stack+0xb/0xc)
> [<0000b23b>] (show_stack) from [<0008d2f1>] (sysfs_warn_dup+0x31/0x48)
> [<0008d2f1>] (sysfs_warn_dup) from [<0008d4a5>]
> (sysfs_do_create_link_sd+0x75/0x88)
> [<0008d4a5>] (sysfs_do_create_link_sd) from [<000e8e91>]
> (device_add+0x111/0x374)
> [<000e8e91>] (device_add) from [<000ca795>] (export_store+0xb5/0x12c)
> [<000ca795>] (export_store) from [<0008c899>] (kernfs_fop_write+0x87/0xda)
> [<0008c899>] (kernfs_fop_write) from [<0005a0a5>] (__vfs_write+0x1d/0xcc)
> [<0005a0a5>] (__vfs_write) from [<0005a1c7>] (vfs_write+0x4f/0x7c)
> [<0005a1c7>] (vfs_write) from [<0005a29b>] (SyS_write+0x33/0x70)
> [<0005a29b>] (SyS_write) from [<00009001>] (ret_fast_syscall+0x1/0x58)
> Exception stack...
> -sh: write error: File exists
> 
> Not sure what the best fix would be thought :-(
> 
> probably pwmX should be named also according with pwmchipN ?
> - dev_set_name(&export->child, "pwm%u", pwm->hwpwm);
> + dev_set_name(&export->child, "pwmchip%d-pwm%u", chip->base, pwm->hwpwm);
> BUT I think this would break existing ABI...
> 
> Also this is quite late in the cycle. Maybe a revert would be wise for now ?

sorry i didn't noticed your mail before. Could you please prepare a revert patch?

Thanks
Stefan
