From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 27 Aug 2014 10:37:58 -0600
Subject: [RFC PATCH 0/9] dt: dependencies (for deterministic driver
 initialization order based on the DT)
In-Reply-To: <53FE07BE.7000809@ahsoftware.de>
References: <53F64624.5000403@ahsoftware.de>
 <20140822131919.GX21734@leverpostej> <20140825093931.GB2399@ulmo>
 <E1XLu15-0002DP-6o@jdl.com> <20140825133714.GH4163@ulmo.nvidia.com>
 <20140826084208.AE5F0C40989@trevor.secretlab.ca>
 <20140826084922.GG17263@ulmo> <53FC566C.30904@ahsoftware.de>
 <20140826101107.GC32315@leverpostej>
 <20140827103432.64927C409CB@trevor.secretlab.ca>
 <20140827144403.GB13850@arm.com> <53FE05AE.9000406@wwwdotorg.org>
 <53FE07BE.7000809@ahsoftware.de>
Message-ID: <53FE0966.5020206@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/27/2014 10:30 AM, Alexander Holler wrote:
> Am 27.08.2014 18:22, schrieb Stephen Warren:
>> On 08/27/2014 08:44 AM, Catalin Marinas wrote:
>
>>> It's not just optimisation but an important feature for new arm64 SoCs.
>>> Given some Tegra discussions recently, in many cases the machine_desc
>>> use on arm is primarily to initialise devices in the right order. If we
>>> can solve this in a more deterministic way (other than deferred
>>> probing), we avoid the need for a dedicated SoC platform driver (or
>>> machine_desc) or workarounds like different initcall levels and explicit
>>> DT parsing.
>>
>> A lot of the ordering is SW driver dependencies. I'm not sure how much
>> of that can accurately be claimed as HW dependencies. As such, I'm not
>> sure that putting dependencies into DT would be a good idea; it doesn't
>> feel like HW data, and might well change if we restructure SW. It'd need
>> some detailed research though.
>
> Almost every phandle is a dependency, so the DT is already full with them.

That's true, but not entirely relevant.

phandles in DT should only be present where there's an obvious HW 
dependency. It's obvious that, for example, there's a real HW dependency 
between an IRQ controller and a device that has an IRQ signal fed into 
the IRQ controller. It makes perfect sense to represent that as a 
phandle (+args).

However, most of the ordering imposed by the Tegra machine descriptor 
callbacks is nothing to do with this. It's more that the SW driver for 
component X needs some low level data (e.g. SKU/fuse information) before 
it can run. However, there's no real HW dependency between the HW 
component X and the fuse module. As such, it doesn't make sense to 
represent such a dependency in DT, using a phandle or by any other means.

Of course, there are probably cases where we could/should add some more 
phandles/... and likewise cases where we shouldn't. That's why detailed 
research is needed.

Irrespective though, a new kernel needs to work against an old DT, so 
always needs to work without any (of these new) dependencies being 
represented in DT, since they aren't represented there today. So, I 
think pushing the issue into DT is a non-starter either way, unless we 
accept yet another ABI-breaking change, in which case we should just 
give up on any claims of ABI and make everyone's lives simpler.
