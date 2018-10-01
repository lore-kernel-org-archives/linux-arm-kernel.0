From: michal.vokac@ysoft.com (=?UTF-8?B?TWljaGFsIFZva8OhxI0=?=)
Date: Mon, 1 Oct 2018 18:29:25 +0200
Subject: [PATCH v2 2/2] pwm: send a uevent on the pwmchip device upon
 channel sysfs (un)export
In-Reply-To: <1538400237-28766-3-git-send-email-fabrice.gasnier@st.com>
References: <1538400237-28766-1-git-send-email-fabrice.gasnier@st.com>
 <1538400237-28766-3-git-send-email-fabrice.gasnier@st.com>
Message-ID: <b43c5dd5-6ffd-5e5a-f4d0-86792feac304@ysoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1.10.2018 15:23, Fabrice Gasnier wrote:
> This patch sends a uevent (KOBJ_CHANGE) on the pwmchipN device, everytime
> a pwmX channel has been exported/unexported via sysfs.
> This allows udev to implement rules on such events, like:
> 
> SUBSYSTEM=="pwm*", PROGRAM="/bin/sh -c '\
>          chown -R root:gpio /sys/class/pwm && chmod -R 770 /sys/class/pwm;\
>          chown -R root:gpio
> /sys/devices/platform/soc/*.pwm/pwm/pwmchip* && chmod -R 770
> /sys/devices/platform/soc/*.pwm/pwm/pwmchip*\
> '"
> 
> This is a replacement patch for commit 7e5d1fd75c3d ("pwm: Set class for
> exported channels in sysfs"), see [1].
> 
> basic testing:
> $ udevadm monitor --environment &
> $ echo 0 > /sys/class/pwm/pwmchip0/export
> KERNEL[197.321736] change   /devices/.../pwm/pwmchip0 (pwm)
> ACTION=change
> DEVPATH=/devices/.../pwm/pwmchip0
> EXPORT=pwm0
> SEQNUM=2045
> SUBSYSTEM=pwm
> 
> [1] https://lkml.org/lkml/2018/9/25/713
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> Tested-by: Gottfried Haider <gottfried.haider@gmail.com>

Tested-by: Michal Vok?? <michal.vokac@ysoft.com>
