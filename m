From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Fri, 12 Jan 2018 14:36:04 -0600
Subject: [PATCH, v3] arm: omap2: timer: fix a kmemleak caused in
 omap_get_timer_dt
In-Reply-To: <1515646483-24199-1-git-send-email-qi.hou@windriver.com>
References: <1515646483-24199-1-git-send-email-qi.hou@windriver.com>
Message-ID: <7dd12934-862c-c7ad-5f43-43e4c6b08199@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On 01/10/2018 10:54 PM, Qi Hou wrote:
> When more than one GP timers are used as kernel system timers and the
> corresponding nodes in device-tree are marked with the same "disabled"
> property, then the "attr" field of the property will be initialized
> more than once as the property being added to sys file system via
> __of_add_property_sysfs().
> 
> In __of_add_property_sysfs(), the "name" field of pp->attr.attr is set
> directly to the return value of safe_name(), without taking care of
> whether it's already a valid pointer to a memory block. If it is, its
> old value will always be overwritten by the new one and the memory block
> allocated before will a "ghost", then a kmemleak happened.
> 
> That the same "disabled" property being added to different nodes of device
> tree would cause that kind of kmemleak overhead, at leat once.
> 
> To fix it, allocate the property dynamically, and delete static one.

Does it in sync with Keerthy's work [1]

[1] https://www.spinics.net/lists/linux-omap/msg141100.html
> 
> Signed-off-by: Qi Hou <qi.hou@windriver.com>
> ---
>   arch/arm/mach-omap2/timer.c | 19 +++++++++++--------
>   1 file changed, 11 insertions(+), 8 deletions(-)

-- 
regards,
-grygorii
