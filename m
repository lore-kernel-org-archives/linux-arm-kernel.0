From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat, 03 Dec 2016 10:11:30 +0000
Subject: [PATCH v2 1/2] arm64: dts: zx: Fix gic GICR property
In-Reply-To: <20161203092251.GA17375@dragon> (Shawn Guo's message of "Sat, 3
 Dec 2016 17:22:55 +0800")
References: <1476361881-19685-1-git-send-email-jun.nie@linaro.org>
 <1476361881-19685-2-git-send-email-jun.nie@linaro.org>
 <a243d381-f7ab-abed-ca21-f0951abb04fd@arm.com>
 <20161203092251.GA17375@dragon>
Message-ID: <86lgvxmiel.fsf@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 03 2016 at 09:22:55 AM, Shawn Guo <shawnguo@kernel.org> wrote:
> On Fri, Dec 02, 2016 at 05:02:28PM +0000, Marc Zyngier wrote:
>> Just noticed this.
>> 
>> On 13/10/16 13:31, Jun Nie wrote:
>> > GICR for multiple CPU can be described with start address and stride,
>> > or with multiple address. Current multiple address and stride are
>> > both used. Fix it.
>> > 
>> > vmalloc patch 727a7f5a9 triggered this bug:
>> > [    0.097146] Unable to handle kernel paging request at virtual address ffff000008060008
>> > [    0.097150] pgd = ffff000008602000
>> > [    0.097160] [ffff000008060008] *pgd=000000007fffe003, *pud=000000007fffd003, *pmd=000000007fffc003, *pte=0000000000000000
>> > [    0.097165] Internal error: Oops: 96000007 [#1] PREEMPT SMP
>> > [    0.097170] Modules linked in:
>> > [    0.097177] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.8.0+ #1474
>> > [    0.097179] Hardware name: ZTE zx296718 evaluation board (DT)
>> > [    0.097183] task: ffff80003e8c8b80 task.stack: ffff80003e8d0000
>> > [    0.097197] PC is at gic_populate_rdist+0x74/0x15c
>> > [    0.097202] LR is at gic_starting_cpu+0xc/0x20
>> > [    0.097206] pc : [<ffff0000082b1b18>] lr : [<ffff0000082b26e0>] pstate: 600001c5
>> > 
>> > Signed-off-by: Jun Nie <jun.nie@linaro.org>
>> > ---
>> >  arch/arm64/boot/dts/zte/zx296718.dtsi | 11 +++--------
>> >  1 file changed, 3 insertions(+), 8 deletions(-)
>> > 
>> > diff --git a/arch/arm64/boot/dts/zte/zx296718.dtsi b/arch/arm64/boot/dts/zte/zx296718.dtsi
>> > index a223066..6b239a3 100644
>> > --- a/arch/arm64/boot/dts/zte/zx296718.dtsi
>> > +++ b/arch/arm64/boot/dts/zte/zx296718.dtsi
>> > @@ -239,16 +239,11 @@
>> >  		compatible = "arm,gic-v3";
>> >  		#interrupt-cells = <3>;
>> >  		#address-cells = <0>;
>> > -		#redistributor-regions = <6>;
>> > -		redistributor-stride = <0x0 0x40000>;
>> > +		#redistributor-regions = <1>;
>> > +		redistributor-stride = <0x20000>;
>> 
>> Why is that stride specified? Is the GIC implementation so busted that
>> the GICR_TYPER do not report a GICv3 redistributor, which implies a
>> 128kB stride?
>
> No, it's not required per my testing.  I guess it's there for
> documentation purpose to make the stride setting explicit.  Are you
> suggesting that we simply drop it?

Indeed. This is only meant as a workaround for some of the most
braindead platforms out there which have a redistributor stride that
deviates from what the architecture defines (128kB for GICv3, 256kB for
GICv4). It is good to know that this implementation is not broken.

> Also, it seems that #redistributor-regions can also be saved, since
> bindings doc tells that it's only required if more than one such region
> is present?

This could be removed as well.

Thanks,

        M.
-- 
Jazz is not dead. It just smells funny.
