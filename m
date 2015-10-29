From: slash.tmp@free.fr (Mason)
Date: Thu, 29 Oct 2015 18:50:31 +0100
Subject: CPU_METHOD_OF_DECLARE() with Linux as non-secure OS
In-Reply-To: <yw1xio5pd5mf.fsf@unicorn.mansr.com>
References: <5630C143.5080103@free.fr> <yw1xio5pd5mf.fsf@unicorn.mansr.com>
Message-ID: <56325C67.8000007@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/10/2015 17:03, M?ns Rullg?rd wrote:

> Mason writes:
> 
>> I'm working on a dual-core SoC (Cortex-A9 MPCore) with Linux running
>> as the non-secure OS. The secure OS implements some of the APIs used
>> in OMAP2 via SMC.
>>
>> To start the second core, I used to define .smp in my DT_MACHINE_START
>> definition, but Arnd wrote: "There are other ways to do [.smp and .restart]
>> too, see CPU_METHOD_OF_DECLARE() and register_restart_handler()."
>>
>> Is CPU_METHOD_OF_DECLARE() the way to go?
>> Is it "compatible" with executing smc to ask the secure OS to do whatever
>> is needed to start the second core? (I don't understand why starting cores
>> is secure OS responsibility.)
>>
>> I've located three relevant secure OS services:
>> get_aux_core_boot
>> set_aux_core_boot0
>> set_aux_core_boot_addr
>>
>> I'm looking for guidance. What mach-* should I take as a reference to
>> implement "second core startup from non-secure OS"?
> 
> See https://github.com/mansr/linux-tangox/commit/717dd5fab87aa90255460ba409970331cb577247

I discussed cpu1 startup with the firmware author; he said the
secure OS does all the heavy lifting, Linux is only expected to
provide secondary_startup. AFAICT, we don't need to jump hoops
like mach-vexpress did.

I don't think you can define the cpus node in your smp87xx.dtsi
because smp8756 is single-core.

BTW, I see that you've tried to enable L2C. I would expect your
board would panic?

http://thread.gmane.org/gmane.linux.ports.arm.kernel/447493

Regards.
