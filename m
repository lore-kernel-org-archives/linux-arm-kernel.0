From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Wed, 30 Mar 2016 14:44:15 +0800
Subject: arm64: kernel v4.6-rc1 hangs on QEMU
In-Reply-To: <20160329225216.GB31869@yury-N73SV>
References: <20160329220502.GA14443@yury-N73SV> <3753214.GGjb33ZPlQ@wuerfel>
 <20160329222217.GA31869@yury-N73SV> <3334343.7r57EH3qRj@wuerfel>
 <20160329225216.GB31869@yury-N73SV>
Message-ID: <56FB75BF.2000401@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/3/30 6:52, Yury Norov wrote:
> On Wed, Mar 30, 2016 at 12:32:42AM +0200, Arnd Bergmann wrote:
>> On Wednesday 30 March 2016 01:22:17 Yury Norov wrote:
>>>>
>>>> Undefined instruction in cpuinfo_store_boot_cpu() could be related
>>>> to the SYS_ID_AA64MMFR2_EL1 access that was recently added.
>>>>

please use new qemu with
commit e20d84c1407d43d5a2e2ac95dbb46db3b0af8f9f
Author: Peter Maydell <peter.maydell@linaro.org>
Date:   Fri Feb 19 14:07:43 2016 +0000

    target-arm: Make reserved ranges in ID_AA64* spaces RAZ, not UNDEF

    The v8 ARM ARM defines that unused spaces in the ID_AA64* system
    register ranges are Reserved and must RAZ, rather than being UNDEF.
    Implement this.

    In particular, ARM v8.2 adds a new feature register ID_AA64MMFR2,
    and newer versions of the Linux kernel will attempt to read this,
    which causes them not to boot up on versions of QEMU missing this fix.

    Since the encoding .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 6
    is actually defined in ARMv8 (as ID_MMFR4), we give it an entry in
    the ARMCPU struct so CPUs can override it, though since none do
    this too will just RAZ.


see https://lists.gnu.org/archive/html/qemu-devel/2016-02/msg04574.html

>>>> What does the architecture say about reading unknown cpuid registers?
>>>>
>>>>       Arnd
>>>
>>> ThunderX has some unimplemented system registers. AFAIR, attempt to access it
>>> causes data abort.
>>
>> Ok, if that is the case, maybe the read_cpuid() macro can be changed
>> so it contains a fixup for the trap? That should handle both data abort
>> and undefinstr.
>>
>> 	Arnd
> 
> Sounds alluring, but not clear what we'd return that way. I mean, how
> we'd distinguish between correct value and error code (0, -1 or whatever).
> But I think, we can do like this:
> 
>         val = read_cpuid_safe(reg, impossible_val);
>         if (val == impossible_val)
>                 goto err;
> 
> I think it will work for many cases.
> 
> Yury.
> 
> 
