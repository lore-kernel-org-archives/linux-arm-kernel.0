From: monstr@monstr.eu (Michal Simek)
Date: Wed, 05 Jun 2013 12:47:46 +0200
Subject: [PATCH] ARM: zynq: wfi exit on same cpu is valid
In-Reply-To: <20130604141701.GX18614@n2100.arm.linux.org.uk>
References: <1369997066-10585-1-git-send-email-sanjay.rawat@linaro.org>
 <51AC5060.80806@linaro.org> <51AC672A.5050501@monstr.eu>
 <51AC8F74.2060302@linaro.org>
 <CAP245DUsRcomDaNKbxYry39ZLCrR33SDRRAhNCdR91e17sHF-A@mail.gmail.com>
 <51ADD667.3010203@linaro.org> <20130604141017.GW18614@n2100.arm.linux.org.uk>
 <20130604141701.GX18614@n2100.arm.linux.org.uk>
Message-ID: <51AF1752.1040804@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/04/2013 04:17 PM, Russell King - ARM Linux wrote:
> On Tue, Jun 04, 2013 at 03:10:17PM +0100, Russell King - ARM Linux wrote:
>> On Tue, Jun 04, 2013 at 01:58:31PM +0200, Daniel Lezcano wrote:
>>> On 06/04/2013 01:39 PM, Amit Kucheria wrote:
>>>> I'm curious why it is called pen_release. :) Is there some historical
>>>> link to some HW lines?
>>>
>>> I tried to figure out the same but I did not found any information on
>>> that. I assumed the name could be referring to a simplified mutual
>>> exclusion algorithm from the 'Dining philosophers problem' [1] where the
>>> fork is a pen.
>>
>> Where it comes from is the original ARM SMP patches from early 2000, which
>> everyone has blindly copied with no thought about what they're doing.  This
>> is why I'm totally against any consolidation of this code, because I'm of
>> the opinion that _no one_ other than the ARM Ltd development platforms
>> should be using it.
>>
>> "pen" means "holding pen".  It comes about because early on in the SMP
>> development, ARM SMP platforms had four CPUs, and it was only possible to
>> release all three secondary CPUs from the boot loader simultaneously to
>> a common piece of code.
>>
>> As the kernel was not able to serialize the release of each CPU, ARM Ltd
>> worked around this problem by having all the CPUs jump to assembly code
>> which "holds" the CPUs which we didn't want to boot yet, and the CPUs
>> are released one at a time by setting pen_release to the hardware CPU
>> number.
>>
>> Modern platforms either have just one secondary CPU, or they have a way
>> to control the reset/power to the secondary CPU.  This makes the holding
>> pen entirely redundant, and such platforms should _not_ make use of any
>> kind of holding pen.
> 
> And yes, indeed, zynq can control the secondary CPU:
> 
> void zynq_slcr_cpu_start(int cpu)
> {
>         /* enable CPUn */
>         writel(SLCR_A9_CPU_CLKSTOP << cpu,
>                zynq_slcr_base + SLCR_A9_CPU_RST_CTRL);
>         /* enable CLK for CPUn */
>         writel(0x0 << cpu, zynq_slcr_base + SLCR_A9_CPU_RST_CTRL);
> }
> 
> void zynq_slcr_cpu_stop(int cpu)
> {
>         /* stop CLK and reset CPUn */
>         writel((SLCR_A9_CPU_CLKSTOP | SLCR_A9_CPU_RST) << cpu,
>                zynq_slcr_base + SLCR_A9_CPU_RST_CTRL);
> }
> 
> So there's no need for the pen.  There's no need for the low power crap
> in hotplug.c, there's no need for the pen in hotplug.c.  You just arrange
> for the secondary CPU to have its clock stopped and reset when it is
> taken offline.
> 
> Hotplugging a CPU back in _should_ be no different from its initial
> bringup into the kernel.

I have tested that and cpu_die code is performed on cpu which
should die.
And simple calling zynq_slcr_cpu_stop() on cpu which should die
just doesn't work.
There is probably any expectation which I can't see.

Feel free to suggest me proper solution.

Thanks,
Michal





-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130605/d7336dc4/attachment.sig>
