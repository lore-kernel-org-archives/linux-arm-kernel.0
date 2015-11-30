From: dawei.chien@mediatek.com (dawei chien)
Date: Mon, 30 Nov 2015 20:16:34 +0800
Subject: [PATCH v4 3/3] thermal: mediatek: Add cpu dynamic power cooling
 model.
In-Reply-To: <20151130103422.GA4899@ubuntu>
References: <1448616727-29367-1-git-send-email-dawei.chien@mediatek.com>
 <1448616727-29367-4-git-send-email-dawei.chien@mediatek.com>
 <20151130053845.GM3373@ubuntu> <1448875581.29031.14.camel@mtksdaap41>
 <20151130093042.GA8556@ubuntu> <1448878884.29031.49.camel@mtksdaap41>
 <20151130103422.GA4899@ubuntu>
Message-ID: <1448885794.29031.78.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-11-30 at 16:04 +0530, Viresh Kumar wrote:
> On 30-11-15, 18:21, dawei chien wrote:
> > As far as I know, user or shell script has the right for using command online/offline cpu.
> 
> Right.
> 
> > Either user by console or shell script could make cpu2 online even cpu2 already onlined.
> 
> Hey, no. You can't online that is already online. You can write '1' to
> the file /sys/devices/system/cpu/cpuX/online, but it wouldn't have any
> affect.
> 
> > That could cause of_cpufreq_cooling_register execute many times for the
> > same cooling device.
> 
> No.
You are right. certainly no, it's my misunderstand.

> > "echo 1 > /sys/devices/system/cpu/cpu2/online"
> > 
> > With above hotplug command, mtk_cpufreq_ready will register cooling
> > device again as well, but fail since the cooling device already created,
> > so we might need not register cooling device again on this case.
> 
> Have you tested this yourself ?

Truly sorry for misunderstanding, so we don't need to add error checking
code there.

(It seems whole of cluster offline, the cooling device unregister as
well. If just one cpu online, cooling device register as well)

Three months ago, Once I used following command, cooling device can't
create any more. err message will show once I echo online command.
However, this bug already fixed in mainline by you. 

echo 0 > /sys/devices/system/cpu/cpu2/online
echo 0 > /sys/devices/system/cpu/cpu3/online
echo 1 > /sys/devices/system/cpu/cpu2/online

commit 528464eaa46ae1bd319882e4dd3495802e55b8c4
Author: Viresh Kumar <viresh.kumar@linaro.org>
Date:   Thu Jul 23 14:32:32 2015 +0530

    thermal: remove dangling 'weight_attr' device file
