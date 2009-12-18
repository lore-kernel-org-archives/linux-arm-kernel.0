From: richardliu@ms1.techarea.org (Richard Liu)
Date: Fri, 18 Dec 2009 20:49:52 +0800
Subject: dma_cache_maint_contiguous should be patched asdma_cache_maint do
In-Reply-To: <SNT109-W571829762ECCA799EA0B3DA7860@phx.gbl>
References: <1260524165.3109.3.camel@pc1117.cambridge.arm.com>,
	<SNT109-W606545835EAEDC6CE7A542A78C0@phx.gbl>,
	<20091216203319.GB17935@n2100.arm.linux.org.uk>
	<SNT109-W571829762ECCA799EA0B3DA7860@phx.gbl>
Message-ID: <4B2B7A70.8080405@ms1.techarea.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



IPI interrupt very high on some network device.

eth0 and eth1 are intel e1000e devices
and was configured as a bridge  (Linux tcp/ip bridge stack)
Use iperf to generate traffic between eth0 and eth1

Here is interrupt counter.
# cat /proc/interrupts
           CPU0       CPU1
pcie0       1703          0         GIC  PCIe0, eth0
pcie1       2067          0         GIC  PCIe1, eth1
IPI:       2487    2407340
LOC:      16709      16794

And the bridge throughput is only 30% then single core system.

Form previous experience, we will flush/invalidate a packet twice.
So, the IPI interrupt twice then pcie's interrupe is make sense.
But we observe extreme hight IPI interrupts, compare to traditional
cache flush function.

Is this issue cause by network stack or by IPI weakness ?

mkl lin wrote:
>>> Linux 2.6.31.1
>>> pcie sata adapter, ahci.c
>>> read 1GB file
>>>
>>> 1CPU:13.56/13.56/13.60 (sec) ~ 75.5MBps
>>> SMP+IPI:16.29/16.14/16.05 (sec) ~ 63.8MBps
>>> SMP+RFO/WFO:21.71/21.72/21.70 (sec) ~ 47.18MBps
>>> SMP+RFO/WFO/pld:21.63/21.46/21.41 (sec) ~ 47.82MBps
>>>       
>> Out of interest, how does the 1CPU version perform when you boot with
>> 'libata.force=pio' specified to the kernel?
>>     
>
> Due to my environment changed, those data is not comparable to previous. And AHCI only support DMA, force it to pio doen't make difference.
>
> 1CPU:17.15/17.07/17.10 ~ 59.98MBps
> 1CPU,with libata.force=pio: 17.02/16.86/17.03 ~ 60.73MBps
> SMP+IPI: 21.20/21.36/21.88 ~ 48.30MBps
> SMP+IPI,with libata.force=pio: 21.36/21.22/21.59 ~ 48.24MBps
>
> Best Regard,
> Mac Lin
>
>  		 	   		  
> _________________________________________________________________
> Windows Live: Friends get your Flickr, Yelp, and Digg updates when they e-mail you.
> http://www.microsoft.com/middleeast/windows/windowslive/see-it-in-action/social-network-basics.aspx?ocid=PID23461::T:WLMTAGL:ON:WL:en-xm:SI_SB_3:092010
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
>   

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091218/36e5ff45/attachment-0001.htm>
