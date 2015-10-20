From: boris.ostrovsky@oracle.com (Boris Ostrovsky)
Date: Tue, 20 Oct 2015 08:55:38 -0400
Subject: [PATCH v3 2/3] xen, cpu_hotplug: call device_offline instead of
 cpu_down
In-Reply-To: <alpine.DEB.2.02.1510201104120.27957@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1510191754000.27957@kaball.uk.xensource.com>
 <1445273735-15758-2-git-send-email-stefano.stabellini@eu.citrix.com>
 <56253543.8080007@oracle.com>
 <alpine.DEB.2.02.1510201104120.27957@kaball.uk.xensource.com>
Message-ID: <562639CA.2010104@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/20/2015 06:28 AM, Stefano Stabellini wrote:
> On Mon, 19 Oct 2015, Boris Ostrovsky wrote:
>> On 10/19/2015 12:55 PM, Stefano Stabellini wrote:
>>> When offlining a cpu, instead of cpu_down, call device_offline, which
>>> also takes care of updating the cpu.dev.offline field. This keeps the
>>> sysfs file /sys/devices/system/cpu/cpuN/online, up to date.  Also move
>>> the call to disable_hotplug_cpu, because it makes more sense to have it
>>> there.
>>>
>>> Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
>>> CC: konrad.wilk at oracle.com
>>> CC: boris.ostrovsky at oracle.com
>>> CC: david.vrabel at citrix.com
>>> ---
>>>    drivers/xen/cpu_hotplug.c |    3 ++-
>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/xen/cpu_hotplug.c b/drivers/xen/cpu_hotplug.c
>>> index 43de1f5..78804b5 100644
>>> --- a/drivers/xen/cpu_hotplug.c
>>> +++ b/drivers/xen/cpu_hotplug.c
>>> @@ -18,6 +18,8 @@ static void enable_hotplug_cpu(int cpu)
>>>      static void disable_hotplug_cpu(int cpu)
>>>    {
>>> +	if (cpu_online(cpu))
>>> +		device_offline(get_cpu_device(cpu));
>>>    	if (cpu_present(cpu))
>>>    		xen_arch_unregister_cpu(cpu);
>> Do we want to call device_online() when plugging cpu in?
> I don't know: that would automatically bring the cpu online after the
> user hot-plugs it. Is it what we want? Current one would have to manually:
>
> echo 1 > /sys/devices/system/cpu/cpu1/online
>
> I thought that was the expected behaviour?

Right, we should keep onlining as an explicit operation. I think it's 
worth mentioning in the commit message why we don't call device_online() 
while using device_offline(), which is its complement.


-boris
