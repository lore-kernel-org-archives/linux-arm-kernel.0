From: denys.zagorui@globallogic.com (Denys Zagorui)
Date: Thu, 13 Apr 2017 13:37:13 +0300
Subject: Testing kexec/kdump on ls2085ardb (arm64)
In-Reply-To: <b34ce5cb-82d3-a706-0a0b-98828ebb4417@redhat.com>
References: <799fca3b-8d1c-c1d0-f3d7-e3b060f962fd@globallogic.com>
 <98f5b725-a4d4-c881-2b78-d369d6859acc@redhat.com>
 <3fa4df10-86f9-5a6d-d78f-48acd38f873c@globallogic.com>
 <b34ce5cb-82d3-a706-0a0b-98828ebb4417@redhat.com>
Message-ID: <f4a70177-5d79-92e1-4a77-6832475d316b@globallogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12.04.17 19:36, Pratyush Anand wrote:
> Hi Denys,
>
> On Wednesday 12 April 2017 08:05 PM, Denys Zagorui wrote:
>> Hello, Pratyush
>> Thanks for your reply.
>>
>> Could you describe how i can find out wich enable method used. One more
>> things, i made this tests on qemu, and it works. Logs attached.
>>
>
> From your board log (log_for_com ):
>
> PSCI: PSCI does not exist
>
>
> and then
>
> [   60.561877] Can't kexec: CPUs are stuck in the kernel.
>
> Above message is coming from machine_kexec_prepare() when
> cpus_are_stuck_in_kernel() returns true. See, its implementation. It
> will return true if number of possible cpus is > 1 and cpu_die() is not
> implemented.
>
> You can boot your first kernel with nr_cpus=1 in  kernel cmdline and
> then you should be able to kexec to the second kernel from there.
>
> However, it can not be a solution. You should update your firmware with
> psci implementation.
>
> For the time being you can have spin-table work aroudn like this [1],
> but please note that spin-table is discouraged upstream [2].
>
> [1]
> https://github.com/pratyushanand/linux/commit/a50e98635b7257c101f02f7ac488a4cb04187f6d
>
> [2] https://patchwork.kernel.org/patch/7873571/
>
>
> From your qemu log:
>
> [    0.000000] psci: probing for conduit method from DT.
> [    0.000000] psci: PSCIv0.2 detected in firmware.
> [    0.000000] psci: Using standard PSCI v0.2 function IDs
> [    0.000000] psci: Trusted OS migration not required
>
>
> and so it works :-)
>
>
> ~Pratyush

Hi Pratyush

Both solutions works. Thanks. It's temporary solution,
i will contact with NXP support team

Best Regards,
Denys
-- 
Denys Zagorui
GlobalLogic
Kyiv, 03038, Protasov Business Park, N.Grinchenka, 2/1
M +38.067.317.30.93
www.globallogic.com

http://www.globallogic.com/email_disclaimer.txt
