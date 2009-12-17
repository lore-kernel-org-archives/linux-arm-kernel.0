From: l.majewski@samsung.com (Lukasz Majewski)
Date: Thu, 17 Dec 2009 17:54:21 +0100
Subject: Regulator framework usage in suspend/resume contex.
Message-ID: <000301ca7f39$96047b60$c20d7220$%majewski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello all,

I'm trying to use the regulator framework in conjunction with suspend/resume
(code based on a s3c Samsung SoC platform).
My goal is to change values of regulators output before going to sleep and
restore their values after resume.

I use echo mem > /sys/power/state to suspend to RAM.
I've implemented platform_suspend_ops' .begin method and from it I'm calling
the regulator_suspend_prepare(state) function from regulator framework
(declared at include/linux/regulator/machine.h, defined at core.c).
After this step I'm going to sleep. And it seems that voltage values are
changed/disabled as they should (according to .constraints->.state_mem
struct fields).

The problem is when I disable normally enabled source or change its voltage
value to new_value when entering the suspend to RAM state.

.state_mem      = {
	.enabled= 0,
},

Or

.state_mem      = {
	.uV= new_value,
	.enabled= 1,
},

I don't know how to enable this source again after resume or restore source
microvolts setting as before suspend?

As I suppose, the preferred place for performing this would be a .finish
method from platform_suspend_ops' structure (declared in
include/linux/suspend.h).

It looks like some relevant method is missing in the framework, or I haven't
look deep enough to spot one :-).

One possible workaround would be to reinitialize all regulators with
regulator_init_complete(void) function, but I'm not sure if then old
microvolt settings would be restored. Probably not...
Does anybody have any idea how to solve this problem?

I was grepping a little and it looks, that regulator_suspend_prepare()
method is not used by any suspend/resume driver in the kernel linux tree (at
least up to kernel version 2.6.32-rc8), so there is no reference code.



Thanks in advance,
Lukasz Majewski
