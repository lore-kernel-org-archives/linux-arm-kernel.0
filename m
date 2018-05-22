From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 22 May 2018 10:12:34 +0100
Subject: [PATCH] cpufreq: Add Kryo CPU scaling driver
In-Reply-To: <001201d3f19a$0130a860$0391f920$@codeaurora.org>
References: <1526555955-29960-11-git-send-email-ilialin@codeaurora.org>
 <1526729701-8589-1-git-send-email-ilialin@codeaurora.org>
 <153cc316-dcb5-972f-5a2f-c91fe0f6348b@arm.com>
 <000f01d3f103$3ff78ba0$bfe6a2e0$@codeaurora.org>
 <2ace10bc-e1c4-2060-94d3-eb71e966ffbe@arm.com>
 <001201d3f19a$0130a860$0391f920$@codeaurora.org>
Message-ID: <5b2eb27b-b852-97ff-b099-fe4c22b44937@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 22/05/18 07:56, ilialin at codeaurora.org wrote:
> 
> 
>> -----Original Message-----
>> From: Sudeep Holla <sudeep.holla@arm.com>
>> Sent: Monday, May 21, 2018 16:05

[...]

>>
>>
>> That may be true and I am not that bothered about it. But assuming physical
>> ordering from the logical cpu number is *incorrect* and will break if kernel
>> decides to change the allocation algorithm. Kernel provides no guarantee on
>> that, so you need to depend on some physical ID or may be DT to achieve
>> what your want. But the current code as it stands is wrong.
> 
> Got your point. In fact CPUs are numbered 0-3 and ordered into 2 clusters in the DT:
> 
> cpus {
> 	#address-cells = <2>;
> 	#size-cells = <0>;
> 
> 	CPU0: cpu at 0 {
> 		...
> 		reg = <0x0 0x0>;
> 		...
> 	};
> 
> 	CPU1: cpu at 1 {
> 		...
> 		reg = <0x0 0x1>;
> 		...
> 	};
> 
> 	CPU2: cpu at 100 {
> 		...
> 		reg = <0x0 0x100>;
> 		...
> 	};
> 
> 	CPU3: cpu at 101 {
> 		...
> 		reg = <0x0 0x101>;
> 		...
> 	};
> 
> 	cpu-map {
> 		cluster0 {
> 			core0 {
> 				cpu = <&CPU0>;
> 			};
> 
> 			core1 {
> 				cpu = <&CPU1>;
> 			};
> 		};
> 
> 		cluster1 {
> 			core0 {
> 				cpu = <&CPU2>;
> 			};
> 
> 			core1 {
> 				cpu = <&CPU3>;
> 			};
> 		};
> 	};
> };
> 
> As far, as I understand, they are probed in the same order. 

Yes that's correct today, will that have to remain same for ever ?
No it's not user ABI and kernel can decide to change the allocation
order. What if for some reason one/more CPUs fails to boot or even
configured not to boot ?

> However, to be certain that the physical CPU is the one I intend to
> configure, I have to fetch the device structure pointer for the cpu-map ->
> clusterX -> core0 -> cpu path. Could you suggest a kernel API to do
> that?
> 

Let's rewind a bit. Do you supply OPPs only on CPU0 and CPU2 ?
If yes, that's again wrong. Simple solution is to parse all logical
CPUs and skip if the share OPPs with some other CPUs. I think that
logic already exists in OPP library IIRC.

-- 
Regards,
Sudeep
